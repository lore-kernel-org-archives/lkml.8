Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80260C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42CBE20738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxRVNmi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHSH3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgHSHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:24:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B37EC061364
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so20427340wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bfE7YUSssid0azom0g6vClz47uYcy21+hGTRmt0JTBI=;
        b=dxRVNmi7LtW/7lmGHRjFCjuxQP1F9s/8kvSh4etZPkfq8exwIAqqPNFL0aK3SmVfDB
         fHrTrRMVtzuGPBrfz4+XBqHTclM6+fKesqjtjlM2VmRdsOTqBfwh5E+hUcfV6zwLp92b
         fH2nmZpRtlLMovLVRE2Q9NvPh5Gm4KCpaSZpkxEVqoFQX8WhvR+uCaJn+AOy2H2IRgBE
         idK19g+Z6/PGsCXH8WA1yRYhKbziLejExH4d1tqRZ3+3G4i2NlG5KHwpM2tG4KFI77hR
         IcGyMdysPTTn9rGjtpo4ymfWtopmI6cAdfums19zH6QW4KngP6oO2kQIIXzJgAvGGYUb
         Tb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bfE7YUSssid0azom0g6vClz47uYcy21+hGTRmt0JTBI=;
        b=jR0wYbV2ZZQPE4tqAx7wVEU/Anw3nsyugr89dbTmATE7/PQx5+iNJ9RAdjmtH3DzO5
         9MYSBMPjhJDxsdBBKyv5c/Mnx49nUCOMQegeT44L4uriAz+naoWzp0ucRtxEJkpkUKc1
         yg3HQzUx7MVXqK/i31YDt5wM52gabklUkD3FYjUa3/NwtDq9K/NA5revnVl1wYHqjPGG
         lJwcZAUJZwa8IvzQSNd+ZBpXD5m6NbR5hQDu851+YhG9Hc/JLv4CW2bDQCxYC2kleWJc
         w4T9Pt51vtpwQfUmmfmVXz7AEXpgR2xu0LfKqxLv3Qe+3HKnPwUolVBRpMpFicwbZ3Km
         6Oaw==
X-Gm-Message-State: AOAM531yUtJYzx5E0vyNOyGxRO0rub2FK/MATQrUI2lrHFc9CiuXqGy9
        G7NapmSr95bRxib2Nd1HwPkwog==
X-Google-Smtp-Source: ABdhPJzRWBnbNFHIjAgUYgqM4NWDUtxLUBkI0z4KY8VqkEYCch07riiASN+lmqbrHFo7MFbLN2tOzA==
X-Received: by 2002:a5d:6401:: with SMTP id z1mr23375743wru.272.1597821861337;
        Wed, 19 Aug 2020 00:24:21 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Solomon Peachy <pizza@shaftnet.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>
Subject: [PATCH 13/28] wireless: st: cw1200: wsm: Remove 'dummy' variables
Date:   Wed, 19 Aug 2020 08:23:47 +0100
Message-Id: <20200819072402.3085022-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They're never read, so there is no reason for them to exist.

They just cause the compiler to complain.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/st/cw1200/wsm.c: In function ‘wsm_ba_timeout_indication’:
 drivers/net/wireless/st/cw1200/wsm.c:1033:5: warning: variable ‘dummy2’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/st/cw1200/wsm.c:1031:6: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]

Cc: Solomon Peachy <pizza@shaftnet.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/st/cw1200/wsm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/wsm.c b/drivers/net/wireless/st/cw1200/wsm.c
index c86f31dcc9817..d9b6147bbb528 100644
--- a/drivers/net/wireless/st/cw1200/wsm.c
+++ b/drivers/net/wireless/st/cw1200/wsm.c
@@ -1028,14 +1028,12 @@ static int wsm_find_complete_indication(struct cw1200_common *priv,
 static int wsm_ba_timeout_indication(struct cw1200_common *priv,
 				     struct wsm_buf *buf)
 {
-	u32 dummy;
 	u8 tid;
-	u8 dummy2;
 	u8 addr[ETH_ALEN];
 
-	dummy = WSM_GET32(buf);
+	WSM_GET32(buf);
 	tid = WSM_GET8(buf);
-	dummy2 = WSM_GET8(buf);
+	WSM_GET8(buf);
 	WSM_GET(buf, addr, ETH_ALEN);
 
 	pr_info("BlockACK timeout, tid %d, addr %pM\n",
-- 
2.25.1

