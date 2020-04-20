Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1128CC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDC820736
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386474;
	bh=JOOTuWI6U2ZH4Csf9zK1OR4MtIve53GIFno1otkRgWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k132IMA4kyvktdyX+qZDgkj+GLMYTAJO44VL0ntO1ZpnIwqbFKSwmLClQORknfphy
	 bn6dOISsclR4FzBGNMyj9N4HUPUtKKGArKKzA9+CFYOpwK354++Hhr8fPBcSiVgJVb
	 w6+oEZbJHyVH4BhEhTo7UaOAYBR883fO93IqChMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgDTMlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbgDTMlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:41:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 108792072B;
        Mon, 20 Apr 2020 12:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386469;
        bh=JOOTuWI6U2ZH4Csf9zK1OR4MtIve53GIFno1otkRgWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WqmmzPVOMRsaIvc8CrDpjVcGAmwlRHcnDl15JIzKsc/VA/nTEJVWtFNrVfCyeEVmz
         vugL2KB9jOcCeoIOH9PrIJxfR3rkbVmJ2R8nZLbVbm7qJZnmdmjK3qZjr+IMrCrqzc
         +ESdIwg+l0aOfD8OejyGlK2P19/cjUCN2Jl5/ewU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.5 34/65] clk: at91: usb: use proper usbs_mask
Date:   Mon, 20 Apr 2020 14:38:38 +0200
Message-Id: <20200420121513.672436645@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
References: <20200420121505.909671922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

commit d7a83d67a1694c42cc95fc0755d823f7ca3bfcfb upstream.

Use usbs_mask passed as argument. The usbs_mask is different for
SAM9X60.

Fixes: 2423eeaead6f8 ("clk: at91: usb: Add sam9x60 support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lkml.kernel.org/r/1579261009-4573-4-git-send-email-claudiu.beznea@microchip.com
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/at91/clk-usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -211,7 +211,7 @@ _at91sam9x5_clk_register_usb(struct regm
 
 	usb->hw.init = &init;
 	usb->regmap = regmap;
-	usb->usbs_mask = SAM9X5_USBS_MASK;
+	usb->usbs_mask = usbs_mask;
 
 	hw = &usb->hw;
 	ret = clk_hw_register(NULL, &usb->hw);


