Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCEBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1178520706
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZcFAslD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgFZPtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgFZPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:49:46 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB22C03E979;
        Fri, 26 Jun 2020 08:49:46 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rk21so9860969ejb.2;
        Fri, 26 Jun 2020 08:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mcSloTrT0dn3NloF0dVlYj3JBYhcEl7CXsI9M6agrbs=;
        b=WZcFAslDpTr+doRqig/AdGBayLSS4vp2ooeqch7l287YzEUIBdXdX135jBobDGx3wK
         2mXoFjH8QNtWG6BwyDTtXQPtLCBjjs1nO/l+IOJNdLiUtblQVSsy6cYW1XYq6cLL9aN4
         X/ufDJRHn8a9mzRf9ooa1y5n4Vlqpehs3mzlocH5Bz+b7kYxyJLL4wdtRXVfxTKrtsac
         U1//4TnpqfQRwjrxCNOF4g5o1P2Zgd6Jfw1Grjm/BR9AMOSSm7/n439tYUc/NXQhhYw9
         +krrEzQCQ/MDiLYIeOSM/kCXYJjHDxtCycGYy/W6Q6aP7SomSgtPaK5SlCGyLoSQxgdu
         oWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mcSloTrT0dn3NloF0dVlYj3JBYhcEl7CXsI9M6agrbs=;
        b=LfOEDB+mVrVSHaL9FkNkPyO4IPJB+ELR7BlYTonJmCLUxRwcRarnqKLDZ9Az5U9PpT
         pRpSn1EMt22NWgdU41ZTXFJ9X8yHlIBDxx6aEe6yITFirU/DP0kC8wk9LNpOdFXhngTf
         ku1Bm3offP0a4PsCpBCJeMWbr6GaLlN7hsIyje25Y8bltv+gLXO41Ov7xz+yLnNbeczI
         nCNwZKDxXvgFMsqZD55W2MLEYCQivcvDaF78aDES4uru8nG9EZ9jguztJyIOi8tlsKK8
         oRcIyTbql3suVwdJcN4EpVs308/Je3FRR64+adXRcy9DsTITPiWJn7GTriZyvX9Ihbh7
         2LCQ==
X-Gm-Message-State: AOAM530A3QS1g7NonLwbLAz9yMKQFJQsYfwuNV9vPhVZlM+BX80Vx5Ib
        746/BTH9M7AN8K3qUB2BjOE=
X-Google-Smtp-Source: ABdhPJywFGzATWjQKSS5GJx1j3mwes43kbYokvck3/iyiewhxZmRJVdvD2yUb5mPXE7FbD5kRTfDtQ==
X-Received: by 2002:a17:906:ecb6:: with SMTP id qh22mr2918270ejb.230.1593186585360;
        Fri, 26 Jun 2020 08:49:45 -0700 (PDT)
Received: from BV030612LT ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id a2sm9584834ejg.76.2020.06.26.08.49.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2020 08:49:44 -0700 (PDT)
Date:   Fri, 26 Jun 2020 18:49:41 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v2 1/6] clk: actions: Fix h_clk for Actions S500 SoC
Message-ID: <20200626154941.GA6611@BV030612LT>
References: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
 <58c4bddaf178cb85d9930064af342190f6010e6e.1592941257.git.cristian.ciocaltea@gmail.com>
 <20200626134541.GB8333@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626134541.GB8333@Mani-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 07:15:41PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 24, 2020 at 08:47:52PM +0300, Cristian Ciocaltea wrote:
> > The h_clk clock in the Actions Semi S500 SoC clock driver has an
> > invalid parent. Replace with the correct one.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> You should add fixes tag for this patch and it needs to be backported as well.
> 
> Thanks,
> Mani

Right, I added the tag:

Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")

Thanks,
Cristi

> 
> > ---
> >  drivers/clk/actions/owl-s500.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> > index e2007ac4d235..0eb83a0b70bc 100644
> > --- a/drivers/clk/actions/owl-s500.c
> > +++ b/drivers/clk/actions/owl-s500.c
> > @@ -183,7 +183,7 @@ static OWL_GATE(timer_clk, "timer_clk", "hosc", CMU_DEVCLKEN1, 27, 0, 0);
> >  static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
> >  
> >  /* divider clocks */
> > -static OWL_DIVIDER(h_clk, "h_clk", "ahbprevdiv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
> > +static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
> >  static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
> >  
> >  /* factor clocks */
> > -- 
> > 2.27.0
> > 
