Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FE1C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C9862065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnTU5fYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgGZOVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 10:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgGZOVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 10:21:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6B1C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 07:21:09 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so7997675pgf.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZhCt15B3uLAeao+GHzN5068S79fDWl+V7bhkaWPaFeo=;
        b=gnTU5fYprVCLITb+lHayB1yzTAm0ei1nEDo+Rx4j51jwURNYjO1UeLJ+DpytkrFS9O
         MxystjCTHnv2fCBjqM0XJ9Gg30uHtie8B3dPNgGBHAVzJ6mu3K53s8xX3BSJJkaGeEQ9
         u4hJK+R9E2sfHJR6xtgWrTivNLYsy8C2GL7bBlj/+ndN8H/cTRf/SbuRoSjYiB7FGTOW
         xRzIzM6uB7PHUhpHRYNMg4y3vxpiqFEAaCHVduQNoGEyaIBPVFB3ow6WZgJiGHhumkoc
         HD7KkoLiWq51fPXWaNW8pQXIrYC9rKFTEjBPlKu0PF56QDGXDkzsDpOwUhDTfkJu0aXH
         DGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZhCt15B3uLAeao+GHzN5068S79fDWl+V7bhkaWPaFeo=;
        b=c8CRV4IXbm24s1oaNBzce3NX8UPGvzDCXKybw8E3jXW4EgVZeAsbSv0EIC5oLe3T5V
         Hl5/8BAHtwyf0g7jTDLbBeyPnrgzTFMg2ppO9z176wJMZtqKuT38z2aTLnY0eDx+Xb3w
         TM2EAtLnGai5FKmcLSEo4YQp8VLNbKaaqB/u5dx13zF0112txb6GAbTIJUc6GwPoEYWr
         DV49QB3/YVAvoCXaUlx/LL8L1ukQzMG0mkwWY+GxlbtCMy2gu8+MzIRTz+dnC/T7Lk6d
         Rf+YSKrUuMgplOUuR8jslzZ7ARM3SMoTIb49moDDbDvWWDWbHUSkvTYYr5fvIV9URIFT
         1tzw==
X-Gm-Message-State: AOAM532tiaVQ94GeppsBkNVQA4z6pVeL1ZN3Qa0ZTOJPL4UWg97+b//G
        5uAhdu7SAhuGKj31GmfVMWQ=
X-Google-Smtp-Source: ABdhPJyTqnPijCFPE8t2sHXXpZGwdP1euWC4TAGoK7SpRByi2EISpR3FnzovjtQD2XjjbUNCuErWqA==
X-Received: by 2002:a62:2ad6:: with SMTP id q205mr16563573pfq.316.1595773268960;
        Sun, 26 Jul 2020 07:21:08 -0700 (PDT)
Received: from localhost.localdomain ([122.167.86.75])
        by smtp.googlemail.com with ESMTPSA id a13sm12493235pfn.171.2020.07.26.07.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 07:21:08 -0700 (PDT)
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Subject: [PATCH v3 2/4] staging: rtl8723bs: include: Clean up function declations
Date:   Sun, 26 Jul 2020 19:50:11 +0530
Message-Id: <20200726142013.2891-2-aditya.jainadityajain.jain@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200726142013.2891-1-aditya.jainadityajain.jain@gmail.com>
References: <20200726141831.2662-1-aditya.jainadityajain.jain@gmail.com>
 <20200726142013.2891-1-aditya.jainadityajain.jain@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up multiline function declartions in hal_phy_cfg.h
to improve code readablility

Signed-off-by: Aditya Jain <aditya.jainadityajain.jain@gmail.com>
---
 .../staging/rtl8723bs/include/hal_phy_cfg.h   | 44 ++++---------------
 1 file changed, 9 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
index 7e48abc4c760..3cec06e9f359 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
@@ -25,37 +25,16 @@
 /*------------------------------Define structure End----------------------------*/
 
 /*--------------------------Exported Function prototype---------------------*/
-u32
-PHY_QueryBBReg_8723B(
-struct adapter *Adapter,
-u32 	RegAddr,
-u32 	BitMask
-	);
+u32 PHY_QueryBBReg_8723B(struct adapter *Adapter, u32 RegAddr, u32 BitMask);
 
-void
-PHY_SetBBReg_8723B(
-struct adapter *Adapter,
-u32 	RegAddr,
-u32 	BitMask,
-u32 	Data
-	);
+void PHY_SetBBReg_8723B(struct adapter *Adapter, u32 RegAddr,
+			u32 BitMask, u32 Data);
 
-u32
-PHY_QueryRFReg_8723B(
-struct adapter *Adapter,
-u8 		eRFPath,
-u32 			RegAddr,
-u32 			BitMask
-	);
+u32 PHY_QueryRFReg_8723B(struct adapter *Adapter, u8 eRFPath,
+			 u32 RegAddr, u32 BitMask);
 
-void
-PHY_SetRFReg_8723B(
-struct adapter *Adapter,
-u8 		eRFPath,
-u32 			RegAddr,
-u32 			BitMask,
-u32 			Data
-	);
+void PHY_SetRFReg_8723B(struct adapter *Adapter, u8 eRFPath,
+			u32 RegAddr, u32 BitMask, u32 Data);
 
 /* MAC/BB/RF HAL config */
 int PHY_BBConfig8723B(struct adapter *Adapter);
@@ -64,13 +43,8 @@ int PHY_RFConfig8723B(struct adapter *Adapter);
 
 s32 PHY_MACConfig8723B(struct adapter *padapter);
 
-void
-PHY_SetTxPowerIndex(
-struct adapter *Adapter,
-u32 				PowerIndex,
-u8 			RFPath,
-u8 			Rate
-	);
+void PHY_SetTxPowerIndex(struct adapter *Adapter, u32 PowerIndex,
+			 u8 RFPath, u8 Rate);
 
 u8
 PHY_GetTxPowerIndex(
-- 
2.25.1

