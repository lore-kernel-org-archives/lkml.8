Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23815C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F014E2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s03wRDxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgHZJhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgHZJfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:35:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81590C061350
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b18so1092579wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvoQanaWTpWNQEXwywlAc7o43dgHa3QRlp1C/cAGUU4=;
        b=s03wRDxSuZJrkgF2oUckm/dxkHDlEzj7UzMo4Rqm6Jg4UF21WboPJXhBjmsdYI44VB
         T80Qv+u/ejdXfR88W2SGz656OtO/FWRBPOKx1iuuWvDdQrNMTfC5JE0nyJWAnusYydDc
         GOPazXC8CxR2wMTlSrN063oegcaXdEmuxL7OHTkh89TSmAWGWQJIp8QMfdTY51HreW3U
         kc8nEWXR50Oqtd60Nj305DBmXokL7F6Yf9ZUX0h/JTqLq9oSZV5GdQmUxXwIKir3clme
         AOdeWWnagZRvMsJg5BwaVzJpqvtcPMKSGuJ6WkwKZbXsyz1GFTc1PqqJ+D0GvAOe2vAZ
         2yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvoQanaWTpWNQEXwywlAc7o43dgHa3QRlp1C/cAGUU4=;
        b=tsVpmwO4AZdE5LnGeCG6J7LXV0+5AKL5iB65856CDYG1a8w7TC6sunNBXqd0PbCdRM
         aLbbtjju7NZe22LFUobFDkFlJbgnlFd+nfP+8HAMJU+FbDh3Mkn3VdKyF1M7kuWpBiBF
         RYvwnMDxE459qAgEsYK3EuG0RFJwK4Ngob/57QSUXKjUpU5HC5jFURuDU8gaqYC1pT+y
         HgKaYg/mfnNlCsjroLmECMR+bawGZqBLjdLzXrIgryX9Yx/OuKs4cIK8L6DFwbUR6rVX
         4Q+mPnEp0Y5173qKosKS79MUnGXZO8GLpns3RPglTdXvzHJRVm20s8ltHL663Ls8f7KQ
         UFRg==
X-Gm-Message-State: AOAM532lWI25PM1+K6F1Tu+XVVk89f4Xct3KRi3M9WBvcgXpVEjJguPf
        YJr7hquvGi6QpDsqx44tmRxTIA==
X-Google-Smtp-Source: ABdhPJxOfF7uQYb9qaD3r7dWTNKRZIkhB0UM17JPesq9XXKWzSzFYvmfyfGy2TKdAm+01oYhG5XIAA==
X-Received: by 2002:a5d:43ca:: with SMTP id v10mr14464274wrr.299.1598434473214;
        Wed, 26 Aug 2020 02:34:33 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Aurelien Alleaume <slts@free.fr>, Valerio Riedel <hvr@gnu.org>,
        "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
Subject: [PATCH 23/30] wireless: intersil: prism54: isl_ioctl:  Remove unused variable 'j'
Date:   Wed, 26 Aug 2020 10:33:54 +0100
Message-Id: <20200826093401.1458456-24-lee.jones@linaro.org>
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

 drivers/net/wireless/intersil/prism54/isl_ioctl.c: In function ‘prism54_update_stats’:
 drivers/net/wireless/intersil/prism54/isl_ioctl.c:166:6: warning: variable ‘j’ set but not used [-Wunused-but-set-variable]

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Aurelien Alleaume <slts@free.fr>
Cc: Valerio Riedel <hvr@gnu.org>
Cc: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intersil/prism54/isl_ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intersil/prism54/isl_ioctl.c b/drivers/net/wireless/intersil/prism54/isl_ioctl.c
index 3ccf2a4b548c6..5c49b9e52a0c4 100644
--- a/drivers/net/wireless/intersil/prism54/isl_ioctl.c
+++ b/drivers/net/wireless/intersil/prism54/isl_ioctl.c
@@ -163,7 +163,6 @@ prism54_update_stats(struct work_struct *work)
 {
 	islpci_private *priv = container_of(work, islpci_private, stats_work);
 	char *data;
-	int j;
 	struct obj_bss bss, *bss2;
 	union oid_res_t r;
 
@@ -187,7 +186,7 @@ prism54_update_stats(struct work_struct *work)
 	kfree(data);
 
 	/* now ask for the corresponding bss */
-	j = mgt_get_request(priv, DOT11_OID_BSSFIND, 0, (void *) &bss, &r);
+	mgt_get_request(priv, DOT11_OID_BSSFIND, 0, (void *) &bss, &r);
 	bss2 = r.ptr;
 	/* report the rssi and use it to calculate
 	 *  link quality through a signal-noise
-- 
2.25.1

