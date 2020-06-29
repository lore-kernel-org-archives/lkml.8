Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD534C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9FF214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnPjIH3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391124AbgF2V1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgF2Smo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:44 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6909C030F08
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:15:33 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dg28so13314376edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heGKiszYARvox0tZHtQsGW6ogrsChhTM0vUjjAQ7Fxc=;
        b=bnPjIH3An1mt00bkgQp2o32ds9guwFtm/l2yxOJMsPPjrCQRaFOFw58b/wgq61+qz6
         ffC7FuhZSPOuZHBdaQXYTipMPLoEImqRxrQCzc8dHvFHmBZpVsvGp5CWGNx7QJopncJJ
         +tBYoHExJmEI/Cgcji6A0JQX/+vnsTSxV+m4z1nZ7+kkoLq3aYN9vUcUBgF+Aet6J0oM
         tO7LDFT9SoX5Kf3R9KLwif43XUss7VrjqX5dmRU1FUVx35428FvFzyXPeAolGnCQkfBC
         ++S6gCucl7Zz8XFT8ZGCFzxS28/ahcwdFCsFJ53JNMOLAerLb8u2Do7PoWEMQHLpgemD
         sqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heGKiszYARvox0tZHtQsGW6ogrsChhTM0vUjjAQ7Fxc=;
        b=llALyO5ZZiBnNsH5wAdWNysyU/+T9fqfrDrJ9O3fQgaqgvaKDQMUoU4HfwO0HJ1XDB
         KSPMWI1YM8zXWpxj0Qut8PxgbGwNVzwqN88DFMjW8pqewb2YDP82j6aTzl267YGp7UFY
         Wek1NMtTpiquCNWcc0A1YVKEKA4PttCROAxAiGQZRJendG0wwCiOhAK8oqlGTie27VaP
         INeoR8SqrnnWDXOR1PI47gCWTfYTiUdqP8Msbzkvy7zWw1DXb1bcI13c0Ssz8QlQnt6g
         SskPiCY1NeAwCVtgYgFJvFW9BhDpCBmlizVimh+EoNHiwHBVwBGchuU1XRcC7VEiIGR/
         SNZw==
X-Gm-Message-State: AOAM5316nftikXvzXAP38MPFr2jl6UZY2MjUNJ3S9leHlyNdp8k5R/3X
        r8PBr531aDp/dnA7Yp5kMV8=
X-Google-Smtp-Source: ABdhPJyX/7C2PCphFFlJPw5Rs4TlWFjhF5uJNYqqBvCYao2poNLZoN5EPeTH0YCtFu3/aCHjRnDG4w==
X-Received: by 2002:a50:a661:: with SMTP id d88mr18585795edc.34.1593447332650;
        Mon, 29 Jun 2020 09:15:32 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-011-230-176.178.011.pools.vodafone-ip.de. [178.11.230.176])
        by smtp.gmail.com with ESMTPSA id m6sm87831ejq.85.2020.06.29.09.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:15:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: use compound assignment operators
Date:   Mon, 29 Jun 2020 18:12:54 +0200
Message-Id: <20200629161255.28371-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use compound assignment operators to simplify the code and clear
missing spaces around operators checkpatch issues.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index d5968ef9f43d..68196d8c05eb 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -211,7 +211,7 @@ static char *translate_scan(struct adapter *padapter,
 		else/* default MCS7 */
 			max_rate = (bw_40MHz) ? ((short_GI) ? 150 : 135) : ((short_GI) ? 72 : 65);
 
-		max_rate = max_rate*2;/* Mbps/2; */
+		max_rate *= 2; /* Mbps/2; */
 	}
 
 	iwe.cmd = SIOCGIWRATE;
@@ -1395,7 +1395,7 @@ static int rtw_wx_set_rate(struct net_device *dev,
 		ratevalue = 11;
 		goto set_rate;
 	}
-	target_rate = target_rate/100000;
+	target_rate /= 100000;
 
 	switch (target_rate) {
 	case 10:
-- 
2.27.0

