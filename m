Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E1EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F9A208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jKgTWVCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgFZVtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZVtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:49:16 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C12DC03E97B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:49:15 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g44so3490162uae.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UILKlvs+GHBhKFphEyncEpPSUsoHCqFUMYUBW3SvT5s=;
        b=jKgTWVCFrYAd3dJXBqQFQxSBYQjuuixCxOjPukeyqxUO/e+fi8dK32Eh9DjzJtOLL1
         nFWBuOWUVUO7aVSpIP1hVhfwFGkZBUrnRhfWlAH8a5WeFoRMyEyPpabt6LRLzTLDWcOA
         CqkvBWP4wDRZPRHKmpKJwVEZuyNtMSBjHBQLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UILKlvs+GHBhKFphEyncEpPSUsoHCqFUMYUBW3SvT5s=;
        b=q9MzxfBCs/pch4DJh264G9mTiABYKeAEt3ks2D2e7zgmF1k/CAmCG80yr0T0xqnp2r
         DxCFi+DF1IpNWv9TQIoKKSbvM1J3cBqtmf8OvUG5W4K0J9870INr//BPTN0bOaktyN92
         lTN1X7n6GDgi7oOaWoe/lutZBqhP1ZSqlFR5/mNKXoPuQxzllgaL9AmWv30EhWil+QCa
         R8q0L7NddE57/iSzLklcm80aio3mzZPK2mwBO8xa4+Ww23Z32NOGcAHNvYCMQsNhnYE4
         bsCxcdIQok7rIqP7/GJCbApHBfxklrbSrPouKrRMH1ZZdgF6PyistrST205R7+BCOAmA
         PwFw==
X-Gm-Message-State: AOAM532IvKOkswiNG0rNaCZ/YgVx+Y8yHfx4ro/JgyYCdR+m8Ufv4v/Y
        ewLDCQlPtykH8n20XzsUkjc7T/031/k=
X-Google-Smtp-Source: ABdhPJzK+PvpmzaaYWiacX6tHEY3EA7m5/FSSLLPh6xGV5sp5lvZCwJZnOhqf2Y6xPpVfA0DaXwK+g==
X-Received: by 2002:a9f:2d83:: with SMTP id v3mr3808623uaj.92.1593208154024;
        Fri, 26 Jun 2020 14:49:14 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id q134sm2720144vkb.18.2020.06.26.14.49.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 14:49:13 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id o2so6273542vsr.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:49:13 -0700 (PDT)
X-Received: by 2002:a67:62c4:: with SMTP id w187mr4135305vsb.109.1593208152714;
 Fri, 26 Jun 2020 14:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <1593193967-29897-1-git-send-email-pillair@codeaurora.org> <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com>
In-Reply-To: <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Jun 2020 14:49:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
Message-ID: <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
To:     Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 26, 2020 at 2:37 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Jun 26, 2020 at 10:53 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
> >
> > Currently the NAPI processing loops through all
> > the copy engines and processes a particular copy
> > engine is the copy completion is set for that copy
> > engine. The host driver is not supposed to access
> > any copy engine register after clearing the interrupt
> > status register.
> >
> > This might result in kernel crash like the one below
> > [ 1159.220143] Call trace:
> > [ 1159.220170]  ath10k_snoc_read32+0x20/0x40 [ath10k_snoc]
> > [ 1159.220193]  ath10k_ce_per_engine_service_any+0x78/0x130 [ath10k_core]
> > [ 1159.220203]  ath10k_snoc_napi_poll+0x38/0x8c [ath10k_snoc]
> > [ 1159.220270]  net_rx_action+0x100/0x3b0
> > [ 1159.220312]  __do_softirq+0x164/0x30c
> > [ 1159.220345]  run_ksoftirqd+0x2c/0x64
> > [ 1159.220380]  smpboot_thread_fn+0x1b0/0x288
> > [ 1159.220405]  kthread+0x11c/0x12c
> > [ 1159.220423]  ret_from_fork+0x10/0x18
> >
> > To avoid such a scenario, we generate an interrupt
> > summary by reading the copy completion for all the
> > copy engine before actually processing any of them.
> > This will avoid reading the interrupt status register
> > for any CE after the interrupt status is cleared.
> >
> > Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> >
> > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> > ---
> >  drivers/net/wireless/ath/ath10k/ce.c | 63 ++++++++++++++++++++++--------------
> >  drivers/net/wireless/ath/ath10k/ce.h |  5 +--
> >  2 files changed, 42 insertions(+), 26 deletions(-)
>
> I'm not an expert on this driver, but your change seems sane to me.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> With your patch I can no longer find a place to put in a magic delay
> and reproduce the crash, thus:
>
> Tested-by: Douglas Anderson <dianders@chromium.org>
>
>
> If it matters, my WiFi firmware reports this:
>
> WLAN.HL.3.2.2-00490-QCAHLSWMTPL-1
>
> ...and it should also be WCN3990.

I should also note that, while I'm not terribly familiar with Kalle's
workflow, I would have expected to see him in the "To:" list.  I've
added him, but it's possible he'll need you to repost the patch with
him in the "To:" list.

-Doug
