Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23BAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918B3206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594223059;
	bh=fBu0ClO0KQXec2oBjKGmKPAybI4/hbfUxR6w24vd01g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XqRIgLy4EI/ZPQVIqZVWKosFu+uTPec00Gh61Z44JoBnvq5k395LcrKZlAE5ocnxw
	 n7EemGMYoOvF0Ie3TVTxQBAotC77i5/5DTYS/TQXl8jHvX2ITqw12E8CBiD+CNRU2j
	 nhoNWUbygukGBeQ94uzTbQvVFky6B6jXQVrY/cyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgGHPoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbgGHPl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:41:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E608020786;
        Wed,  8 Jul 2020 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594222887;
        bh=fBu0ClO0KQXec2oBjKGmKPAybI4/hbfUxR6w24vd01g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjWSZ4vQazQU3XfWD6nsDbiET9RVvRWR5hJ0Q6Xt3ibXsAICKWoIoxym8WKroCF+2
         ypv9lYHC6GeuqckuZ8uiJzuxwCZl/7yuE2KkiDl7EL05lHPHUq+Ct36KCHdg/D237w
         86tqEmQFePW7KSl9AFVq363+iDMtC2ZHO98H/MiE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hyunchul Lee <hyc.lee@gmail.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 08/30] exfat: call sync_filesystem for read-only remount
Date:   Wed,  8 Jul 2020 11:40:54 -0400
Message-Id: <20200708154116.3199728-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708154116.3199728-1-sashal@kernel.org>
References: <20200708154116.3199728-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit a0271a15cf2cf907ea5b0f2ba611123f1b7935ec ]

We need to commit dirty metadata and pages to disk
before remounting exfat as read-only.

This fixes a failure in xfstests generic/452

generic/452 does the following:
cp something <exfat>/
mount -o remount,ro <exfat>

the <exfat>/something is corrupted. because while
exfat is remounted as read-only, exfat doesn't
have a chance to commit metadata and
vfs invalidates page caches in a block device.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index c1b1ed306a485..e879801533980 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -637,10 +637,20 @@ static void exfat_free(struct fs_context *fc)
 	}
 }
 
+static int exfat_reconfigure(struct fs_context *fc)
+{
+	fc->sb_flags |= SB_NODIRATIME;
+
+	/* volume flag will be updated in exfat_sync_fs */
+	sync_filesystem(fc->root->d_sb);
+	return 0;
+}
+
 static const struct fs_context_operations exfat_context_ops = {
 	.parse_param	= exfat_parse_param,
 	.get_tree	= exfat_get_tree,
 	.free		= exfat_free,
+	.reconfigure	= exfat_reconfigure,
 };
 
 static int exfat_init_fs_context(struct fs_context *fc)
-- 
2.25.1

