Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E964FC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA58B2064C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZmmZcLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAWP3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:29:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33771 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgAWP3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:29:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so3954330lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 07:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGe3quY2eM1LzswjO8uadoKz/qhRhLC7XH0fyTRmfIQ=;
        b=kZmmZcLnBB/6+OoVmRStZyaY1vZDgraq1Y4osCxfYnkug17wt3Z8H7PIJcN2GPBnAp
         O0y/+danf2adTO4N/3uPwFTKZzZ2XAMHrI/QYZ38X+z7i/93sU/f9DCLtKHS1qbH0ik/
         0xhEeXZuAqhiMcAQ4VVYtrCesIN7j+KIF/yvhL5M2iAbnatzBMsy7SG/ES0Je+8g8MSN
         2U4SMVkgzo63Ujfmq9u8ijkiLagrv3K5UcwkMELrv/DtlHlY7mzMuKxDd3CRu87y6Dcc
         txdy/ilpzlbJBlJ1LdvNMA+whtA/9m/033U+eBsfZMA3X/vbeOOq8PNOxNn+GOvzC0yj
         6d8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGe3quY2eM1LzswjO8uadoKz/qhRhLC7XH0fyTRmfIQ=;
        b=CdMEruS+2YpW9W0Ku3QZqom1idD+T90g1WlK0wLaC82iBjgA4AGFRylUEQzFMVtK4/
         7qiIvLuiPcsXZ5ES18C2KQEV0OhFhNXSVWnfiTHlO9bxxKhWSMUS5LL0mZYJU6vYoIIL
         oLq0jl7gXEEO9GvgiFKgiEH+BeAJm2dDRJgBGgR2Az/5xvqUl4fkyTnEr1Uk1+/XpeU/
         a/e5GJCCotFFA6fNY84Y1gvopvEQpxx3cAcil0NymJf72R8fi4R8YFahdk6ILtqQ/xcI
         5aKyvudDI6A3dhZCgUxCjTsM+R3KLpSxtVhvjGVmQizgmq9zOELjfN4P3uVwveYepF8u
         1v9g==
X-Gm-Message-State: APjAAAW/J54sEr9mJqsJQ7dLa6smlJxp9Ka6/lWv+iK6CrD9ZfrNclRj
        6OvY0zcL3g33HwqHTdfGGomHf5mPOzm5lztmr6qOxg==
X-Google-Smtp-Source: APXvYqyAo9QbCuj1ZRrdrCnwV0MRmiJ9cmkQGRldVrsy7R8hyn9coEr4fEciRA8CmIrO6Wc8kC6OmN+1PfuydxcHueI=
X-Received: by 2002:a05:651c:111c:: with SMTP id d28mr24180974ljo.32.1579793382400;
 Thu, 23 Jan 2020 07:29:42 -0800 (PST)
MIME-Version: 1.0
References: <20200121183748.68662-1-swboyd@chromium.org>
In-Reply-To: <20200121183748.68662-1-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jan 2020 16:29:31 +0100
Message-ID: <CACRpkdbgfNuJCgOWMBGwf1FoF+9cpQACnGH7Uon5Y6X+kN+x_w@mail.gmail.com>
Subject: Re: [PATCH] spmi: pmic-arb: Set lockdep class for hierarchical irq domains
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Masney <masneyb@onstation.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 7:37 PM Stephen Boyd <swboyd@chromium.org> wrote:

> I see the following lockdep splat in the qcom pinctrl driver when
> attempting to suspend the device.
>
>  WARNING: possible recursive locking detected
>  5.4.11 #3 Tainted: G        W
>  --------------------------------------------
>  cat/3074 is trying to acquire lock:
>  ffffff81f49804c0 (&irq_desc_lock_class){-.-.}, at: __irq_get_desc_lock+0x64/0x94
>
>  but task is already holding lock:
>  ffffff81f1cc10c0 (&irq_desc_lock_class){-.-.}, at: __irq_get_desc_lock+0x64/0x94
>
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(&irq_desc_lock_class);
>    lock(&irq_desc_lock_class);
>
>   *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
>  6 locks held by cat/3074:
>   #0: ffffff81f01d9420 (sb_writers#7){.+.+}, at: vfs_write+0xd0/0x1a4
>   #1: ffffff81bd7d2080 (&of->mutex){+.+.}, at: kernfs_fop_write+0x12c/0x1fc
>   #2: ffffff81f4c322f0 (kn->count#337){.+.+}, at: kernfs_fop_write+0x134/0x1fc
>   #3: ffffffe411a41d60 (system_transition_mutex){+.+.}, at: pm_suspend+0x108/0x348
>   #4: ffffff81f1c5e970 (&dev->mutex){....}, at: __device_suspend+0x168/0x41c
>   #5: ffffff81f1cc10c0 (&irq_desc_lock_class){-.-.}, at: __irq_get_desc_lock+0x64/0x94
>
>  stack backtrace:
>  CPU: 5 PID: 3074 Comm: cat Tainted: G        W         5.4.11 #3
>  Hardware name: Google Cheza (rev3+) (DT)
>  Call trace:
>   dump_backtrace+0x0/0x174
>   show_stack+0x20/0x2c
>   dump_stack+0xc8/0x124
>   __lock_acquire+0x460/0x2388
>   lock_acquire+0x1cc/0x210
>   _raw_spin_lock_irqsave+0x64/0x80
>   __irq_get_desc_lock+0x64/0x94
>   irq_set_irq_wake+0x40/0x144
>   qpnpint_irq_set_wake+0x28/0x34
>   set_irq_wake_real+0x40/0x5c
>   irq_set_irq_wake+0x70/0x144
>   pm8941_pwrkey_suspend+0x34/0x44
>   platform_pm_suspend+0x34/0x60
>   dpm_run_callback+0x64/0xcc
>   __device_suspend+0x310/0x41c
>   dpm_suspend+0xf8/0x298
>   dpm_suspend_start+0x84/0xb4
>   suspend_devices_and_enter+0xbc/0x620
>   pm_suspend+0x210/0x348
>   state_store+0xb0/0x108
>   kobj_attr_store+0x14/0x24
>   sysfs_kf_write+0x4c/0x64
>   kernfs_fop_write+0x15c/0x1fc
>   __vfs_write+0x54/0x18c
>   vfs_write+0xe4/0x1a4
>   ksys_write+0x7c/0xe4
>   __arm64_sys_write+0x20/0x2c
>   el0_svc_common+0xa8/0x160
>   el0_svc_handler+0x7c/0x98
>   el0_svc+0x8/0xc
>
> Set a lockdep class when we map the irq so that irq_set_wake() doesn't
> warn about a lockdep bug that doesn't exist.
>
> Fixes: 12a9eeaebba3 ("spmi: pmic-arb: convert to v2 irq interfaces to support hierarchical IRQ chips")
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

LGTM
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
