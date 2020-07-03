Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FBAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C4D20720
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fV5+RbrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgGCKTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:19:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24183 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725891AbgGCKTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593771542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=44JtbJMmCSQYDS81jJeGZeKwGH9kWwFJF0hFzZPWY1Y=;
        b=fV5+RbrL2fPl17ujfKUTdtqWvHC9sUGTRhcxSJzOfj1wyYrZ+R47RpLtyz/sj1WPNw7cwf
        c/vPZXK/IG5UqoSCuVXMyfMstD0BKDOLOqSw0sya/GFovztJXoO1x3DiHK64xwXQ9FR2Z9
        9eb+1zekqL9bp2AWXRY/EKlPF9EBzmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-ad3CzcCVNfaKibVH21oFBQ-1; Fri, 03 Jul 2020 06:19:00 -0400
X-MC-Unique: ad3CzcCVNfaKibVH21oFBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3FAB18A8221;
        Fri,  3 Jul 2020 10:18:59 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F32B19CA0;
        Fri,  3 Jul 2020 10:18:55 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [GIT PULL] Additional gfs2 fixes for 5.8
Date:   Fri,  3 Jul 2020 12:18:54 +0200
Message-Id: <20200703101854.1493930-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull the following additional gfs2 fixes?

These don't conflict with the IOCB_NOIO / readahead deadlock fixes.

Thanks a lot,
Andreas

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.8-rc3.fixes

for you to fetch changes up to c860f8ffbea8924de05a281b937128773d30a77c:

  gfs2: The freeze glock should never be frozen (2020-07-03 12:05:35 +0200)

----------------------------------------------------------------
Various gfs2 fixes

----------------------------------------------------------------
Andreas Gruenbacher (2):
      gfs2: Don't return NULL from gfs2_inode_lookup
      gfs2: Don't sleep during glock hash walk

Bob Peterson (6):
      gfs2: fix trans slab error when withdraw occurs inside log_flush
      gfs2: eliminate GIF_ORDERED in favor of list_empty
      gfs2: freeze should work on read-only mounts
      gfs2: read-only mounts should grab the sd_freeze_gl glock
      gfs2: When freezing gfs2, use GL_EXACT and not GL_NOCACHE
      gfs2: The freeze glock should never be frozen

 fs/gfs2/glock.c      |  5 ++++-
 fs/gfs2/glops.c      | 10 ++++++----
 fs/gfs2/incore.h     |  1 -
 fs/gfs2/inode.c      |  3 ++-
 fs/gfs2/log.c        | 25 +++++++++++++++++++------
 fs/gfs2/log.h        |  4 ++--
 fs/gfs2/main.c       |  1 +
 fs/gfs2/ops_fstype.c | 13 ++++++++++++-
 fs/gfs2/recovery.c   |  4 ++--
 fs/gfs2/super.c      | 20 ++++++++++----------
 10 files changed, 58 insertions(+), 28 deletions(-)

