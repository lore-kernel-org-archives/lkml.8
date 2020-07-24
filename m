Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B50BC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A6F20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595582487;
	bh=NoiQQKq2UrJBOToHS3LbdiX2Te3HUXoc6HhIkqU9bYw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=XC9TMb3H7yVmfIUXceenrltzamjnnokbZFQ9ImfSN4DdffP4BRg7HEQ9e40hFWgWU
	 Sf93zTZtbM3LjasV7WenFS6KcL3InvSKDuL10GgAW4CrMsEWrkCt2JUzUjSFn9yRCs
	 V0TBXhSk2piTR+q/hcgrbR8x32v9e6op0XqqrNK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgGXJVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGXJVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:21:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3ECC2063A;
        Fri, 24 Jul 2020 09:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595582484;
        bh=NoiQQKq2UrJBOToHS3LbdiX2Te3HUXoc6HhIkqU9bYw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KwIzMMErUw7dVCzthD4oE2dloBB+56NoaOzKAonB/3yD0493iGtwxZo0Eg8yNZi0X
         bkqTsFR+Yadh331Wh4dzdP1d2k9+OA8Ub+H4xdHOrOroyui3TZR4ZUdoZylWRHk8DS
         cjy+xD7IoMp+4eFQFIzk9wLmffo6armjbI5JT1FU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595403506-8209-9-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com> <1595403506-8209-9-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 08/18] clk: at91: sckc: register slow_rc with accuracy option
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Fri, 24 Jul 2020 02:21:24 -0700
Message-ID: <159558248412.3847286.6927039947131599378@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-07-22 00:38:16)
> Chapter 57.7.5 of SAM9X60 datasheet specifies that the maximum drift of
> this oscillator is +- 3KHz. Use that value and the formula at [1]
> or the calculator at [2] to compute the PPB value.
>=20
> [1] https://www.everythingrf.com/rf-calculators/ppm-to-hz-calculator
> [2] https://www.changpuak.ch/electronics/ppm_to_Hz_converter.php
>=20
> Fixes: 04bcc4275e601 ("clk: at91: sckc: add support for SAM9X60")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
