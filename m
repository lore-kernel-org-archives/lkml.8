Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F80AC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5625421655
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJLIbnrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgEHVoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgEHVoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:44:34 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AC4C061A0C;
        Fri,  8 May 2020 14:44:33 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u6so3223139ljl.6;
        Fri, 08 May 2020 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9STgKXxF3MEqSS/+ei2u4BjGAAZhqufG8MU2LAh7EQg=;
        b=kJLIbnrg6MmybxYNLRvCXzrBwTiRUK/PQBatG+wYug1rf68UKki38ZcZuT1lRoWbsD
         k9BuCcn9eiq3d1lG1nH/FtUe/+B243ZvqiwmLqz3MqCB+5QF7CC76BXfqsPHZ/7mJpse
         Uv+Qx520d+eGS18fNhIiuKscNeFnLrY5tFZWC4gUtEf5w5tK6rvv/AH4FaFLKJucWrM4
         qYNsq2Q1dWx8oDvBsErx9COd8mUy31p2DxMkHm9/YOHwnoE/A4pzksst7ekzgtMt439C
         VTGT14vcFyK+nzFOxG96bwVxG0EUMorq1Xbu33eseUwCzBAdOZckzKQy2nu0cGPKXy2x
         A61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9STgKXxF3MEqSS/+ei2u4BjGAAZhqufG8MU2LAh7EQg=;
        b=rFSNTcjQsGBn68St5uDSh/FrNzRZwlroMCsJCSWjc/Mq89kzB409LIiYY3Ml5+wdSV
         //fQiD0x8SEJNwLJvwMvMpVLKj4nhdTEFyyBb8s/bMPh1Dy1gMh+Jdl207oWAEnTJfLO
         RWp4n6AMHFHypChX6dssvqRC2x1hyXVxOLS0CzM9fMyZWyeaW+L0CCN/eTVOS40cJg7/
         XO71oeNBXvK3lck2/oVPDrxPKwoT/V2TVxr60VuEcz3RFiLktZRmgITjpDOM35W+J+NA
         FNt5/I/H3K5g0t2f6RvTTRvN274MaCadnZAqxlIiKyXyB/Qh4s72cNZTTgjliOTm1+iO
         ozrg==
X-Gm-Message-State: AOAM530QaUzWf6EIzcNH+XC8xTjA1swMviXLHSTZV4xxBODMoRfx1PA6
        Sj/nqATp+OWu8cyqVBzKeAg=
X-Google-Smtp-Source: ABdhPJwOERlMcC9Nci0ag57cuaBOQkLsyrFQOZWAIlonkVNH0qg8oU10/kTQbLoBvsCGYzJamq/Sng==
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr2993745ljp.277.1588974272109;
        Fri, 08 May 2020 14:44:32 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id v17sm2174863lfi.49.2020.05.08.14.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 14:44:31 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     chunfeng.yun@mediatek.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] usb: mtu3: constify struct debugfs_reg32
Date:   Fri,  8 May 2020 23:44:21 +0200
Message-Id: <20200508214421.3943-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtu3_prb_regs is never changed and can therefore be made const.

This allows the compiler to put it in the text section instead of the
data section.

Before:
   text    data     bss     dec     hex filename
  19966    7120       0   27086    69ce drivers/usb/mtu3/mtu3_debugfs.o

After:
   text    data     bss     dec     hex filename
  20142    6992       0   27134    69fe drivers/usb/mtu3/mtu3_debugfs.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/usb/mtu3/mtu3_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
index c96e5dab0a48..fdeade6254ae 100644
--- a/drivers/usb/mtu3/mtu3_debugfs.c
+++ b/drivers/usb/mtu3/mtu3_debugfs.c
@@ -276,7 +276,7 @@ static const struct file_operations mtu3_ep_fops = {
 	.release = single_release,
 };
 
-static struct debugfs_reg32 mtu3_prb_regs[] = {
+static const struct debugfs_reg32 mtu3_prb_regs[] = {
 	dump_prb_reg("enable", U3D_SSUSB_PRB_CTRL0),
 	dump_prb_reg("byte-sell", U3D_SSUSB_PRB_CTRL1),
 	dump_prb_reg("byte-selh", U3D_SSUSB_PRB_CTRL2),
@@ -349,7 +349,7 @@ static const struct file_operations mtu3_probe_fops = {
 static void mtu3_debugfs_create_prb_files(struct mtu3 *mtu)
 {
 	struct ssusb_mtk *ssusb = mtu->ssusb;
-	struct debugfs_reg32 *regs;
+	const struct debugfs_reg32 *regs;
 	struct dentry *dir_prb;
 	int i;
 
-- 
2.26.2

