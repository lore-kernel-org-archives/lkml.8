Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02843C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBCF207ED
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZPGZGYsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgFEGJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 02:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgFEGJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 02:09:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85C8C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 23:09:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so8441443wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 23:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eBnPTpjo4sbfxNdiUeiX3hhoM91GdEyE1vjnsfKmQVs=;
        b=ZPGZGYsacwgv8VJ1gxNwyvJc0rK46BuynGTaIPFX6flqj0fXKLKT2rw2orZ5Mxgg4k
         EjtsPcjlXrKc/vneYc8K0n1wXtTql1ci6zn8j9y+Mrhr0uvDyVTAeXguOcUCzBrKts2+
         CDruOwthB7t76QoX+SgVB2jm57hgTj9kE0onuPssSMXILpV4izp/hhF7KmTC6j8HOQuk
         8ExQ/ESTlfnFM57O/ar+uQcjgAe3yc4m6HBVidOYugehw8tjCWdqj9HZ5uVxdTlZJGN0
         J1jfrg9caFgmZZEar53OhUDVQmGaCsBWQoGYh4Rar6R/fDGqoBnq8IaaSssZa1DGMJhn
         sCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eBnPTpjo4sbfxNdiUeiX3hhoM91GdEyE1vjnsfKmQVs=;
        b=PkB+cktczzCw/5TYKWaabMiVS6b8yChWthJUEdcgsdzo2M/+ONhSfQskT8tmjgIUKA
         0V+dyOk5L5/INVaPb4OW3eEBbJfbVmQqB5C3VAz9Azn3etU56gs466wok9v1x/Z1GfPp
         JvyQwLqvaKO6HFAmm3LZJy9PHq1tVXHDd26mLa9vVVz4yIMBx9/7MHLzA1OD12LiHnc3
         6dpLLdLoJdgdO70KEKGQLAc8Q3kSqashsVtA+/A3Vg4km9olaD/hiG8J48v0z4CmAuWy
         ccYnyUOYzRBJDK1FR42cuD6gCYXoX/bYFseqnZsH2k/pFbRklqDvK4o8B35dbB+R/Df8
         B+aw==
X-Gm-Message-State: AOAM5334Vp/mSVd2BZNEj9D0Hm/BJBWaNUsqxd70JrN4v6u/7gUN6lLj
        wReriKIT+Tsc9B/aXyLk/2hW9g==
X-Google-Smtp-Source: ABdhPJyO0VqBURko0Faf4hiaDVUBAKMjf83HPbx/6POOw7QaVSJEbD9QQ0OLSM2AvmmABejZKv/WZQ==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr7535060wrp.136.1591337346299;
        Thu, 04 Jun 2020 23:09:06 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id t8sm9900817wmi.46.2020.06.04.23.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 23:09:05 -0700 (PDT)
Date:   Fri, 5 Jun 2020 07:09:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH V2] mfd: sprd: Add wakeup capability for PMIC irq
Message-ID: <20200605060904.GB3714@dell>
References: <20200527062147.680-1-zhang.lyra@gmail.com>
 <CAAfSe-voe6as4VveyMt2pyJR1jytdzfRCp1z3s9AnS+QzTvPKA@mail.gmail.com>
 <20200604111639.GZ3714@dell>
 <CAAfSe-uuzWp+NS9dMj5=f-UFRyYR0XvuX0D_sJ0JpSRVJxnyiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAfSe-uuzWp+NS9dMj5=f-UFRyYR0XvuX0D_sJ0JpSRVJxnyiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Jun 2020, Chunyan Zhang wrote:

> On Thu, 4 Jun 2020 at 19:16, Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 04 Jun 2020, Chunyan Zhang wrote:
> >
> > > Hi Lee,
> > >
> > > On Wed, 27 May 2020 at 14:21, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > >
> > > > From: Baolin Wang <baolin.wang7@gmail.com>
> > > >
> > > > When changing to use suspend-to-idle to save power, the PMIC irq can not
> > > > wakeup the system due to lack of wakeup capability, which will cause
> > > > the sub-irqs (such as power key) of the PMIC can not wake up the system.
> > > > Thus we can add the wakeup capability for PMIC irq to solve this issue,
> > > > as well as removing the IRQF_NO_SUSPEND flag to allow PMIC irq to be
> > > > a wakeup source.
> > > >
> > > > Reported-by: Chunyan Zhang <zhang.lyra@gmail.com>
> > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > Tested-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > ---
> > > > Changes from v1:
> > > > * addressed comments from Lee;
> > > > * added tested-by from Chunyan.
> > > > (This patch is rebased on branch for-mfd-next)
> > >
> > > Could you please pick up this patch if there's no more comments :)
> >
> > Please don't send contentless nags.  Your patch is in my queue.
> >
> > The merge-window is currently open, which is a) a busy time for
> 
> I understand that very much, and also appreciate all maintainer's
> works for the great opensource project.
> And just because of that I know you're busy during merge-window, I was
> worried that this patch was left out, since I didn't see it at
> mfd-next.

It was left out, as it was sent during -rc7.  Very few patches sent to
late in the release cycle are applied during this time, since it
leaves too little time to soak in -next.

The patch should make it into the next kernel release (v5.9) without
issue.

> I apologize if the last email made you unhappay. I will not send
> reminder email to you anymore.

If more than 2 weeks have passed and you genuinely believe your patch
has been forgotten.  The correct means to solve the issue is to submit
a [RESEND].

> > Maintainers and b) a time where some of us take a little breather
> > before the next release.  Please wait until -rc1 has been released
> > before sending out your [RESENDS].

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
