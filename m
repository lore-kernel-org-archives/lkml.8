Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABED6C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA92217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608009;
	bh=g3V5GqFuvHm9hAAo7i5DEoNIqNDkI0QlDyTVfPLRz8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=omQC+6DI25Mf8ORxQ+eDZvgtb2VpOl74iL948Tqf5RzoB5MkyHJXA/+/ofUU6eoxH
	 j6Pxbtlh3Pc3rOmxBjX11hDyspmiaoT9E9inF5/8vMS2ev68MkW9F9g6z2rkezNhJY
	 QxdZmmR5NuirvEv+zAWd/esEzqY7AZnBHPqJS5KE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbgBMPd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:33:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729643AbgBMP3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:29:00 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EFC2206DB;
        Thu, 13 Feb 2020 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607740;
        bh=g3V5GqFuvHm9hAAo7i5DEoNIqNDkI0QlDyTVfPLRz8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=13PcozQb7/k8W98A0PF4/v5vcELgzXcnAfug7+E+Rfm/9b3Ja5zJN/z5JQk9yyml3
         mbGuZwSD6iz2iBKLBZE0vIdQIULEzP9vbgxpQdyrytneEqVYIs4owdAyo0nhI0Tyyy
         RA/EGMYuUEyp2lHPts2CwcceY+eGWcyn+3zsNMPg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5.5 076/120] ARM: at91: pm: use of_device_id array to find the proper shdwc node
Date:   Thu, 13 Feb 2020 07:21:12 -0800
Message-Id: <20200213151927.081639499@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

commit ec6e618c8c018c1361d77789a100a5f6f6317178 upstream.

Use of_device_id array to find the proper shdwc compatibile node.
SAM9X60's shdwc changes were not integrated when
commit eaedc0d379da ("ARM: at91: pm: add ULP1 support for SAM9X60")
was integrated.

Fixes: eaedc0d379da ("ARM: at91: pm: add ULP1 support for SAM9X60")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/1576062248-18514-3-git-send-email-claudiu.beznea@microchip.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-at91/pm.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -691,6 +691,12 @@ static void __init at91_pm_use_default_m
 		soc_pm.data.suspend_mode = AT91_PM_ULP0;
 }
 
+static const struct of_device_id atmel_shdwc_ids[] = {
+	{ .compatible = "atmel,sama5d2-shdwc" },
+	{ .compatible = "microchip,sam9x60-shdwc" },
+	{ /* sentinel. */ }
+};
+
 static void __init at91_pm_modes_init(void)
 {
 	struct device_node *np;
@@ -700,7 +706,7 @@ static void __init at91_pm_modes_init(vo
 	    !at91_is_pm_mode_active(AT91_PM_ULP1))
 		return;
 
-	np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-shdwc");
+	np = of_find_matching_node(NULL, atmel_shdwc_ids);
 	if (!np) {
 		pr_warn("%s: failed to find shdwc!\n", __func__);
 		goto ulp1_default;


