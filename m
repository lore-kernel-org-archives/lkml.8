Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACFBC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09D3206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386818;
	bh=JOOTuWI6U2ZH4Csf9zK1OR4MtIve53GIFno1otkRgWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H0+Gj+CPMHypjMdEdGfG2/wsz5NoBvJu9GPGLVXEw8PGx2n5HoaOM81rmNYxg69MY
	 o15bvjRv8QZCrHpumkTXVZrTp8tjf6YbMFJcQ6LHcvHBcQj8HFtg8fm+Sq3nIFNlqc
	 TBJwFLAr/UyKDmaDtC6q0S/A7iTEIkqlHIBSRflg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgDTMq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgDTMqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:46:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1A5E22242;
        Mon, 20 Apr 2020 12:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386797;
        bh=JOOTuWI6U2ZH4Csf9zK1OR4MtIve53GIFno1otkRgWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifshT+GUX2dC2aDXp88j3uDPPOfEM3QV7ATZcxoEgBmVfaLadwdKEqWQmXT9U+1U5
         pajfn7BLU+7gbl1KGJ7kX66BUmZL7/p3YpdQrGLCHpZGLcrRs2Kl//m8QEkJd2qy8i
         e2LQqLQ9KT428Bou5x6zVXIH6sffLYgTdq2K+m/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.4 30/60] clk: at91: usb: use proper usbs_mask
Date:   Mon, 20 Apr 2020 14:39:08 +0200
Message-Id: <20200420121509.331290084@linuxfoundation.org>
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


