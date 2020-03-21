Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A022C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C9B20722
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+2HJ7IE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgCUWZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:25:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40515 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgCUWZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 18:25:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id l184so5376310pfl.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mAhmgr201F3GjjWTmMCpMYY5Zc1UTBtq2w4m7TVaIeU=;
        b=O+2HJ7IEtf1noDrpRDmSJCnPcn+fcsUAQCahss8+FtCDyzZy0Sz6nWT9ZDz5hvFxpC
         AWjGFmKcOcOcxMnRV2Y8eEJhUzcQ3MDQ2qePOGDndplF29nInBW8XdIw26zJGKchzMT+
         XUflKsB6rxWFFIAQ+D3jBHXqTQ0aOz3nSP8C6+jJi2P81inIhv9re1/eA5g3+8TxmCSN
         T41SMtzn3maq9Q1P3JZEjwGAXeH4BGltcns+9lhvetm0NpjnIwvdq763uc0HcT04+Kmd
         Xbl1TB+7dNGeWPRFqt90d6Z48lWY0jIHleuNBpjevZvEl0aF39hCx+dhyoSuqewEw/C2
         x4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mAhmgr201F3GjjWTmMCpMYY5Zc1UTBtq2w4m7TVaIeU=;
        b=MSUw0xmmj922q9ayZfCSBbzqluA/FMfJpaDWGoCRdUH949bRFvxMi3l9CFS+PEsEd1
         pkMvvdv3LxSFKVWdzhT6Axjn+tguU+Ll0ANoGwi235Q4Y885s+cRELDvqhWzYDnw0nwb
         y+t2O2TBCijKhAHxlZr7c2AMng9hTu6ddWmiR8ZE+OBlmHNXDahjis7WLaf8NAMtEVpx
         wxzTUJmiLVwjJdMqrbVhKSNxnBqwYrot9Dz47NA7A8pyU0Y7Kq3Iq5UM/M3F+dKT9S9f
         KPiJHf1zr3b3ER5Tx7pPh3S031907FoGiZvbZo78yUz2SuKkJ0XvTyCa7RrYYrUpSPGh
         gGhg==
X-Gm-Message-State: ANhLgQ3Fxt/9AspBxrTCbKWVB4pR8By5gtnLuy4JxkC73DbfTpjYG0ff
        Wr/RkHJEkEs4TOLlqpPeO4I=
X-Google-Smtp-Source: ADFU+vsyEd7bpVl93Yp8/Rjb/7dX7rkaj1rjklbifa7zkg3PLPJF9mzbjZHsZjebqCF2UvKGHogovQ==
X-Received: by 2002:a63:7416:: with SMTP id p22mr13500492pgc.32.1584829520646;
        Sat, 21 Mar 2020 15:25:20 -0700 (PDT)
Received: from localhost.localdomain ([113.193.33.115])
        by smtp.gmail.com with ESMTPSA id x11sm6998244pgq.48.2020.03.21.15.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 15:25:20 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [Outreachy kernel] [PATCH 05/11] Staging: rtl8188eu: pwrseqcmd: Add space around operators
Date:   Sun, 22 Mar 2020 03:55:13 +0530
Message-Id: <4847208f6bc4ef05b3f685e390dea6b2fc4b4464.1584826154.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1584826154.git.shreeya.patel23498@gmail.com>
References: <cover.1584826154.git.shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add space around operators for improving the code
readability.
Reported by checkpatch.pl

git diff -w shows no difference.
diff of the .o files before and after the changes shows no difference.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

shreeya@Shreeya-Patel:~git/kernels/staging$ git diff -w drivers/staging/rtl8188eu/hal/pwrseqcmd.c
shreeya@Shreeya-Patel:~git/kernels/staging$

shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$ diff pwrseqcmd_old.o pwrseqcmd.o
shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$

 drivers/staging/rtl8188eu/hal/pwrseqcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/pwrseqcmd.c b/drivers/staging/rtl8188eu/hal/pwrseqcmd.c
index 249cbc375074..77edd7ad19a1 100644
--- a/drivers/staging/rtl8188eu/hal/pwrseqcmd.c
+++ b/drivers/staging/rtl8188eu/hal/pwrseqcmd.c
@@ -85,7 +85,7 @@ u8 rtl88eu_pwrseqcmdparsing(struct adapter *padapter, u8 cut_vers,
 				if (GET_PWR_CFG_VALUE(pwrcfgcmd) == PWRSEQ_DELAY_US)
 					udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd));
 				else
-					udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd)*1000);
+					udelay(GET_PWR_CFG_OFFSET(pwrcfgcmd) * 1000);
 				break;
 			case PWR_CMD_END:
 				/* When this command is parsed, end the process */
-- 
2.17.1

