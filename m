Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE67C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC302053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2x5E/y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgD1Il4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726641AbgD1Ilz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:41:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7056FC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 01:41:55 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f11so15970759ljp.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 01:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5xO2curM8TPnAbNfzC7JBzZZ5XZ1U5vChbJBjLJxQNk=;
        b=N2x5E/y429xcQRwIsDERP9vgg9I9dC/YUkDuruDVAsHIt/13nZ36rdNqyA3IiSaMKI
         fteIk/m64SGiNnc7FWjaHwLxdZ67jYUW4ocSPeLMGxAICNfpHAv//GgkxNvumH33euIK
         XzEiX7nfsJ8J+osQj2FBVEEqWL7YchB44endof69ArlwVQNFJHCnPBgR6/48C24IZyQ0
         LIzTloiEGcJcYGLjpOsAUU3qRRdw6emyQRC/klLcVcRtD6OKWxsL2ez8Vud95SG6usWr
         4k5INzK4ews/ZWFOJMahVXyBtaynUrEKBrktop5h2GK/oPRCUAO6vD3WMdGkZEhQaKO7
         FIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5xO2curM8TPnAbNfzC7JBzZZ5XZ1U5vChbJBjLJxQNk=;
        b=Yl1OEjAapDmbgg3NVCACCvbdp68TUffLFU/63SI6dempO13jxdLU3tyowRQ6g6ggwP
         gKE5XBCNqNF1Mfz/rs6SWhEcWLIhGTyB1U9XgFp8d2JwhcwnFPneLA0bQLTCySNpUTBu
         ODHnZL5ihC/7wkS2fb2SXu/9BEdTTq8knqREOzeSDVUUo5V9hyHBkPJT/0lmgy+u0hZ4
         fiVl/VRrtlY8PTsBmp+UKW4XAgXvQwMmU+0LNLhJpUN4kYMSzwix3C+ownDyUFqMFNBl
         Ge5uVL81pMZPBow/ckCLtDgFLgIs4FBwXf+O7aOwJvysAHvS4OINRLzJPpDDAjW5V9Cg
         rZnQ==
X-Gm-Message-State: AGi0PuYGEcSyfzs+Vn7e+wPkLxt7LPGc1/dOENkEaf+BUvxYA5L7RdS3
        me6QTuoQzHYxFRU0S1O6rkPwyToNh4sZL/YoHZw=
X-Google-Smtp-Source: APiQypJFzaR2etbv4S4HLIvAIGjC4yqHby+BjyQQ8bLYQSK8d0Fa5/4bUXOlfjdX0WckVGenwsWWdMvyELDu03Ee4Q8=
X-Received: by 2002:a2e:5746:: with SMTP id r6mr16565212ljd.15.1588063313948;
 Tue, 28 Apr 2020 01:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <c2fd765aa388d4510194ba02c017e39bde57c8d4.1587478171.git.baolin.wang7@gmail.com>
 <CADBw62rJ8VYTgnW_3q4=TkCyZx2B1DHsG+oOmiph8FLsukUROQ@mail.gmail.com>
 <20200427090518.GG3559@dell> <CADBw62qXtNnoNq0F1iZrvQHryMTy86GEqcD-qXBzsJJL-B8mQg@mail.gmail.com>
 <20200428071447.GJ3559@dell> <CADBw62o=D-hmp1yB=oPXPJfBucOEEa87cZado5+1mTKsCWDKfg@mail.gmail.com>
 <20200428081902.GK3559@dell>
In-Reply-To: <20200428081902.GK3559@dell>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 28 Apr 2020 16:41:42 +0800
Message-ID: <CADBw62qrsOHUCKdU17ctQBM21EAOuAO8vxFabRP9hpguC5ixsg@mail.gmail.com>
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

On Tue, Apr 28, 2020 at 4:19 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 28 Apr 2020, Baolin Wang wrote:
>
> > On Tue, Apr 28, 2020 at 3:14 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Tue, 28 Apr 2020, Baolin Wang wrote:
> > >
> > > > On Mon, Apr 27, 2020 at 5:05 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > >
> > > > > On Mon, 27 Apr 2020, Baolin Wang wrote:
> > > > >
> > > > > > Hi Arnd and Lee,
> > > > > >
> > > > > > On Tue, Apr 21, 2020 at 10:13 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > > >
> > > > > > > Some platforms such as Spreadtrum platform, define a special method to
> > > > > > > update bits of the registers instead of read-modify-write, which means
> > > > > > > we should use a physical regmap bus to define the reg_update_bits()
> > > > > > > operation instead of the MMIO regmap bus. Thus we can register a new
> > > > > > > physical regmap bus into syscon core to support this.
> > > > > > >
> > > > > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > > >
> > > > > > Do you have any comments for this patch? Thanks.
> > > > >
> > > > > Yes.  I'm not accepting it, sorry.
> > > > >
> > > > > I'd rather you duplicate the things you need from of_syscon_register()
> > > > > in your own driver than taint this one.
> > > >
> > > > Thanks for your comments and I can understand your concern. But we
> > > > still want to use the standard syscon APIs in syscon.c, which means we
> > > > still need insert an callback or registration or other similar methods
> > > > to support vendor specific regmap bus. Otherwise we should invent some
> > > > similar syscon APIs in our vendor syscon driver, like
> > > > sprd_syscon_regmap_lookup_by_phandle/sprd_syscon_regmap_lookup_by_compatible.
> > >
> > > So long as the generic driver stays generic.  Providing a registration
> > > function sounds cleaner than tainting the code with vendor specifics.
> >
> > So seems my V1 patch set [1] was on the direction as you suggested,
> > but Arnd did not like that.
> >
> > [1]
> > https://lore.kernel.org/patchwork/patch/1226161/
> > https://lore.kernel.org/patchwork/patch/1226162/
>
> I don't often disagree with Arnd, but in this instance I think a
> registration function which allows vendor spin-offs to use the generic
> API is better than tainting the generic driver by adding vendor
> specific #ifery/code to it.
>
> Your original idea seems more palatable to me.

OK, thanks for sharing your opinion. Let's see what Arnd's opinion
before I send out new version.

-- 
Baolin Wang
