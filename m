Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56CAC47258
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9D12496F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="sSELaenv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgEDUMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:12:25 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:24175 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgEDUMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:12:24 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49GDY21b4jzGl;
        Mon,  4 May 2020 22:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588623142; bh=lVLIC8hMj/0zr6xzzWxKI8HUujqMOA03DhHUsoA3EK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSELaenvGR2loMssEW9C2IPbeJJDiP07QoXDXmPDjeihpa36xngv/yqhlQnNLiciW
         aK97Q6unTc7OHBBaPpQMSEU9ECI+m8Z0UiEHl0Ggzx8UVLhlK9x2p3X+KS8W9mDtM1
         yRXlP50WBSyvLl5z3+6WFxIhWb5LL+HXrCHs3rifrGZb2Xz2M1tV9BKkHrVvVHnbkZ
         Ki+0igizq16vYtHxr2Hieb36mugVEbhSHuXmW7swTURL14uA4/6MThhNOkHqHVkUsc
         uoY3tdjDDx3ir3X19XKEiPvdI2x3PpOlTHbTgjS0SDVcw6pLHxOzcLLq/lDAR774RN
         BRYmABHPNDlpQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 4 May 2020 22:12:21 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] clk: at91: allow setting all PMC clock parents
 via DT
Message-ID: <20200504201220.GA21544@qmqm.qmqm.pl>
References: <cover.1588526049.git.mirq-linux@rere.qmqm.pl>
 <ae0c612ce6bc53ea726ddcb25eb36bca78055e33.1588526049.git.mirq-linux@rere.qmqm.pl>
 <20200504200431.GI34497@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504200431.GI34497@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 10:04:31PM +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 03/05/2020 19:19:26+0200, Micha³ Miros³aw wrote:
> > diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> > index c3f4aa6a2d29..adcf608b41fa 100644
> > --- a/include/dt-bindings/clock/at91.h
> > +++ b/include/dt-bindings/clock/at91.h
> > @@ -21,6 +21,9 @@
> >  #define PMC_MCK2		4
> >  #define PMC_I2S0_MUX		5
> >  #define PMC_I2S1_MUX		6
> > +#define PMC_PLLACK		7
> > +#define PMC_PLLBCK		8
> > +#define PMC_AUDIOPLLCK		8		/* SAMA5D2-only, no PLLB there */
> Just use 9 here because we can't know for sure that a future SoC won't
> have both a PLLB and audio PLL.

Ok. I assumed that PLLB is only in old generations. Fix coming shortly.

Best Regrads,
Micha³ Miros³aw
