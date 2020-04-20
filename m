Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A140C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2D02072B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387235;
	bh=v8NLptpyVYC24OZAKei+xlXW2y89vKtkcFa3OBOY2gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=flFCaOjNV+3YFGydHd10GvpS6kM2wpqeIZfF9WSmpB7Kzypesqk0pN+Ex2mG4ThVl
	 QcgjiS9FhFV3Lm5M/etS257t4OqNBRk5wJowgqPDXP4T7epD7hKHlpb8+VSlV103/b
	 b2nXbk9nBWnPzqUsYjS9WcnB4Je/1wM1do42/qk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgDTMxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgDTMqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:46:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DC9C206E9;
        Mon, 20 Apr 2020 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386794;
        bh=v8NLptpyVYC24OZAKei+xlXW2y89vKtkcFa3OBOY2gM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUQ51uT/D9Ms3RSxpMg36MQnMnsK3O2PmBGzijy75BARpmL3R7or9YV3ngeYJYy2y
         u8XL5F139XgTrOlHMqKuYpoCUjvSNTtGQMSqWOlOcZI0ns3UKD7svHGXUQT/2c42NO
         xqPFmCzFME9nMge43evEpCcz8MwPda1jp11puseE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.4 29/60] clk: at91: sam9x60: fix usb clock parents
Date:   Mon, 20 Apr 2020 14:39:07 +0200
Message-Id: <20200420121509.214895608@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121500.490651540@linuxfoundation.org>
References: <20200420121500.490651540@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

commit 43b203d32b77d1b1b2209e22837f49767020553e upstream.

SAM9X60's USB clock has 3 parents: plla, upll and main_osc.

Fixes: 01e2113de9a5 ("clk: at91: add sam9x60 pmc driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lkml.kernel.org/r/1579261009-4573-3-git-send-email-claudiu.beznea@microchip.com
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/at91/sam9x60.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -237,9 +237,8 @@ static void __init sam9x60_pmc_setup(str
 
 	parent_names[0] = "pllack";
 	parent_names[1] = "upllck";
-	parent_names[2] = "mainck";
-	parent_names[3] = "mainck";
-	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, 4);
+	parent_names[2] = "main_osc";
+	hw = sam9x60_clk_register_usb(regmap, "usbck", parent_names, 3);
 	if (IS_ERR(hw))
 		goto err_free;
 


