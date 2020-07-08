Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5107C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 21:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F7D0206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 21:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RbdOVmNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgGHVTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHVTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 17:19:36 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCB3C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 14:19:36 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id u6so52933uau.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 14:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/y9ZwmNn+oHS/YG99lAA1vbL+yYfWBpKvPtygJNnx1Y=;
        b=RbdOVmNLjU1dmqCFDkewrU07toCP6wp5eolc5J+eZG1aV0cymd0po74ugeBqP50Ln5
         mAerEGGHvwIPfsv/GD4tVXPwsYeKgvvwwJdzSeEtH5wxNt2BIMmDwhaxXREjc6ohOSRe
         oPjk2ZFYEIOsgoY5s+WuADTF1hRrBpUNm5+WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/y9ZwmNn+oHS/YG99lAA1vbL+yYfWBpKvPtygJNnx1Y=;
        b=bhZiqOyuI2vG39yVnO4vDkaax3H7jEnUlQQrPYLwAKAznlT9XAqZv8XTzCXwJTr9/z
         a145NC0rH23eg2K6JfCEAXOHv6GI2PaazvCFnZpCZGZhZ/2vYTYO1fzqlyGGx4Tm1llL
         JzdNOEhidJcMqsTZ3Cf0fmkhnvtpW7wU92A8LYIwiRaCx+hls5jwkys8dzjbK4tAAYID
         KZTs2YoO9yjeR8SgyUO0fjj89Gw6edX/hT7GkGjlqvE4eIUiLzQnS7vuq7wW2BpB5AB/
         5xBvkkZfTr5+WBrH9rrUw7dybGF6lpDpiRpQIn5yTtWogCcPcaJdzsjEclegVIrBNWSD
         PmAw==
X-Gm-Message-State: AOAM530MEngIbYvEkWoF7rN5bFLCwNHw2j8w9N2Wri/x4D9khTmWo1y7
        pAZaJo8ABPXJPbPWHqB6EbWbDlf2dhM=
X-Google-Smtp-Source: ABdhPJyBg9imwdJ8E8o5r01U4KsN0z4AKV8X/xhaq19XUteA5dJA4vANcPe+mHhHUczB+bbS9d704Q==
X-Received: by 2002:ab0:6893:: with SMTP id t19mr44872211uar.61.1594243175114;
        Wed, 08 Jul 2020 14:19:35 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 185sm148450vkr.15.2020.07.08.14.19.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 14:19:33 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id e15so25302359vsc.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 14:19:32 -0700 (PDT)
X-Received: by 2002:a67:69c1:: with SMTP id e184mr13796424vsc.119.1594243172403;
 Wed, 08 Jul 2020 14:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <1593762506-32680-1-git-send-email-rnayak@codeaurora.org>
 <CAD=FV=WyhJ6g0DZS=ysT-AyXJoiRX=UFE9fXY2NEHfuUHYUXCQ@mail.gmail.com>
 <20200706203805.GS388985@builder.lan> <c747043d-c69e-4153-f2ca-16f1fc3063c2@codeaurora.org>
 <CAD=FV=Xs9Z37hv=CPgLEALoSoX=Uyir0s=ker=YKecA+Lhy1Qg@mail.gmail.com>
 <56fb02df-372d-935a-cc39-c13289d65c0d@codeaurora.org> <CAD=FV=VcBK02CS+ms0HtV0f_t7G7-0rzJ11xDKWdLanGVrx0QA@mail.gmail.com>
In-Reply-To: <CAD=FV=VcBK02CS+ms0HtV0f_t7G7-0rzJ11xDKWdLanGVrx0QA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Jul 2020 14:19:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WeXKAfWTK9q9u4m7=OU51rqQ975B+NBQDJT_sedPFOfQ@mail.gmail.com>
Message-ID: <CAD=FV=WeXKAfWTK9q9u4m7=OU51rqQ975B+NBQDJT_sedPFOfQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: qcom: sc7180: Make gpio28 non wakeup capable
 for google,lazor
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LinusW <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 8, 2020 at 6:42 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Was there something wrong with my proof of concept patch?  Unless I
> get swamped with other things, my plan was to try to make that more
> real and post it unless someone told me why it was wrong...

OK, I spent a bit of time poking at it and cleaning it.  I _think_
this is right now:

https://lore.kernel.org/r/20200708141610.1.Ie0d730120b232a86a4eac1e2909bcbec844d1766@changeid

Please test and/or review.

-Doug
