Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C786C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 15:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6084621655
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 15:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH43tNwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgF0PSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 11:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgF0PSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 11:18:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E305C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 08:18:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so12275514wrn.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NU9KLKmGGGJvPp19RkXwDYHc15SB6HnPK2Xb5FuPPA4=;
        b=XH43tNwpFGVVg3khLEQCBEjs5TPlPP9gLywPjk21fGzPdo08pV/4IsbQ3xbnt6zguI
         34/BM7kHcr83thA+8JeKs2tZwUcf7RpuRWltaQ/d+MXOtCth+luDRGg2kliElojRGebs
         AGtG30W/wLSG7gIbidZ9MjgqxGIFREqrSvAd9l3EvzrK1mChlQeera9mahWjvkJwe9lA
         htYb7UzQz27bWO/RT2bzisDOFZYPAqyfAT2mhtSkAAcxGEZvK0eQhVnS6DjoaDId6Rtb
         Er6ODEGGwoCPRNMl8/kWoD7pGufUexrNcMX18xvsuaTv6wsdxXDtEyLZv7dIvVtPoyOI
         pSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NU9KLKmGGGJvPp19RkXwDYHc15SB6HnPK2Xb5FuPPA4=;
        b=bpSmr1TZez0D1QX7Rxrk012gIMyqKzv2IZWR1c46Tlq7+29gvhGmnUxU+9RrcgspTY
         q+K6Q59e0AXYypgPD1ElFot9spe9Y4y+eHrRIC8Rocm5QF3dKZuq6emO9vc3JKsBN74f
         LS9gHXjn28S/g4YwBDgCpyL5CivwZmNWjV1kXKtdNh8kfgn4Ji2zyCFLfEI4Y1A9Q/vA
         wW1fCsK+6lHzxW07gmQUTakMYrvt9ww8pa6kJIestX1I/ZX1P1m9D+WUDoZDc8ERmLMS
         hLurMG4ypbWY/0mxO0tSYWDFEr1Fs6my8hCwrv66cxaG4uLjxxfcBRoWyfvED8eQ5G1t
         K07g==
X-Gm-Message-State: AOAM5328wegl5pWN78IFPMRMFOYFvEJS9I7BNY5TkjX1Kk4iw+c5S3xZ
        1zcE7Bjxo+OS7uOl9JRpwuc=
X-Google-Smtp-Source: ABdhPJwHF8Cc75NiCoqdWLrfa/FPxGFh0JpjLi0WPGU7UIEedQzFzmb0A4CuVxua7FvyHzOO96fVKQ==
X-Received: by 2002:adf:9062:: with SMTP id h89mr8288825wrh.285.1593271102040;
        Sat, 27 Jun 2020 08:18:22 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-006-252-175.178.006.pools.vodafone-ip.de. [178.6.252.175])
        by smtp.gmail.com with ESMTPSA id o7sm20454932wmb.9.2020.06.27.08.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 08:18:21 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove unnecessary comments in hal8188e_phy_cfg.h
Date:   Sat, 27 Jun 2020 17:15:44 +0200
Message-Id: <20200627151544.11251-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary comments in hal8188e_phy_cfg.h to improve
readability and clear multiple blank lines checkpatch issues.

CHECK: Please don't use multiple blank lines

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../rtl8188eu/include/hal8188e_phy_cfg.h      | 23 -------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h b/drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h
index 0c5b2b0948f5..78b44bf55f28 100644
--- a/drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h
+++ b/drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h
@@ -7,8 +7,6 @@
 #ifndef __INC_HAL8188EPHYCFG_H__
 #define __INC_HAL8188EPHYCFG_H__
 
-
-/*--------------------------Define Parameters-------------------------------*/
 #define LOOP_LIMIT			5
 #define MAX_STALL_TIME			50		/* us */
 #define AntennaDiversityValue		0x80
@@ -17,11 +15,6 @@
 
 #define MAX_AGGR_NUM			0x07
 
-
-/*--------------------------Define Parameters-------------------------------*/
-
-
-/*------------------------------Define structure----------------------------*/
 enum sw_chnl_cmd_id {
 	CmdID_End,
 	CmdID_SetTxPowerLevel,
@@ -145,21 +138,7 @@ struct bb_reg_def {
 				 */
 };
 
-/*------------------------------Define structure----------------------------*/
-
-
-/*------------------------Export global variable----------------------------*/
-/*------------------------Export global variable----------------------------*/
-
-
-/*------------------------Export Marco Definition---------------------------*/
-/*------------------------Export Marco Definition---------------------------*/
-
-
-/*--------------------------Exported Function prototype---------------------*/
-/*  */
 /*  BB and RF register read/write */
-/*  */
 
 /* Read initi reg value for tx power setting. */
 void rtl8192c_PHY_GetHWRegOriginalValue(struct adapter *adapter);
@@ -181,8 +160,6 @@ void PHY_EnableHostClkReq(struct adapter *adapter);
 
 bool SetAntennaConfig92C(struct adapter *adapter, u8 defaultant);
 
-/*--------------------------Exported Function prototype---------------------*/
-
 #define PHY_SetMacReg	PHY_SetBBReg
 
 #define	SIC_HW_SUPPORT			0
-- 
2.27.0

