Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5E6C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B12246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C22hZa3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgB1Vt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:49:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38420 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB1Vt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 16:49:28 -0500
Received: by mail-lf1-f68.google.com with SMTP id w22so2178380lfk.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 13:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OWRcLlaA6/EqTP6Xmqhmkn6LDkI+Uf7SWw6gemPWjgk=;
        b=C22hZa3v1UrMeBELHr6Mnoehrvcy7NRg1yltGMcP5BYW7wOr1VXiTtWgRRzvIy4tQw
         yrR6XREKofL4j3BG1SyRu4gl/BWgInQbVm5FTC7ok6GwJ4IPN45Fek6mRJdAPdQxqCRW
         /JF/uUfcJvGU0URkwoAiGwfznyOOYRyZGdgWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OWRcLlaA6/EqTP6Xmqhmkn6LDkI+Uf7SWw6gemPWjgk=;
        b=Q4siC7yDhKkGHvl3DhbkPvrfnrpI1X5nr+PWQTFSJcEnifp994Ga6oEitT7tuWDmlN
         0QqhEPUw3csCxXB45DUxZydxJjlG4Bfd0lc0mAHzpwPQzb6Hqwgrl0GYfdjNz1RTXT+y
         hCOe8qbrYMd+YNq5CGWijG9F9dRA1KFkiAiCtVsZP1BiR4r4LSKK66vHl/lcDH3NRM1Y
         VyaoL/Zb5TcoryXJ2dqk0EV0z2S+sZeO2Qg1KuwLDgr0u1Go1CrpHyKtoZJkBMxNDS5J
         9cNAkGs3xztLlHykKgotgQGGu7naSFFB1ac13J5IwlkThDr6h5mrg7+htfRMwumAxjZm
         IzWQ==
X-Gm-Message-State: ANhLgQ2DcOriX8WD7zMoC5Z3QFvOJUu/EmHjSqstyArVkGiWL0R/q/Rh
        noZwh/uS3WuGGRfIJ4u2cjMDzAGs7ao=
X-Google-Smtp-Source: ADFU+vvSrgZ6J+Dh3S1EPwxFsRInX94ZlNUDeSmukLSlwjQntKPgtWEH60HnKniUaKJo7fNFRXCtyA==
X-Received: by 2002:a19:c704:: with SMTP id x4mr3702682lff.13.1582926565501;
        Fri, 28 Feb 2020 13:49:25 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id n2sm6563971ljj.1.2020.02.28.13.49.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 13:49:24 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id w27so3206938lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 13:49:24 -0800 (PST)
X-Received: by 2002:a05:6512:6c5:: with SMTP id u5mr3700695lff.130.1582926564050;
 Fri, 28 Feb 2020 13:49:24 -0800 (PST)
MIME-Version: 1.0
References: <1582889903-12890-1-git-send-email-mkshah@codeaurora.org> <1582889903-12890-4-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1582889903-12890-4-git-send-email-mkshah@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 28 Feb 2020 13:48:47 -0800
X-Gmail-Original-Message-ID: <CAE=gft7mT18V1QOi0LSk+kcNoOOKEdVNywj4wcO22J_d=kA+3w@mail.gmail.com>
Message-ID: <CAE=gft7mT18V1QOi0LSk+kcNoOOKEdVNywj4wcO22J_d=kA+3w@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maulik,
Thanks for spinning this so promptly.

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
>
>         for (i = 0; i < count; i++) {
>                 struct completion *compl = &compls[i];
> @@ -455,9 +469,6 @@ static int send_single(struct rpmh_ctrlr *ctrlr, enum rpmh_state state,
>   * Return: -EBUSY if the controller is busy, probably waiting on a response
>   * to a RPMH request sent earlier.
>   *
> - * This function is always called from the sleep code from the last CPU
> - * that is powering down the entire system. Since no other RPMH API would be
> - * executing at this time, it is safe to run lockless.

Oh nice, I didn't even see that comment. We should probably replace
that with a comment indicating that we assume ctrlr->cache_lock is
already held.

Please also remove this comment in rpmh_flush():
        /*
         * Nobody else should be calling this function other than system PM,
         * hence we can run without locks.
         */
        list_for_each_entry(p, &ctrlr->cache, list) {

-Evan

>   */
>  int rpmh_flush(struct rpmh_ctrlr *ctrlr)
>  {
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
