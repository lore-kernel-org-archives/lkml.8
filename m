Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28DFC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 08:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0FA207FF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 08:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGekoVrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgFMIWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 04:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgFMIVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 04:21:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BE9C08C5C1;
        Sat, 13 Jun 2020 01:21:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y20so10021427wmi.2;
        Sat, 13 Jun 2020 01:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EiM8JpBzJJPkdg1XS1Ms7nThi6XK6NYvjUfMDMV3we4=;
        b=vGekoVrdkknxL8dRxqLO9M769KZhGeENyVytXE4MdSCxVG90FHVhTJs0zWpAk3Dk/i
         glp0jkI/u+3bwmUmk2kPwwO/w/y9yUTpQJuMbJ1lbdrMi1I2ZDT6KcuFvBStQ/uPUCzD
         ncqPmXpL1HwjSxHdSsr09HnLxkcPsCkYavEmcnPYo5rFaaBpkfx+CUtVErIfR4gIQEZw
         2Y1bj0PD5owcrIT9REVuICinG0Z5b3I0PvlUbka4lbDvg3b7CLGkkiu4i+kcwCnXGXPa
         ZbPwF3f23GHp78le3WniqLI+bAHCrx1z7GTORORgfW34QC4HgaKHWMGTkBeMPB/0SQCh
         Ib2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EiM8JpBzJJPkdg1XS1Ms7nThi6XK6NYvjUfMDMV3we4=;
        b=cyjEf0YoI8660e2idZ4hMQxoEaXZt/oM4Z2iAQVxhW4qnhugCFLOX7NtpMbtjafNl/
         ovd6Zu4RvkeuMIpw6uv9j2zVGQAaDAEW8vTgVrmm9xrAE22fm2x9heKmHriQbqvNPKDL
         wXAYr2h1MThX4g8p6EDhGsnSuZVHusyska0akKQKz5y0wPsx4SP081X2zVwFk8WioJeO
         ymnaVzOrXdIv8K+ioioE+hNFojDXue0hD6BVEo9nFh6VYp4Mq7N8VHmN+f0x/GV9jsOk
         +l/M29MCRKwIjjiOe9ApZ0I7b9qhPo5l7SampI0YTsEAfGCFHl34JgQR3zFqFMPfqWI4
         t97w==
X-Gm-Message-State: AOAM530lbVyK2Q0hJl2ZPV6W4Li5R9xj9GF6g8MoWOeSaernVEEjAWys
        vLWEyXAs5Z2A32tlab66Y7I=
X-Google-Smtp-Source: ABdhPJx8NpCRU70fRrfcT1DYEFGz9YToPBJNwlMmqUtS8GbcC1QgtcjhWzF2HxqlwqnORWtkAlb4KQ==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr2933559wmo.139.1592036513089;
        Sat, 13 Jun 2020 01:21:53 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id n189sm12243603wmb.43.2020.06.13.01.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 01:21:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     hauke@hauke-m.de, zajec5@gmail.com, tsbogend@alpha.franken.de,
        robh+dt@kernel.org, f.fainelli@gmail.com, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v4 9/9] mips: bmips: dts: add BCM63268 power domain support
Date:   Sat, 13 Jun 2020 10:21:40 +0200
Message-Id: <20200613082140.2009461-10-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200613082140.2009461-1-noltari@gmail.com>
References: <20200610171630.465579-1-noltari@gmail.com>
 <20200613082140.2009461-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM63268 SoCs have a power domain controller to enable/disable certain
components in order to save power.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v4: no changes.
 v3: Separate dt-bindings definitions from power domain .dtsi support.
 v2: Add dt-bindings header files.

 arch/mips/boot/dts/brcm/bcm63268.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm63268.dtsi b/arch/mips/boot/dts/brcm/bcm63268.dtsi
index beec24145af7..5acb49b61867 100644
--- a/arch/mips/boot/dts/brcm/bcm63268.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm63268.dtsi
@@ -117,6 +117,12 @@ leds0: led-controller@10001900 {
 			status = "disabled";
 		};
 
+		periph_pwr: power-controller@1000184c {
+			compatible = "brcm,bcm6328-power-controller";
+			reg = <0x1000184c 0x4>;
+			#power-domain-cells = <1>;
+		};
+
 		ehci: usb@10002500 {
 			compatible = "brcm,bcm63268-ehci", "generic-ehci";
 			reg = <0x10002500 0x100>;
-- 
2.27.0

