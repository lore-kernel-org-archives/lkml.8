Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D39C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2B921569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWDnx4s6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgAMGwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:52:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46586 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgAMGwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:52:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so4207642pgb.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 22:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ixWmZZn5cz1mbd7yW9N78OzPov834nZ+OiSf3qX3/Iw=;
        b=MWDnx4s6w/tmBrNVbFIQ1vEX6qQvpKt44HmfIThiV/xaQluAyx9nzyLcL1Yscq+xBf
         85JkyYzx/i3b13pq2yZWeuEiFyErVuSGRIvzYKg2iEQ28m/8Emq3+YX7/q0T0WBZFIMf
         oTC6CpQifBvzkwRzR4sdi24ce49Jp8JxpA6AuQFHTZyKoAiT0ivYXwf4aytyqc13wQ3a
         1Lga1hYL7mosq+M9NPIETKtjn0RmIMrRa/6veh8h7PHZwLsJx+2JYtc3LfBUGPv8OyWz
         CqkgN1sVbjpQlCZH9/lo7vnLK3UHfaqTWUezZWHxQ7oaQ0lMi2fEOtSkA7s27R2x/y3B
         U54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ixWmZZn5cz1mbd7yW9N78OzPov834nZ+OiSf3qX3/Iw=;
        b=asNcPiVtPOxehJnyn+OXXhIh/vXtU0NB+onOX6RbQDRVjlp44UxaDwIzoHsWc9aStG
         RknCdicFWpkV9GVXr4VtLVD5r6wc93coEFXCfzYujRFEfQtAcTJu8k2k1Lk8mePMZ0wy
         oDi3e0nvzDBVveL6SCn0ixQoc0vrgVm/tDtK2ilyS4A7zxOxwDJuolTkWZ+TZoYenBmZ
         bMtHO0/i6oaKGrLJ6SaL0qORtPyVTQzWAp+Ff4jnMfxX74RqHwYv1jMCaYAPckRDphAJ
         /eNxGa+554VXhZYbJ46abuowTrbruKcXfJL1TrtaJ5I6fYbyDqwItwdmuYLnw4K+5j+O
         H7eQ==
X-Gm-Message-State: APjAAAWzGXvGsmoc2fLu3dvdHC7DweyWN7DIkall4eauuVxr9mAv6Jdu
        JnLlh1vZPAh2rPVDTGVIf7/6CKMSMmM=
X-Google-Smtp-Source: APXvYqz8DDYgtxILjbT8NXNXztKpdNhF11x4wKO5q4NOEFrzD3WC1my7gwV5KogGtPbc3vnQZWJIiw==
X-Received: by 2002:a05:6a00:90:: with SMTP id c16mr17661377pfj.230.1578898361059;
        Sun, 12 Jan 2020 22:52:41 -0800 (PST)
Received: from xp-OptiPlex-7050.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id p21sm12338217pfn.103.2020.01.12.22.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Jan 2020 22:52:40 -0800 (PST)
From:   ping xiong <xp1982.06.06@gmail.com>
To:     yuchao0@huawei.com
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, xiongping1 <xiongping1@xiaomi.com>
Subject: [f2fs-dev][PATCH V2] resize.f2fs: add option for large_nat_bitmap feature
Date:   Mon, 13 Jan 2020 14:52:30 +0800
Message-Id: <1578898350-29607-1-git-send-email-xp1982.06.06@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiongping1 <xiongping1@xiaomi.com>

resize.f2fs has already supported large_nat_bitmap feature, but has no
option to turn on it.

This change add a new '-i' option to control turning on it.

Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
---
 fsck/main.c   | 6 +++++-
 fsck/resize.c | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index 9a7d499..e7e3dfc 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -104,6 +104,7 @@ void resize_usage()
 	MSG(0, "\nUsage: resize.f2fs [options] device\n");
 	MSG(0, "[options]:\n");
 	MSG(0, "  -d debug level [default:0]\n");
+	MSG(0, "  -i extended node bitmap, node ratio is 20%% by default\n");
 	MSG(0, "  -s safe resize (Does not resize metadata)");
 	MSG(0, "  -t target sectors [default: device size]\n");
 	MSG(0, "  -V print the version number and exit\n");
@@ -449,7 +450,7 @@ void f2fs_parse_options(int argc, char *argv[])
 				break;
 		}
 	} else if (!strcmp("resize.f2fs", prog)) {
-		const char *option_string = "d:st:V";
+		const char *option_string = "d:st:iV";
 
 		c.func = RESIZE;
 		while ((option = getopt(argc, argv, option_string)) != EOF) {
@@ -476,6 +477,9 @@ void f2fs_parse_options(int argc, char *argv[])
 					ret = sscanf(optarg, "%"PRIx64"",
 							&c.target_sectors);
 				break;
+			case 'i':
+				c.large_nat_bitmap = 1;
+				break;
 			case 'V':
 				show_version(prog);
 				exit(0);
diff --git a/fsck/resize.c b/fsck/resize.c
index fc563f2..46b1cfb 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -512,6 +512,9 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 
 	/* update nat_bits flag */
 	flags = update_nat_bits_flags(new_sb, cp, get_cp(ckpt_flags));
+	if (c.large_nat_bitmap)
+		flags |= CP_LARGE_NAT_BITMAP_FLAG;
+
 	if (flags & CP_COMPACT_SUM_FLAG)
 		flags &= ~CP_COMPACT_SUM_FLAG;
 	if (flags & CP_LARGE_NAT_BITMAP_FLAG)
-- 
2.7.4

