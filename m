Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD47C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9725206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Wd14+tH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgD0Q6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgD0Q6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:58:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41886C03C1A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:58:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so424551wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=DTm75Aea4kx63zypL+0Xj2RsPaFJvZTD8m8bbUbYo8o=;
        b=Wd14+tH1GzAaBupCXZp0hHv3eWs6bqyllV2IDrXXo8Zl9zuOi7JDibdyRCOtP5NJxq
         wIqKf6fBgHDx1YQvXElRv5McvDRiSRi4TX3q2SGCebaliyfsoH0W4Zt+FdX/N+T6v5VB
         IZOuBKKS7RC0HxqVr5N/0iXFraZ8mvS00Zz9B4XBgVgpX5REuLHJT9cEnOqW5sUY0S9T
         VBj+4X5gpzmCQZzJCWJXJMAe/+y42VFw+xMaqfkH2DIbzgP5L+iry6URrSxgfAoIWq3W
         hD7g49fdVMwjVjzxV3zLoDdsQk+4uictbEY4mo0pXzp8oqE+aSUWEsRtPz44ldhQ5Wtf
         XhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=DTm75Aea4kx63zypL+0Xj2RsPaFJvZTD8m8bbUbYo8o=;
        b=PfIk4FiEV6OSi3d7oytMhlUgaq4exJ9+zywMLIiNZtlxUQ+3HGKP7UPl51YI+PP94O
         ASiPZjJnObDIXEn6CaJlPhJgqpgocMC50A2joqPY+htJBQfGuU4B7kgO1ohiloYdzmnd
         v+BSC/qCpF/s+Gh6B1IVbMdytoKwI9FvliGA73RIHLNwbH724JPNO73Hn4YlcCBuD9Sh
         sWGHs1fUPu8zFdXDoAS2m5l00hU25iPZ6/AmPhcMKIodDXzsHRpCe01SMLZaejp3z4Ig
         lnNlWJ6OYPe8vmpfD/IIDXKID9u1qYKGZwFNA2x3EnqnzlZ0Bcj7NIL1ciqcLPj52C/8
         OWyg==
X-Gm-Message-State: AGi0PubaXCk6++MCO8tjROMUjjE7hOb8gAyO7wp9K0Gn/mYVgsp9mcnt
        rqvFXHvcs2zALF9+pC7AnTdhTA==
X-Google-Smtp-Source: APiQypJ81bomouHmPVnGvWRivUag+BqAjvtduoE5qnPKZGZP4kwZSO608DZdB0WJAdDgKEizAA2K4Q==
X-Received: by 2002:a05:600c:441a:: with SMTP id u26mr462425wmn.154.1588006695835;
        Mon, 27 Apr 2020 09:58:15 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id r3sm22949564wrx.72.2020.04.27.09.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:58:15 -0700 (PDT)
References: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com> <20200328003249.1248978-3-martin.blumenstingl@googlemail.com> <1jd07t2ucy.fsf@starbuckisacylon.baylibre.com> <CAFBinCCRE9ceErVVQJ=prDp5+srpcSM6oqNkgwznYq8awNpQ3Q@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org, yinxin_1989@aliyun.com,
        linux-arm-kernel@lists.infradead.org, lnykww@gmail.com
Subject: Re: [PATCH v5 2/3] clk: meson: add a driver for the Meson8/8b/8m2 SDHC clock controller
In-reply-to: <CAFBinCCRE9ceErVVQJ=prDp5+srpcSM6oqNkgwznYq8awNpQ3Q@mail.gmail.com>
Date:   Mon, 27 Apr 2020 18:58:13 +0200
Message-ID: <1j7dy03ly2.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 27 Apr 2020 at 18:33, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jerome,
>
> thank you for looking into this!
>
> On Mon, Apr 27, 2020 at 10:41 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> [...]
>> > +#include "clk-regmap.h"
>> > +#include "clk-pll.h"
>>
>> If you need the pll clocks, it should probably appear in the Kconfig
>> deps as well
> this driver does not need "clk-pll.h"
> good catch - thank you
>
>> > +
>> > +#define MESON_SDHC_CLKC                      0x10
>> > +
>> > +static const struct clk_regmap meson_mx_sdhc_src_sel = {
>> > +     .data = &(struct clk_regmap_mux_data){
>> > +             .offset = MESON_SDHC_CLKC,
>> > +             .mask = 0x3,
>> > +             .shift = 16,
>> > +     },
>> > +     .hw.init = &(struct clk_init_data){
>> > +             .name = "sdhc_src_sel",
>> > +             .ops = &clk_regmap_mux_ops,
>> > +             .parent_data = (const struct clk_parent_data[]) {
>> > +                     { .fw_name = "clkin0", .index = -1, },
>> > +                     { .fw_name = "clkin1", .index = -1, },
>> > +                     { .fw_name = "clkin2", .index = -1, },
>> > +                     { .fw_name = "clkin3", .index = -1, },
>>
>> When fw_name is specified, setting the index is not necessary
> noted, will fix this
>
> [...]
>> > +     .hw.init = &(struct clk_init_data){
>> > +             .name = "sdhc_div",
>> > +             .ops = &clk_regmap_divider_ops,
>> > +             .parent_data = (const struct clk_parent_data[]) {
>> > +                     { .name = "sdhc_src_sel", .index = -1, },
>>
>> Any reason for using the lagacy names and not the clk_hw pointers ?
>> Same comment for the rest of the clocks
> indeed, there is a reason and it took me a while to figure out
> __clk_register will set hw->init = NULL;
> This means: if we unregister the driver and register it again all
> hw->init will be lost (as it's now NULL)

I think Stephen recently added the reset to NULL and it might be an
unintended consequence. AFAICT, you should be able to use hw pointer
here even if the driver unloads.
Please report it to linux-clk


> This is why I am effectively cloning (devm_kzalloc + memcpy) these
> clocks which only serve as a template
> Due to this I can't easily use a reference to another clk_hw
>
> We don't have this problem in any of our other clock controller
> drivers because these cannot be unloaded
>
> [...]
>> > +     .hw.init = &(struct clk_init_data){
>> > +             .name = "sdhc_mod_clk_on",
>> > +             .ops = &clk_regmap_gate_ops,
>> > +             .parent_data = (const struct clk_parent_data[]) {
>> > +                     { .name = "sdhc_div", .index = -1, },
>> > +             },
>> > +             .num_parents = 1,
>> > +             .flags = CLK_SET_RATE_GATE,
>>
>> Why can't the clock change rate unless gated ? Maybe you prefer to
>> change the rate in the mmc while clock is gated, but this is the
>> handling of the clock by the mmc driver, not a constraint of the actual
>> clock HW, isn't it ?
>>
>> Also, this is a gate so I suppose the rate propagates through it ?
>> Can you explain why CLK_SET_RATE_PARENT is not set  ?
> [...]
>> Ok so apparently you only want to set the rate through the RX clock.
>> You are free to call set_rate() only on this clock in the mmc driver.
>> However, I don't think this should reflect as clock constraints.
> I think these two belong together
> looking back at this I believe that you are right:
> - CLK_SET_RATE_GATE should be dropped because that's not a constraint
> of the clock but of the clock consumer (MMC driver)
> - CLK_SET_RATE_PARENT should be added to all clocks because rate
> propagation will work for all clocks
>
>> > +     },
>> > +};
>> > +
>> > +static const struct clk_regmap meson_mx_sdhc_sd_clk_en = {
>> > +     .data = &(struct clk_regmap_gate_data){
>> > +             .offset = MESON_SDHC_CLKC,
>> > +             .bit_idx = 12,
>> > +     },
>> > +     .hw.init = &(struct clk_init_data){
>> > +             .name = "sdhc_sd_clk_on",
>> > +             .ops = &clk_regmap_gate_ops,
>> > +             .parent_data = (const struct clk_parent_data[]) {
>> > +                     { .name = "sdhc_div", .index = -1, },
>> > +             },
>> > +             .num_parents = 1,
>> > +             .flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>>
>> ... now I lost with these flags. I'm sure there is an idea related to
>> the mmc driver. Clockwise, I don't get it.
> indeed, just like above I'll fix these
>
>
> Martin

