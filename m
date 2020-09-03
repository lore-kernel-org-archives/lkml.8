Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AC2C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A92D20775
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JfKC0Y35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgICPyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgICPyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:54:20 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4129DC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 08:54:20 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id a16so1976851vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1RdWhFEUIEusrCzDYddJtTorOG99HWCCc7/UV2fKOf4=;
        b=JfKC0Y35WzHtVAfZBViQ/tKsZUybqwHfVCx6QlbKyX/XjoFMqDy5V+YheduSqsBSJs
         f4TuzdbQXF4N470Nm0qN0NGy66JKgN1WuU2qJirS2eCaCZmfSWUUXYs/0HFcs1E9P2g+
         OW1mqs25SSpiJs+P2eUAgF0Y/gXD0cIl4Su5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1RdWhFEUIEusrCzDYddJtTorOG99HWCCc7/UV2fKOf4=;
        b=oeo5zQMKZkv5jEZaEpGbsmiCDB0GFtllXFaJ2YiNOWKMIXrdTp1GO9qqW3k7JWArBs
         bDW+QIJS5SRL6EuwiH98sV35ovMVqjQzMk6XP39rIlCsjRlFvyRe2lVw82IZFeHuru3R
         p7xrdkXaafnI+XlhchVbnlWi2BkWe3aX3XnXzHhJ47Fn7p8F2+DyifgPWx9I6Nl+PZhk
         rwLyhnGs+QXMvDCMqZUIh1moj/ehnaV8RLptDeXsPfPa6jvMsijKMLYuXsbwo8Ss3Vle
         tIsdYestdBkkL6MTO4JuGSEQ9dkn/3mEDnEvuVUbKVQv7sji5PRGGN/aK3NIx1eRgVZo
         LerQ==
X-Gm-Message-State: AOAM531mztzmQn6IW9keyBKloVKOi6fD1tBrGiKaF0MnLufsN/qjsYae
        QxVUg/w/Tysbd5OpaaVbo5qc92t7IkMhJQ==
X-Google-Smtp-Source: ABdhPJws3KpeKcJ2prO7SRCCHZma1GDeGVJpOObTpIO99FdLRbqVmuDh0tDusrhIo7ueVTxxiPO1cg==
X-Received: by 2002:a67:7dd3:: with SMTP id y202mr1862388vsc.0.1599148457824;
        Thu, 03 Sep 2020 08:54:17 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id t81sm557343vke.14.2020.09.03.08.54.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 08:54:17 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id p185so1990697vsp.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 08:54:17 -0700 (PDT)
X-Received: by 2002:a67:8c89:: with SMTP id o131mr2434340vsd.41.1599148456608;
 Thu, 03 Sep 2020 08:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200817144722.6665-1-saiprakash.ranjan@codeaurora.org>
 <CAD=FV=VE6vCPjDvvP0e73tnd8u5rPuMUa-mwvDazrfUpXP+bKQ@mail.gmail.com>
 <2a0c5fa189dbb2e810ba88f59621b65c@codeaurora.org> <CAD=FV=X8yS1gUNhhVNyfuRPzDUheG2Rco2g16KMegCG6fKJw7Q@mail.gmail.com>
 <d949bdfa15b133f74a47727401553c76@codeaurora.org> <7714ee57f75542839d5c33b28f232aa6@codeaurora.org>
 <CAD=FV=Xt0NTNjCEJ2USfyd2qZ+FfBz9xwctbpv+hSWvvCoAZFg@mail.gmail.com> <dd60dafcea8b75b10516bf2bc4952abb@codeaurora.org>
In-Reply-To: <dd60dafcea8b75b10516bf2bc4952abb@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Sep 2020 08:54:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WrEh9_XqOvA5mNYQRMDujOWBqeeDFDFj_C3XKy-okGVQ@mail.gmail.com>
Message-ID: <CAD=FV=WrEh9_XqOvA5mNYQRMDujOWBqeeDFDFj_C3XKy-okGVQ@mail.gmail.com>
Subject: Re: [PATCHv2] soc: qcom: llcc: Support chipsets that can write to
 llcc registers
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 3, 2020 at 8:47 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> On 2020-09-03 19:16, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Sep 3, 2020 at 2:58 AM Sai Prakash Ranjan
> > <saiprakash.ranjan@codeaurora.org> wrote:
> >>
> >> Hi,
> >>
> >> On 2020-08-18 21:07, Sai Prakash Ranjan wrote:
> >> > Hi Doug,
> >> >
> >> >>
> >> >> I guess to start, it wasn't obvious (to me) that there were two
> >> >> choices and we were picking one.  Mentioning that the other
> >> >> alternative was way-based allocation would help a lot.  Even if you
> >> >> can't fully explain the differences between the two, adding somethi=
ng
> >> >> to the commit message indicating that this is a policy decision (in
> >> >> other words, both work but each have their tradeoffs) would help.
> >> >> Something like this, if it's correct:
> >> >>
> >> >> In general we try to enable capacity based allocation (instead of t=
he
> >> >> default way based allocation) since that gives us better performanc=
e
> >> >> with the current software / hardware configuration.
> >> >>
> >> >
> >> > Thanks, I will add it for next version. Let me also go poke some arc=
h
> >> > teams
> >> > to understand if we actually do gain something with this selection, =
who
> >> > knows
> >> > we might get some additional details as well.
> >> >
> >>
> >> I got some information from arch team today, to quote them exactly:
> >>
> >> 1) What benefits capacity based allocation brings over the default way
> >> based allocation?
> >>
> >> "Capacity based allows finer grain partition. It is not about improved
> >> performance but more flexibility in configuration."
> >>
> >> 2) Retain through power collapse, doesn=E2=80=99t it burn more power?
> >>
> >> "This feature is similar to the standard feature of retention. Yes,
> >> when
> >> we
> >> have cache in retention mode it burns more power but it keeps the
> >> values
> >> so
> >> that when we wake up we can get more cache hits."
> >>
> >>
> >> If its good enough, then I will add this info to the commit msg and
> >> post
> >> next version.
> >
> > Sounds fine to me.  I was mostly looking for a high level idea of what
> > was happening here.  I am at least a little curious about the
> > retention bit.  Is that retention during S3, or during some sort of
> > Runtime PM?  Any idea how much power is burned?  Unless the power is
> > miniscule it seems hard to believe that it would be a net win to keep
> > a cache powered up during S3 unless you're planning on waking up a
> > lot.
> >
>
> The retention setting is based on sub cache id(SCID), so I think its for
> runtime pm, the power numbers weren't provided. But I believe these
> decisions are made after solid testing and not some random
> approximations.

Right, I believe it was tested, I just wonder if it was tested on a
phone vs. a laptop.  A phone is almost constantly waking up to deal
with stuff (which is why my phone battery barely lasts till the end of
the day).  Phones also usually have some type of self refresh on their
panels so they can be suspended even when they look awake which means
even more constant wakeups.  A laptop (especially without panel self
refresh) may have very different usage models.  I'm trying to confirm
that this setting is appropriate for both classes of devices or if it
has been only measured / optimized for the cell phone use case.

-Doug
