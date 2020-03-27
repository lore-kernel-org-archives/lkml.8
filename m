Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443A9C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1112076B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KbYEM+2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgC0SmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:42:20 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35409 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgC0SmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:42:20 -0400
Received: by mail-vs1-f68.google.com with SMTP id u11so6895589vsg.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xc3LoiplRnf2aKZoDkeqAn+I7PpOTwp2GWQBp5c9cME=;
        b=KbYEM+2vyjx2c7Pk5OCUrrNAWU8wVJP8BfLb9V1kBS3T3g9kwSbFPaih46M5o42bHE
         BwX800FckXQ8L0ubDF/CdkrVIPG7r4L/IuzFcu+CJKZDfw93iGrHwj2Ka1WDjoN2heic
         MriKZ8uwjcDbohlycFXZywHiFek01lSaL/Fho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xc3LoiplRnf2aKZoDkeqAn+I7PpOTwp2GWQBp5c9cME=;
        b=roADx8S6r5gSZTpKUUM+Jq8A55/konzoQjz9QB71TXU1xzJkE+a0Fn+tzlQP4lKwyF
         Nciv2UfgrOXoxSXctnLjQp6/5Uta9TEzryRLwBw6Q6s5eEnU5y4T4Up/HFgb4wRiCpxV
         7SBOQ5gC3EmhdTgxxqYPB0bONhBUX1mVh4dFGDj5/8PznHp7pe6TyW4Z9V8ymdakTPHy
         AYQ8DlK8Q6k/sFH6N97K2tT5ikndd+leeKdezAYEEYWg46v0/AhiGyeHNw230XaJWaxC
         4l3rfWoITXSambCUzQRGPjajmcEEBD3BVAGEfVLCxkHnuhg+3VQ+D3aCUo1WN8T6FBGR
         jnCA==
X-Gm-Message-State: AGi0PuYj7zJuTSK0JoRQS94sJR7tYZPS094yiUGUWrk8GXIhyAk4KIlE
        LM68JW36ALstdGFfuIBb5AqcLYl7F2w=
X-Google-Smtp-Source: APiQypL/Nzr/rwWqmsnrkFk/J4WcMINB2nh8fxWNz8UQqY1II9Nhw2DrP8wP8KywLgL1oezcfU3HDQ==
X-Received: by 2002:a67:2fd8:: with SMTP id v207mr308061vsv.233.1585334537277;
        Fri, 27 Mar 2020 11:42:17 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id c16sm1065352vsq.18.2020.03.27.11.42.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 11:42:15 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id t20so3869486uao.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 11:42:15 -0700 (PDT)
X-Received: by 2002:a9f:21b8:: with SMTP id 53mr279391uac.8.1585334535095;
 Fri, 27 Mar 2020 11:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <1585244270-637-1-git-send-email-mkshah@codeaurora.org>
 <1585244270-637-7-git-send-email-mkshah@codeaurora.org> <CAD=FV=Vbo3JC6mBJXq+q+DQPC_bbNtn3bbScG5N8wzJZm87YuA@mail.gmail.com>
 <8d19958d-7334-ca4e-d7ba-f5919a56b279@codeaurora.org>
In-Reply-To: <8d19958d-7334-ca4e-d7ba-f5919a56b279@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 27 Mar 2020 11:42:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UZTyfVN=a35hiXxdNSvdhfK60HewP_p_VvH1KdoUa1ww@mail.gmail.com>
Message-ID: <CAD=FV=UZTyfVN=a35hiXxdNSvdhfK60HewP_p_VvH1KdoUa1ww@mail.gmail.com>
Subject: Re: [PATCH v14 6/6] soc: qcom: rpmh-rsc: Allow using free WAKE TCS
 for active request
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 27, 2020 at 5:04 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> > Why can't rpmh_write()
> > / rpmh_write_async() / rpmh_write_batch() just always unconditionally
> > mark the cache dirty?  Are there really lots of cases when those calls
> > are made and they do nothing?
>
> At rpmh.c, it doesn't know that rpmh-rsc.c worked on borrowed TCS to finish the request.
>
> We should not blindly mark caches dirty everytime.

In message ID "5a5274ac-41f4-b06d-ff49-c00cef67aa7f@codeaurora.org"
which seems to be missing from the archives, you said:

> yes we should trust callers not to send duplicate data

...you can see some reference to it in my reply:

https://lore.kernel.org/r/CAD=FV=VPSahhK71k_D+nfL1=5QE5sKMQT=6zzyEF7+JWMcTxsg@mail.gmail.com/

If callers are trusted to never send duplicate data then ever call to
rpmh_write() will make a change.  ...and thus the cache should always
be marked dirty, no?  Also note that since rpmh_write() to "active"
also counts as a write to "wake" even those will dirty the cache.

Which case are you expecting a rpmh_write() call to not dirty the cache?


> > ...interestingly after your patch I guess now I guess tcs_invalidate()
> > no longer needs spinlocks since it's only ever called from PM code on
> > the last CPU.  ...if you agree, I can always do it in my cleanup
> > series.  See:
> >
> > https://lore.kernel.org/r/CAD=FV=Xp1o68HnC2-hMnffDDsi+jjgc9pNrdNuypjQZbS5K4nQ@mail.gmail.com
> >
> > -Doug
>
> There are other RSCs which use same driver, so lets keep spinlock.

It is really hard to try to write keeping in mind these "other RSCs"
for which there is no code upstream.  IMO we should write the code
keeping in mind what is supported upstream and then when those "other
RSCs" get added we can evaluate their needs.

Specifically when reasoning about rpmh.c and rpmh-rsc.c I can only
look at the code that's there now and decide whether it is race free
or there are races.  Back when I was analyzing the proposal to do
rpmh_flush() all the time (not from PM code) it felt like there were a
bunch of races, especially in the zero-active-TCS case.  Most of the
races go away when you assume that rpmh_flush() is only ever called
from the PM code when nobody could be in the middle of an active
transfer.

If we are ever planning to call rpmh_flush() from another place we
need to re-look at all those races.


-Doug
