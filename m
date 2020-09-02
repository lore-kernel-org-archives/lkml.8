Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73879C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4059E204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWe6uQCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgIBPoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:44:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41560 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728191AbgIBPo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599061463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UK/4h/D4Qk2bl5GH5uYbOm22qCf+nIc9TgkObmodVtA=;
        b=gWe6uQCq0l5KO7f8cn33+QEeW41wrAZxhrS+o+ACWHFX/IKFFug6GspXv7vfcM26E0XJ9+
        ddl62QN+VSqNJrGqNlZjBnAtexyaooPFVKc0LLM7D+r6/JJUrGS3lkBLvLyF9YuLukx5qr
        2vFvoqEBMO8txEcZEwMQSJFR1lYtefg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-uRXC5zwdP0aHH49AaOB0Iw-1; Wed, 02 Sep 2020 11:44:20 -0400
X-MC-Unique: uRXC5zwdP0aHH49AaOB0Iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE6E518C5217;
        Wed,  2 Sep 2020 15:44:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-6.rdu2.redhat.com [10.10.113.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4CD85D9CC;
        Wed,  2 Sep 2020 15:44:17 +0000 (UTC)
Subject: [RFC PATCH 0/6] mm: Make more use of readahead_control [ver #2]
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     Song Liu <songliubraving@fb.com>, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 02 Sep 2020 16:44:17 +0100
Message-ID: <159906145700.663183.3678164182141075453.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Willy,

Here's a set of patches to expand the use of the readahead_control struct,
essentially from do_sync_mmap_readahead() down.  It's on top of:

	http://git.infradead.org/users/willy/pagecache.git

Also pass file_ra_state into force_page_cache_readahead().

The bugfix for khugepaged.c is included as that code is further changed
here.

David
---
David Howells (6):
      Fix khugepaged's request size in collapse_file()
      mm: Make ondemand_readahead() take a readahead_control struct
      mm: Push readahead_control down into force_page_cache_readahead()
      mm: Pass readahead_control into page_cache_{sync,async}_readahead()
      mm: Fold ra_submit() into do_sync_mmap_readahead()
      mm: Pass a file_ra_state struct into force_page_cache_readahead()


 fs/btrfs/free-space-cache.c |  4 ++-
 fs/btrfs/ioctl.c            |  9 +++--
 fs/btrfs/relocation.c       | 10 +++---
 fs/btrfs/send.c             | 16 +++++----
 fs/ext4/dir.c               | 11 +++---
 fs/f2fs/dir.c               |  8 +++--
 include/linux/pagemap.h     |  7 ++--
 mm/fadvise.c                |  6 +++-
 mm/filemap.c                | 32 +++++++++--------
 mm/internal.h               | 14 ++------
 mm/khugepaged.c             |  4 +--
 mm/readahead.c              | 70 ++++++++++++++++++-------------------
 12 files changed, 100 insertions(+), 91 deletions(-)


