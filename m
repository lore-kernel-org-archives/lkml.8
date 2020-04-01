Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E52C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF86E20658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758120;
	bh=2HWcueEfTNlE8Ex8w0UbtPN8RR9ULSYgszf7n7vXJsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ifp1Lce7Bzyr/83Q5eeL6WtRQQ7Y89nkdDN2WRSVeUcfOftw8DKKFlKBDOSxXMgG0
	 p1e0W3Bk98vRxQezvuy4O5DRsuyE+hs4+zaxbaYoUym68KRObv29feIrv4VbxFV608
	 XXO/GdWvo6aRKiJNZbEPWrhvImLk5zbJxMm0bnJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbgDAQV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732839AbgDAQV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:21:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6DC820658;
        Wed,  1 Apr 2020 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758116;
        bh=2HWcueEfTNlE8Ex8w0UbtPN8RR9ULSYgszf7n7vXJsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tn42aJxdSqA/AmfBFXRpKS00CrwiykpLkN6pKEhwkCMbcw4xGAwN8r6s9S82UYgOB
         zvYn9ViK8KjObvvx0TE0xB3St3WksX/CR/ZlNYEZMCCl+S5h9bbDAGvWkQM+rof+8H
         qlqIL0Jm3htljVmYI2Af6uMVnqoJGwSqwrECOm9g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.4 17/27] clk: ti: am43xx: Fix clock parent for RTC clock
Date:   Wed,  1 Apr 2020 18:17:45 +0200
Message-Id: <20200401161428.655179743@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161414.352722470@linuxfoundation.org>
References: <20200401161414.352722470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

commit 5f3d9b07b9bb4679922f0b2e2baa770e74a6bbd3 upstream.

Currently enabling clkctrl clock on am4 can fail for RTC as the clock
parent is wrong for RTC.

Fixes: 76a1049b84dd ("clk: ti: am43xx: add new clkctrl data for am43xx")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Link: https://lkml.kernel.org/r/20200221171030.39326-1-tony@atomide.com
Acked-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/ti/clk-43xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/ti/clk-43xx.c
+++ b/drivers/clk/ti/clk-43xx.c
@@ -78,7 +78,7 @@ static const struct omap_clkctrl_reg_dat
 };
 
 static const struct omap_clkctrl_reg_data am4_l4_rtc_clkctrl_regs[] __initconst = {
-	{ AM4_L4_RTC_RTC_CLKCTRL, NULL, CLKF_SW_SUP, "clk_32768_ck" },
+	{ AM4_L4_RTC_RTC_CLKCTRL, NULL, CLKF_SW_SUP, "clkdiv32k_ick" },
 	{ 0 },
 };
 


