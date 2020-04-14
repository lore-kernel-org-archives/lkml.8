Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69475C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2AB2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AskEzpYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504331AbgDNSqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504293AbgDNSqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:46:32 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6265C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:46:32 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y15so662002vsm.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hm1Qks6SZ0yWu4P75XfFoZTXE4Nra+rfLYilmC4vdmU=;
        b=AskEzpYssKBaC+I8r9xjA/upQU03fey7fH06JRnjoVatycGcNwUujD+hfTF271zYY3
         LjnobQTSiBTpktVOcl+h3EILwuI8sCGjEqPFBGZ1b5w4ZJnfJ+SaoQpR5w56BJfu7UPp
         iHdwkGKCYF2HEvA47R3NTYI22vz2qYDlqXVdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hm1Qks6SZ0yWu4P75XfFoZTXE4Nra+rfLYilmC4vdmU=;
        b=TZ+DWozBm24tep/31Y2MzFU2NUXj6pJHq8WVxJK5D4KFgKQfbpvRv5NAMbq7FTuK7H
         h0RJZeKAlHTBgQpp0sOaC48oNas6AhfVdGdMKs1Cp0uPUZTI/IerFeQDthGSNppCRqPJ
         /zBsjBoi8BebsQ3aOIItMhnNxS5sfwgkCWUJLxwMMHx35PHPOUZbTWyyHu3UTjsB7qXB
         vS65ijupbLgUBO5JEHhOhFNY+u94epo9ZPMEst9qn75jQQt1nIjxGhN1xQiRGHduDdtT
         gfBBF2xTSX9B4hQpY/vw4R1X1DIBrEOOpxN3CnbI9cbSTkQqB0Mh3SrZ+R60rOO8GPZd
         IoJg==
X-Gm-Message-State: AGi0PubhZm9wltUN4qjbdjmddfGbMsmut2oLSkbMC193O+tH/z255NfH
        2AtJn/t/GpYTWpWBlFPEvKHCRpAzDQo=
X-Google-Smtp-Source: APiQypJvwAu8fdA+RHdEKh/eDAPzdyLQAOmby/HfXwOnm2gudesmyZajnEg2dTUUPpjgWcVcyYM4lA==
X-Received: by 2002:a67:1947:: with SMTP id 68mr1514222vsz.145.1586889991673;
        Tue, 14 Apr 2020 11:46:31 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id w143sm4334978vkd.5.2020.04.14.11.46.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 11:46:31 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id u11so635469vsu.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:46:31 -0700 (PDT)
X-Received: by 2002:a67:2b07:: with SMTP id r7mr1505045vsr.169.1586889990771;
 Tue, 14 Apr 2020 11:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200414104120.1.Ic70288f256ff0be65cac6a600367212dfe39f6c9@changeid>
 <9c633ea161df91265a338aaa93a78443894c268f.camel@perches.com>
In-Reply-To: <9c633ea161df91265a338aaa93a78443894c268f.camel@perches.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Apr 2020 11:46:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X8Wci5cKPcfHQq-PjsexwLCjErnB63gF4_XgTBK9aWFQ@mail.gmail.com>
Message-ID: <CAD=FV=X8Wci5cKPcfHQq-PjsexwLCjErnB63gF4_XgTBK9aWFQ@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Factor "tcs_reg_addr" and
 "tcs_cmd_addr" calculation
To:     Joe Perches <joe@perches.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 14, 2020 at 10:58 AM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-04-14 at 10:41 -0700, Douglas Anderson wrote:
> > We can make some of the register access functions more readable by
> > factoring out the calculations a little bit.
>
> unrelated trivia:
>
> > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> []
> >  static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
> >                              u32 data)
> >  {
> > -     writel(data, drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg);
> > +     writel(data, tcs_reg_addr(drv, reg, tcs_id));
> >       for (;;) {
> > -             if (data == readl(drv->tcs_base + reg +
> > -                               RSC_DRV_TCS_OFFSET * tcs_id))
> > +             if (data == readl(tcs_reg_addr(drv, reg, tcs_id)))
> >                       break;
> >               udelay(1);
> >       }
>
> There a lockup potential here.
>
> It might be better to use some max loop counter with
> an error/warning emitted instead of a continuous retry.

Yeah, I noticed that too but I assumed that it was probably OK.  I
think in this case it's really just confirming that the write made it
across the bus since it's checking the same bit that it's writing.
...but I wouldn't be opposed to this changing to use
readl_poll_timeout().

-Doug
