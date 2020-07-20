Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42751C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20106207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vm+rTjwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbgGTUYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbgGTUYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:24:15 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D71C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:24:14 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id d11so9213027vsq.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8OZQPM5EHX3K0LcIbG7M5SK0hksxqYnwmQqH5pq9aU=;
        b=Vm+rTjwEti7KsrVH0G9zYwoD4ZvDR6asQnjKP0m5wquwlArH8wQZRdqCHpEs2vHPvD
         g75u4ABiQ/mstLqHDFM3kEjUdBRDLkaT+aHsmawJTSXH6qiC4UZtxnBplOeiU32rw9e6
         TVFHTnzR3EKkZyrNnb68WQkbezTZ8VZU5t++w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8OZQPM5EHX3K0LcIbG7M5SK0hksxqYnwmQqH5pq9aU=;
        b=mMReK0Qbn6ABIFwY7YwGigNZlLvoUXLFevFQrsFBbC4tHSGSVgQYQwcwhFEDo3oFuT
         fOujgnlRm3mSuUOG5pIb9sCr4LCgWuTCWWvXHp0yHESykSp8UHVToFwWmd54lumE6oXD
         za+UvrjFC1/vYNyvRtMXxPSR7UcviDZrATfB3ak73MjX6EBDmqm1fD552w0vEKj09iU/
         DjbHJdUsYXpze2cF3zZKnTpVjk8M+WmcP1Jg2qllznj/4tUEqWBboUihtXBeBK55jee0
         +Wg3r1/HXH3TxCXfYONQaHkJGZHrmd/AVEsRRt5MdGeVwrBu7IfxEB96L1+8szDzGk3L
         bNyQ==
X-Gm-Message-State: AOAM532a+KTz5AV6MRm3GaSqxL19Rd6fcsIGs6WcYZ6ARjSu4yQx7dPY
        ggmFkkWQK6eSEgf4twfLAkodaPTZhu8=
X-Google-Smtp-Source: ABdhPJyiIChQ6Ejh6h5Uyvl4Z9z+8ag8p+3p08KdThdd3OWoleK7beIwo+8ziBVQ28kiXixXgoh3tA==
X-Received: by 2002:a67:db97:: with SMTP id f23mr17830354vsk.135.1595276653712;
        Mon, 20 Jul 2020 13:24:13 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id j189sm2387461vsd.24.2020.07.20.13.24.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 13:24:12 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id x13so9169764vsx.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:24:12 -0700 (PDT)
X-Received: by 2002:a05:6102:20a:: with SMTP id z10mr17445636vsp.213.1595276651995;
 Mon, 20 Jul 2020 13:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200716132120.1.I01e738cd469b61fc9b28b3ef1c6541a4f48b11bf@changeid>
In-Reply-To: <20200716132120.1.I01e738cd469b61fc9b28b3ef1c6541a4f48b11bf@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 Jul 2020 13:24:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WonUcENxsY_jnYdw3d5rS0OMmrDAoMsDwYRZbMwCkJdw@mail.gmail.com>
Message-ID: <CAD=FV=WonUcENxsY_jnYdw3d5rS0OMmrDAoMsDwYRZbMwCkJdw@mail.gmail.com>
Subject: Re: [PATCH] drm: panel: simple: Delay HPD checking on
 boe_nv133fhm_n61 for 15 ms
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Thu, Jul 16, 2020 at 1:21 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> On boe_nv133fhm_n62 (and presumably on boe_nv133fhm_n61) a scope shows
> a small spike on the HPD line right when you power the panel on.  The
> picture looks something like this:
>
>          +--------------------------------------
>          |
>          |
>          |
> Power ---+
>                                            +---
>                                            |
>               ++                           |
>          +----+|                           |
> HPD -----+     +---------------------------+
>
> So right when power is applied there's a little bump in HPD and then
> there's small spike right before it goes low.  The total time of the
> little bump plus the spike was measured on one panel as being 8 ms
> long.  The total time for the HPD to go high on the same panel was
> 51.2 ms, though the datasheet only promises it is < 200 ms.
>
> When asked about this glitch, BOE indicated that it was expected and
> persisted until the TCON has been initialized.
>
> If this was a real hotpluggable DP panel then this wouldn't matter a
> whole lot.  We'd debounce the HPD signal for a really long time and so
> the little blip wouldn't hurt.  However, this is not a hotpluggable DP
> panel and the the debouncing logic isn't needed and just shows down
> the time needed to get the display working.  This is why the code in
> panel_simple_prepare() doesn't do debouncing and just waits for HPD to
> go high once.  Unfortunately if we get unlucky and happen to poll the
> HPD line right at the spike we can try talking to the panel before
> it's ready.
>
> Let's handle this situation by putting in a 15 ms prepare delay and
> decreasing the "hpd absent delay" by 15 ms.  That means:
> * If you don't have HPD hooked up at all you've still got the
>   hardcoded 200 ms delay.
> * If you've got HPD hooked up you will always wait at least 15 ms
>   before checking HPD.  The only case where this could be bad is if
>   the panel is sharing a voltage rail with something else in the
>   system and was already turned on long before the panel came up.  In
>   such a case we'll be delaying 15 ms for no reason, but it's not a
>   huge delay and I don't see any other good solution to handle that
>   case.
>
> Even though the delay was measured as 8 ms, 15 ms was chosen to give a
> bit of margin.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I don't actually have a device in front of me that is exhibiting these
> problems.  I believe that it is only some devices and some of the
> time.  Still, this patch seems safe and seems likely to fix the issue
> given the scope shots.

Just to follow-up, I just heard that someone who had a panel
exhibiting this problem tried my patch and it fixed it for them.  :-)
So this is not such a shot in the dark anymore.

-Doug
