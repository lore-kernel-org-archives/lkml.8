Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C33C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93CE246B5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WTZJMvhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgB1XpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:45:19 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38891 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgB1XpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:45:19 -0500
Received: by mail-ua1-f66.google.com with SMTP id c7so1626617uaf.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlTe9fbt3lgKg4ZZXZ3aj/L3D+FZdZW5C7wJYepFMxY=;
        b=WTZJMvhUqmYNsakc7uGisGYk3flMpS+xsWVdNE2YyEGXlIiQ896Gdt2skNcREMbG2y
         bqPcugSLtUKFNgF3FXoa6SqQwTGD7SS51ocKMS8GVNF2tpEQiIJDl2I0dcq/wMdpGmDI
         u18Q08SvTdEEKuekTbUWGkMr9Q2b0JEbBJNhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlTe9fbt3lgKg4ZZXZ3aj/L3D+FZdZW5C7wJYepFMxY=;
        b=jd8mctAro+P/RzuPSWzeSNbo5ei90l6BPjoKbliA+GNabqysyhp2BnSYORWDrIlQek
         v/H0ph3BsJw9ZO7ZUVgP4q6DJC7UZG4ygpnMWmzgXG6NRnWDr9wfPsIxZCJ1GCxN5qk7
         72pA65VYKJPpMpGCTGWT034pZOAcPIX/FM5dWb7ZyflvridNwXqAvjOqLxGhtzV4ietf
         lPXdOP1c9k7hxwUy3jSR7kGhmD5RZ3ooajWp5B+5Zo2H8iSu10rhddWPLFccp3mPeRbr
         RmkIglCkguBcdFoqjATJrBDU934Gu9WwBNzwG2fh1Rm1/q4k7LG+tohiSND9kHVhnGD2
         nASw==
X-Gm-Message-State: ANhLgQ2mrfTY3GhLU6z3Jbd1f9EA2c99tkSj+IkugqVAeGi4IlapNArH
        1LiCw004c2kz+HFnUL8XVeIx2Faxru4=
X-Google-Smtp-Source: ADFU+vu0untlGddY+Hg0jzAmQ3bFFqBzYbnn7x2iMg7311Bm7ExwT2NAuDCyRK0A3RK02Iwu6FBUEQ==
X-Received: by 2002:a9f:300a:: with SMTP id h10mr3320194uab.91.1582933515729;
        Fri, 28 Feb 2020 15:45:15 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id d8sm3047309uan.13.2020.02.28.15.45.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 15:45:15 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id c18so3073269vsq.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:45:14 -0800 (PST)
X-Received: by 2002:a67:e342:: with SMTP id s2mr4092211vsm.198.1582933514402;
 Fri, 28 Feb 2020 15:45:14 -0800 (PST)
MIME-Version: 1.0
References: <1582889903-12890-1-git-send-email-mkshah@codeaurora.org> <1582889903-12890-4-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1582889903-12890-4-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 28 Feb 2020 15:45:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V92fFH8q+yvMk2sWdgi_xjFyvt3rMu14O+sO5zLp2kGg@mail.gmail.com>
Message-ID: <CAD=FV=V92fFH8q+yvMk2sWdgi_xjFyvt3rMu14O+sO5zLp2kGg@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 28, 2020 at 3:38 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Add changes to invoke rpmh flush() from within cache_lock when the data
> in cache is dirty.
>
> This is done only if OSI is not supported in PSCI. If OSI is supported
> rpmh_flush can get invoked when the last cpu going to power collapse
> deepest low power mode.
>
> Also remove "depends on COMPILE_TEST" for Kconfig option QCOM_RPMH so the
> driver is only compiled for arm64 which supports psci_has_osi_support()
> API.
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Srinivas Rao L <lsrao@codeaurora.org>
> ---
>  drivers/soc/qcom/Kconfig |  2 +-
>  drivers/soc/qcom/rpmh.c  | 33 ++++++++++++++++++++++-----------
>  2 files changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index d0a73e7..2e581bc 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -105,7 +105,7 @@ config QCOM_RMTFS_MEM
>
>  config QCOM_RPMH
>         bool "Qualcomm RPM-Hardened (RPMH) Communication"
> -       depends on ARCH_QCOM && ARM64 || COMPILE_TEST
> +       depends on ARCH_QCOM && ARM64
>         help
>           Support for communication with the hardened-RPM blocks in
>           Qualcomm Technologies Inc (QTI) SoCs. RPMH communication uses an
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index f28afe4..6a5a60c 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/psci.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> @@ -158,6 +159,13 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
>         }
>
>  unlock:
> +       if (ctrlr->dirty && !psci_has_osi_support()) {
> +               if (rpmh_flush(ctrlr)) {
> +                       spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
> +                       return ERR_PTR(-EINVAL);
> +               }
> +       }

It's been a long time since I looked in depth at RPMH, but upon a
first glance this seems like it's gonna be terrible for performance.
You're going to send every entry again and again, aren't you?  In
other words in pseudo-code:

1. rpmh_write(addr=0x10, data=0x99);
==> writes on the bus (0x10, 0x99)

2. rpmh_write(addr=0x11, data=0xaa);
==> writes on the bus (0x10, 0x99)
==> writes on the bus (0x11, 0xaa)

3. rpmh_write(addr=0x10, data=0xbb);
==> writes on the bus (0x10, 0xbb)
==> writes on the bus (0x11, 0xaa)

4. rpmh_write(addr=0x12, data=0xcc);
==> writes on the bus (0x10, 0xbb)
==> writes on the bus (0x11, 0xaa)
==> writes on the bus (0x12, 0xcc)

That seems bad.  Why can't you just send the new request itself and
forget adding it to the cache?  In other words don't even call
cache_rpm_request() in the non-OSI case and then in __rpmh_write()
just send right away...

I tried to test this and my printouts didn't show anything actually
happening in rpmh_flush().  Maybe I just don't have the write patches
to exercise this properly...


> +
>         spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>
>         return req;
> @@ -285,26 +293,35 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
>  }
>  EXPORT_SYMBOL(rpmh_write);
>
> -static void cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
> +static int cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
>  {
>         unsigned long flags;
>
>         spin_lock_irqsave(&ctrlr->cache_lock, flags);
> +
>         list_add_tail(&req->list, &ctrlr->batch_cache);
>         ctrlr->dirty = true;
> +
> +       if (!psci_has_osi_support()) {
> +               if (rpmh_flush(ctrlr)) {
> +                       spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
> +                       return -EINVAL;
> +               }
> +       }
> +
>         spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
> +
> +       return 0;
>  }
>
>  static int flush_batch(struct rpmh_ctrlr *ctrlr)
>  {
>         struct batch_cache_req *req;
>         const struct rpmh_request *rpm_msg;
> -       unsigned long flags;
>         int ret = 0;
>         int i;
>
>         /* Send Sleep/Wake requests to the controller, expect no response */
> -       spin_lock_irqsave(&ctrlr->cache_lock, flags);
>         list_for_each_entry(req, &ctrlr->batch_cache, list) {
>                 for (i = 0; i < req->count; i++) {
>                         rpm_msg = req->rpm_msgs + i;
> @@ -314,7 +331,6 @@ static int flush_batch(struct rpmh_ctrlr *ctrlr)
>                                 break;
>                 }
>         }
> -       spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>
>         return ret;
>  }
> @@ -386,10 +402,8 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>                 cmd += n[i];
>         }
>
> -       if (state != RPMH_ACTIVE_ONLY_STATE) {
> -               cache_batch(ctrlr, req);
> -               return 0;
> -       }
> +       if (state != RPMH_ACTIVE_ONLY_STATE)
> +               return cache_batch(ctrlr, req);

I'm curious: why not just do:

if (state != RPMH_ACTIVE_ONLY_STATE && psci_has_osi_support()) {
  cache_batch(ctrlr, req);
  return 0;
}

...AKA don't even cache it up if we're not in OSI mode.  IIUC this
would be a huge deal because with your code you're doing the whole
RPMH transfer under "spin_lock_irqsave", right?  And presumably RPMH
transfers are somewhat slow, otherwise why did anyone come up with
this whole caching / last-man-down scheme to start with?

OK, it turned out to be at least slightly more complex because it
appears that we're supposed to use rpmh_rsc_write_ctrl_data() for
sleep/wake stuff and that they never do completions, but it really
wasn't too hard.  I prototyped it at <http://crrev.com/c/2080916>.
Feel free to hijack that change if it looks like a starting point and
if it looks like I'm not too confused.


>         for (i = 0; i < count; i++) {
>                 struct completion *compl = &compls[i];
> @@ -455,9 +469,6 @@ static int send_single(struct rpmh_ctrlr *ctrlr, enum rpmh_state state,
>   * Return: -EBUSY if the controller is busy, probably waiting on a response
>   * to a RPMH request sent earlier.
>   *
> - * This function is always called from the sleep code from the last CPU
> - * that is powering down the entire system. Since no other RPMH API would be
> - * executing at this time, it is safe to run lockless.

Interesting that you removed this comment but not the copy of the
comment inside this function.  Was that on purpose?
