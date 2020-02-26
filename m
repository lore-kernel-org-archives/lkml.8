Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B0BC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EF82467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKKpA64p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgBZQPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:15:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23106 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727746AbgBZQPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582733708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=GFnA8Sa/wZo/6noDEkcT6+Ar1rUimsYkRyF79+pzSnM=;
        b=hKKpA64puSbthkYg26S2DHL5/xf5LH8T/6yNVtOh65UTzmp2Qlc0X3hjk80XCIyfnsTFXP
        cAy/TCeF6DUqd+V0kIQXuNWjm12+hXnF0ATe7q3tJMPvKQuEWwKipwxNMs6XX+H9CCYcnh
        MwPDAIaeFLicA/c0KPP0dU2HTy/PN8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-6kLbTQcGNnSdZWckjUi0gA-1; Wed, 26 Feb 2020 11:15:04 -0500
X-MC-Unique: 6kLbTQcGNnSdZWckjUi0gA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5C251005512;
        Wed, 26 Feb 2020 16:15:02 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC22160BE1;
        Wed, 26 Feb 2020 16:14:55 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 00/11] fs/dcache: Limit # of negative dentries
Date:   Wed, 26 Feb 2020 11:13:53 -0500
Message-Id: <20200226161404.14136-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is no limit for negative dentries, it is possible that a sizeable
portion of system memory can be tied up in dentry cache slabs. Dentry slabs
are generally recalimable if the dentries are in the LRUs. Still having
too much memory used up by dentries can be problematic:

 1) When a filesystem with too many negative dentries is being unmounted,
    the process of draining the dentries associated with the filesystem
    can take some time. To users, the system may seem to hang for
    a while.  The long wait may also cause unexpected timeout error or
    other warnings.  This can happen when a long running container with
    many negative dentries is being destroyed, for instance.

 2) Tying up too much memory in unused negative dentries means there
    are less memory available for other use. Even though the kernel is
    able to reclaim unused dentries when running out of free memory,
    it will still introduce additional latency to the application
    reducing its performance.

There are two different approaches to limit negative dentries.

  1) Global reclaim
     Based on the total number of negative dentries as tracked by the
     nr_dentry_negative percpu count, a function can be activated to
     scan the various LRU lists to trim out excess negative dentries.

  2) Local reclaim
     By tracking the number of negative dentries under each directory,
     we can start the reclaim process if the number exceeds a certain
     limit.

The problem with global reclaim is that there are just too many LRU lists
present that may need to be scanned for each filesystem. Especially
problematic is the fact that each memory cgroup can have its own LRU
lists. As memory cgroup can come and go at any time, scanning its LRUs
can be tricky.

Local reclaim does not have this problem. So it is used as the basis
for negative dentry reclaim for this patchset. Accurately tracking the
number of negative dentries in each directory can be costly in term of
performance hit. As a result, this patchset estimates the number of
negative dentries present in a directory by looking at a newly added
children count and an opportunistically stored positive dentry count.

A new sysctl parameter "dentry-dir-max" is introduced which accepts a
value of 0 (default) for no limit or a positive integer 256 and up. Small
dentry-dir-max numbers are forbidden to avoid excessive dentry count
checking which can impact system performance.

The actual negative dentry reclaim is delegated to the system workqueue
to avoid adding excessive latency to normal filesystem operation.

Waiman Long (11):
  fs/dcache: Fix incorrect accounting of negative dentries
  fs/dcache: Simplify __dentry_kill()
  fs/dcache: Add a counter to track number of children
  fs/dcache: Add sysctl parameter dentry-dir-max
  fs/dcache: Reclaim excessive negative dentries in directories
  fs/dcache: directory opportunistically stores # of positive dentries
  fs/dcache: Add static key negative_reclaim_enable
  fs/dcache: Limit dentry reclaim count in negative_reclaim_workfn()
  fs/dcache: Don't allow small values for dentry-dir-max
  fs/dcache: Kill off dentry as last resort
  fs/dcache: Track # of negative dentries reclaimed & killed

 Documentation/admin-guide/sysctl/fs.rst |  18 +
 fs/dcache.c                             | 428 +++++++++++++++++++++++-
 include/linux/dcache.h                  |  18 +-
 kernel/sysctl.c                         |  11 +
 4 files changed, 457 insertions(+), 18 deletions(-)

-- 
2.18.1

