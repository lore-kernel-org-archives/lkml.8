Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61DFC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82365206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0JZ00v/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgELOy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:54:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48225 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725929AbgELOy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589295296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ayS808bLgmNMdF8Jk/2gP5FgQYDM/m50c1GF+CBCNaA=;
        b=a0JZ00v/v/fhWh2rNcv78AEFqsLw7aOFBtkZqlr4hD/eW5GmS+LgOGdLmTxTq7t3x6Q/k9
        hCnDwwsFyzEWyE2+dIDwgDYxDQKu6+HaHJj3iCmECn7SZfa0zpDNZQqQ/LbcG9ljShZIpP
        1krIoqGEbB23KbyWVxpH1EvjlYguqbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-angpt5usPPCy0Cv76CkZiw-1; Tue, 12 May 2020 10:54:54 -0400
X-MC-Unique: angpt5usPPCy0Cv76CkZiw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 295F01906808;
        Tue, 12 May 2020 14:54:38 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5E205D9DD;
        Tue, 12 May 2020 14:54:36 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] GFS2 fixes for 5.7
Date:   Tue, 12 May 2020 16:54:34 +0200
Message-Id: <20200512145434.160164-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull the following fixes for gfs2?

Thanks a lot,
Andreas

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.7-rc1.fixes

for you to fetch changes up to b14c94908b1b884276a6608dea3d0b1b510338b7:

  Revert "gfs2: Don't demote a glock until its revokes are written" (2020-05-08 15:01:25 -0500)

----------------------------------------------------------------
Various gfs2 fixes

Fixes for bugs prior to v5.7-rc1:
- Fix random block reads when reading fragmented journals (v5.2).
- Fix a possible random memory access in gfs2_walk_metadata (v5.3).

Fixes for v5.7-rc1:
- Fix several overlooked gfs2_qa_get / gfs2_qa_put imbalances.
- Fix several bugs in the new filesystem withdraw logic.

----------------------------------------------------------------
Andreas Gruenbacher (3):
      gfs2: Another gfs2_walk_metadata fix
      gfs2: More gfs2_find_jhead fixes
      gfs2: Grab glock reference sooner in gfs2_add_revoke

Bob Peterson (11):
      gfs2: fix withdraw sequence deadlock
      gfs2: Fix error exit in do_xmote
      gfs2: Fix BUG during unmount after file system withdraw
      gfs2: Fix use-after-free in gfs2_logd after withdraw
      gfs2: Fix problems regarding gfs2_qa_get and _put
      gfs2: Change BUG_ON to an assert_withdraw in gfs2_quota_change
      gfs2: remove check for quotas on in gfs2_quota_check
      gfs2: move privileged user check to gfs2_quota_lock_check
      gfs2: don't call quota_unhold if quotas are not locked
      gfs2: If go_sync returns error, withdraw but skip invalidate
      Revert "gfs2: Don't demote a glock until its revokes are written"

 fs/gfs2/bmap.c    | 16 +++++++++-------
 fs/gfs2/glock.c   |  6 ++----
 fs/gfs2/inode.c   |  7 ++++---
 fs/gfs2/log.c     | 11 ++++++++---
 fs/gfs2/lops.c    | 19 ++++++++++++-------
 fs/gfs2/meta_io.c |  2 +-
 fs/gfs2/quota.c   | 13 +++++--------
 fs/gfs2/quota.h   |  3 ++-
 fs/gfs2/super.c   |  1 -
 fs/gfs2/util.c    | 10 ++++++----
 10 files changed, 49 insertions(+), 39 deletions(-)

