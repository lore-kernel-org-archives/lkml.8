Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939F1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F8820674
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 21:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XucHTUJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgA3V0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:26:52 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39364 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbgA3V0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 16:26:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id 84so2144739pfy.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 13:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKb9L35tQcyRyNMGKuAJ6Ea5QSPI1QLK9JjZ13bjSck=;
        b=XucHTUJGVqo+dvrOVctD99spVTAWc6/H5Ie5rc4c68sI8IZEdOO3i5dcSPJG7jTxwY
         yYLYXQG/Yetkj67ZkEKuFz/saEg5P6jcccVihpjXHkMTowW/qlFnfCP9iRao5tWTSGR6
         76NU6QGK2oEpbP+jc2q8UeV0uStilfnAYz9Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKb9L35tQcyRyNMGKuAJ6Ea5QSPI1QLK9JjZ13bjSck=;
        b=gj5HFze7aoasIrfi57pdahVfbrVbPXM0zpNsKKdVfqb6okzIK4237kv6w1XHyPSEvG
         DEY/RoC40b7/SF6qzZyMihRUtWh4ogq3Tg9aGEtpIgC4+8IxPDoXZnIApjpaFhTqVEVs
         pv2kHbZCOOds56v5LnkUN8ghs5WFJl4dykA9g1qHskooXEiau94vDyVwT2Tl8yEqH2Ta
         97Rq9Expikmhq0vJmq/Z70moJxU0z9HwSn66E7mwVhcHZUZknyhOUNg8qIQWjEcBw/Qj
         46zoyJE5FXWFoTlZPbBzYYbF2v8IaUFttQ3AarUpnQ7CTJrlfoBDNGBuRMVodQDQdVPf
         rwVg==
X-Gm-Message-State: APjAAAUzWBr3iHIKPaJWUCyfOgP9wga6ewN8sAIsF/pvYDdnoXODHk2r
        Kyq3kIgM8qkCTZw5gGRFAJhrJaaT2Xs=
X-Google-Smtp-Source: APXvYqwCPFtA4XbLL5Xs+/nzbHTmkOC4EGS+kZuDiG34/MqMVaU8YEvv9MrjcNSnITYPZCNOCNTvaw==
X-Received: by 2002:a05:6a00:2a3:: with SMTP id q3mr6716522pfs.230.1580419611564;
        Thu, 30 Jan 2020 13:26:51 -0800 (PST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com. [209.85.216.48])
        by smtp.gmail.com with ESMTPSA id o73sm7950807pje.7.2020.01.30.13.26.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 13:26:51 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id gv17so1899558pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 13:26:51 -0800 (PST)
X-Received: by 2002:a67:fa1a:: with SMTP id i26mr4644896vsq.169.1580419157458;
 Thu, 30 Jan 2020 13:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20200124224225.22547-1-dianders@chromium.org> <20200124144154.v2.5.If590c468722d2985cea63adf60c0d2b3098f37d9@changeid>
 <20200129005152.2A3ED205F4@mail.kernel.org>
In-Reply-To: <20200129005152.2A3ED205F4@mail.kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Jan 2020 13:19:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WKDC-58Muq4-TWLZ3V20eQURm7cELMik1FfjcKBnpr7w@mail.gmail.com>
Message-ID: <CAD=FV=WKDC-58Muq4-TWLZ3V20eQURm7cELMik1FfjcKBnpr7w@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] clk: qcom: Fix sc7180 dispcc parent data
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>, kalyan_t@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 28, 2020 at 4:51 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Douglas Anderson (2020-01-24 14:42:20)
> >
> > diff --git a/drivers/clk/qcom/dispcc-sc7180.c b/drivers/clk/qcom/dispcc-sc7180.c
> > index 30c1e25d3edb..380eca3f847d 100644
> > --- a/drivers/clk/qcom/dispcc-sc7180.c
> > +++ b/drivers/clk/qcom/dispcc-sc7180.c
> > @@ -76,40 +76,32 @@ static struct clk_alpha_pll_postdiv disp_cc_pll0_out_even = {
> >
> >  static const struct parent_map disp_cc_parent_map_0[] = {
> >         { P_BI_TCXO, 0 },
> > -       { P_CORE_BI_PLL_TEST_SE, 7 },
> >  };
> >
> >  static const struct clk_parent_data disp_cc_parent_data_0[] = {
> > -       { .fw_name = "bi_tcxo" },
> > -       { .fw_name = "core_bi_pll_test_se", .name = "core_bi_pll_test_se" },
> > +       { .fw_name = "xo" },
>
> If we can make the binding match the code here and keep saying "bi_tcxo"
> then that is preferred. That way we don't have to see bi_tcxo changing
> and qcom folks are happy to keep the weird name. The name in the binding
> is really up to the binding writer.

v3 is now out and it still says "bi_tcxo" and generally uses the
"internal" name.  The big exception is msm8998's gpucc.  It seems like
a whole bunch of work has been done to move that over to more "purist"
(AKA logical) names and I didn't want to undo that work.  If we should
move msm8998 to match everyone else then hopefully someone can do it
as a followup patch?


> >  };
> >
> >  static const struct parent_map disp_cc_parent_map_1[] = {
> >         { P_BI_TCXO, 0 },
> >         { P_DP_PHY_PLL_LINK_CLK, 1 },
> >         { P_DP_PHY_PLL_VCO_DIV_CLK, 2 },
> > -       { P_CORE_BI_PLL_TEST_SE, 7 },
> >  };
> [...]
> > @@ -203,7 +188,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_aux_clk_src = {
> >         .clkr.hw.init = &(struct clk_init_data){
> >                 .name = "disp_cc_mdss_dp_aux_clk_src",
> >                 .parent_data = disp_cc_parent_data_0,
> > -               .num_parents = 2,
> > +               .num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
>
> Can you split this ARRAY_SIZE() stuff to another patch? That will keep
> focus on what's relevant here without distracting from the patch
> contents. I know that parent array size is changing, but I don't want it
> to be changing this line too.

It has been done.

-Doug
