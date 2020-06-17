Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8FEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C91221924
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="1pp7YrVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgFQSFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgFQSFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:05:49 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93C5C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:05:48 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dr13so3465036ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=yDJt73mw7weaay3nFZ2M3lWsQoLaL8FRFjLnlYqrKi0=;
        b=1pp7YrVnknNM8LvbhqviZfKRvt81ldvDhhGsjRDo3NxyU+iQtzVy5HnFYycmwRt3HZ
         8kXQwp6KqzKKCgAEuL7X4AaMYTUL5AzZimCdK2+ZkoarZQ2nb7sWmI8waAMh73e544Of
         8W4pFCivlUMvYydSxAexRpQ/u0omhoVZrom6sC8wqe/dPPd0dxgPnX/xRtAsMvzTWrSd
         cg0tCOjc0RVArkFtzbAnZE9mxuTdIsZcoYhWwmRkxPXqIfrpKd+DqtY5XeQ1KWxNct41
         NDB4ME9I5woyo8wnVcumDy9syS2m2y/JCFIKZLKUGf99feP4bI3cWv5/D8Aig4l5eZTi
         xgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=yDJt73mw7weaay3nFZ2M3lWsQoLaL8FRFjLnlYqrKi0=;
        b=XITkTMH0Woc41XSkKg3aKskXcJlfG4jei4ZLgYfCyVncxoF9u5jXoo4SEO/YEvn2i8
         txmPGEB4gUdGNEDt59zhU/m6xxkOe478c0vzn5hqjws8hgXoniWcUQCOdqXThgre3zf7
         mWyUWM0VLFswxy/jHmrGhKe7ySc9QfX8e/iQq+hGKMnVyiTi1n872ZMHWk4WAwKgEKBf
         +uIkU1J//sOHF4YExwv4IGFjx8WGHr+/fc/DYqY7chzEB04hH57XS8Yie682XAt7MYd7
         J3wdyLo9GIqS//ZyvbgsCo316MQ38MKoFSi5lVLjmFSp42hkaqcrxnNTlEb1pd7U8sq1
         NB7Q==
X-Gm-Message-State: AOAM530aMOfVbqvEPpB/QeRja2k57SkYY9bP8WQLWRvmBJd+JYJnrqOE
        dJi3Y6xdqPndXhJAPnqs53GEdw==
X-Google-Smtp-Source: ABdhPJzMWK4g+FCDDXKT/NqpY8aSLOan2cBspKMr8Txzql3WBYoiuuE6IFAEwnRnzTYR8iJpw6uTrw==
X-Received: by 2002:a17:906:7ad7:: with SMTP id k23mr336797ejo.439.1592417147096;
        Wed, 17 Jun 2020 11:05:47 -0700 (PDT)
Received: from x1 (i59F66838.versanet.de. [89.246.104.56])
        by smtp.gmail.com with ESMTPSA id r6sm253016edq.44.2020.06.17.11.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 11:05:46 -0700 (PDT)
Date:   Wed, 17 Jun 2020 20:05:43 +0200
From:   Drew Fustini <drew@beagleboard.org>
To:     trivial@kernel.org, Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] pinctrl: single: fix function name in documentation
Message-ID: <20200617180543.GA4186054@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct the function name in the documentation for
"pcs_parse_one_pinctrl_entry()".

"smux_parse_one_pinctrl_entry()" appears to be an artifact from the
development of a prior patch series ("simple pinmux driver") which
transformed into pinctrl-single.

Fixes: 8b8b091bf07f ("pinctrl: Add one-register-per-pin type device tree based pinctrl driver")
Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
v2:
- add trivial@kernel.org
- add Fixes: tag

 drivers/pinctrl/pinctrl-single.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index a9d511982780..02f677eb1d53 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -958,7 +958,7 @@ static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
 }
 
 /**
- * smux_parse_one_pinctrl_entry() - parses a device tree mux entry
+ * pcs_parse_one_pinctrl_entry() - parses a device tree mux entry
  * @pctldev: pin controller device
  * @pcs: pinctrl driver instance
  * @np: device node of the mux entry
-- 
2.25.1
