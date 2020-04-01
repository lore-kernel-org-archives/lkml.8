Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB55DC2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8DB2071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvB5xMfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbgDARt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:49:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56138 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726974AbgDARt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585763394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n8Ov33Z36+lHvF5rViWeNYhfdorHlSo9Is6iCBi878w=;
        b=OvB5xMfc/CAN4aImulapCwrQEUWLkAFJYu5xMIpbjZeI8Ya2s3UcC0+JvWs8f61PYT03cq
        OPmFe0yDt6tDFHgA4Pex9I1IwFGcRl9+tZtrT4ZeFAdbRXSn2jwSM1YZjm3k5lzOVNZQsy
        6w8cbAle+6wICwCfHKiPLitGdaTR5bk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-KkCLuziRPNm2MYRPNfnTIw-1; Wed, 01 Apr 2020 13:49:51 -0400
X-MC-Unique: KkCLuziRPNm2MYRPNfnTIw-1
Received: by mail-qt1-f199.google.com with SMTP id l29so560043qtu.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 10:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8Ov33Z36+lHvF5rViWeNYhfdorHlSo9Is6iCBi878w=;
        b=SNH1ODRDePnn1SmRVdpfmTaVFXpMU22W/z54tk7Spd9fS2IZj1Wh0IDGoVbAiFeu+I
         wvd7sA6b8eOkBCJbbCqpXbx85ORGAEbXo2d99AERwrR6elfr1aiHebP0mcFQ+fqhbNlw
         H93La4vqzQLuKDBQngRI0CecLEjOSZwmxbyFdoV6sTo6oheut+iO/dw5tWtEK5Q9yiMU
         J21LfT40trLF8Ypk/R3UGHrfeSNk8geKA7hIUwYjhOqLSHD2SkJOWpiMAkl9enOVfPNR
         gLrXtcacxyX6si15TW1e6h1N0QlL/PnHPaElxt/9Hz6VZ3rujLy2odLhQfbh0m9VQo72
         HMbw==
X-Gm-Message-State: ANhLgQ259i1NdB+Ig7Wp12UtTq/gM9jK6dlYq3JDgU2Y3Igq+QCj/uE7
        l0gWkmlC8xW2q9KScRdUsJZYqvNxme2Lc14BJqtLdtuTsfTTt/M41sE21Xrb7aJk1faw2QA9jk9
        kJsCcKJj7ptXnRYaat46nCSLO
X-Received: by 2002:ac8:6f46:: with SMTP id n6mr11548341qtv.119.1585763390479;
        Wed, 01 Apr 2020 10:49:50 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtVsQ2XgHLfTDm93MKtCwvKwn+8GGG8LrSa5aKMaHcYuqx3eDFWBEhz6eMkU0V/+iU4Y44Tbg==
X-Received: by 2002:ac8:6f46:: with SMTP id n6mr11548319qtv.119.1585763390227;
        Wed, 01 Apr 2020 10:49:50 -0700 (PDT)
Received: from xps13.redhat.com (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id v17sm1812339qkf.83.2020.04.01.10.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 10:49:49 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhoward@redhat.com
Subject: [PATCH] drivers: gpio: xgene-sb: set valid IRQ type in to_irq()
Date:   Wed,  1 Apr 2020 13:49:37 -0400
Message-Id: <20200401174937.3969599-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xgene-sb is setup to be a hierarchical IRQ chip with the GIC as the
parent chip. xgene_gpio_sb_to_irq() currently sets the default IRQ type
to IRQ_TYPE_NONE, which the GIC loudly complains about with a WARN_ON().
Let's set the initial default to a sane value (IRQ_TYPE_EDGE_RISING)
that was determined by decoding the ACPI tables on affected hardware:

    Device (_SB.GPSB)
    {
        Name (_HID, "APMC0D15")  // _HID: Hardware ID
        Name (_CID, "APMC0D15")  // _CID: Compatible ID
        Name (_UID, "GPIOSB")  // _UID: Unique ID
        ...
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            ...
            Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
            {
                0x00000048,
            }
            ...
        }
    }

This can be overridden later as needed with irq_set_irq_type().

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpio/gpio-xgene-sb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index 25d86441666e..b45bfa9baa26 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -122,7 +122,7 @@ static int xgene_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
 	fwspec.fwnode = gc->parent->fwnode;
 	fwspec.param_count = 2;
 	fwspec.param[0] = GPIO_TO_HWIRQ(priv, gpio);
-	fwspec.param[1] = IRQ_TYPE_NONE;
+	fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
 	return irq_create_fwspec_mapping(&fwspec);
 }
 
-- 
2.25.1

