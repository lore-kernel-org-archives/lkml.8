Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EAFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C8372065F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xEJadjap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgESKfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgESKfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:35:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A685C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:35:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k13so13216179wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HIzWuSV+k6FJhbDEx4nptdRHbD6AzRLTefY9kmB7ViA=;
        b=xEJadjapo2Y7f8mHAYd0MOvvh9qBYVxEe6UrFkD/KBi4A7urNSIz60SM5TP1c+PLzq
         3r4pYDfQYUS4EPBK9mnPRDDfrI6fKrGexbmFibGuaa4rKvZhZce+zTQ4pvW4HX++fCvY
         AzmgLmojQmLhTgzsadFMQV0itgWqNippPRia7KJCpxwvQJCtEyI3owbNlN7JpniHBKjv
         LSO+FxUuLM9m426GwiqzjXV483fTd3QMy6cUNod6MwRi86HxK2pG7V/EgnSGR977XES5
         HPGKR5MylfMkMRAI4TMqf/YMHZwB+1fkOzxNqq4lnLArMqfCJztMFCb4NtQbkT65SHFW
         o+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HIzWuSV+k6FJhbDEx4nptdRHbD6AzRLTefY9kmB7ViA=;
        b=ArX8ZI8RHedkrhy+qHKUtUWpv6MIAO4JAVEj7yuYBSjUKHlr1IwCePXhCJDvjcbTIQ
         V7MaaUhUxHfSaxjw/dDBWAzTvSJvzu5H2Cf0yvGpI60C8102bQMm0RrS5itKsiiSs7q9
         1QXHjR21ZXkPchxwT3ov4lgeN0DHZNnwax7S4oP3RTabsiEFUWKm1QoFrft9UNKzPkv0
         jSR4VKJStW7+ShMubFbh1vIn75Lbvd4r7WaYyVuaTrP6y7V4GYBHziOZoiJmJaDHFHyx
         8FKL+PDF2XQwz2o6PrgFKjZoT1/vxvDcjCI8zSCytmLnLt0vaHwVGDXTTQf5HnAtzEL5
         R9iA==
X-Gm-Message-State: AOAM530UZUiUgPoGNv2pG7eCmGga6wzAfXG3DU+fT6mz5lumUNFSHiAJ
        5G4nqzr0CccUfq5qdG/oz3OYJg==
X-Google-Smtp-Source: ABdhPJyQ/nsTjIGwYWaVsKP6YjIcCpBVI60KUPgVghu8qqNaJVlwi/qONbe3umWmEyd8A17BGTkFmA==
X-Received: by 2002:adf:fa0b:: with SMTP id m11mr24718798wrr.417.1589884513087;
        Tue, 19 May 2020 03:35:13 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id 37sm20798815wrk.61.2020.05.19.03.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:35:12 -0700 (PDT)
Date:   Tue, 19 May 2020 11:35:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mfd: syscon: Add Spreadtrum physical regmap bus
 support
Message-ID: <20200519103510.GV271301@dell>
References: <c2fd765aa388d4510194ba02c017e39bde57c8d4.1587478171.git.baolin.wang7@gmail.com>
 <CADBw62rJ8VYTgnW_3q4=TkCyZx2B1DHsG+oOmiph8FLsukUROQ@mail.gmail.com>
 <20200427090518.GG3559@dell>
 <CADBw62qXtNnoNq0F1iZrvQHryMTy86GEqcD-qXBzsJJL-B8mQg@mail.gmail.com>
 <20200428071447.GJ3559@dell>
 <CADBw62o=D-hmp1yB=oPXPJfBucOEEa87cZado5+1mTKsCWDKfg@mail.gmail.com>
 <20200428081902.GK3559@dell>
 <CADBw62qrsOHUCKdU17ctQBM21EAOuAO8vxFabRP9hpguC5ixsg@mail.gmail.com>
 <CADBw62psCr1aSmYtqck5dpddCRk8f-UAw5rUsPyfhNw-OCfYkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADBw62psCr1aSmYtqck5dpddCRk8f-UAw5rUsPyfhNw-OCfYkA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 May 2020, Baolin Wang wrote:

> Hi Arnd
> 
> On Tue, Apr 28, 2020 at 4:41 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > On Tue, Apr 28, 2020 at 4:19 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Tue, 28 Apr 2020, Baolin Wang wrote:
> > >
> > > > On Tue, Apr 28, 2020 at 3:14 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > >
> > > > > On Tue, 28 Apr 2020, Baolin Wang wrote:
> > > > >
> > > > > > On Mon, Apr 27, 2020 at 5:05 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > >
> > > > > > > On Mon, 27 Apr 2020, Baolin Wang wrote:
> > > > > > >
> > > > > > > > Hi Arnd and Lee,
> > > > > > > >
> > > > > > > > On Tue, Apr 21, 2020 at 10:13 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Some platforms such as Spreadtrum platform, define a special method to
> > > > > > > > > update bits of the registers instead of read-modify-write, which means
> > > > > > > > > we should use a physical regmap bus to define the reg_update_bits()
> > > > > > > > > operation instead of the MMIO regmap bus. Thus we can register a new
> > > > > > > > > physical regmap bus into syscon core to support this.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > > > > >
> > > > > > > > Do you have any comments for this patch? Thanks.
> > > > > > >
> > > > > > > Yes.  I'm not accepting it, sorry.
> > > > > > >
> > > > > > > I'd rather you duplicate the things you need from of_syscon_register()
> > > > > > > in your own driver than taint this one.
> > > > > >
> > > > > > Thanks for your comments and I can understand your concern. But we
> > > > > > still want to use the standard syscon APIs in syscon.c, which means we
> > > > > > still need insert an callback or registration or other similar methods
> > > > > > to support vendor specific regmap bus. Otherwise we should invent some
> > > > > > similar syscon APIs in our vendor syscon driver, like
> > > > > > sprd_syscon_regmap_lookup_by_phandle/sprd_syscon_regmap_lookup_by_compatible.
> > > > >
> > > > > So long as the generic driver stays generic.  Providing a registration
> > > > > function sounds cleaner than tainting the code with vendor specifics.
> > > >
> > > > So seems my V1 patch set [1] was on the direction as you suggested,
> > > > but Arnd did not like that.
> > > >
> > > > [1]
> > > > https://lore.kernel.org/patchwork/patch/1226161/
> > > > https://lore.kernel.org/patchwork/patch/1226162/
> > >
> > > I don't often disagree with Arnd, but in this instance I think a
> > > registration function which allows vendor spin-offs to use the generic
> > > API is better than tainting the generic driver by adding vendor
> > > specific #ifery/code to it.
> > >
> > > Your original idea seems more palatable to me.
> >
> > OK, thanks for sharing your opinion. Let's see what Arnd's opinion
> > before I send out new version.
> 
> Do yo have any comments about how to add new bits updating method? Can
> I re-send my v1 patch set [1]? Thanks.

Just resend and we'll review.

> [1]:
> https://lore.kernel.org/patchwork/patch/1226161/
> https://lore.kernel.org/patchwork/patch/1226162/
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
