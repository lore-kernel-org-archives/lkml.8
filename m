Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EEBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B761F208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUJKLbTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgHZJid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgHZJer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3437C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q14so1083558wrn.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bx7yNWclgWagoUc19DO980I/LQpudxltdUcBDgMx82s=;
        b=uUJKLbTU9CLl0GGHDJpGfj9qHXqTE3vmdSY72df5VY22nwMKPTB/gJEbRC16KsVj7V
         lqf/Msco72OZwC3/z43E9HJuCf6O4FXc4Ln2h+/SPuM85Apb34/d9LJm1+eeVSKbALFc
         c2rVrF2Sh84an294dpobLgvr2n7+wlJehzkTlL83PcF2HIXgrzahwnvouyL2GQg8BVCy
         YzEczRcmVW4jKWDL4pBiFlrSkNOCzvJm1JnA04lj/UemOevD3v2UMxrTXE53HxYDN0d2
         mIfNdwOUuKYx7/GFEVMKTyGbyVQd+W2euTeJ/u8fddVeUrdSAHX+9rPgTn/5CayY333+
         iGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bx7yNWclgWagoUc19DO980I/LQpudxltdUcBDgMx82s=;
        b=RYhoPB5pvntKtviUQKJ6BV9g1kaQB6U0F2j83J3YAKJiJ0blgAzLRay0xocHj0vX7N
         mA4pPPH5G8Xr1Be5Ww9bI4Kbv7WisVi9kVwBRF1wNVDsOIU/WITYxQeZb5NebiFraCbg
         2wPBbR+RStzsInhWKuIrDF/kkzmB9NsLndgoReQwRXjj5n/JBJrBuMij6d8SwLE0udqd
         rnvovbuBoKmA1VyaM0CMO09CgSFQ2fcPsHryFI25SRxwR4d8QfqVjfD4OQfsP6r55NIp
         mi2k3p23jT0vjtImTNY6qw7s1JoY7Vjnpg9DcZ1Rw89Hxzp4oCSClu2e140Q9AmHzs6o
         vR4w==
X-Gm-Message-State: AOAM531NQgOykuDFLY/khKzKFzljzk9ze1OI5Ugcw2Ty2IOLpddJ5hhT
        kGBt/U8wC9LuQk4z+aYqFN6l3g==
X-Google-Smtp-Source: ABdhPJwQFvrvdmFHV9OPBjwjVStS/qGSXw/JVNaDpgJRCYX+jtI39dQIrk6xIFkbAjhbnJEZSJLl9g==
X-Received: by 2002:a5d:4050:: with SMTP id w16mr1517291wrp.412.1598434463554;
        Wed, 26 Aug 2020 02:34:23 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Luciano Coelho <luciano.coelho@nokia.com>
Subject: [PATCH 15/30] wireless: ti: wlcore: debugfs: Remove unused variable 'res'
Date:   Wed, 26 Aug 2020 10:33:46 +0100
Message-Id: <20200826093401.1458456-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Luciano Coelho <luciano.coelho@nokia.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ti/wlcore/debugfs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/debugfs.h b/drivers/net/wireless/ti/wlcore/debugfs.h
index fc3bb0d2ab8da..b143293e694f9 100644
--- a/drivers/net/wireless/ti/wlcore/debugfs.h
+++ b/drivers/net/wireless/ti/wlcore/debugfs.h
@@ -78,13 +78,13 @@ static ssize_t sub## _ ##name## _read(struct file *file,		\
 	struct wl1271 *wl = file->private_data;				\
 	struct struct_type *stats = wl->stats.fw_stats;			\
 	char buf[DEBUGFS_FORMAT_BUFFER_SIZE] = "";			\
-	int res, i;							\
+	int i;								\
 									\
 	wl1271_debugfs_update_stats(wl);				\
 									\
 	for (i = 0; i < len; i++)					\
-		res = snprintf(buf, sizeof(buf), "%s[%d] = %d\n",	\
-			       buf, i, stats->sub.name[i]);		\
+		snprintf(buf, sizeof(buf), "%s[%d] = %d\n",		\
+			 buf, i, stats->sub.name[i]);			\
 									\
 	return wl1271_format_buffer(userbuf, count, ppos, "%s", buf);	\
 }									\
-- 
2.25.1

