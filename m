Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2FCC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C672921569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581531262;
	bh=XPutHtfrd9L6DCjKR/i4gzTwtBJqO9VVCF2dsQMhOT0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QCu+QS024W72Nf/IGGGyG0e1gch61m+ZbgjkkYMmQcEhdFiHwzL5RWwAKpFbkWTOr
	 nGCGvWUEpaXHGzjxOq3qrcsISMXY9rZVOJTL+3fquLm/OSMwzmfiCjD0KSekcgHg3m
	 K/aSh66Af4kybRpC7HyHp+r0tQJffnOCd+b9K7P0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgBLSOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbgBLSOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:14:22 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1351E21569;
        Wed, 12 Feb 2020 18:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581531261;
        bh=XPutHtfrd9L6DCjKR/i4gzTwtBJqO9VVCF2dsQMhOT0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H0t1S9X9r5QrGUd7DvAOuSUSqqXDsgdC1XTVAcFbzj4EY2h/S8r/mWZNvB10mdCQa
         38EaQisKKJidSQ7TOlCXmLvne+3QnPgrSM7v03v8XngdUW7peGivsjAvtTOAtfr4CA
         wewf/BxAmAKE916HXnBmP76nvVhL3jH9qCPQp3LY=
Received: by mail-qv1-f42.google.com with SMTP id l14so1341710qvu.12;
        Wed, 12 Feb 2020 10:14:21 -0800 (PST)
X-Gm-Message-State: APjAAAWvizwDu3Pmzojt+E/r5DutlCrkK5eWqajftF25OTp/uyq+nl5z
        fHi7yZtE0E6xw7ny0jjl+8lmTeSSFfqJcYtUFQ==
X-Google-Smtp-Source: APXvYqwYf7OiqvLmE/STxKkwBxfQm+rxJyw5z6FFooFuohKsTmQUlxLvZAqUvV1R4jPQEGjoiAS5DvHkVqtRkL1b//c=
X-Received: by 2002:a05:6214:11ac:: with SMTP id u12mr8482894qvv.85.1581531260167;
 Wed, 12 Feb 2020 10:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-8-drinkcat@chromium.org> <CANMq1KBL-S2DVKbCB2h_XNpfUro+pZ96-C5ft0p-8GX_tbXELQ@mail.gmail.com>
In-Reply-To: <CANMq1KBL-S2DVKbCB2h_XNpfUro+pZ96-C5ft0p-8GX_tbXELQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 12 Feb 2020 12:14:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLuo+2G2MjiwS9cwNhMV2pGBojXFGNqEfLv3fP-Y04mfA@mail.gmail.com>
Message-ID: <CAL_JsqLuo+2G2MjiwS9cwNhMV2pGBojXFGNqEfLv3fP-Y04mfA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] RFC: drm/panfrost: devfreq: Add support for 2 regulators
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 2:49 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> +Viresh Kumar +Stephen Boyd for clock advice.
>
> On Fri, Feb 7, 2020 at 1:27 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> >
> > The Bifrost GPU on MT8183 uses 2 regulators (core and SRAM) for
> > devfreq, and provides OPP table with 2 sets of voltages.
> >
> > TODO: This is incomplete as we'll need add support for setting
> > a pair of voltages as well.
>
> So all we need for this to work (at least apparently, that is, I can
> change frequency) is this:
> https://lore.kernel.org/patchwork/patch/1192945/
> (ah well, Viresh just replied, so, probably not, I'll check that out
> and use the correct API)
>
> But then there's a slight problem: panfrost_devfreq uses a bunch of
> clk_get_rate calls, and the clock PLLs (at least on MTK platform) are
> never fully precise, so we get back 299999955 for 300 Mhz and
> 799999878 for 800 Mhz. That means that the kernel is unable to keep
> devfreq stats as neither of these values are in the table:
> [ 4802.470952] devfreq devfreq1: Couldn't update frequency transition
> information.
> The kbase driver fixes this by remembering the last set frequency, and
> reporting that to devfreq. Should we do that as well or is there a
> better fix?
>
> Another thing that I'm not implementing is the dance that Mediatek
> does in their kbase driver when changing the clock (described in patch
> 2/7):
> ""
> The binding we use with out-of-tree Mali drivers includes more
> clocks, this is used for devfreq: the out-of-tree driver switches
> clk_mux to clk_sub_parent (26Mhz), adjusts clk_main_parent, then
> switches clk_mux back to clk_main_parent:
> (see https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbase_runtime_pm.c#423)
> clocks =
>         <&topckgen CLK_TOP_MFGPLL_CK>,
>         <&topckgen CLK_TOP_MUX_MFG>,
>         <&clk26m>,
>         <&mfgcfg CLK_MFG_BG3D>;
> clock-names =
>         "clk_main_parent",
>         "clk_mux",
>         "clk_sub_parent",
>         "subsys_mfg_cg";
> ""
> Is there a clean/simple way to implement this in the clock
> framework/device tree? Or should we implement something in the
> panfrost driver?

Putting parent clocks into 'clocks' for a device is a pretty common
abuse. The 'assigned-clocks' binding is what's used for parent clock
setup. Not sure that's going to help here though. Is this dance
because the parent clock frequency can't be changed cleanly? If up to
me, I'd put that dance in the clock driver. The GPU shouldn't have to
care.

Rob
