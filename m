Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC6BC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C03F206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387471;
	bh=v8NLptpyVYC24OZAKei+xlXW2y89vKtkcFa3OBOY2gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fngH4XrfnyIoaPpCgQpHWMYtZhURDv4J4X23Uc6H+Ex5nUD7fXSt25r3OFkEZXKQu
	 IA21/a+DcuvogMedFHKsa+S36rdITNgbc4NdiKpKYUy0uZKh1zTU1TxJgQbb37IhBY
	 0exV5GYwjTebKIuZVyhGAFuJ3F1QdkdyMUJ4C/6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgDTMn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbgDTMnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:43:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C262070B;
        Mon, 20 Apr 2020 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386632;
        bh=v8NLptpyVYC24OZAKei+xlXW2y89vKtkcFa3OBOY2gM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aiFQWp/pHfodZ8hnSc0bQilZOqXxzX4aGZTCBI7I41sWrHn+PLBK8UFYsMyqBCt49
         TAhSLA6AVblUSxhuvO8kIuSqqFyziOn8ELhs2C9CVzuayyOohnd1gFYreIay17SqEJ
         MpMsOIhZbGF7JEuLBrMtLVPY5d4dNh6uFE9BGLcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.6 35/71] clk: at91: sam9x60: fix usb clock parents
Date:   Mon, 20 Apr 2020 14:38:49 +0200
Message-Id: <20200420121516.107953164@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121508.491252919@linuxfoundation.org>
References: <20200420121508.491252919@linuxfoundation.org>
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
 


