Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF87C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BAE20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HMIxrbK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgCZSVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:21:02 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44089 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgCZSVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:21:02 -0400
Received: by mail-vs1-f65.google.com with SMTP id e138so4492228vsc.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ohjyYv73OFKplmBSM5tbGvwFGemqZp6n5SDqqDBghU=;
        b=HMIxrbK1VCB2JxiQem4/MeacZoLlMIbT6Oaise1EYREq3Npjbn+u7cn+w3g/xFl3K/
         3eeKrOIKuUnSMHwY6GxEXl1EPlDU6KUdFBMueFiFO2KlaCccAiLgmOa2cFUWt6fYhoa7
         oEDNm5IU3L+Q3TA9eizBtP3dpLIi8HZV3yn1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ohjyYv73OFKplmBSM5tbGvwFGemqZp6n5SDqqDBghU=;
        b=CQHdBWLlxEsyKCFJIAqYnk3/JtSIy/2u/S7Kp1G/V11nWK762sr/OEjF4VpTVSq2DL
         IvzNR7gjuiIRpEFKHcrn6hQSNBYhGFH9ezH60wWTfXAyA73dgZ9ZE82DS/TOVIkVJWQV
         +fPdULdAt1uceyWXmWk8C+Az5MIOb7OFUA+b1N21fh8mK7mbBrAwXUlWcuhWIGOndlmZ
         tmOFKG5Y6rH1Cg3lt92VtX/9V4YbCrtxsCz7HSBAbSmJsDuqlsY618NmKAM5RXPnyH0/
         /+lG7wiQYNP+x1guOBUZH6GYqkv8889AwBfRW0dj069HgeMnz4g8sfFrNhyVn7ou8XTn
         bKFw==
X-Gm-Message-State: ANhLgQ0AWu81aQ/Hzz/2M6mileJ5/OhMZRI3P3zy30ilnOjpirC0Gl3H
        UHBavnD/FggTsMSEuSBndCV7TcYEtY8=
X-Google-Smtp-Source: ADFU+vu5jZuIXq6fyd+fpGSKCnHhaoityiSpsP6NKmAy2fQyIvdIeIiH9sr1BML2VRLpkQFoZIVb6g==
X-Received: by 2002:a67:c189:: with SMTP id h9mr8089221vsj.91.1585246859642;
        Thu, 26 Mar 2020 11:20:59 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id g1sm1484972uak.5.2020.03.26.11.20.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 11:20:58 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id e138so4492121vsc.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:20:57 -0700 (PDT)
X-Received: by 2002:a67:2c81:: with SMTP id s123mr7183988vss.198.1585246857424;
 Thu, 26 Mar 2020 11:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <1585244270-637-1-git-send-email-mkshah@codeaurora.org> <1585244270-637-6-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1585244270-637-6-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 26 Mar 2020 11:20:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WvMe4xqGTH=pU8TL1FWN9BBkp0EOkxasdBsC51299fJA@mail.gmail.com>
Message-ID: <CAD=FV=WvMe4xqGTH=pU8TL1FWN9BBkp0EOkxasdBsC51299fJA@mail.gmail.com>
Subject: Re: [PATCH v14 5/6] soc: qcom: rpmh-rsc: Clear active mode
 configuration for wake TCS
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 26, 2020 at 10:38 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
>
> For RSCs that have sleep & wake TCS but no dedicated active TCS, wake
> TCS can be re-purposed to send active requests. Once the active requests
> are sent and response is received, the active mode configuration needs
> to be cleared so that controller can use wake TCS for sending wake
> requests.
>
> Introduce enable_tcs_irq() to enable completion IRQ for repurposed TCSes.
>
> Fixes: 2de4b8d33eab (drivers: qcom: rpmh-rsc: allow active requests from wake TCS)
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> [mkshah: call enable_tcs_irq() within drv->lock, update commit message]
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 77 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 54 insertions(+), 23 deletions(-)

I was writing my review of v1 at the same time you sent this.  Looks
like your patch does address the most important piece of feedback I
had (adjusting the interrupt enable under spinlock), but some of the
other feedback might be nice to incorporate:

https://lore.kernel.org/r/CAD=FV=XmBQb8yfx14T-tMQ68F-h=3UHog744b3X3JZViu15+4g@mail.gmail.com

-Doug
