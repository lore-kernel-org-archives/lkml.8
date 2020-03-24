Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2D9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9003B20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgCXKJ6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:09:58 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:58831 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgCXKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:09:58 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id BA66024000B;
        Tue, 24 Mar 2020 10:09:55 +0000 (UTC)
Date:   Tue, 24 Mar 2020 11:09:55 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rtc: jz4740: Add support for JZ4760 SoC
Message-ID: <20200324100955.GJ5504@piout.net>
References: <20200311182318.22154-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200311182318.22154-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2020 19:23:16+0100, Paul Cercueil wrote:
> The WENR feature (set a magic value to enable RTC registers read-write)
> first appeared on the JZ4760; the JZ4780 came much later.
> 
> Since it would be dangerous to specify a newer SoC's compatible string as
> the fallback of an older SoC's compatible string, we add support for the
> "ingenic,jz4760-rtc" compatible string in the driver.
> 
> This will permit to support the JZ4770 by having:
> compatible = "ingenic,jz4770-rtc", "ingenic,jz4760-rtc";
> 
> Instead of doing:
> compatible = "ingenic,jz4770-rtc", "ingenic,jz4780-rtc";
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/rtc/rtc-jz4740.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
