Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C10C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416A620823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfXV6uvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgESNK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgESNK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:10:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EBEC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:10:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z18so5445784lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3T4HJxG7nloSmqdosUw7LZReYrTIT+rb+lo8g4PhXc=;
        b=WfXV6uvWMP7bERrroIWlWQhf8aEFDvg396PU/l5K/u1eegAtL8ZrMTl1uXpTlHum05
         INGDeUjN7qDA5B93Yy0zA6RENPkb7xW2Xl6XrgVzP0L9IjOUh9PjmELLWLgzF82kba5H
         rc2p4ssL2U/+hddN81cxAqbASB3/3lt2ekMV/4CKKLcqxrj50Q1m5ZFjjo6m6WziXB2r
         uphJkg7eeimwHvhdUjSoSU9X9ptyge1/gyA3V75PdKAaixQXPvstFGTxTNsXbQypHPC6
         Ra6RQR2sWctWRMx+bFr8CWTxXRCZHf9BdB/rRaNMIHbXg5upwK2Y+zR4t7jkx4LDdvtM
         vu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3T4HJxG7nloSmqdosUw7LZReYrTIT+rb+lo8g4PhXc=;
        b=p6McBTmJfsnF2eavteh6iRGJGALa5p5IIpm9DWcyNxxCU7u2qzCnfLJVpniQnuO7sM
         ucgK+Qzl9vD/klDibzffGMT4FKVvakKKjsqtaytpAMaISiVLmM8gy6hSh6REWjoWWPCU
         Hlu4WKkBUGBW4FTf6AulfmJa1zabkRqxa3P1PbJVTmwh3KD3v4xsseyyRX5QIHNqZLWE
         /KKbtaLlZKyAknfvAf665vq5zRt0DsDBN6r2uchtzqOZ9mVv64Y0oZW4Iyb4C8Hmsq2Z
         egHp2tCTBFi9zu7j7nrgxvc0aK3DqS6DF9f4/fAyfRkjB0GUVwpHUIdyAqCMMUl07QXz
         CY9Q==
X-Gm-Message-State: AOAM532dw+RQVeHFvlc3vfy19mznnZ02ITniVfQ1BXMPzdNuZ/zDbXqO
        /2OD/jd6/hos+/FK0GEyPvcWcbbYKJYI4/3rkeiUlA89
X-Google-Smtp-Source: ABdhPJwtjCl2l/A0oGeUtPPFnQfGFCfpy9223dKnCMGr9Lf2njPCAfitKZVHMCS1pJNbPCr1hR5N3vAvLYMNVNoNaJg=
X-Received: by 2002:a2e:9a0d:: with SMTP id o13mr12632808lji.15.1589893855058;
 Tue, 19 May 2020 06:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <c2fd765aa388d4510194ba02c017e39bde57c8d4.1587478171.git.baolin.wang7@gmail.com>
 <CADBw62rJ8VYTgnW_3q4=TkCyZx2B1DHsG+oOmiph8FLsukUROQ@mail.gmail.com>
 <20200427090518.GG3559@dell> <CADBw62qXtNnoNq0F1iZrvQHryMTy86GEqcD-qXBzsJJL-B8mQg@mail.gmail.com>
 <20200428071447.GJ3559@dell> <CADBw62o=D-hmp1yB=oPXPJfBucOEEa87cZado5+1mTKsCWDKfg@mail.gmail.com>
 <20200428081902.GK3559@dell> <CADBw62qrsOHUCKdU17ctQBM21EAOuAO8vxFabRP9hpguC5ixsg@mail.gmail.com>
 <CADBw62psCr1aSmYtqck5dpddCRk8f-UAw5rUsPyfhNw-OCfYkA@mail.gmail.com> <20200519103510.GV271301@dell>
In-Reply-To: <20200519103510.GV271301@dell>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 19 May 2020 21:10:43 +0800
Message-ID: <CADBw62qq4o8dXx=uvTKmaVJbgpAVnHx8gEfjdGn6EHKtg5b8PQ@mail.gmail.com>
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

On Tue, May 19, 2020 at 6:35 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 04 May 2020, Baolin Wang wrote:
>
> > Hi Arnd
> >
> > On Tue, Apr 28, 2020 at 4:41 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > >
> > > On Tue, Apr 28, 2020 at 4:19 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Tue, 28 Apr 2020, Baolin Wang wrote:
> > > >
> > > > > On Tue, Apr 28, 2020 at 3:14 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > >
> > > > > > On Tue, 28 Apr 2020, Baolin Wang wrote:
> > > > > >
> > > > > > > On Mon, Apr 27, 2020 at 5:05 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, 27 Apr 2020, Baolin Wang wrote:
> > > > > > > >
> > > > > > > > > Hi Arnd and Lee,
> > > > > > > > >
> > > > > > > > > On Tue, Apr 21, 2020 at 10:13 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Some platforms such as Spreadtrum platform, define a special method to
> > > > > > > > > > update bits of the registers instead of read-modify-write, which means
> > > > > > > > > > we should use a physical regmap bus to define the reg_update_bits()
> > > > > > > > > > operation instead of the MMIO regmap bus. Thus we can register a new
> > > > > > > > > > physical regmap bus into syscon core to support this.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > > > > > >
> > > > > > > > > Do you have any comments for this patch? Thanks.
> > > > > > > >
> > > > > > > > Yes.  I'm not accepting it, sorry.
> > > > > > > >
> > > > > > > > I'd rather you duplicate the things you need from of_syscon_register()
> > > > > > > > in your own driver than taint this one.
> > > > > > >
> > > > > > > Thanks for your comments and I can understand your concern. But we
> > > > > > > still want to use the standard syscon APIs in syscon.c, which means we
> > > > > > > still need insert an callback or registration or other similar methods
> > > > > > > to support vendor specific regmap bus. Otherwise we should invent some
> > > > > > > similar syscon APIs in our vendor syscon driver, like
> > > > > > > sprd_syscon_regmap_lookup_by_phandle/sprd_syscon_regmap_lookup_by_compatible.
> > > > > >
> > > > > > So long as the generic driver stays generic.  Providing a registration
> > > > > > function sounds cleaner than tainting the code with vendor specifics.
> > > > >
> > > > > So seems my V1 patch set [1] was on the direction as you suggested,
> > > > > but Arnd did not like that.
> > > > >
> > > > > [1]
> > > > > https://lore.kernel.org/patchwork/patch/1226161/
> > > > > https://lore.kernel.org/patchwork/patch/1226162/
> > > >
> > > > I don't often disagree with Arnd, but in this instance I think a
> > > > registration function which allows vendor spin-offs to use the generic
> > > > API is better than tainting the generic driver by adding vendor
> > > > specific #ifery/code to it.
> > > >
> > > > Your original idea seems more palatable to me.
> > >
> > > OK, thanks for sharing your opinion. Let's see what Arnd's opinion
> > > before I send out new version.
> >
> > Do yo have any comments about how to add new bits updating method? Can
> > I re-send my v1 patch set [1]? Thanks.
>
> Just resend and we'll review.

Yes, I already sent out the v4 patch set.
https://lore.kernel.org/patchwork/patch/1242814/
https://lore.kernel.org/patchwork/patch/1242815/

-- 
Baolin Wang
