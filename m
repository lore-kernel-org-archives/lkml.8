Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871F3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621D92085B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlfyTdXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgFPUwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgFPUwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:52:46 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692AC06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:52:45 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n5so6441716otj.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mDaBoAYNlImmGKdCyzs30Ab2CK6GaNdKX0Jt8lvk4Q=;
        b=NlfyTdXcuRk+bHqUw+iSQlY+Yp1tZiUjSeOcpP040ruHIUtzEyafQn2O0GlSn7gYeL
         7zHVQjG9C9jWGTbTF3esb4X57Pwk4YUnUyCBcQkM53dx293ZwGNIXK+ItM/IYIuYFfwi
         Tgh+QD873HT3EHOdSG6ryAhurDSG7jATKMwanI5nOGb4ckZpJDg+8gUZ5AtbgIsACytK
         za71wGu8CC+u6oCoxiGLOUpgt5E91RAOhdv90F6y9lE1VYMGnZ34mU6D9A5ODCBpMhl/
         +wSeCnpZeuB4NhP2YYyHpXgVNoZi6FdoAdKqdqF8ZOxCxXiNu5ob8xDBytu9hCeMnQ9o
         qU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mDaBoAYNlImmGKdCyzs30Ab2CK6GaNdKX0Jt8lvk4Q=;
        b=EyDVZ5hUY6XNVQAJsrqc6mtvk8nFLUQKk9lCiABFQ//Pb+Vl3TdaiHeiWptO77SXsH
         FPwTaMDZCly+AMJGJNABd+CgzfKd0knYTMLJpVs8OUYVcZk6wO4+XFeN7mzc/Oy00KI5
         iIvVDt3gV4g4Tw0n8eOft1UDcjBFDpLn4R66cS0wmTD5WTiCsujHlC7BHGmOYXtPyPDA
         MOruPu+ulnQiuNRWWtVSRf7ufaJ9s1y4CMj599ihosh6Ci42+SDqrrBRMsqmMJRoIuw0
         nCCtFJZ5yXrbGN2XK3UmxeZV2U3oMEGgmjxLk/AQnXmNaps1KCkp3b6sRZiQZaYIsrnT
         Hzrg==
X-Gm-Message-State: AOAM532dB6Aw7OKpWUzPwM/E8nQ1f9jX2XjFypML+iBzlhUNMOu7eDwk
        eo1O2LCl0IgGMjl/ezH1h/gYdC5J+C1UOEeV/ppVgWfKjJo=
X-Google-Smtp-Source: ABdhPJwZnDuYF1+ScqyNsWThdN1UjAZVIPE//LsOe27AsBQ3nI7GPtgCaXGfrrPsASezMO6Zgd4KdSIOrpniIxtDmiQ=
X-Received: by 2002:a9d:1296:: with SMTP id g22mr4304025otg.102.1592340765193;
 Tue, 16 Jun 2020 13:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200616061338.109499-1-john.stultz@linaro.org>
 <20200616061338.109499-6-john.stultz@linaro.org> <0be86735238a0f8b0c25934e2ed39eee@kernel.org>
In-Reply-To: <0be86735238a0f8b0c25934e2ed39eee@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 16 Jun 2020 13:52:32 -0700
Message-ID: <CALAqxLUZBdiLBRcp1GW9rGxt1KhgNVQ86MuPXZcXdx2wFLZk6w@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/5] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
To:     Marc Zyngier <maz@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        iommu@lists.linux-foundation.org, linux-gpio@vger.kernel.org,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 12:55 AM Marc Zyngier <maz@kernel.org> wrote:
> On 2020-06-16 07:13, John Stultz wrote:
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index b510f67dfa49..714893535dd2 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -381,6 +381,7 @@ config SPAPR_TCE_IOMMU
> >  config ARM_SMMU
> >       tristate "ARM Ltd. System MMU (SMMU) Support"
> >       depends on (ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)) &&
> > MMU
> > +     depends on QCOM_SCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y
>
> This looks a bit ugly. Could you explain why we need this at the SMMU
> level? I'd have expected the dependency to flow the other way around...

Yea, so the arm-smmu-qcom.c file calls directly into the qcom-scm code
via qcom_scm_qsmmu500_wait_safe_toggle()
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm-smmu-qcom.c?h=v5.8-rc1#n44

So if ARM_SMMU=y and QCOM_SCM=m we get:
drivers/iommu/arm-smmu-qcom.o: In function `qcom_smmu500_reset':
arm-smmu-qcom.c:(.text+0xb4): undefined reference to
`qcom_scm_qsmmu500_wait_safe_toggle'

Do you have a suggestion for an alternative approach?

thanks
-john
