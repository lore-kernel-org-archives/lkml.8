Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE17FC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58D52074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6filvbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgD3M5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726483AbgD3M5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:57:10 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E147C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 05:57:08 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e10so1111038vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 05:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mU9mh8frCSvzZ2AQ8WhgOwwMg+9Km7u/NzzuYl4YD1I=;
        b=g6filvbPbyIgdPyFg4f/c2OWURlfXHDUJ90Exzzsi3HA3iNVJe8+600azVV+stqhS8
         ctrtGOjUDszhu4EBHa6W4hPtviR5pvOXdG6fx5KAlaKp8x/KnbfKQdLt/KZ21gDtGuPg
         C6WGTadOS274B0S+4Q7ypNfMTqfYhRvmLFfCiFHQssl4Kf6E5zeNZZMIIo5Vx7Z/cJ09
         4kmS3wQVQFfCFsr5vRV2I9/MK8v00Th2fqrSCIy7wFzZ2AEI7487CJ+zjjqkmZbALoz1
         RPj2b770WBNVnClgVqoM3Z4RWYB0Mee1f31XTfEIjJyYN3OC6K2nwNS4iPjgWeDGMMAN
         KSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mU9mh8frCSvzZ2AQ8WhgOwwMg+9Km7u/NzzuYl4YD1I=;
        b=Xe05mGO/1c5ME0n0AWqkweciFiMwbY2deKTClBzrm+qEuZP/brQE5doCojWJ8PvaMW
         TFKBuLQAMmZT/FY9P/1Khq4zkuUtQNrkMGlAsj7EdpjgOx71l/SYLoks+wHDF3kdKJ+m
         qsQj9SX4HGlWlxxej6xcfp5+GiZyNLZFek/q6w5DJGAhCw6tpdfpM6//ifUhUM4xdZbl
         VSR+J/KPdKRsi3rEPutr1ZvPP8XPJXRTb3R0H7GsI9LVnyr0dK8g13yRQnDhma0HRkjd
         /ZsGM6ibKnoNv8BrbsFKOoNcGJ8bEYYABJQo8qIzXIN0nk6sL+HW1+kSnt8nGVmgDeBY
         x91A==
X-Gm-Message-State: AGi0PubxMGAur5HZUitKMlYQv8earTsOT1ypwP8iTnNqNow4xgy8YELU
        zjoIvuKuXUXH2+t9BdDskYR9AP0pEcQjqLnLtPCsPw==
X-Google-Smtp-Source: APiQypJHim+kVj/j2pLRzz3bLIrkC1LfqpqgRCUbCCsk1fOEYOYCG0w9XnW4TsZTsjBcaDxO5WOK8OXVKrsFW+MZ47k=
X-Received: by 2002:a67:8b46:: with SMTP id n67mr2806854vsd.35.1588251427814;
 Thu, 30 Apr 2020 05:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
 <CADBw62pmiguVmuq334eskLAZ5CkrjxohW_fXNjNev+O1U15=OQ@mail.gmail.com>
 <bd800f7b-05fd-b393-fba6-1965ba89e1b3@linaro.org> <CAGETcx9da-U+dXA6sreTKJQiS3brYh3Hfh_qVYt06=3UOSmT_g@mail.gmail.com>
 <429da47b-ad51-30eb-ff36-b05780c941ba@linaro.org> <CAGETcx9sc6oWSPK=aWJ+39i9eHAyg6iOf+Xf2oVECO+g1pFjtQ@mail.gmail.com>
 <573b7d9e-fb5d-5c81-a981-6d965db933f3@linaro.org> <20200427221752.GA166576@google.com>
 <7c508403-3b53-8285-5724-c2bca221b77a@linaro.org> <CAGETcx_peaPtmjF4s0iR6ObZ=f76EjaMOokyBYM3a7AX-8_ong@mail.gmail.com>
 <da25dc33-addb-298d-103a-fcf1cf0e6793@linaro.org>
In-Reply-To: <da25dc33-addb-298d-103a-fcf1cf0e6793@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Apr 2020 14:56:32 +0200
Message-ID: <CAPDyKFrDSqnkhCVweaA0D-d+KWN_8=OiXW74tDM1DhnCZAgPww@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers/clocksource/timer-of: Remove __init markings
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sandeep Patil <sspatil@android.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 at 20:55, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 28/04/2020 20:23, Saravana Kannan wrote:
> > On Tue, Apr 28, 2020 at 12:02 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >>
> >> Hi Saravana,
> >
> > You were replying to Sandeep :)
>
> Oh, right :)
>
> Sorry Sandeep. Thanks for taking the time to elaborate a clear statement
> of the GKI.
>
> [ ... ]
>
> >> That was my understanding of the GKI, thanks for confirming.
> >>
> >> Putting apart the non-technical aspect of these changes, the benefit I
> >> see is the memory usage optimization regarding the single kernel image.
> >>
> >> With the ARM64 defconfig, multiple platforms and their corresponding
> >> drivers are compiled-in. It results in a big kernel image which fails to
> >> load because of overlapping on DT load address (or something else). When
> >> that is detected, it is fine to adjust the load addresses, otherwise it
> >> is painful to narrow down the root cause.
> >>
> >> In order to prevent this, we have to customize the defconfig each
> >> version release.
> >
> > Sorry, I'm not sure I understand where you are going with this. Are
> > you agreeing to pick up this change?
>
> Right. I agree with the change but I would like to have Thomas opinion
> on this before picking the patch.
>
> Thomas ?

I am not Thomas :-) But just wanted to provide some feedback from my side.

In general we are careful when deciding to export symbols. And at
least, I think at least we should require one user of it before
allowing it to be exported (I assume that is what is happening in
patch2/2 - I couldn't find it)

Kind regards
Uffe
