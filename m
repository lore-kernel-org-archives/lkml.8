Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBA7C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D04720729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rMPv1MwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgG0X5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgG0X53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:57:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A129DC061794;
        Mon, 27 Jul 2020 16:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=DrmwEKrz7BHtbJJmQ7m3w5SwKnKl4Ez0pS0H/xr6id8=; b=rMPv1MwJu9ht8NCJpDf6ui19Q+
        v3Tjt4LnnWAjFWdwkvAshvKB7QcgNcECeHYZ5x/RWGCAUlanNkRqvy4G5aA8KiNNNmmcz6w2kV1Ei
        6WPmEvawzNUnS3fzlUjX8GPpesRkmGLnBaxvOM0v72yQp5Qb3RHlhwIgIvvO8W2bpd1DmtbYjqNDN
        wD6VPHd3ZIM1OxafCWQvtihOHa8uhCAp/sjkxV/6BqhsVx1C616Qz+wNElxtTcqvGmoRSZjqMFZom
        y/8cRWNbETqqzzn54cDwOU7FHIA1zFlQ15e7h0HgUWS8evq4uFOEoO+sqhyqacze4rsg0nUqHbDk1
        WZGXSGDQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0Czd-0001yi-26; Mon, 27 Jul 2020 23:57:17 +0000
To:     LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Milo Kim <milo.kim@ti.com>,
        Mathias Nyman <mathias.nyman@nokia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] leds: fix LEDS_LP55XX_COMMON dependency and build
 errors
Message-ID: <dba79c02-b7f1-dd75-b364-93d90538cc5e@infradead.org>
Date:   Mon, 27 Jul 2020 16:57:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Make LEDS_LP55XX_COMMON depend on I2C to fix build errors:

leds-lp55xx-common.c:(.text+0x9d): undefined reference to `i2c_smbus_read_byte_data'
leds-lp55xx-common.c:(.text+0x8fc): undefined reference to `i2c_smbus_write_byte_data'

These errors happened when I2C=m and LEDS_LP55XX_COMMON=y, so
prevent that from being possible.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: linux-leds@vger.kernel.org
Cc: Milo Kim <milo.kim@ti.com>
Cc: Mathias Nyman <mathias.nyman@nokia.com>
---
 drivers/leds/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200727.orig/drivers/leds/Kconfig
+++ linux-next-20200727/drivers/leds/Kconfig
@@ -399,6 +399,7 @@ config LEDS_LP55XX_COMMON
 	tristate "Common Driver for TI/National LP5521/5523/55231/5562/8501"
 	depends on LEDS_CLASS_MULTICOLOR || !LEDS_CLASS_MULTICOLOR
 	depends on OF
+	depends on I2C
 	select FW_LOADER
 	select FW_LOADER_USER_HELPER
 	help

