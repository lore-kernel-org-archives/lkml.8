Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC67DC2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B026420774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AITiKiJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCZVox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:44:53 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:36983 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZVox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:44:53 -0400
Received: by mail-vk1-f193.google.com with SMTP id o124so2149909vkc.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ly3DexEg+nhnocqoA+VfvZ4RxhvbGJ/QEwcAEp/nd6s=;
        b=AITiKiJVhyAukyfkPH5ZHE8lTqi4itL+XpJ3XEX3e8XYsSsJyz+guiAWR+jemSfeeV
         xTekmYS2ECnZld3Pv6e1FG35/CgqJl1m/thoo25QBTuHNIJaowBPhQZYwdG4dGLqIi0p
         l9kErkRJCrVUFNh1JJAumbWL1xyyFy+sHAjig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ly3DexEg+nhnocqoA+VfvZ4RxhvbGJ/QEwcAEp/nd6s=;
        b=RBlj0YoXe6ivl9iQGF8wtfjrcGV4Ec6euuIme46gsY4QQmNuq7pQ2e3q0C1Z8cbyCw
         D3AY3CExm4xNFqDKl+SAQGYIB7SKVyUqlwTWcQD/Phq63oa3v5yWbWIspy6LNt27sq2d
         uK5Vv+HRXwxWrO0rHmZoRJ8XtIarzdxklp8iG5e69xsrliLD2rFc1GJhkYHJP5ofEhLs
         Ud3iyMa895CRhkHpACTsy3YHK+otBeMvP/oYGXLTTHBjP4cdJxfqOEcTDGjnDj8Ftfhv
         T1s0EAbAlSPobj65v9D05FclAQhitvJ/9AJz+yp8TbORDN8r5u+VXh6CaakQyqUm56ZH
         vSXQ==
X-Gm-Message-State: ANhLgQ2aGpXb4gaIhzIxs/N587xaczTsnMumPhkOEtmkLQASpQeXLulN
        mTDkgxmYyTtBxTWcYuqMnF1cU20z+fo=
X-Google-Smtp-Source: ADFU+vulVgdfGYiJxZ89tpxY92QNzzz1zFMs/2qQzHaWSAwrULBUSDpZw82sJv7qotHIxoJg3D0QHQ==
X-Received: by 2002:a1f:6e44:: with SMTP id j65mr9345468vkc.60.1585259091610;
        Thu, 26 Mar 2020 14:44:51 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id x4sm1715777vsh.18.2020.03.26.14.44.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 14:44:50 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id a63so4922415vsa.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:44:50 -0700 (PDT)
X-Received: by 2002:a67:2b07:: with SMTP id r7mr9673008vsr.169.1585259089569;
 Thu, 26 Mar 2020 14:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200311231348.129254-1-dianders@chromium.org> <20200311161104.RFT.v2.8.I07c1f70e0e8f2dc0004bd38970b4e258acdc773e@changeid>
In-Reply-To: <20200311161104.RFT.v2.8.I07c1f70e0e8f2dc0004bd38970b4e258acdc773e@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 26 Mar 2020 14:44:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xp1o68HnC2-hMnffDDsi+jjgc9pNrdNuypjQZbS5K4nQ@mail.gmail.com>
Message-ID: <CAD=FV=Xp1o68HnC2-hMnffDDsi+jjgc9pNrdNuypjQZbS5K4nQ@mail.gmail.com>
Subject: Re: [RFT PATCH v2 08/10] drivers: qcom: rpmh-rsc: spin_lock_irqsave()
 for tcs_invalidate()
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 11, 2020 at 4:14 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Auditing tcs_invalidate() made me worried.  Specifically I saw that it
> used spin_lock(), not spin_lock_irqsave().  That always worries me.
>
> As I understand it, using spin_lock() is only valid in these
> situations:
>
> a) You know you are running in the interrupt handler (and all other
>    users of the lock use the "irqsave" variant).
> b) You know that nobody using the lock is ever running in the
>    interrupt handler.
> c) You know that someone else has always disabled interrupts before
>    your code runs and thus the "irqsave" variant is pointless.
>
> From auditing the driver we look OK.  ...except that there is one
> further corner case.  If sometimes your code is called with IRQs
> disabled and sometimes it's not you will get in trouble if someone
> ever boots your board with "nosmp" (AKA in uniprocessor mode).  In
> such a case if someone else has the lock (without disabling
> interrupts) and they get swapped out then your code (with interrupts
> disabled) might loop forever waiting for the spinlock.
>
> It's just safer to use the irqsave version, so let's do that.  In
> future patches I believe tcs_invalidate() will always be called with
> interrupts off anyway.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2: None
>
>  drivers/soc/qcom/rpmh-rsc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index ba489d18c20e..c82c734788b1 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -218,9 +218,10 @@ static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
>  static int tcs_invalidate(struct rsc_drv *drv, int type)
>  {
>         int m;
> +       unsigned long flags;
>         struct tcs_group *tcs = &drv->tcs[type];
>
> -       spin_lock(&tcs->lock);
> +       spin_lock_irqsave(&tcs->lock, flags);
>         if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
>                 spin_unlock(&tcs->lock);

Noticed a bug while doing a code review of:

https://lkml.kernel.org/r/1585244270-637-7-git-send-email-mkshah@codeaurora.org

...specifically my patch forgets to change the error case to
spin_unlock_irqrestore().  ...but perhaps if that other patch lands
when we can just remove the spinlocks from this function...  I'll post
more in my reply to that other patch.


-Doug
