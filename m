Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF12C33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400122469C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoQZ24VX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgARRe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:34:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38730 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgARRe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:34:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so10645663wmc.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 09:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jOnsoF053Km6go/T2sCH79lEV40yjl4edkCjg1CpyA=;
        b=NoQZ24VXAyUj4z6tsBB8Qx+DzGN4a1DQTYFtEIpb7diIEpZYqyhfAOj31Nzyf0fYjx
         cD0iXSQccKQ7Cs7WUFE4kyNP3mVSPIJrtp55wfvKcWoeFQf+xAhLX3MbNXkjKBX37XFy
         46FwWhV4ereyL9ZbBt5br183WhNqWC7qQmofDVdOS4i4VojlPsSgQHPBrGn6PsW7vMsj
         MuWJggoip9CBuTZULSdO3MOQBwii++yVMNYSlH0zZhXwPrmSYNJKJLgBJWDmsxGKThSe
         OeQ649qlQ8TnfLyNSKwo87xxYyAKfVyBTYpTJkjZmgrB11zhhjAdl7DskO4RDuVDNM7b
         zvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jOnsoF053Km6go/T2sCH79lEV40yjl4edkCjg1CpyA=;
        b=rxs0kE+TAJnk5ze/FdGF3gsZ5Mm9+q89BidD0l3zdobg0Edevg/TArIBM47yETP9h6
         mPGEA+3XODdzaXjcBnbvwYGMwH9qlQmTKmWqJDmq63k6aKIknMc8jxEbhOKdO6GUvNzu
         QgUGakE2vrkarkzZrZwvIQnQM10ZQ28OnS6yozeZ+UMe1RkXQ80AkMue4xWclU9oz4Oe
         TlSTclHAI13YocPehoKv7JBRucs68Tri1UEocQxJpkRPCCZtGE/CpJKo5vRYOLiZ5cap
         ND3L4rtn6zJh4Zl2rLnSKtDwJRhDIhCNsmONZOZszS1pCJ3lQNrvVPN5APgrKkjh1sYO
         jVKw==
X-Gm-Message-State: APjAAAVq5c6YKiSeo3t9ZX7in9VpGRB3dJImsy0ruqjMf4lSPF2IQRv5
        5wLgM760vcaIb63FaGq+Bro8Qe/YHQU=
X-Google-Smtp-Source: APXvYqyNJ/ed669KI1Q4xpHUpOtEtMZxe1Ov8qJKVXQrA7IRH9Na9w1OuE5JpYQx1lrWhi569zSstg==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr10427783wmb.81.1579368865111;
        Sat, 18 Jan 2020 09:34:25 -0800 (PST)
Received: from localhost.localdomain (dslb-002-204-143-199.002.204.pools.vodafone-ip.de. [2.204.143.199])
        by smtp.gmail.com with ESMTPSA id q11sm39884347wrp.24.2020.01.18.09.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 09:34:24 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: rtl8188eu: remove redundant defines
Date:   Sat, 18 Jan 2020 18:33:42 +0100
Message-Id: <20200118173343.32405-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200118173343.32405-1-straube.linux@gmail.com>
References: <20200118173343.32405-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant defines from hal8188e_phy_cfg.h and rtl8188e_dm.h.
All of them are defined in odm.h with the same values.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h | 5 -----
 drivers/staging/rtl8188eu/include/rtl8188e_dm.h      | 7 +------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h b/drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h
index da66695a1d8f..0c5b2b0948f5 100644
--- a/drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h
+++ b/drivers/staging/rtl8188eu/include/hal8188e_phy_cfg.h
@@ -15,11 +15,6 @@
 #define MAX_TXPWR_IDX_NMODE_92S		63
 #define Reset_Cnt_Limit			3
 
-#define IQK_MAC_REG_NUM			4
-#define IQK_ADDA_REG_NUM		16
-#define IQK_BB_REG_NUM			9
-#define HP_THERMAL_NUM			8
-
 #define MAX_AGGR_NUM			0x07
 
 
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_dm.h b/drivers/staging/rtl8188eu/include/rtl8188e_dm.h
index 19204335ab4c..910b982ab775 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_dm.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_dm.h
@@ -10,12 +10,7 @@ enum{
 	UP_LINK,
 	DOWN_LINK,
 };
-/*  duplicate code,will move to ODM ######### */
-#define IQK_MAC_REG_NUM		4
-#define IQK_ADDA_REG_NUM		16
-#define IQK_BB_REG_NUM			9
-#define HP_THERMAL_NUM		8
-/*  duplicate code,will move to ODM ######### */
+
 struct	dm_priv {
 	u8	DM_Type;
 	u8	DMFlag;
-- 
2.24.1

