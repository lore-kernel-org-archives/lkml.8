Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A7DC55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B44F20700
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUxj4mDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDYJag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726022AbgDYJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 05:30:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588C8C09B04A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 02:30:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x17so13648261wrt.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqIOpvjAX4aB+i0alurBPqHQCQRYmgJifFMe4+PDeSc=;
        b=DUxj4mDQiE/jn60mXBqDyIIczs085H9kop9QRKaMAq8ft5OCBdGAJbSmf8Zb1OVuxk
         eUzXFjyXVfccJWsBENIond1vHrjdeHxhlRpgjh509u3BzGpCWaafxxdXqWL9arnVeQ17
         J4wngiImwieQ6kJ0K5mEkkd9IImZdSs60wnVfQNtyEuYhZYPKEC+QiEyvytoH6T+Xv/s
         kwEcXleVw4pRzInOu9tp1O0mEomdsZgE02BsYRamRCFk/Lv3+VyjRPIYIVEekMLDTuaO
         S7+u3dAowYaiuNkxbp0nTN9D7Y+o9CKvxMcjoSAQIa5RmgnfsmN5UjpfndvhYFElDFUW
         NVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqIOpvjAX4aB+i0alurBPqHQCQRYmgJifFMe4+PDeSc=;
        b=D6V95nvqsbqPPsbTws7YLG4aJwhfcHbRLL2P9HmxE4Mbqpe38wk4cbv2sQ8/3HiWca
         R8lklfGPeoWiMNMet3kvM3Kmj96/GVaCTpNLvZWLXwVfxltdDFTXXirn51ZUYVCy7f0b
         slpTiYH8BWHj+TeR9pJuTymyJbHSc59Yhn7K9Vlvpb1ZhswD/MFwnhyyTrH2Di1+TpJP
         oC6PZFpcMmVKvfIfoR1jt7bclTRiT4A2Mmcnety76k501K8QnnDNyFo3ozgJRWuiGzQC
         fmWz3v40yDW53ZC/1oG7z376WPkAHiXSMw/I0V5zcfIC7oR1w4ObD1s0q46Bo9sPFKgH
         129A==
X-Gm-Message-State: AGi0PubWCa9/LhSiY34IPKuzziND9IYIXlp2Zp3Q/YzZPnXkvnclktDv
        1MLbmLnDXLY8m0l2n7M+Y8mUdiBn
X-Google-Smtp-Source: APiQypI+RYtCtuxA4FvRIxtod8076du/gFx3J/mEpn4RTDVu1Wq/eruzAVbLdgUgiXC+CA+dOqTHfA==
X-Received: by 2002:a5d:610e:: with SMTP id v14mr15831207wrt.159.1587807033996;
        Sat, 25 Apr 2020 02:30:33 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-006-252-221.178.006.pools.vodafone-ip.de. [178.6.252.221])
        by smtp.gmail.com with ESMTPSA id w6sm12318805wrm.86.2020.04.25.02.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 02:30:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove some superfluous comments
Date:   Sat, 25 Apr 2020 11:28:22 +0200
Message-Id: <20200425092822.19925-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some obviously superflous comments.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm.c          | 2 --
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 2 --
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c  | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index b3cc40527730..28974808839d 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -5,8 +5,6 @@
  *
  ******************************************************************************/
 
-/*  include files */
-
 #include "odm_precomp.h"
 #include "phy.h"
 
diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index a6f2731b076d..65a346ae3cb0 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -5,8 +5,6 @@
  *
  ******************************************************************************/
 
-/*  include files */
-
 #include "odm_precomp.h"
 
 #define READ_AND_CONFIG     READ_AND_CONFIG_MP
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
index 241f55b92808..1af919ff6d93 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
@@ -29,9 +29,6 @@ static void dm_InitGPIOSetting(struct adapter *Adapter)
 	usb_write8(Adapter, REG_GPIO_MUXCFG, tmp1byte);
 }
 
-/*  */
-/*  functions */
-/*  */
 static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 {
 	struct hal_data_8188e *hal_data = Adapter->HalData;
-- 
2.26.1

