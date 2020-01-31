Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0843FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF03215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 15:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsd7+0ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgAaPse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:48:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29484 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728974AbgAaPsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580485712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gpWbeTX1IiCGQYtqoFvlcDOaUtkH1pyaLXLukOOu9oE=;
        b=dsd7+0aboVob3yMPz92UwqttLGSBbyaElsGlhWtESCqnm9pFKvKVmUrVC1oC33J+xCjXhA
        0EdPAa2yzBJRPyQktXT/hDyAcxuKFoIUNh1SEqzok3Toa/jtLVOQFt8GCo8xe3igxu/vMT
        /BXaSxJnqf4Rr7T4N4af+k3k7ekvvPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-mo0TXs6tNHewOnBPJ8xP2g-1; Fri, 31 Jan 2020 10:48:30 -0500
X-MC-Unique: mo0TXs6tNHewOnBPJ8xP2g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD3ED100551A;
        Fri, 31 Jan 2020 15:48:29 +0000 (UTC)
Received: from max.com (ovpn-205-139.brq.redhat.com [10.40.205.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26BFE89E75;
        Fri, 31 Jan 2020 15:48:25 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] GFS2 changes for the 5.6 merge window
Date:   Fri, 31 Jan 2020 16:48:23 +0100
Message-Id: <20200131154823.30363-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull the following changes for gfs2?

In addition, please expect to see another pull request from Bob Peterson
about his gfs2 recovery patch queue shortly.

Thanks a lot,
Andreas

The following changes since commit 887352fb5ffd593d28f77059c09dabb47c5b86=
e9:

  Merge branch 'for-linus' from git://git.kernel.dk/linux-block (2019-12-=
10 11:02:38 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/=
gfs2-for-5.6

for you to fetch changes up to a31b4ec539e966515f1f97f4000d0e2a399930ce:

  Revert "gfs2: eliminate tr_num_revoke_rm" (2020-01-28 15:04:53 +0100)

----------------------------------------------------------------
Changes in gfs2:

- Fix some corner cases on filesystems with a block size < page size.
- Fix a corner case that could expose incorrect access times over nfs.
- Revert an otherwise sensible revoke accounting cleanup that causes
  assertion failures.  The revoke accounting is whacky and needs to be
  fixed properly before we can add back this cleanup.
- Various other minor cleanups.

----------------------------------------------------------------
Alex Shi (2):
      fs/gfs2: remove unused IS_DINODE and IS_LEAF macros
      gfs2: remove unused LBIT macros

Andreas Gruenbacher (4):
      gfs2: Another gfs2_find_jhead fix
      gfs2: Avoid access time thrashing in gfs2_inode_lookup
      gfs2: Fix incorrect variable name
      gfs2: Remove GFS2_MIN_LVB_SIZE define

Bob Peterson (3):
      gfs2: eliminate ssize parameter from gfs2_struct2blk
      gfs2: minor cleanup: remove unneeded variable ret in gfs2_jdata_wri=
tepage
      Revert "gfs2: eliminate tr_num_revoke_rm"

 fs/gfs2/aops.c       |  4 +--
 fs/gfs2/dir.c        |  3 ---
 fs/gfs2/glock.c      |  2 +-
 fs/gfs2/glops.c      |  2 +-
 fs/gfs2/incore.h     |  6 ++---
 fs/gfs2/inode.c      | 10 ++++----
 fs/gfs2/log.c        | 21 +++++++---------
 fs/gfs2/log.h        |  4 +--
 fs/gfs2/lops.c       | 70 +++++++++++++++++++++++++++++++++-------------=
------
 fs/gfs2/ops_fstype.c |  2 ++
 fs/gfs2/rgrp.c       | 10 --------
 fs/gfs2/trans.c      |  9 +++----
 12 files changed, 73 insertions(+), 70 deletions(-)

