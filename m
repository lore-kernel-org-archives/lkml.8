Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECDEC04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5569214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j75d0oaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgBGPxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:53:31 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38556 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgBGPxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:53:31 -0500
Received: by mail-vk1-f194.google.com with SMTP id w4so721040vkd.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 07:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95ygi45qtZTOWH+UKxvi28hwPyGfXfy4ZjYmQW0i/SI=;
        b=j75d0oaRHNtEC+MzXfW9/nEOcgNA3FX81yhp5QL/gzqPhUE9bPTWd7pIxDD2tJdnoD
         lFmTVekPy83AuHK4oQrEsq7ftUURUTxJ9cHEJpWShoUGKC0ikjyESDkEfo8X9qs8uQ0m
         1osZusZiWV377s0jr3USuUDihezOV+4A9lYiyNvEx56g8jrfZqDXuQScNUWvqEMIT7fG
         AWvRwjQUiCGGUaGqNp3SB61dlAhcik3Tclg3r5SvBOBcgCOvcp5gOxIg56wQNV83RPMG
         Jpw/4RXYPSqBvoXTgAIiHft1h8B9m9pNJxvFxh4+uP1R3i6r3x+T6WF6k6axZtfvLetf
         apYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95ygi45qtZTOWH+UKxvi28hwPyGfXfy4ZjYmQW0i/SI=;
        b=B2QvHNRsFWSz7n3Vt6vkVjAYN8dXVxIcxnN2M+plgFuqZu/yEPumAfFO5UtkMSDejN
         q7Lw1//lGwgNd1sVz/yD6vknhR6fTyBqcw19oxyZdCKZqYBoVLbPfnldU6XaOfX6gDHN
         7lul5TLMFHSFKOyyEl3UYwitOmwQUBVEmTD0tJPTulct75Z74XnCWMABPk+N6vIbH+ZA
         tvi8J8UNfWDAgVoGCnNt1V7R1KZdigS4TsBW0S3wPDxnkKqEbxiwVPQNLk4D1oGFNiR+
         2rK3pWfB1aRFN7tpoHNXIN1lrJGz7bkxyeUw7Y+esXuJjWtlKtIu1Q/L0xRsGJ/jpYmf
         oD4A==
X-Gm-Message-State: APjAAAUc6aEVhqcRQE5aoHdAo5jXwp9n9hdzMnjbhfC8UKZzN7iYuwiH
        42Q+UzCcygE4IJ9mYymw4m2DSNzt1o178WGc+I3v6Q==
X-Google-Smtp-Source: APXvYqwFFtbUIctx3YdFoC4QriFsEms4xU7w6LquZ748k027glxZE0QklHy04PJmF/kHORQ6R34TsyT2ppLdjjIsU0w=
X-Received: by 2002:a1f:434b:: with SMTP id q72mr5084872vka.53.1581090808740;
 Fri, 07 Feb 2020 07:53:28 -0800 (PST)
MIME-Version: 1.0
References: <0d7f7ade-3a1e-5428-d851-f1a886f58712@codeaurora.org>
 <20200204152132.GA44858@bogus> <6ff7c82d-4204-a339-4070-0154ab4515f1@codeaurora.org>
 <20200205140603.GB38466@bogus> <CAPDyKFoyepN2VX4COMomp1e9dXPozzrgCdcy0paee2jp8Wm3YA@mail.gmail.com>
 <20200205161816.GD38466@bogus> <CAPDyKFqaA7oN2+oLS=Puw+jQXke_ErGQAWYuTuU-6PS7mo5YbQ@mail.gmail.com>
 <20200206204514.GB8107@codeaurora.org> <20200207111955.GA40103@bogus>
 <CAPDyKFp-zvD1iFcpRaTFiuazxYmLEx0Czf3=TZJxjSCDmmPsvA@mail.gmail.com> <20200207144850.GA18655@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200207144850.GA18655@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Feb 2020 16:52:52 +0100
Message-ID: <CAPDyKFoZ+QQFdG3yQ5wGpg2Z5c9WksUhresGz02o3HVrGt1UhQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] drivers: firmware: psci: Add hierarchical domain
 idle states converter
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, lsrao@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2020 at 15:48, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Feb 07, 2020 at 01:32:28PM +0100, Ulf Hansson wrote:
> > [...]
> >
> > > > I understand the arguments for using PC vs OSI and agree with it. But
> > > > what in PSCI is against Linux knowing when the last core is powering
> > > > down when the PSCI is configured to do only Platform Cordinated.
> > >
> > > Nothing :D. But knowing the evolution and reasons for adding OSI in the
> > > PSCI specification and having argued about benefits of OSI over PC for
> > > years and finally when we have it in mainline, this argument of using
> > > PC for exact reasons why OSI evolved is something I can't understand
> > > and I am confused.
> > >
> > > > There should not be any objection to drivers knowing when all the cores
> > > > are powered down, be it reference counting CPU PM notifications or using
> > > > a cleaner approach like this where GendPD framwork does everything
> > > > cleanly and gives a nice callback. ARM architecture allows for different
> > > > aspects of CPU access be handled at different levels. I see this as an
> > > > extension of that approach.
> > > >
> > >
> > > One thing that was repeatedly pointed out during OSI patch review was no
> > > extra overhead for PC mode where firmware can make decisions. So, just
> > > use OSI now and let us be done with this discussion of OSI vs PC. If PC
> > > is what you think you need for future, we can revert all OSI changes and
> > > start discussing again :-)
> >
> > Just to make it clear, I fully agree with you in regards to overhead
> > for PC-mode. This is especially critical for ARM SoCs with lots of
> > cores, I assume.
> >
> > However, the overhead you refer to, is *only* going to be present in
> > case when the DTS has the hierarchical CPU topology description with
> > "power-domains". Because, that is *optional* to use, I am expecting
> > only those SoC/platforms that needs to manage last-man activities to
> > use this layout, the others will remain unaffected.
>
> In PC mode not only there is no need but it is wrong to manage
> any last-man activity in the kernel. I wonder why we are still
> talking about this to be honest.

I guess the discussion is here because there is a use case to consider now.

For sure, we agree on what is the best solution. But this is rather
about what can we do to improve the current situation, if we should do
anything.

>
> Code to handle PSCI platform coordinated mode has been/is in
> the kernel today and that's all is needed according to the PSCI
> specifications.

PSCI specifies CPU power management, not SoC power management. If
these things were completely decoupled, I would agree with you, but
that's not the case. Maybe SCMI, etc, helps with this in future.

Anyway, my fear is that not many ARM vendors implements OSI support,
but still they have "last-man-activities" to deal with. This is not
only QCOM.

I guess an option would be to add OSI support to the public ARM
Trusted Firmware, then we could more easily point to that - rather
than trying to mitigate the problem on the kernel side.

Kind regards
Uffe
