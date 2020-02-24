Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20293C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAF32084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WixG3cAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgBXKRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:17:42 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35825 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXKRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:17:41 -0500
Received: by mail-io1-f65.google.com with SMTP id h8so9710668iob.2;
        Mon, 24 Feb 2020 02:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tqgnHB78w+khquGpyEPrfbvz14CK0FBf/BfCrVKj88=;
        b=WixG3cAlWOKVA4zty0GxO81FbCDDDdvXcsrqJIiNoeOazlCyYJhLt//qepqkHWRO+i
         au8MthJG6xQCVYimonXq9J9UTkxQXTdXeNwnnCFAHRTYFa09tVbWDVrszuNNcd48xy79
         M4607MnC3gbpRzJcoaCojUBEi5DyF0la38CNAh+2NTCj+lJ+103ixbRogzGDVh1V4uM+
         9+r0ecBMS49H+uLc6Edb//J6Pj451lLdugtqNKHmng3AISj9RlOqV9UNxLAUgRxMb2bU
         xkN1jLWgnF70i9ajrtqOS07p8Qzum6J0p4vXRWAInArvAziclsYDozRZmKb9k128O5se
         MvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tqgnHB78w+khquGpyEPrfbvz14CK0FBf/BfCrVKj88=;
        b=bNCcRnyk0ujTkRi2WuPJz7sNGdZZG0zY6b+6BGuH4xxPhTJfA2j2xTPii2Kd4u0vBW
         hi3WluAjkHiTJss3qZgsR+Y/ewSQo4NOJqVXIItrowhQYIzYXqcWnQjAGxAN2Phinklf
         3lDY8TR7myuisQMogyMh8HTrNdV3igzF9yKsU+Fq2TvuFo5xI1Q013MB9lIOLcLOZ1sL
         V1Phs4BUjpb5f2LZ1Gt48r5onmtZifjFrnbjD+gjpA2qagsEBLIETnpK9jFmYn4xDKH7
         hovnof7K9GcE87cKFy+p54Pgdg3Z6yN6EC7QPaddqpl+Ctm9c7/jN8UpG5cPwfUCCIYv
         l4eA==
X-Gm-Message-State: APjAAAXMeEpHKkSsCme3RTY8j+illlWR1z9/MgOnFC8TWcpaCb5J9lUR
        CfT863YF02NMdAMMVJWy17PUKdXPYN1uD2iRniDsIILt
X-Google-Smtp-Source: APXvYqwPv4BN9QmonBXFEkWlD/VhU4fuL8hHLJ8UwrlbVXmch79Uws0KccS8fO8B/i+cYv9Wj4Xn1YJ0Kro0+Mktymw=
X-Received: by 2002:a6b:b48e:: with SMTP id d136mr50065897iof.243.1582539460606;
 Mon, 24 Feb 2020 02:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20200216173446.1823-1-linux.amoon@gmail.com> <20200216173446.1823-4-linux.amoon@gmail.com>
 <1jmu9hzlo2.fsf@starbuckisacylon.baylibre.com> <CANAwSgSaQgU=H3h0S9deT11HA8z9R=Fhy5Kawii9tSBxKf2Wgw@mail.gmail.com>
 <CAFBinCCSosE1XfwbKZOR9G+DVYg8zFcKShmTNWUhh1e8W0VoAQ@mail.gmail.com>
 <CANAwSgRZy1K0GZq30cEoH2KiJfjX-5LvkMy79ZeM_aSEyrkD+g@mail.gmail.com> <1jo8togwmi.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jo8togwmi.fsf@starbuckisacylon.baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 24 Feb 2020 15:47:29 +0530
Message-ID: <CANAwSgSKUEJEe_H6XnKmHZNtB549jLau=TY00jzCHAC8zb_7oA@mail.gmail.com>
Subject: Re: [PATCHv1 3/3] clk: meson: g12a: set cpu clock divider flags too CLK_IS_CRITICAL
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Jerome,

On Mon, 24 Feb 2020 at 15:01, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Sun 23 Feb 2020 at 14:34, Anand Moon <linux.amoon@gmail.com> wrote:
>
> > Hi Martin / Jerome / Neil,
> >
> > On Fri, 21 Feb 2020 at 02:45, Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> >>
> >> Hi Anand,
> >>
> >> On Mon, Feb 17, 2020 at 2:30 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >> [...]
> >> > > > @@ -681,7 +682,7 @@ static struct clk_regmap g12b_cpub_clk = {
> >> > > >                       &g12a_sys_pll.hw
> >> > > >               },
> >> > > >               .num_parents = 2,
> >> > > > -             .flags = CLK_SET_RATE_PARENT,
> >> > > > +             .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> >> > >
> >> > > Why not. Neil what do you think of this ?
> >> > > If nothing is claiming this clock and enabling it then I suppose it
> >> > > could make sense.
> >> > >
> >> > I would like core developers to handle this.
> >> > Sorry for the noise.
> >> can you please resend this patch with only the change to g12b_cpub_clk?
> >> I have no G12B board myself so it would be great if you could take care of this!
> >>
> >>
> >> Martin
> >
> > Thanks, yes I will try again, but I have a question.
> >
> > On eMMC module  *cpub_clk* is not getting enabled, see below is
> > clk_summay of eMMC.
>
> I'm sorry but I don't understand the link between the cpu clock of the
> second cluster and MMC.
>
> > [...]
> >           fclk_div2_div               1        1        0   999999985
> >         0     0  50000
> >              fclk_div2                2        2        0   999999985
> >         0     0  50000
> >                 ff3f0000.ethernet#m250_sel       1        1        0
> > 999999985          0     0  50000
> >                    ff3f0000.ethernet#m250_div       1        1
> > 0   249999997          0     0  50000
> >                       ff3f0000.ethernet#fixed_div2       1        1
> >     0   124999998          0     0  50000
> >                          ff3f0000.ethernet#rgmii_tx_en       1
> > 1        0   124999998          0     0  50000
> >                 ffe07000.mmc#mux       1        1        0   999999985
> >          0     0  50000
> >                    ffe07000.mmc#div       1        1        0
> > 199999997          0     0  50000
> >                 cpub_clk_dyn1_sel       0        0        0
> > 999999985          0     0  50000
> >                    cpub_clk_dyn1       0        0        0   999999985
> >          0     0  50000
> >                       cpub_clk_dyn       0        0        0
> > 999999985          0     0  50000
> >                          cpub_clk       0        0        0
> > 999999985          0     0  50000
> >                             cpub_clk_div8       0        0        0
> > 124999998          0     0  50000
> >                             cpub_clk_div7       0        0        0
> > 142857140          0     0  50000
> >                             cpub_clk_div6       0        0        0
> > 166666664          0     0  50000
> >                                cpub_clk_trace_sel       0        0
> >    0   166666664          0     0  50000
> >                                   cpub_clk_trace       0        0
> >   0   166666664          0     0  50000
> >                             cpub_clk_div5       0        0        0
> > 199999997          0     0  50000
> >                                cpub_clk_apb_sel       0        0
> >  0   199999997          0     0  50000
> >                                   cpub_clk_apb       0        0
> > 0   199999997          0     0  50000
> >                             cpub_clk_div4       0        0        0
> > 249999996          0     0  50000
> >                             cpub_clk_div3       0        0        0
> > 333333328          0     0  50000
> >                                cpub_clk_atb_sel       0        0
> >  0   333333328          0     0  50000
> >                                   cpub_clk_atb       0        0
> > 0   333333328          0     0  50000
> >                             cpub_clk_div2       0        0        0
> > 499999992          0     0  50000
> >                                cpub_clk_axi_sel       0        0
> >  0   499999992          0     0  50000
> >                                   cpub_clk_axi       0        0
> > 0   499999992          0     0  50000
> >                             cpub_clk_div16_en       0        0
> > 0   999999985          0     0  50000
> >                                cpub_clk_div16       0        0
> > 0    62499999          0     0  50000
>
> I can't read that.
>
> >
> > After enable *cpub_clk* flags with
> > .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> > this clk is enabled on microSD card see clk_summary below.
>
> Again, I don't get the relationship between cpub and sdcard (or eMMC)
>

Yes their is not relation with the cpub and sdcard and eMMC,
I understood  that cpub_clk is not getting enable which is causing
the staling at booting using sdcard.

sorry about this logs.

> > [...]
> >          fclk_div2_div               1        1        0   999999985
> >        0     0  50000
> >              fclk_div2                3        3        0   999999985
> >         0     0  50000
> >                 ff3f0000.ethernet#m250_sel       1        1        0
> > 999999985          0     0  50000
> >                    ff3f0000.ethernet#m250_div       1        1
> > 0   249999997          0     0  50000
> >                       ff3f0000.ethernet#fixed_div2       1        1
> >     0   124999998          0     0  50000
> >                          ff3f0000.ethernet#rgmii_tx_en       1
> > 1        0   124999998          0     0  50000
> >                 ffe05000.sd#mux       1        1        0   999999985
> >         0     0  50000
> >                    ffe05000.sd#div       1        1        0
> > 50000000          0     0  50000
> >                 cpub_clk_dyn1_sel       1        1        0
> > 999999985          0     0  50000
> >                    cpub_clk_dyn1       1        1        0   999999985
> >          0     0  50000
> >                       cpub_clk_dyn       1        1        0
> > 999999985          0     0  50000
> >                          cpub_clk       1        1        0
> > 999999985          0     0  50000
> >                             cpub_clk_div8       0        0        0
> > 124999998          0     0  50000
> >                             cpub_clk_div7       0        0        0
> > 142857140          0     0  50000
> >                             cpub_clk_div6       0        0        0
> > 166666664          0     0  50000
> >                                cpub_clk_trace_sel       0        0
> >    0   166666664          0     0  50000
> >                                   cpub_clk_trace       0        0
> >   0   166666664          0     0  50000
> >                             cpub_clk_div5       0        0        0
> > 199999997          0     0  50000
> >                                cpub_clk_apb_sel       0        0
> >  0   199999997          0     0  50000
> >                                   cpub_clk_apb       0        0
> > 0   199999997          0     0  50000
> >                             cpub_clk_div4       0        0        0
> > 249999996          0     0  50000
> >                             cpub_clk_div3       0        0        0
> > 333333328          0     0  50000
> >                                cpub_clk_atb_sel       0        0
> >  0   333333328          0     0  50000
> >                                   cpub_clk_atb       0        0
> > 0   333333328          0     0  50000
> >                             cpub_clk_div2       0        0        0
> > 499999992          0     0  50000
> >                                cpub_clk_axi_sel       0        0
> >  0   499999992          0     0  50000
> >                                   cpub_clk_axi       0        0
> > 0   499999992          0     0  50000
> >                             cpub_clk_div16_en       0        0
> > 0   999999985          0     0  50000
> >                                cpub_clk_div16       0        0
> > 0    62499999          0     0  50000
> >                    cpub_clk_dyn1_div       0        0        0
> > 999999985          0     0  50000
> >
> > Is this correct approach to set the flags to enable *cpub_clk*.
> > .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> >
> > What I meant is their *Dyn_enable[26]* field for enable/disable for
> > HHI_SYS_CPU_CLK_CNTL0 and HHI_SYS_CPUB_CLK_CNTL clk controller.
> > in the S922X datasheets which could help resolve this issue.
> > Any thought on this.
>
> I sorry but I'm just lost. I don't understand anything above so I can't
> comment.

I am not able to express my self clearly,
I will try to submit the patch by enable cpub_clk with following flags.

 .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,

-Anand
