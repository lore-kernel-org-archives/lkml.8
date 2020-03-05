Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BE0C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654F4208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kresin-me.20150623.gappssmtp.com header.i=@kresin-me.20150623.gappssmtp.com header.b="iWLNpIoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCESW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:22:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54921 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgCESWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:22:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id i9so7460584wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Fka8imS/1xK6KJNhtftXLfBrbLrzvdMLMZpCkl8cR10=;
        b=iWLNpIoER9UnuztnR+05HmzAnfkAl3NxxjdwsiL9JsUcDyjTQ+V13sJDvRF/CwMzp4
         o7gU/oN9zypjyyHUlSeZUAIP5obBfz+5CN3Z4B9+bodo9PsjTV3RbEadDxdJzocUxJxz
         8XXzco+fhfKO3iq7fq6PYjmvJx/a4mVZ6tef1hhUyeZCNPGBxZnvNokhMORxph8P535M
         4nwDuBxd3Jnqx0pBWanAFthwus7h1F4uRjM3ARF/qw7ixwaZfhfGeVI+vqi+mTTGoQYy
         wR8FZJ1UXkCx0EYIe5Jp+fyYPhf6U5MJk8HnSvx8PIVjXdmdoMYhWH4Ym+7Urr5CFQ2s
         xnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fka8imS/1xK6KJNhtftXLfBrbLrzvdMLMZpCkl8cR10=;
        b=pYQ98VBA36AZU7/+yzXBn5N94ew5gq4kguyz71el1gnH/fi/Svy8wZm2gAQn2vlkGc
         QcBoyZaq+w3zbi8va6AYj3VxOlPcfbPTw4UZBSwpoUxZFTqEgGUpMFrmmsjnkoR0ghlG
         PIMuDq3TxJnISrCFCDHDVvar9FT9N+WhHs3pGk1xNUGg5VCxXHNsP/0sdwckOEpsDR0M
         uT3XU1X14sx61vdNVTkR9immeEYDh3IDyb2Qrgzhw3JGtY1Thm8Kr1m9JPIxkhxckMtl
         53oeKM9ZGh3w/+MpNsDWQBj0IgMLbL/bK5SUl9ETcVZjOGwb2oySwcCuIy1en7oa8gEC
         76rQ==
X-Gm-Message-State: ANhLgQ03whTcAeJZB77J+D/qYSH45DBFKr/QlvhdMVBq52Dkwd3v/QjT
        YSXDR5Yyg+vwhp03pq+paD0VDQ==
X-Google-Smtp-Source: ADFU+vsIJFiHCoLIv+/msfzl/lI5ZtLr2/v7pFClpu9/Qs0qrq4bL/6WVmA9WiCBf4ySO/dBx+hrzQ==
X-Received: by 2002:a1c:9802:: with SMTP id a2mr57168wme.117.1583432573971;
        Thu, 05 Mar 2020 10:22:53 -0800 (PST)
Received: from desktop.wvd.kresin.me (p200300EC2F0EF80014FA05E763F3370C.dip0.t-ipconnect.de. [2003:ec:2f0e:f800:14fa:5e7:63f3:370c])
        by smtp.gmail.com with ESMTPSA id a5sm10540509wmb.37.2020.03.05.10.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 10:22:53 -0800 (PST)
From:   Mathias Kresin <dev@kresin.me>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] pinctrl: falcon: fix syntax error
Date:   Thu,  5 Mar 2020 19:22:45 +0100
Message-Id: <20200305182245.9636-1-dev@kresin.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing semicolon after of_node_put to get the file compiled.

Fixes: f17d2f54d36d ("pinctrl: falcon: Add of_node_put() before return")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 drivers/pinctrl/pinctrl-falcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-falcon.c b/drivers/pinctrl/pinctrl-falcon.c
index a454f57c264e..62c02b969327 100644
--- a/drivers/pinctrl/pinctrl-falcon.c
+++ b/drivers/pinctrl/pinctrl-falcon.c
@@ -451,7 +451,7 @@ static int pinctrl_falcon_probe(struct platform_device *pdev)
 		falcon_info.clk[*bank] = clk_get(&ppdev->dev, NULL);
 		if (IS_ERR(falcon_info.clk[*bank])) {
 			dev_err(&ppdev->dev, "failed to get clock\n");
-			of_node_put(np)
+			of_node_put(np);
 			return PTR_ERR(falcon_info.clk[*bank]);
 		}
 		falcon_info.membase[*bank] = devm_ioremap_resource(&pdev->dev,
-- 
2.17.1

