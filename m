Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069A8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D937B206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UJR6Qi/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGXULd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGXULc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:11:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A98C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:11:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 72so5159862ple.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=bs1aX7lFDIpMImaAa30odJrsbjxTgzOIzVfQ0iVdnGU=;
        b=UJR6Qi/G0RCAPylYoDDP6ro7bWAdTsABFrM3DQu2TYtYADCQM3+wMQOYOur6BiKfxI
         bz8Cm2Gl6vTqsY20UHa0PjMh41cQMPEmqpLhfM5zKlFQT2AeYPzNW8zw8B50s1vQKxEZ
         SQLAwaNPwcAMq0O25XJs8rNeS7i2mSR99Zszs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=bs1aX7lFDIpMImaAa30odJrsbjxTgzOIzVfQ0iVdnGU=;
        b=Vg0dIetfjbGUm+2PpoCNZCvIjHqfe+8+bOomM4fZHb2dDLKJqAU3SkttORq8Wd+foU
         4FCD+u++nxzRceTT1ZHU63l2lquncEPOx4knVtW0vIgmWQxGikFY1USxRGMHLPmVDMTn
         FN7Op4wADw1JATpXR2BWNNcgrfusLEH1o3X66khkQNgNDyXxNXtPRvR1YZL9ccxV24tb
         97DWJ7BouB4A7iYyvdKOvytK9GeevOEyyzz8GTmIIAcRWsC55VonuGCzQFgp2O0/yqqS
         y3oZR1j/hKyOyldryktR2cqw0UThNauLJYMh/SBFYPpS2xBZXmU+SgRNFRWjsB5tQYQD
         e4uQ==
X-Gm-Message-State: AOAM531uerujZ880cCv//seGwAPywT9cVWxMZ20TA0AhK620SBvz7Arv
        BZqA7bGDo/cG5llffQRx4AwCxg==
X-Google-Smtp-Source: ABdhPJz25ykO0sRmUj0w0Jh4M7RsJU6ajIMRWPsG0iakfnZwP1VeDqzM8GLYna05GDUUGctTSuzWnw==
X-Received: by 2002:a17:902:7605:: with SMTP id k5mr3645859pll.331.1595621492121;
        Fri, 24 Jul 2020 13:11:32 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id a17sm7038876pgw.60.2020.07.24.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 13:11:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200724200841.GJ9185@codeaurora.org>
References: <20200723010137.3127584-1-swboyd@chromium.org> <CAD=FV=WtjyYY+bmocc17S9NbRs6inkAWjj7=c9qBsVf3LtG99Q@mail.gmail.com> <159561988523.3847286.14763422711224252201@swboyd.mtv.corp.google.com> <CAD=FV=WH1vKKe=MPVdtBJZWnSzxNLO0uyM02GFG6oCJfSEwehQ@mail.gmail.com> <159562087212.3847286.9484527206999948907@swboyd.mtv.corp.google.com> <20200724200841.GJ9185@codeaurora.org>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Sleep waiting for tcs slots to be free
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>
Date:   Fri, 24 Jul 2020 13:11:30 -0700
Message-ID: <159562149056.3847286.11191144133990578500@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2020-07-24 13:08:41)
> On Fri, Jul 24 2020 at 14:01 -0600, Stephen Boyd wrote:
> >Quoting Doug Anderson (2020-07-24 12:49:56)
> >> Hi,
> >>
> >> On Fri, Jul 24, 2020 at 12:44 PM Stephen Boyd <swboyd@chromium.org> wr=
ote:
> >I think Lina was alluding to this earlier in this
> >thread.
> I was thinking more of threaded irq handler than a kthread to post the
> requests. We went away from post-thread approach a few years ago.
>=20

Ok, got it. Why was the kthread approach abandoned?
