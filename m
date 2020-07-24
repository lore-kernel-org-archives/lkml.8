Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB900C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993A520767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595582441;
	bh=VTwN0IdMajgbQVCZwuFqjGSNxmcUBVYSXJq8+7fBKq0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=knhskqt5mYZNPnbYC8MEdb+cPVjpnqAAihIB4+mZTK5yXAUGmW3qPoxWM3C2/iMP0
	 brLv0EWgZ/ZSVFySmHMEUt11FblzehvRwngAzM8TBQTA75Au+tBMiKceF+9DYt5QCT
	 ZRfJUMCwotM1Y3Kcvae5ZPQHpEQhUMSWSixyYB5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgGXJUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbgGXJUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:20:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC2A2074F;
        Fri, 24 Jul 2020 09:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595582438;
        bh=VTwN0IdMajgbQVCZwuFqjGSNxmcUBVYSXJq8+7fBKq0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IIpPdDUmXQziyESQtm0qF+FIEzMsyN/1H20DPJPiWOCoMuDR43dUhUVDFzW3gDXR0
         Hwp/aVCgGCu+miBH0fQIycMMJw3NcdLy+YE5GFXXk1qsml6iZSLttedcmKTLRqcpDk
         54QHNCrByC/Zi59lE8IF4QpsA+LLcPqgaC83Texg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595403506-8209-2-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com> <1595403506-8209-2-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 01/18] clk: at91: clk-generated: continue if __clk_determine_rate() returns error
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Fri, 24 Jul 2020 02:20:37 -0700
Message-ID: <159558243734.3847286.9752234252878054990@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-07-22 00:38:09)
> __clk_determine_rate() may return error. Skip the current step
> in case of error.
>=20
> Fixes: 1a1a36d72e3d3 ("clk: at91: clk-generated: make gclk determine audi=
o_pll rate")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next
