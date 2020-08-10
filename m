Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BB7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2708C2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5ESQ2LO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgHJSgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:36:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21000 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728155AbgHJSgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597084603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QXfIGxWYHli8UViM6M93oQLb9NwlH1AHgGXp2GsD3So=;
        b=f5ESQ2LOJY2swKAXKmbQIF2CJVOPujC9qi0dh1QFgxJ0wDBUQQpHK9S1ZBit1SxO94shCL
        u7O05heg0y9EFyZO2Z2SAHuGC7BUn6XKZ8JX6OAVhajb6LuvBh2liOcJaCLMIl7rIzNbRF
        JwMRT+NUag333ofS6rT+Xvo47kV54tg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-6YiDE5zlPemw24k8Tq1dOg-1; Mon, 10 Aug 2020 14:36:41 -0400
X-MC-Unique: 6YiDE5zlPemw24k8Tq1dOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61355107ACCA;
        Mon, 10 Aug 2020 18:36:40 +0000 (UTC)
Received: from max.home.com (unknown [10.40.194.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D0045D9E7;
        Mon, 10 Aug 2020 18:36:35 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] GFS2 changes for 5.9
Date:   Mon, 10 Aug 2020 20:36:34 +0200
Message-Id: <20200810183634.617307-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 changes for 5.9.

Thanks a lot,
Andreas

The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:

  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.9

for you to fetch changes up to e28c02b94f9e039beeb5c75198caf6e17b66c520:

  gfs2: When gfs2_dirty_inode gets a glock error, dump the glock (2020-08-07 17:26:24 +0200)

----------------------------------------------------------------
Changes in gfs2:

- Make sure transactions won't be started recursively in gfs2_block_zero_range.
  (Bug introduced in 5.4 when switching to iomap_zero_range.)
- Fix a glock holder refcount leak introduced in the iopen glock locking
  scheme rework merged in 5.8.
- A few other small improvements (debugging, stack usage, comment fixes).

----------------------------------------------------------------
Andreas Gruenbacher (3):
      gfs2: Pass glock holder to gfs2_file_direct_{read,write}
      gfs2: Fix refcount leak in gfs2_glock_poke
      fs: Fix typo in comment

Bob Peterson (5):
      gfs2: Add some flags missing from glock output
      gfs2: Fix inaccurate comment
      gfs2: print details on transactions that aren't properly ended
      gfs2: Never call gfs2_block_zero_range with an open transaction
      gfs2: When gfs2_dirty_inode gets a glock error, dump the glock

 fs/gfs2/bmap.c     | 69 ++++++++++++++++++++++++++++++------------------------
 fs/gfs2/file.c     | 31 ++++++++++++------------
 fs/gfs2/glock.c    | 10 +++++++-
 fs/gfs2/log.c      |  2 +-
 fs/gfs2/super.c    |  1 +
 fs/gfs2/trans.c    | 29 +++++++++++++----------
 include/linux/fs.h |  2 +-
 7 files changed, 82 insertions(+), 62 deletions(-)

