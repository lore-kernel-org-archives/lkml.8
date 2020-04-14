Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59282C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 301902076C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c6qp5YUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633291AbgDNUjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730053AbgDNUj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:39:29 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037B6C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:39:28 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id n128so351143vke.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxK3Sqhwvh9HQz8vI3EGqehbyyDGiizGlJruFTBZOiI=;
        b=c6qp5YUtAXQcWJjTWNsBFpOyyFWdmGQpkw4prkbONKTeTw/XOR/xcawcwrXd2fbgSU
         JOMhYTnvdPurqp721fz0QiydwLxg1DaBoGODQdVn4Zndww6QKB/wzjVlvaHdBD0bRZCX
         5UuKM+vtKTnZEJuss5/lGBpw/28PwI2XHAB3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxK3Sqhwvh9HQz8vI3EGqehbyyDGiizGlJruFTBZOiI=;
        b=o4yDW5Cd3yG+Ji97w1CA9X6Jm1j85O5W+e4h1R2fPWDhb2pS+xtsv5ZTwxLGt41Em+
         DWbdQfYYvtvp4k2q4rHqv5vo019ekfLjT/QRZr3SCugK73EsbEB94s+BUz/EwxwX7EjW
         u7BWYawyXW8YUiPswB5GokAryEqTXrtkseFTi/KVeIRvM8A8Nh8v0SC2cVclYrIDElnt
         6t3yGtaeVXn9Gi5ln7PXFvkr7YZkAG+urQzuOTPwLr+SIgCFRKHq/Hd34r3hZuZbbsPJ
         txTE7r/mo3CMystUMMzmyULuDt7ymlT9Die1V8fk1QOPQ4c/MDkryFes8/ri8Pw4WFKk
         4BBA==
X-Gm-Message-State: AGi0Pua7oxaZJxc32EE/WGlsyQL9Hw586p+7iD0xzAVN80W7Cz7LtHTv
        6Hi2HwYrg6T4gIMfOv87EBcNCvGGVpQ=
X-Google-Smtp-Source: APiQypJFBbCwIcB5dqlitII3g8/AjLwY0lmQSVZrforCemC80VDTluzApC9mDoA+RPk/SPAqQWTT7w==
X-Received: by 2002:ac5:c9aa:: with SMTP id f10mr11290711vkm.100.1586896767738;
        Tue, 14 Apr 2020 13:39:27 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id r205sm2398969vkr.11.2020.04.14.13.39.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 13:39:27 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id g24so862076vsp.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:39:27 -0700 (PDT)
X-Received: by 2002:a67:2b07:: with SMTP id r7mr1932123vsr.169.1586896766379;
 Tue, 14 Apr 2020 13:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200414131010.v2.1.Ic70288f256ff0be65cac6a600367212dfe39f6c9@changeid>
 <20200414131010.v2.2.I8550512081c89ec7a545018a7d2d9418a27c1a7a@changeid> <158689621032.105027.15399009553185990099@swboyd.mtv.corp.google.com>
In-Reply-To: <158689621032.105027.15399009553185990099@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Apr 2020 13:39:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W9swvzfCX5H=qhqdsnCAFTCWwzibcu72JJ9VKi9cR+1Q@mail.gmail.com>
Message-ID: <CAD=FV=W9swvzfCX5H=qhqdsnCAFTCWwzibcu72JJ9VKi9cR+1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] soc: qcom: rpmh-rsc: Timeout after 1 second in write_tcs_reg_sync()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 14, 2020 at 1:30 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2020-04-14 13:10:16)
> > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> > index f988e9cc2c30..02fc114ffb4f 100644
> > --- a/drivers/soc/qcom/rpmh-rsc.c
> > +++ b/drivers/soc/qcom/rpmh-rsc.c
> > @@ -174,12 +175,13 @@ static void write_tcs_reg(const struct rsc_drv *drv, int reg, int tcs_id,
> >  static void write_tcs_reg_sync(const struct rsc_drv *drv, int reg, int tcs_id,
> >                                u32 data)
> >  {
> > +       u32 new_data;
> > +
> >         writel(data, tcs_reg_addr(drv, reg, tcs_id));
> > -       for (;;) {
> > -               if (data == readl(tcs_reg_addr(drv, reg, tcs_id)))
> > -                       break;
> > -               udelay(1);
> > -       }
> > +       if (readl_poll_timeout_atomic(tcs_reg_addr(drv, reg, tcs_id), new_data,
> > +                                     new_data == data, 1, USEC_PER_SEC))
> > +               pr_err("%s: error writing %#x to %d:%d\n", drv->name,
>
> Shouldn't the register be hex? That seems to be how the registers are
> represented. But I guess tcs_id is decimal and can't be translated to be
> meaningful enough to indicate which TCS it is like the sleep or wake
> one.

Good point.  Should I quickly spin a v3 just so this is all ready to
go, or wait to see if there is any additional feedback?

-Doug
