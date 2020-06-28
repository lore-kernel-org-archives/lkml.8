Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4369C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A34020768
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4AKnM80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgF1Hdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgF1Hdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 03:33:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62720C061794
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 00:33:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so10337635wrw.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 00:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2d9c5rlwJyLS7VkfWg05Pa2UC7lC7fYcPBwq9WTwDEg=;
        b=C4AKnM80AOAfqzONrFQI2edJq1C+Qwf2g45W13kfjvXDYvbGLBJ+zfs5c9Xsupgsav
         P6UIQediDGH9L+twQJO3Zt0ni0EmTykxhzIPQIxzcK8g3ZJpkys0v7Y6Rh1ATKOQoGHK
         uCY3G/cacma7GbiM6KN29nlfObhGyoBbV+rrOseREMFdLmdw/W2+7QU4/Y10SvYKmxdW
         y5cosK/1Rh6k4sOgYDDHYzPNZtvAYd3M/gg+8qls8xoiRulmX+LbEn00u9P6s1zTJi6H
         1VpjdSh/XhBaCYEM52rZv2dxgCOY7Hr4n2gRY0U7imAzy/NR9GDcfVasSKSG+hm/RMLy
         qKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2d9c5rlwJyLS7VkfWg05Pa2UC7lC7fYcPBwq9WTwDEg=;
        b=eEwDFujDK0+smMpyFITuNwdJHnqk0KB5ppPhRBV0iT5feXcGk1UJLdr4Yz3NiWdo4T
         00cCcCDbdJ75p6oQmIU2HLTUzVutARPMrxPjPBKjuDDBgLKoS9x9h3FuEXbJlCbGmFJi
         02zYUY/xSENaG7g/0axVZSqaKqa73xkDUPp4GkMbTSeGwz6xGIFMklmWbMT5c+kYaPbo
         2BpznXwrY2GItp5fFYp4MEnaspHV8KnOYw7MG26rsVgU4i/j7ze2tl7B/QWItg0on/R9
         3wiJbIzsqQbsnEIPpuMe7bqzh525/e9LqGchN2lVk8KqSfHtv1y0OpWf4Z/LzAfp6Hgb
         VUxw==
X-Gm-Message-State: AOAM531QXhnWLV4iWAYhVw9Bugc0G9hA9E5Y/3KsU6dujqqYP3VEjlKX
        0z0BT7auc9UqFQhdMV9xh6s7p6sa
X-Google-Smtp-Source: ABdhPJwZWmGGl1pGY7mCaqScTqLa9a57i4c0tfj0De0ajVq6J+OxF0ndKhCSP3mx22AqqAGuXSj7Bg==
X-Received: by 2002:a5d:4ac3:: with SMTP id y3mr11295573wrs.133.1593329614017;
        Sun, 28 Jun 2020 00:33:34 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-006-252-175.178.006.pools.vodafone-ip.de. [178.6.252.175])
        by smtp.gmail.com with ESMTPSA id j41sm45863734wre.12.2020.06.28.00.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 00:33:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2] staging: rtl8188eu: remove unnecessary comments in hal8188e_phy_cfg.h
Date:   Sun, 28 Jun 2020 09:30:58 +0200
Message-Id: <20200628073058.11228-1-straube.linux@gmail.com>
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
v1 -> v2
Remove one more line as suggested by Dan Carpenter.

 .../rtl8188eu/include/hal8188e_phy_cfg.h      | 25 -------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h b/drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h
index 0c5b2b0948f5..a1055ceb7206 100644
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
@@ -145,22 +138,6 @@ struct bb_reg_def {
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
-/*  BB and RF register read/write */
-/*  */
-
 /* Read initi reg value for tx power setting. */
 void rtl8192c_PHY_GetHWRegOriginalValue(struct adapter *adapter);
 
@@ -181,8 +158,6 @@ void PHY_EnableHostClkReq(struct adapter *adapter);
 
 bool SetAntennaConfig92C(struct adapter *adapter, u8 defaultant);
 
-/*--------------------------Exported Function prototype---------------------*/
-
 #define PHY_SetMacReg	PHY_SetBBReg
 
 #define	SIC_HW_SUPPORT			0
-- 
2.27.0

