Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA9CC33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AC120882
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lzhbjfPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgAJRRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:17:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35315 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgAJRRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:17:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so2784964wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LJ+029g6d1kMuKZjHmcK4CynzHKfYgyeKH9nRPh7CKA=;
        b=lzhbjfPfk19t6AL0qyxVZQ9GlqoWYbfiLPz2M+qi8UINPCtmAmxW5zxIU7dmQVXedT
         iIT6Ngof6Bbf5giZ7v/4QhbEFb0e1HVADVFHFkAdpZ/1PB4Q/aEIKEGgXJoWBuGJxKup
         /Gids0NlPdKQ/AxfQfR85lZCQEMjSKFFcNrQTd+oto2NeRAQUWsrgtf6P5EcOXkMIR2M
         fLKdNRWvDHopsobyZZErkuruMItzSyAAy8i1bgwLEpnm4M3vtISonhgyqJBrIvoUAcHX
         ONuLvlZ/tgTAdjj+3Glr/kP947L+ebAcynuHbhrRIjXsZWIvB7ERU24AVhQYlicZAC92
         GHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJ+029g6d1kMuKZjHmcK4CynzHKfYgyeKH9nRPh7CKA=;
        b=ovxurcZw3LcRyDemlDs+SJ9agsq6BLmm1qkYrDGo31pXLpLstMfyVjt6aEW8sa06Pz
         1IKKbEeTM548jDAR78ddziUpsnon+cUIYP67K7iRoVyh2m4R0YG9BUd6TNwRdRHKcg5E
         yPoU8X+0/7FapmI7pU54c4lwVZqUVkkjxPhSB8H/9g0ZRpxLtXhMdlPvHGn+9z0091km
         q+XaTS7fHyCrY2IlcUMG2q8AoaR0sAuqgdxM0KBxgC19iCVaXA48g+psRsRo0TDzBKMx
         fKXz7vslmSQ3xqvW9z1mb19mxYtnx3AzFzKbMSuBMWxmiAWverxUcoicSGi9wZ8xBX/y
         YGzw==
X-Gm-Message-State: APjAAAUnBdiL/fqUcdSls6ftMMVow9JBsNe7HnG2gK4+Rgv7snoyLdze
        07D6a11KJAP45mElMSGfjZUonOUyM8s=
X-Google-Smtp-Source: APXvYqzB7908YONDlx6fRj1H2RvZiziBUnC5fh3wvW/XzAeIGcVwXTFgGevXhFrXOXGfE9pTysAfCQ==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr5432051wmc.82.1578676623525;
        Fri, 10 Jan 2020 09:17:03 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:b0ec:c83d:aa26:b93])
        by smtp.gmail.com with ESMTPSA id z123sm3072725wme.18.2020.01.10.09.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 09:17:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 1/3] clocksource: davinci: only enable clockevents once tim34 is initialized
Date:   Fri, 10 Jan 2020 18:16:41 +0100
Message-Id: <20200110171643.18578-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200110171643.18578-1-brgl@bgdev.pl>
References: <20200110171643.18578-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The DM365 platform has a strange quirk (only present when using ancient
u-boot - mainline u-boot v2013.01 and later works fine) where if we
enable the second half of the timer in periodic mode before we do its
initialization - the time won't start flowing and we can't boot.

When using more recent u-boot, we can enable the timer, then reinitialize
it and all works fine.

To work around this issue only enable clockevents once tim34 is
initialized i.e. move clockevents_config_and_register() below tim34
initialization.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clocksource/timer-davinci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index 62745c962049..e421946a91c5 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -302,10 +302,6 @@ int __init davinci_timer_register(struct clk *clk,
 		return rv;
 	}
 
-	clockevents_config_and_register(&clockevent->dev, tick_rate,
-					DAVINCI_TIMER_MIN_DELTA,
-					DAVINCI_TIMER_MAX_DELTA);
-
 	davinci_clocksource.dev.rating = 300;
 	davinci_clocksource.dev.read = davinci_clocksource_read;
 	davinci_clocksource.dev.mask =
@@ -323,6 +319,10 @@ int __init davinci_timer_register(struct clk *clk,
 		davinci_clocksource_init_tim34(base);
 	}
 
+	clockevents_config_and_register(&clockevent->dev, tick_rate,
+					DAVINCI_TIMER_MIN_DELTA,
+					DAVINCI_TIMER_MAX_DELTA);
+
 	rv = clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
 	if (rv) {
 		pr_err("Unable to register clocksource");
-- 
2.23.0

