Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D055C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAF020675
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944849;
	bh=k2ujJbbLaLkp8RkQ81qTnaWFmJhWwsTCR9ZgosbWkAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2O4hzz3JZLon0jJ76ru1+cQ/axKlH53aRfcJSxDYw+kBNMIiRkj9pUv6YlZmFPDHp
	 S8jg1/S5f6MWsvgdOYJIzGGA+9/cNlGCdRTQVnSgEbgMQGp3TlxzXu4/tjwm8lRAgH
	 tVBpyHRrZQgpMHz2iUblqkJaUX6uB4f8WlF/08E0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392280AbgFWUkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392262AbgFWUkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:40:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 759FC20675;
        Tue, 23 Jun 2020 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944840;
        bh=k2ujJbbLaLkp8RkQ81qTnaWFmJhWwsTCR9ZgosbWkAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J3fPejAdub6QHV1bZ1J/1NKvV/UPZh8e3ar5PhVR2XPiGsJIiQyZg6SMuFDt1rivb
         RnDWi4ljpMifyFwDtjQnNIFF58ufc8CCam2fM34w0GNrc2HO5i0ycIsgqWShh37xeN
         IGimKHtFA7ME0cSoyUmkkt9P0b/QICrAkXODdJDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 128/206] gfs2: Allow lock_nolock mount to specify jid=X
Date:   Tue, 23 Jun 2020 21:57:36 +0200
Message-Id: <20200623195323.273161227@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

[ Upstream commit ea22eee4e6027d8927099de344f7fff43c507ef9 ]

Before this patch, a simple typo accidentally added \n to the jid=
string for lock_nolock mounts. This made it impossible to mount a
gfs2 file system with a journal other than journal0. Thus:

mount -tgfs2 -o hostdata="jid=1" <device> <mount pt>

Resulted in:
mount: wrong fs type, bad option, bad superblock on <device>

In most cases this is not a problem. However, for debugging and
testing purposes we sometimes want to test the integrity of other
journals. This patch removes the unnecessary \n and thus allows
lock_nolock users to specify an alternate journal.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/ops_fstype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index b041cb8ae383d..ed77b10bdfb53 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -903,7 +903,7 @@ fail:
 }
 
 static const match_table_t nolock_tokens = {
-	{ Opt_jid, "jid=%d\n", },
+	{ Opt_jid, "jid=%d", },
 	{ Opt_err, NULL },
 };
 
-- 
2.25.1



