Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A866C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397A22076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="BousnIH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgGRPxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRPxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 11:53:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD24CC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:53:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so21220457wmi.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nm7RbRbPXsGrD5oeSS4NsVpJcs55MiMj/6SWijtpEjw=;
        b=BousnIH6TWxTOBuP6LlByW1rJ2d7ZIi1dhlxP/92+rdVWYIm+UwlgtzTh/JdDvY810
         3mLF+bW3d3wmVhklOzBmxIKlj9NjiNxPzWl+VCYZHkwYGJ+p31uwC767CTqRBSrNmH2D
         KLQ4/1SUBUG/0j52bY65Btclx94bWLVL6mmypADVLgbqsPIJwu8BYpPmq1/KJ7tAQ6W+
         VUNk98nrVOubafzIbrB1wAB3etaT/gZ41fVGzgYWEWyAxn5U9Ug8x0CFbI+mFVrj0Tn2
         +8CRVASIuskUTdMhrLa83t196RP1EZRhuV4UmxSFoO3hE34kGkbLc7Hgt4bm+8QOC69i
         Tl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nm7RbRbPXsGrD5oeSS4NsVpJcs55MiMj/6SWijtpEjw=;
        b=BJza+B+g+n6yjvlb5+VZ/3LRGvq7CDfaUkOiSpltKK/XGZuQcZ8v84M9TPnUVT/s5d
         qH69dPigGJ7bRivWtR1YtL4muNojvbz4MhqY4Mnmhn6tnyhBydIuxkf7J8Ezb9McEsdD
         pO0+rYqERrHDQlXs5vkon74z0oCw06Ic+FRZm6h/s2E9QwiXqiXCo/XbUUHQimyl6iRv
         d74xbe1BguBVoRqH1OPqWOzNNgkIbi9ml+Y5zaSTGy4BVR321W3NjRZcMSrWbe2SyLbl
         ZBg6+Y6q9oSLVMAxTTXGjV0OkxUjM07+7lOyDO4z5dL/StpuKKVreNdEsvvpw4Gdh6y8
         mOlg==
X-Gm-Message-State: AOAM530MA8bfVC1KSkdLT9GFlAN2t1GYLvzP5pLl3i3ksLaHbWqxKjbA
        xIUAyxhVnboLGU7o3Z3php0OrQ==
X-Google-Smtp-Source: ABdhPJybWy/0R3DSJk1V+N6uY+brwF6uf7mCMJfmMhhasJYalSP2zIEWXZfA9FMYPFmiKFdMaqWoFg==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr14371545wmc.117.1595087588317;
        Sat, 18 Jul 2020 08:53:08 -0700 (PDT)
Received: from localhost.localdomain (195.red-80-27-212.dynamicip.rima-tde.net. [80.27.212.195])
        by smtp.gmail.com with ESMTPSA id s10sm21284623wme.31.2020.07.18.08.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 08:53:07 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH] pinctrl: core: print gpio in pins debugfs file
Date:   Sat, 18 Jul 2020 17:49:10 +0200
Message-Id: <20200718154908.1816031-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a gpio range mapping for the pin, then print out the gpio
number for the pin in the debugfs 'pins' file.

Here is an example output on the BeagleBone Black from:
/sys/kernel/debug/pinctrl/44e10800.pinmux-pinctrl-single/pins

pin 103 (PIN103) GPIO-113 44e1099c 00000027 pinctrl-single
pin 104 (PIN104) GPIO-114 44e109a0 0000002c pinctrl-single
pin 105 (PIN105) GPIO-115 44e109a4 00000027 pinctrl-single
pin 106 (PIN106) GPIO-116 44e109a8 00000027 pinctrl-single
pin 107 (PIN107) GPIO-117 44e109ac 00000027 pinctrl-single
pin 108 (PIN108) GPIO-19 44e109b0 00000027 pinctrl-single
pin 109 (PIN109) GPIO-20 44e109b4 00000027 pinctrl-single
pin 110 (PIN110) 44e109b8 00000030 pinctrl-single
pin 111 (PIN111) 44e109bc 00000028 pinctrl-single
pin 112 (PIN112) 44e109c0 00000030 pinctrl-single
pin 113 (PIN113) 44e109c4 00000028 pinctrl-single
pin 114 (PIN114) 44e109c8 00000028 pinctrl-single

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
Note:
- I am hoping to get feedback if another format is better.  Currently
  the column 'GPIO-xxx' will only be printed when there is a GPIO num

 drivers/pinctrl/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 70e13fcd94c4..e3eee950a553 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1633,6 +1633,8 @@ static int pinctrl_pins_show(struct seq_file *s, void *what)
 	struct pinctrl_dev *pctldev = s->private;
 	const struct pinctrl_ops *ops = pctldev->desc->pctlops;
 	unsigned i, pin;
+	struct pinctrl_gpio_range *range;
+	unsigned gpio_num;
 
 	seq_printf(s, "registered pins: %d\n", pctldev->desc->npins);
 
@@ -1650,6 +1652,16 @@ static int pinctrl_pins_show(struct seq_file *s, void *what)
 
 		seq_printf(s, "pin %d (%s) ", pin, desc->name);
 
+		gpio_num = 0;
+		list_for_each_entry(range, &pctldev->gpio_ranges, node) {
+			if ((pin >= range->pin_base) &&
+			    (pin < (range->pin_base + range->npins)))
+				gpio_num = range->base + (pin - range->pin_base);
+		}
+
+		if (gpio_num > 0)
+			seq_printf(s, "GPIO-%u ", gpio_num);
+
 		/* Driver-specific info per pin */
 		if (ops->pin_dbg_show)
 			ops->pin_dbg_show(pctldev, s, pin);
-- 
2.25.1

