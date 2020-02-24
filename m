Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D610DC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9904520675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LkScTrUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgBXJbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:31:06 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:51933 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgBXJbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:31:05 -0500
Received: by mail-wm1-f53.google.com with SMTP id t23so8236306wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 01:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=YOte6mkbLz8vWB4XILdt5n/2oNrjFYd6rB4VsC43SZs=;
        b=LkScTrUJ1WRO4koGPH5T6yQVaJ/OAjh8lS3tJhPh6V8y0lH1xCydRzutbqRCYe7YkX
         6LLTRBr+r+C9S4l73An6he9drrVTqKpwJzpWa1OtuF68XVklQ/WCaHFqmdPtH/lHa02R
         bZ8c4UQgfobDpNloGFB1ahsWLkuaTVdBhvPc0Qoga/kfGKD01BdL4TGDToph7eEY7HrP
         vznp3bUWfpFS7RClFIgV6Bn7gt8Uvlc8Rp5JMwlKd+7aY8ADJ6DJNHCG8c+l7HRESLuc
         iZpnocdwelXCfeYzSjkL9abx7gx+LJgIOrob4VmGvA5ViD9up+PMrfJHwaKHHzch9bxk
         LlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=YOte6mkbLz8vWB4XILdt5n/2oNrjFYd6rB4VsC43SZs=;
        b=mNf1FZPybWd+AFGmiOKP6AHJklcfLATnZ3mfEPeISNIWXxV1kzQus8rxI9Q4Nu+FD7
         rE+zmO9I8pzJANOA921iBQGkNiAc0Oo0EZda59UWAm4whDTWXBTvf5jRMcuPrCVPUR3T
         sjmv18HQ5WwZr+STCPukRARGo5bgSwnUJdj7mJCT2AhyrUiWC8wkN91cbxKTpMgQxYWx
         n20CwdtY3LqLo1WOMtul54IQe4qxQ8mAInn3jqwWCzxejE4nj1E8d8pMQXfIf3q4QXXm
         mKH7rhD+RCAbn6MaBgmMrtSgSLWOWYQTCQIFIplRbrgU3UgIT7IHzqlbdvcMJIDglVqM
         R6+Q==
X-Gm-Message-State: APjAAAXK8tL/nhZP4opr8e0QRhe3EusiTduc5z++ywaNN+O4o94iulU8
        wOk8mt19BtlovP6ntK9DU/24LQ==
X-Google-Smtp-Source: APXvYqzpPJJc/gi2QDQZsmpxB1GGyiaXMyI3zKCeQIn/x5jdKbDBEK0RMFsxIzWortV5efOCDJJqpA==
X-Received: by 2002:a1c:a443:: with SMTP id n64mr20158521wme.141.1582536663181;
        Mon, 24 Feb 2020 01:31:03 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 133sm18669254wme.32.2020.02.24.01.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 01:31:02 -0800 (PST)
References: <20200216173446.1823-1-linux.amoon@gmail.com> <20200216173446.1823-4-linux.amoon@gmail.com> <1jmu9hzlo2.fsf@starbuckisacylon.baylibre.com> <CANAwSgSaQgU=H3h0S9deT11HA8z9R=Fhy5Kawii9tSBxKf2Wgw@mail.gmail.com> <CAFBinCCSosE1XfwbKZOR9G+DVYg8zFcKShmTNWUhh1e8W0VoAQ@mail.gmail.com> <CANAwSgRZy1K0GZq30cEoH2KiJfjX-5LvkMy79ZeM_aSEyrkD+g@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list\:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Subject: Re: [PATCHv1 3/3] clk: meson: g12a: set cpu clock divider flags too CLK_IS_CRITICAL
In-reply-to: <CANAwSgRZy1K0GZq30cEoH2KiJfjX-5LvkMy79ZeM_aSEyrkD+g@mail.gmail.com>
Date:   Mon, 24 Feb 2020 10:31:01 +0100
Message-ID: <1jo8togwmi.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 23 Feb 2020 at 14:34, Anand Moon <linux.amoon@gmail.com> wrote:

> Hi Martin / Jerome / Neil,
>
> On Fri, 21 Feb 2020 at 02:45, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>>
>> Hi Anand,
>>
>> On Mon, Feb 17, 2020 at 2:30 PM Anand Moon <linux.amoon@gmail.com> wrote:
>> [...]
>> > > > @@ -681,7 +682,7 @@ static struct clk_regmap g12b_cpub_clk = {
>> > > >                       &g12a_sys_pll.hw
>> > > >               },
>> > > >               .num_parents = 2,
>> > > > -             .flags = CLK_SET_RATE_PARENT,
>> > > > +             .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>> > >
>> > > Why not. Neil what do you think of this ?
>> > > If nothing is claiming this clock and enabling it then I suppose it
>> > > could make sense.
>> > >
>> > I would like core developers to handle this.
>> > Sorry for the noise.
>> can you please resend this patch with only the change to g12b_cpub_clk?
>> I have no G12B board myself so it would be great if you could take care of this!
>>
>>
>> Martin
>
> Thanks, yes I will try again, but I have a question.
>
> On eMMC module  *cpub_clk* is not getting enabled, see below is
> clk_summay of eMMC.

I'm sorry but I don't understand the link between the cpu clock of the
second cluster and MMC.

> [...]
>           fclk_div2_div               1        1        0   999999985
>         0     0  50000
>              fclk_div2                2        2        0   999999985
>         0     0  50000
>                 ff3f0000.ethernet#m250_sel       1        1        0
> 999999985          0     0  50000
>                    ff3f0000.ethernet#m250_div       1        1
> 0   249999997          0     0  50000
>                       ff3f0000.ethernet#fixed_div2       1        1
>     0   124999998          0     0  50000
>                          ff3f0000.ethernet#rgmii_tx_en       1
> 1        0   124999998          0     0  50000
>                 ffe07000.mmc#mux       1        1        0   999999985
>          0     0  50000
>                    ffe07000.mmc#div       1        1        0
> 199999997          0     0  50000
>                 cpub_clk_dyn1_sel       0        0        0
> 999999985          0     0  50000
>                    cpub_clk_dyn1       0        0        0   999999985
>          0     0  50000
>                       cpub_clk_dyn       0        0        0
> 999999985          0     0  50000
>                          cpub_clk       0        0        0
> 999999985          0     0  50000
>                             cpub_clk_div8       0        0        0
> 124999998          0     0  50000
>                             cpub_clk_div7       0        0        0
> 142857140          0     0  50000
>                             cpub_clk_div6       0        0        0
> 166666664          0     0  50000
>                                cpub_clk_trace_sel       0        0
>    0   166666664          0     0  50000
>                                   cpub_clk_trace       0        0
>   0   166666664          0     0  50000
>                             cpub_clk_div5       0        0        0
> 199999997          0     0  50000
>                                cpub_clk_apb_sel       0        0
>  0   199999997          0     0  50000
>                                   cpub_clk_apb       0        0
> 0   199999997          0     0  50000
>                             cpub_clk_div4       0        0        0
> 249999996          0     0  50000
>                             cpub_clk_div3       0        0        0
> 333333328          0     0  50000
>                                cpub_clk_atb_sel       0        0
>  0   333333328          0     0  50000
>                                   cpub_clk_atb       0        0
> 0   333333328          0     0  50000
>                             cpub_clk_div2       0        0        0
> 499999992          0     0  50000
>                                cpub_clk_axi_sel       0        0
>  0   499999992          0     0  50000
>                                   cpub_clk_axi       0        0
> 0   499999992          0     0  50000
>                             cpub_clk_div16_en       0        0
> 0   999999985          0     0  50000
>                                cpub_clk_div16       0        0
> 0    62499999          0     0  50000

I can't read that.

>
> After enable *cpub_clk* flags with
> .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> this clk is enabled on microSD card see clk_summary below.

Again, I don't get the relationship between cpub and sdcard (or eMMC)

> [...]
>          fclk_div2_div               1        1        0   999999985
>        0     0  50000
>              fclk_div2                3        3        0   999999985
>         0     0  50000
>                 ff3f0000.ethernet#m250_sel       1        1        0
> 999999985          0     0  50000
>                    ff3f0000.ethernet#m250_div       1        1
> 0   249999997          0     0  50000
>                       ff3f0000.ethernet#fixed_div2       1        1
>     0   124999998          0     0  50000
>                          ff3f0000.ethernet#rgmii_tx_en       1
> 1        0   124999998          0     0  50000
>                 ffe05000.sd#mux       1        1        0   999999985
>         0     0  50000
>                    ffe05000.sd#div       1        1        0
> 50000000          0     0  50000
>                 cpub_clk_dyn1_sel       1        1        0
> 999999985          0     0  50000
>                    cpub_clk_dyn1       1        1        0   999999985
>          0     0  50000
>                       cpub_clk_dyn       1        1        0
> 999999985          0     0  50000
>                          cpub_clk       1        1        0
> 999999985          0     0  50000
>                             cpub_clk_div8       0        0        0
> 124999998          0     0  50000
>                             cpub_clk_div7       0        0        0
> 142857140          0     0  50000
>                             cpub_clk_div6       0        0        0
> 166666664          0     0  50000
>                                cpub_clk_trace_sel       0        0
>    0   166666664          0     0  50000
>                                   cpub_clk_trace       0        0
>   0   166666664          0     0  50000
>                             cpub_clk_div5       0        0        0
> 199999997          0     0  50000
>                                cpub_clk_apb_sel       0        0
>  0   199999997          0     0  50000
>                                   cpub_clk_apb       0        0
> 0   199999997          0     0  50000
>                             cpub_clk_div4       0        0        0
> 249999996          0     0  50000
>                             cpub_clk_div3       0        0        0
> 333333328          0     0  50000
>                                cpub_clk_atb_sel       0        0
>  0   333333328          0     0  50000
>                                   cpub_clk_atb       0        0
> 0   333333328          0     0  50000
>                             cpub_clk_div2       0        0        0
> 499999992          0     0  50000
>                                cpub_clk_axi_sel       0        0
>  0   499999992          0     0  50000
>                                   cpub_clk_axi       0        0
> 0   499999992          0     0  50000
>                             cpub_clk_div16_en       0        0
> 0   999999985          0     0  50000
>                                cpub_clk_div16       0        0
> 0    62499999          0     0  50000
>                    cpub_clk_dyn1_div       0        0        0
> 999999985          0     0  50000
>
> Is this correct approach to set the flags to enable *cpub_clk*.
> .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>
> What I meant is their *Dyn_enable[26]* field for enable/disable for
> HHI_SYS_CPU_CLK_CNTL0 and HHI_SYS_CPUB_CLK_CNTL clk controller.
> in the S922X datasheets which could help resolve this issue.
> Any thought on this.

I sorry but I'm just lost. I don't understand anything above so I can't
comment.

>
> -Anand

