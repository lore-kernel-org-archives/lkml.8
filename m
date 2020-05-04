Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8483AC47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5567A2078C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtEOiAVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgEDXyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbgEDXyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:54:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DFEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 16:54:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so193675wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 16:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yKobP0d+YE9fqWTVBjM8NgVHDYkeVvv/+2LiM8akl8E=;
        b=DtEOiAVzsjODFUCGMGNHWkkg/QB4j93j1k2stANRhYoqqIoQBMZMqL7bff/n6FT6QK
         pAViJwcRNhbVy65QoP7lOh9l8MF+HpA4aSpPTuuQ1jmYBjCGe7TWrI6wHoKGamHyOjei
         3RQEVmMLGQm8H/67MBzWQ+4IVzMVaKElov6EZ8P8c94zefhFxgpmTHsHdbQ+VIfukRE9
         JzLOQOjzTzCUWIQEyUIwvYPxKpTx/9NxOJm2V9ZRubScsB1UEifEDKJoMWJG2sCgTqjo
         ZyLvaQBZQ5+KFWoxSXBlo1/64VItECbYeqi6wyMWeOipcEnIn/qEfGgyGu5bT35gFsyI
         Ghjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yKobP0d+YE9fqWTVBjM8NgVHDYkeVvv/+2LiM8akl8E=;
        b=B7+8Kx6i9cfcK/B0GJt/20vnz2gROADTr449jkynsvt1wuBXCUNo/NJvQsEuHUTmCp
         ozhId4BEiZ1o9U7HCMS4yt15zkDfs4sXE7hF7ybvhyZ0HKDoPRIhIC/S9nqFLdNE2pYs
         E2BGffcRLfnoDpJpyUFeTMkWPh7ZIZRwGebYYs2LHg6H9uN5fwyrwLyNbcxIAhzLKA/E
         s/5VHyrhBTD4DBJZa1zd7CoQJgMthHKG/q632oaltKG1ysABsGQy2gWPgU2qQVIskiK6
         dTtnLRtv8ycgLfh644je/nfHmFTipJafr2w5671r7kLGU/S4zeKBZ/jsWrH7pZPHBpEt
         sp1g==
X-Gm-Message-State: AGi0PuYq++W/I7+6R099yGBXA113cTrBpzOOngSwdyH58fjLCHfjpMlv
        jzsLvY2KDTYhaFDI5i0YqD4=
X-Google-Smtp-Source: APiQypJs/O9zhA/4dyvRB2eoRAkmSEA7TW79fXqp1fel21Z13TuUNgqNw8DA2casKCFpX3jHbZBKsA==
X-Received: by 2002:a1c:e1c1:: with SMTP id y184mr207981wmg.143.1588636481538;
        Mon, 04 May 2020 16:54:41 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id a125sm972385wme.3.2020.05.04.16.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:54:40 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [Patch] mtd: set master partition panic write flag
Date:   Mon,  4 May 2020 19:54:02 -0400
Message-Id: <20200504235403.13504-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check and set master panic write flag so that low level drivers
can use it to take required action to ensure oops data gets written
to assigned mtdoops device partition.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/mtdcore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 2916674208b3..7e37ed2f38ea 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1235,8 +1235,8 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 		return -EROFS;
 	if (!len)
 		return 0;
-	if (!mtd->oops_panic_write)
-		mtd->oops_panic_write = true;
+	if (!master->oops_panic_write)
+		master->oops_panic_write = true;
 
 	return master->_panic_write(master, mtd_get_master_ofs(mtd, to), len,
 				    retlen, buf);
-- 
2.17.1

