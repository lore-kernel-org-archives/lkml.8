Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 16:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C6A2067C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 16:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjouAZy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgHIQcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:32:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58360 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726175AbgHIQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 12:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596990749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=PsMQY7jSXY4+oAbixnAnftAfol98FgMKGuspJ+Q9XFk=;
        b=WjouAZy/Snmzs6Ax4eLZP8Wtjx76ufPpC8102HpZoHpdyqkc8YiBTHTsVQL4s1fFCob8nc
        Fl1iUdOM4stOZGpcQ/aJ/1Gmrjpz6KCT/h0j2FCvV8xpx0vBG715EsPjkkhKcg837vMSK0
        HeVqE0tsEs3BK2ZuNnJRqysxbfqDssg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-QDUChbIfOJu9pmy-rhCG4g-1; Sun, 09 Aug 2020 12:32:27 -0400
X-MC-Unique: QDUChbIfOJu9pmy-rhCG4g-1
Received: by mail-qv1-f70.google.com with SMTP id y30so5675087qvy.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 09:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PsMQY7jSXY4+oAbixnAnftAfol98FgMKGuspJ+Q9XFk=;
        b=IU4PA8xcseSa9SBvQTcO+0bQt0aagZAVVS1NopTLtpIMBXzQz6SQz8r8flg9QNGCXE
         DNmkfUBYGc34uLxAL73nDJ7eDUKAEIE0aULZ44iyaN3hZbquvX0B+/6JCxdUfMkSYPem
         Q+MBdsBWSzhDSgiusHMMY5lsr4ZBL7upr62iQeigIcPu3TsgTQnX10CDp2kp8myGn9yN
         sda5w7Fq0/9BNICaG8FWSCW91bcE1el8GzhQAu65gT6Mj/45Gp0LP6B5FuS+eKjV/yPj
         5st2R3EVn7EYluwi3gufI0hrBm4TO8QILYpK2+06ichtKvCCHAjS8ruxdILthMWoSbQq
         ivWw==
X-Gm-Message-State: AOAM530I02eTQZ6NOFybcetr3g6m8fWRsiVD3V95YXSpF/1MGaRPi8Fe
        SUGxSlQxGRERtRLtbWklnFjhJHVbfIm39dqHXCAPkpHAjtIaknWN0gjK42xHyUiEu8zlN4AS4YN
        H/dG/vup1kL1kiAMFg8tMz9gX
X-Received: by 2002:a05:6214:290:: with SMTP id l16mr24599894qvv.187.1596990747394;
        Sun, 09 Aug 2020 09:32:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxma2GBDDu2oNvsxHZ9yvLuxWvPbRyHyBBHUXJQyxP4tzEslX0cuIqMV03P+K7mAvDDQKZmWw==
X-Received: by 2002:a05:6214:290:: with SMTP id l16mr24599873qvv.187.1596990747159;
        Sun, 09 Aug 2020 09:32:27 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y3sm8304604qkd.132.2020.08.09.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:32:26 -0700 (PDT)
From:   trix@redhat.com
To:     sean.wang@mediatek.com, pavel@ucw.cz, dmurphy@ti.com,
        matthias.bgg@gmail.com, jacek.anaszewski@gmail.com
Cc:     linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] leds: mt6323: move period calculation
Date:   Sun,  9 Aug 2020 09:32:21 -0700
Message-Id: <20200809163221.32413-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

leds-mt6323.c:275:12: warning: Division by zero
        duty_hw = MT6323_CAL_HW_DUTY(*delay_on, period);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is because period can be 0.

	period = *delay_on + *delay_off;

There is a later check that *delay_on/off are valid.

	if (!*delay_on && !*delay_off) {
		*delay_on = 500;
		*delay_off = 500;
	}

Setting the delay_on/off means period needs to be recalculated
anyway.  So move the period statements after this check.

Fixes: 216ec6cc4c19 ("leds: Add LED support for MT6323 PMIC")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/leds/leds-mt6323.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
index 2a13e3161bf4..7b240771e45b 100644
--- a/drivers/leds/leds-mt6323.c
+++ b/drivers/leds/leds-mt6323.c
@@ -248,15 +248,6 @@ static int mt6323_led_set_blink(struct led_classdev *cdev,
 	u8 duty_hw;
 	int ret;
 
-	/*
-	 * Units are in ms, if over the hardware able
-	 * to support, fallback into software blink
-	 */
-	period = *delay_on + *delay_off;
-
-	if (period > MT6323_MAX_PERIOD)
-		return -EINVAL;
-
 	/*
 	 * LED subsystem requires a default user
 	 * friendly blink pattern for the LED so using
@@ -268,6 +259,15 @@ static int mt6323_led_set_blink(struct led_classdev *cdev,
 		*delay_off = 500;
 	}
 
+	/*
+	 * Units are in ms, if over the hardware able
+	 * to support, fallback into software blink
+	 */
+	period = *delay_on + *delay_off;
+
+	if (period > MT6323_MAX_PERIOD)
+		return -EINVAL;
+
 	/*
 	 * Calculate duty_hw based on the percentage of period during
 	 * which the led is ON.
-- 
2.18.1

