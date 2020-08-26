Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5DFC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 129562087D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YC0J7kOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgHZJhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgHZJfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:35:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1410BC06134A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so1098033wrl.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y9vzHS6aHZF+kDxD6ikVzao6jVEkcdJnGSqUufDJu9w=;
        b=YC0J7kOL2kJwoCB6PgkNpW5h3dq6NVC2Xkws2NJEAH5xD2iKNQobz7x/NieN3UBwaM
         cSn2z7m4Smw7oi2IWzzyP/ohnJE3YCZOtULAeRrePXs6M5iC/emGeaaGP+9bxGeazca/
         XME3AmOZg1kmyCCBeoP7SBIgjOvM0Twrt2+nKfkF8nC8UbaFCTW8QbDAMZ9U2wHWbUmr
         LoKbo+u8L1/REpsf1gxSh/Z8XFx0y1MbeHZJe5QM7dyEyyg+CcQ/0Jdnv6ScroburOgu
         +rAMk8tWQ4Lg9SaajGHqbhpP3cjBL7rEyrGnlPYUwPigpw7QeM8kH5AHWTP5FCw7t5Ct
         fSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9vzHS6aHZF+kDxD6ikVzao6jVEkcdJnGSqUufDJu9w=;
        b=CfMG3o1NM5ZSASJPTRUlDccT6gKpGHYnH8zWj22YcjA4hwAut3SUpAPVX07kfn3AZA
         AdPqYF9eV6lFRFhgjxwvmy5EhbFusFsCJ8Ahg8SiVBoGObLmuTlRNNPtuSB+NxJQ72rd
         AYnb8+sf1wa4bdTYheoslsJWwhSS9zot6z9hsN6zy49/IsS297IA0F5xkYOnkTYsEle9
         xGda/Kg6wzIc16BYxFCm1QBomPXZFUZaoGnINzobd5OTct7Jv2eyGdFC/3/fb3pMtfi/
         sDi3oMtJPpaJWptRp1iFJ+iE/lc/pgRSQQN4/Cz11yXVpfIyZwqGf3OjgmN5/oS86qfZ
         TOMA==
X-Gm-Message-State: AOAM5302x6GDhOMkfHXVAcs6bjCF33TYBK4etc1MOyUV9c9nNubgoOyU
        xaFgyWMq+xSXqxLnbgrbBR7M+Q==
X-Google-Smtp-Source: ABdhPJyN4ci4jtPd/M2OA/JeSCKTm6lmnTrzznvThCroyX1Ow0WW+6LwG7XzM3P56DikPqpdT57ZYg==
X-Received: by 2002:a5d:56c6:: with SMTP id m6mr6343048wrw.204.1598434470695;
        Wed, 26 Aug 2020 02:34:30 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:30 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>
Subject: [PATCH 21/30] wireless: realtek: rtw88: debug: Remove unused variables 'val'
Date:   Wed, 26 Aug 2020 10:33:52 +0100
Message-Id: <20200826093401.1458456-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/realtek/rtw88/debug.c: In function ‘rtw_debug_get_mac_page’:
 drivers/net/wireless/realtek/rtw88/debug.c:430:6: warning: variable ‘val’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/realtek/rtw88/debug.c: In function ‘rtw_debug_get_bb_page’:
 drivers/net/wireless/realtek/rtw88/debug.c:450:6: warning: variable ‘val’ set but not used [-Wunused-but-set-variable]

Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/realtek/rtw88/debug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index f769c982cc91e..985cf5d606159 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -427,12 +427,11 @@ static int rtw_debug_get_mac_page(struct seq_file *m, void *v)
 {
 	struct rtw_debugfs_priv *debugfs_priv = m->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
-	u32 val;
 	u32 page = debugfs_priv->cb_data;
 	int i, n;
 	int max = 0xff;
 
-	val = rtw_read32(rtwdev, debugfs_priv->cb_data);
+	rtw_read32(rtwdev, debugfs_priv->cb_data);
 	for (n = 0; n <= max; ) {
 		seq_printf(m, "\n%8.8x  ", n + page);
 		for (i = 0; i < 4 && n <= max; i++, n += 4)
@@ -447,12 +446,11 @@ static int rtw_debug_get_bb_page(struct seq_file *m, void *v)
 {
 	struct rtw_debugfs_priv *debugfs_priv = m->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
-	u32 val;
 	u32 page = debugfs_priv->cb_data;
 	int i, n;
 	int max = 0xff;
 
-	val = rtw_read32(rtwdev, debugfs_priv->cb_data);
+	rtw_read32(rtwdev, debugfs_priv->cb_data);
 	for (n = 0; n <= max; ) {
 		seq_printf(m, "\n%8.8x  ", n + page);
 		for (i = 0; i < 4 && n <= max; i++, n += 4)
-- 
2.25.1

