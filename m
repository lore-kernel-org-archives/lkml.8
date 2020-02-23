Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302D1C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9450206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4wXPHlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgBWNef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 08:34:35 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:41692 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWNef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 08:34:35 -0500
Received: by mail-io1-f41.google.com with SMTP id m25so7494759ioo.8;
        Sun, 23 Feb 2020 05:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjlxCHc9TIK73b6JYIZFY6Ze1wSFh93pwbVlW0RqGQw=;
        b=S4wXPHlYe1klCwC0XEptaw2iN6cSWpw4NT4/SAS2S/cEWnCAhupLRvzoqpScE8/iw4
         OltgGfgfsOFQY82HJ8j7ZyEqT1KOJmDcXTRjnVzhlmaXIm2DPJB/eTcaJTSQzW1sVALD
         P9qYRd9J0SVEpUnl1HUmrTnAHZL/hx0r7DYsGda6b2ZlBE0goXdH5yqCUomUx1XeRjz/
         o0xh5HSIKDg7NfiVoCuK7Fdo+l0thF3jz5Q8DHmj6c/iptKCy7Zlc+6VhrNr7xcwyW3D
         csalaThVXhZI3jGAyo9o7fwy4PkhBtkb6gg/7S+ak8m2hKpzPg3v+oGU9qjVblYBZJwP
         7Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjlxCHc9TIK73b6JYIZFY6Ze1wSFh93pwbVlW0RqGQw=;
        b=Jas6br1P419vGkHfBo3IB4KQShdxZoSRzGXTANhpLB3RUCCu5J+4IItj6n3TkHCwdu
         0prb0BFjnPhUZEOynktprmUzRIo2oV7bmTfYISOltZD7gqg9SRTy3erL7Kd4l7LmbU1i
         0COckqfthLv4pR9EBrILmjPldZoPzYFAjGzMUpNmxGfCuqKaYjpm5ao2uly7oTlWI7mh
         LpGvaL0MLpr3J027/m+p71C47Jtwq+DilIaD6dcTMLLZEH9dB+yIyxJ7vscixgV009Bf
         /PWufTlMjV1s8Q+G/thqcOjNymtW7PfT7FSZY9YfuWghmHByXKaFcDFFULR5EzPmLRwu
         wkfQ==
X-Gm-Message-State: APjAAAV9dXx/95P4xTBvGWkVjdEaGepsj9/Duu3VVuLvQecpc1c4w/5M
        jsoxGbOAlN7rwiyZhfA8VYSthRMEhiG40+PSL7TRJ1G5
X-Google-Smtp-Source: APXvYqzuka0HKg/Fr4Uu0KPzM3CzpCIv3wTW1akb/1w5wysjVXPDkvFNj8eadeNpBXZ1kbVST/UgckRZKgAKVMPUJY8=
X-Received: by 2002:a5d:8790:: with SMTP id f16mr42917678ion.246.1582464874614;
 Sun, 23 Feb 2020 05:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20200216173446.1823-1-linux.amoon@gmail.com> <20200216173446.1823-4-linux.amoon@gmail.com>
 <1jmu9hzlo2.fsf@starbuckisacylon.baylibre.com> <CANAwSgSaQgU=H3h0S9deT11HA8z9R=Fhy5Kawii9tSBxKf2Wgw@mail.gmail.com>
 <CAFBinCCSosE1XfwbKZOR9G+DVYg8zFcKShmTNWUhh1e8W0VoAQ@mail.gmail.com>
In-Reply-To: <CAFBinCCSosE1XfwbKZOR9G+DVYg8zFcKShmTNWUhh1e8W0VoAQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 23 Feb 2020 19:04:23 +0530
Message-ID: <CANAwSgRZy1K0GZq30cEoH2KiJfjX-5LvkMy79ZeM_aSEyrkD+g@mail.gmail.com>
Subject: Re: [PATCHv1 3/3] clk: meson: g12a: set cpu clock divider flags too CLK_IS_CRITICAL
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
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

Hi Martin / Jerome / Neil,

On Fri, 21 Feb 2020 at 02:45, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Mon, Feb 17, 2020 at 2:30 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > > > @@ -681,7 +682,7 @@ static struct clk_regmap g12b_cpub_clk = {
> > > >                       &g12a_sys_pll.hw
> > > >               },
> > > >               .num_parents = 2,
> > > > -             .flags = CLK_SET_RATE_PARENT,
> > > > +             .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> > >
> > > Why not. Neil what do you think of this ?
> > > If nothing is claiming this clock and enabling it then I suppose it
> > > could make sense.
> > >
> > I would like core developers to handle this.
> > Sorry for the noise.
> can you please resend this patch with only the change to g12b_cpub_clk?
> I have no G12B board myself so it would be great if you could take care of this!
>
>
> Martin

Thanks, yes I will try again, but I have a question.

On eMMC module  *cpub_clk* is not getting enabled, see below is
clk_summay of eMMC.
[...]
          fclk_div2_div               1        1        0   999999985
        0     0  50000
             fclk_div2                2        2        0   999999985
        0     0  50000
                ff3f0000.ethernet#m250_sel       1        1        0
999999985          0     0  50000
                   ff3f0000.ethernet#m250_div       1        1
0   249999997          0     0  50000
                      ff3f0000.ethernet#fixed_div2       1        1
    0   124999998          0     0  50000
                         ff3f0000.ethernet#rgmii_tx_en       1
1        0   124999998          0     0  50000
                ffe07000.mmc#mux       1        1        0   999999985
         0     0  50000
                   ffe07000.mmc#div       1        1        0
199999997          0     0  50000
                cpub_clk_dyn1_sel       0        0        0
999999985          0     0  50000
                   cpub_clk_dyn1       0        0        0   999999985
         0     0  50000
                      cpub_clk_dyn       0        0        0
999999985          0     0  50000
                         cpub_clk       0        0        0
999999985          0     0  50000
                            cpub_clk_div8       0        0        0
124999998          0     0  50000
                            cpub_clk_div7       0        0        0
142857140          0     0  50000
                            cpub_clk_div6       0        0        0
166666664          0     0  50000
                               cpub_clk_trace_sel       0        0
   0   166666664          0     0  50000
                                  cpub_clk_trace       0        0
  0   166666664          0     0  50000
                            cpub_clk_div5       0        0        0
199999997          0     0  50000
                               cpub_clk_apb_sel       0        0
 0   199999997          0     0  50000
                                  cpub_clk_apb       0        0
0   199999997          0     0  50000
                            cpub_clk_div4       0        0        0
249999996          0     0  50000
                            cpub_clk_div3       0        0        0
333333328          0     0  50000
                               cpub_clk_atb_sel       0        0
 0   333333328          0     0  50000
                                  cpub_clk_atb       0        0
0   333333328          0     0  50000
                            cpub_clk_div2       0        0        0
499999992          0     0  50000
                               cpub_clk_axi_sel       0        0
 0   499999992          0     0  50000
                                  cpub_clk_axi       0        0
0   499999992          0     0  50000
                            cpub_clk_div16_en       0        0
0   999999985          0     0  50000
                               cpub_clk_div16       0        0
0    62499999          0     0  50000

After enable *cpub_clk* flags with
.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
this clk is enabled on microSD card see clk_summary below.
[...]
         fclk_div2_div               1        1        0   999999985
       0     0  50000
             fclk_div2                3        3        0   999999985
        0     0  50000
                ff3f0000.ethernet#m250_sel       1        1        0
999999985          0     0  50000
                   ff3f0000.ethernet#m250_div       1        1
0   249999997          0     0  50000
                      ff3f0000.ethernet#fixed_div2       1        1
    0   124999998          0     0  50000
                         ff3f0000.ethernet#rgmii_tx_en       1
1        0   124999998          0     0  50000
                ffe05000.sd#mux       1        1        0   999999985
        0     0  50000
                   ffe05000.sd#div       1        1        0
50000000          0     0  50000
                cpub_clk_dyn1_sel       1        1        0
999999985          0     0  50000
                   cpub_clk_dyn1       1        1        0   999999985
         0     0  50000
                      cpub_clk_dyn       1        1        0
999999985          0     0  50000
                         cpub_clk       1        1        0
999999985          0     0  50000
                            cpub_clk_div8       0        0        0
124999998          0     0  50000
                            cpub_clk_div7       0        0        0
142857140          0     0  50000
                            cpub_clk_div6       0        0        0
166666664          0     0  50000
                               cpub_clk_trace_sel       0        0
   0   166666664          0     0  50000
                                  cpub_clk_trace       0        0
  0   166666664          0     0  50000
                            cpub_clk_div5       0        0        0
199999997          0     0  50000
                               cpub_clk_apb_sel       0        0
 0   199999997          0     0  50000
                                  cpub_clk_apb       0        0
0   199999997          0     0  50000
                            cpub_clk_div4       0        0        0
249999996          0     0  50000
                            cpub_clk_div3       0        0        0
333333328          0     0  50000
                               cpub_clk_atb_sel       0        0
 0   333333328          0     0  50000
                                  cpub_clk_atb       0        0
0   333333328          0     0  50000
                            cpub_clk_div2       0        0        0
499999992          0     0  50000
                               cpub_clk_axi_sel       0        0
 0   499999992          0     0  50000
                                  cpub_clk_axi       0        0
0   499999992          0     0  50000
                            cpub_clk_div16_en       0        0
0   999999985          0     0  50000
                               cpub_clk_div16       0        0
0    62499999          0     0  50000
                   cpub_clk_dyn1_div       0        0        0
999999985          0     0  50000

Is this correct approach to set the flags to enable *cpub_clk*.
.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,

What I meant is their *Dyn_enable[26]* field for enable/disable for
HHI_SYS_CPU_CLK_CNTL0 and HHI_SYS_CPUB_CLK_CNTL clk controller.
in the S922X datasheets which could help resolve this issue.
Any thought on this.

-Anand
