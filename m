Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073BCC4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8309206B9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU7VtKff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgEDIVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727100AbgEDIVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:21:37 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ACEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 01:21:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y4so8748889ljn.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 01:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUC+hpkyutV8S5+QH/c+7yUMtr6MEkXFCNyPSg7o1E4=;
        b=mU7VtKff+auNB64V3AYUSs2qQFmjPo0dWpA4Aoz+YTW586bZoIgSw9VhcFKYoSoBfw
         bOVl4yPbt3FTTuKTpCXuLlLeVDh36N2hicHfSEwZ6ADqZm9Jqn1GEp234DaD6oeCMmOw
         AZaF945jzYr94/9RAxcctlAIedKPuCORYhA4Xu3pRChnM6v2V1nLukexpBjDSVnzxYaJ
         6oLKSWLSlC7wv/hpL82I8XWOxxGuN4wjxwqVFK7WuHRq6GbYTFMHtYdIbII3hjvIOohq
         VxfwloeIh2nwc6y+U8tcNEH8y+dpm6CqnAdlhytHJQT1H+d45sZGsW2kvvy1ldQXnx06
         viPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUC+hpkyutV8S5+QH/c+7yUMtr6MEkXFCNyPSg7o1E4=;
        b=Chog8oJWZzen3w7bSNvyzxxU6ZwnjgJLrI2JVwfPV9knjl8OXB9X1LWNJBKejrpXvj
         OUoY1uueOaaTxPRcrRvQJ9y+vmVXLkxx1X1gDogozimgm7mYtPRXJrjXIGbPSym1pnHE
         +yfOWp8NbHTz/AYf62dA/SyRMm7+mm7ohbfvzbsC/SsVWglcqzLBmpnlFNuq8vyv4ZBi
         +VCtEzFKy80ZEnZkJNj/wj9RIJR5ZNJ+xZ7uLDV2PLGHx+gjOEg1b3n872fdGjtvz5B1
         MxDEUxX0btCLyMuqJMyvtpTXAnCz9kmvNuFX/V/qDaeHu5B9D+2yaz4ANxzGVxViP7bP
         Jatw==
X-Gm-Message-State: AGi0PuZgeE/uBsVFB5PV+EX5bRYEdanVERj8fOzYmf8c5KFAQHTLW3X2
        Wsdm2vNLLfUCuaOle4nc0hADTAoFSk3x1Rp8H3M=
X-Google-Smtp-Source: APiQypLbXjgu8KnJh/TptbZQXk2/XJY0chvNvaA7TtSWS/bWwmb+UY+6XkkrvNtDTPWLVl8K88HCGsvtKZdMUVRV9f8=
X-Received: by 2002:a2e:8603:: with SMTP id a3mr9843410lji.153.1588580495753;
 Mon, 04 May 2020 01:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <c2fd765aa388d4510194ba02c017e39bde57c8d4.1587478171.git.baolin.wang7@gmail.com>
 <CADBw62rJ8VYTgnW_3q4=TkCyZx2B1DHsG+oOmiph8FLsukUROQ@mail.gmail.com>
 <20200427090518.GG3559@dell> <CADBw62qXtNnoNq0F1iZrvQHryMTy86GEqcD-qXBzsJJL-B8mQg@mail.gmail.com>
 <20200428071447.GJ3559@dell> <CADBw62o=D-hmp1yB=oPXPJfBucOEEa87cZado5+1mTKsCWDKfg@mail.gmail.com>
 <20200428081902.GK3559@dell> <CADBw62qrsOHUCKdU17ctQBM21EAOuAO8vxFabRP9hpguC5ixsg@mail.gmail.com>
In-Reply-To: <CADBw62qrsOHUCKdU17ctQBM21EAOuAO8vxFabRP9hpguC5ixsg@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 4 May 2020 16:21:22 +0800
Message-ID: <CADBw62psCr1aSmYtqck5dpddCRk8f-UAw5rUsPyfhNw-OCfYkA@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: syscon: Add Spreadtrum physical regmap bus support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd

On Tue, Apr 28, 2020 at 4:41 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> On Tue, Apr 28, 2020 at 4:19 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 28 Apr 2020, Baolin Wang wrote:
> >
> > > On Tue, Apr 28, 2020 at 3:14 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Tue, 28 Apr 2020, Baolin Wang wrote:
> > > >
> > > > > On Mon, Apr 27, 2020 at 5:05 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > >
> > > > > > On Mon, 27 Apr 2020, Baolin Wang wrote:
> > > > > >
> > > > > > > Hi Arnd and Lee,
> > > > > > >
> > > > > > > On Tue, Apr 21, 2020 at 10:13 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Some platforms such as Spreadtrum platform, define a special method to
> > > > > > > > update bits of the registers instead of read-modify-write, which means
> > > > > > > > we should use a physical regmap bus to define the reg_update_bits()
> > > > > > > > operation instead of the MMIO regmap bus. Thus we can register a new
> > > > > > > > physical regmap bus into syscon core to support this.
> > > > > > > >
> > > > > > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > > > >
> > > > > > > Do you have any comments for this patch? Thanks.
> > > > > >
> > > > > > Yes.  I'm not accepting it, sorry.
> > > > > >
> > > > > > I'd rather you duplicate the things you need from of_syscon_register()
> > > > > > in your own driver than taint this one.
> > > > >
> > > > > Thanks for your comments and I can understand your concern. But we
> > > > > still want to use the standard syscon APIs in syscon.c, which means we
> > > > > still need insert an callback or registration or other similar methods
> > > > > to support vendor specific regmap bus. Otherwise we should invent some
> > > > > similar syscon APIs in our vendor syscon driver, like
> > > > > sprd_syscon_regmap_lookup_by_phandle/sprd_syscon_regmap_lookup_by_compatible.
> > > >
> > > > So long as the generic driver stays generic.  Providing a registration
> > > > function sounds cleaner than tainting the code with vendor specifics.
> > >
> > > So seems my V1 patch set [1] was on the direction as you suggested,
> > > but Arnd did not like that.
> > >
> > > [1]
> > > https://lore.kernel.org/patchwork/patch/1226161/
> > > https://lore.kernel.org/patchwork/patch/1226162/
> >
> > I don't often disagree with Arnd, but in this instance I think a
> > registration function which allows vendor spin-offs to use the generic
> > API is better than tainting the generic driver by adding vendor
> > specific #ifery/code to it.
> >
> > Your original idea seems more palatable to me.
>
> OK, thanks for sharing your opinion. Let's see what Arnd's opinion
> before I send out new version.

Do yo have any comments about how to add new bits updating method? Can
I re-send my v1 patch set [1]? Thanks.

[1]:
https://lore.kernel.org/patchwork/patch/1226161/
https://lore.kernel.org/patchwork/patch/1226162/

-- 
Baolin Wang
