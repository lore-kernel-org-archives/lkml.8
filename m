Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17781C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA30524680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zzpVCXjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgBZNxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:53:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33315 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgBZNxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:53:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so3166190wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 05:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3cxtMG4sZ4y/Scu1ZO3icRIO3At+4PfcH7Mul3RpG0=;
        b=zzpVCXjGnNVaBg/Rk4JA9XUtDzvNEn48i7Iszdb+rdrxketdQqCn6Eh7w91livJIDn
         +KxvOa3eKPt/Wn044/IZFFvBcUv7KR474fr/fRUbwSlVIf6KCBM2QJbWnafPNT6FeEAw
         +rXE7gXDNVHwC6qYtHAmOSwiyhXAWHXtMqeeJ43QmPB63KhUmwsQ2s4nbt13gTvHKNbT
         R+fFt8e0qK1bGGIRPZwDSrKD42zZmUtfi4y9m6TzbANVQ3fmm5ep4ykVT4PSPGM9XKuh
         kvcoAuSPF4YTup3lajgudLJ413ewI/bnuec4RqvkQfn9Rh4oY6NNYOQFPHZTO5eYcgER
         LoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3cxtMG4sZ4y/Scu1ZO3icRIO3At+4PfcH7Mul3RpG0=;
        b=Fs7IN11R8KwlrzBebNj9ioU9H6IsnhQkF/XealqRzN3XJciMi4qcpeKuvWpFgB3CUS
         PpSl4fYpfGt07J7KmfVp2sTYFUKYYEJkfM2CTkkCvc8rvmu5/vYd06tJeNyrffMVk8cZ
         0yWKdLjRE0/rQ5P4QqL2PWw1hU+vLWe69FnH66seWN+ZBMPY560Xj1engQuFwrHu8gIQ
         3KGKNsc5bjvprl1A+FdCpfWiWUoUbAqDcmhJWsE7tSdOrgBRosNnMfnRTJWBT/yL945K
         R35YoUkyS4rVf11YKBxt/fNQJCuvFKwbvWi6zDzASRer8hRLZ2mcgvseSb5dLKV7R/zx
         33AA==
X-Gm-Message-State: APjAAAWFRP38cnH1gazR2TGqn2M0DBRepKXmEUp1Fru/rLjLsxjJhU7P
        B1kHjsGjoVgl2B/Et69HXhNiyA==
X-Google-Smtp-Source: APXvYqwId0MNOOSohhYiwMOwoBaxQal9aFkn9RfJOajEiRd99TeuRJKBFRwtdq4N/vks3d9Yq2ZzZw==
X-Received: by 2002:adf:8294:: with SMTP id 20mr6074492wrc.175.1582725211286;
        Wed, 26 Feb 2020 05:53:31 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id w19sm2832783wmc.22.2020.02.26.05.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 05:53:30 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kent Gibson <warthog618@gmail.com>
Subject: [PATCH] gpiolib: fix bitmap operations related to line event watching
Date:   Wed, 26 Feb 2020 14:53:23 +0100
Message-Id: <20200226135323.1840-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

When operating on the bits of watched_lines bitmap, we're using
desc_to_gpio() which returns the GPIO number from the global numberspace.
This leads to all sorts of memory corruptions and invalid behavior. We
should switch to using gpio_chip_hwgpio() instead.

Fixes: 51c1064e82e7 ("gpiolib: add new ioctl() for monitoring changes in line info")
Reported-by: Kent Gibson <warthog618@gmail.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a5cd1b4abe6f..5cc80f6f79e0 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1261,7 +1261,7 @@ static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return -EFAULT;
 
 		if (cmd == GPIO_GET_LINEINFO_WATCH_IOCTL)
-			set_bit(desc_to_gpio(desc), priv->watched_lines);
+			set_bit(gpio_chip_hwgpio(desc), priv->watched_lines);
 
 		return 0;
 	} else if (cmd == GPIO_GET_LINEHANDLE_IOCTL) {
@@ -1276,7 +1276,7 @@ static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (IS_ERR(desc))
 			return PTR_ERR(desc);
 
-		clear_bit(desc_to_gpio(desc), priv->watched_lines);
+		clear_bit(gpio_chip_hwgpio(desc), priv->watched_lines);
 		return 0;
 	}
 	return -EINVAL;
@@ -1304,7 +1304,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	struct gpio_desc *desc = data;
 	int ret;
 
-	if (!test_bit(desc_to_gpio(desc), priv->watched_lines))
+	if (!test_bit(gpio_chip_hwgpio(desc), priv->watched_lines))
 		return NOTIFY_DONE;
 
 	memset(&chg, 0, sizeof(chg));
-- 
2.25.0

