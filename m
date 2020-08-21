Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B772C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E6C207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqBAgO7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgHUHTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgHUHSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:18:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6635C0612FB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:27 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so843451wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfFg9RUTuN2F8vvFrXXNIjSsY/KCnm5aECkRX+2ASeo=;
        b=fqBAgO7teh33NdNsTW/b6NzdWawTVywuYK2x6IGwSq9y16dqYDjW9Qz4E2+bBTm8p2
         /NHwhOUOrUsE65XLaAFzWyK+sPwXnCftCi1kJ6bXjLumrqQGyvT0rZMipZFyaXJb3sIi
         kxUOF8EypcuCo/Dplaej0wakhwUKlJuFm6KHSrHrRfpxLcfm9HZoxlq70V11nwU4z9tX
         H4GJm8NiGHnx7bXKyosLaHnqvR84AwIB32o0m3EbrEkjgioE23H3UCcrhFsXXA7K2y3O
         EoCU+FcsBixva9PsetO5BGuGdHmLlF0LRtp2hBQVm6tOopfNW/RqWPFURyp70FieZ1RF
         4+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfFg9RUTuN2F8vvFrXXNIjSsY/KCnm5aECkRX+2ASeo=;
        b=pNfMceMpicxlEuh9rXFSWq5GbXVudMQB9WGXS7Pkt/+kNLh108jhlL5IKojNqJkbxM
         k0e8EBRmAA4OrEjmjH9CIK5BiJLjcl3bjAhnV9HyhQ7esRKOHaxEq5Jk6/WehuRNegOB
         mEg1WAGvCWMKMMactQiWhgZy9FP9nX1jzncP9n+0cvunDPOCpNS6UyqNfMsMphGzGhQs
         DS4SCstVr2iSTcgomyWenFG5ZYdcf28+6+4PplU1WXA19i/0I0BsU2gQKxrsjmdfZOON
         IGdPJVtr9oPjGtCUhbh+6BMWnt5kM+u+TiMTSr9Q4iaBLtezo/b1OzZPFkJBF0tC6vSR
         oT/Q==
X-Gm-Message-State: AOAM533MNZga3rFc3/46KB1sCDOrLRbGDl8R6KkkvRuT+NCe9dNgyNnu
        VpcctKav/M3M383+P8iAroG0mA==
X-Google-Smtp-Source: ABdhPJzav9dQ8PaAelYkZpvnUWV20JKc0zilOzmoa9NhJ7bKNFb+/SCm0MnKs0b6c7YAroxN/IRghQ==
X-Received: by 2002:a7b:c5cf:: with SMTP id n15mr2261791wmk.93.1597994246591;
        Fri, 21 Aug 2020 00:17:26 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:26 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: [PATCH 31/32] wireless: ath: wil6210: wil_platform: Demote kernel-doc header to standard comment block
Date:   Fri, 21 Aug 2020 08:16:43 +0100
Message-Id: <20200821071644.109970-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has been no attempt to document any of the function parameters
here.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/wil6210/wil_platform.c:27: warning: Function parameter or member 'dev' not described in 'wil_platform_init'
 drivers/net/wireless/ath/wil6210/wil_platform.c:27: warning: Function parameter or member 'ops' not described in 'wil_platform_init'
 drivers/net/wireless/ath/wil6210/wil_platform.c:27: warning: Function parameter or member 'rops' not described in 'wil_platform_init'
 drivers/net/wireless/ath/wil6210/wil_platform.c:27: warning: Function parameter or member 'wil_handle' not described in 'wil_platform_init'

Cc: Maya Erez <merez@codeaurora.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: wil6210@qti.qualcomm.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/wil6210/wil_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/wil_platform.c b/drivers/net/wireless/ath/wil6210/wil_platform.c
index 10e10dc9fedfb..35347fe05b33b 100644
--- a/drivers/net/wireless/ath/wil6210/wil_platform.c
+++ b/drivers/net/wireless/ath/wil6210/wil_platform.c
@@ -15,7 +15,7 @@ void wil_platform_modexit(void)
 {
 }
 
-/**
+/*
  * wil_platform_init() - wil6210 platform module init
  *
  * The function must be called before all other functions in this module.
-- 
2.25.1

