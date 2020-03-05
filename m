Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7852BC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC1F206D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JhxBDlNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCEWUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:20:52 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40995 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCEWUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:20:52 -0500
Received: by mail-vs1-f66.google.com with SMTP id k188so266185vsc.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrmCjw7xyG8fg4C1dKjDiV0Q8S1LhYkzPOfDEOi+i6c=;
        b=JhxBDlNuZ+wqBBfKTq7jRiznrdUS2hRiPAoff37XUBYnwD4QbFPjdEWWg8BXQeu3HA
         sP5144hQmSd5qudCwUvdsz2OpsStzWufw3hsrRFRRi55g6skgNorWbKv7cJP1B6ltpMy
         Bze/Tte7ajsI4RYzI2m66PsE3nztR+E+istJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrmCjw7xyG8fg4C1dKjDiV0Q8S1LhYkzPOfDEOi+i6c=;
        b=VcgatQYe531GR6QQMXUmb6/JsoB9yYpXLlhzBinDjFFsZHuyf5L9p8KNqWVbsfJ2Fx
         3YrYTHeW4sH5KvxHeYcy4oHAVCooT8jfGMeCJBxxOu9qwIkW7oiWD3LQijGtoT7n/Fs/
         95SspbRE82uHYOunjiSBhQ3FAfeHoZ9oQgwXRqAbUuOnJqcL23Ev/HYCOtgIzyZaEn2b
         QHgR+XU1HnrtbcwLvmuVRKd9DU9LLhV0EftTDMr2/EtXDywvKoIbBA1ZKXBkKq9T5g/7
         GzhhFCxqqV6GlBmn+ynKw5oappvJgnm/+4X6+pe+7linnaNcNYSgmNXRHZWHagMVYL6g
         gPMQ==
X-Gm-Message-State: ANhLgQ1oog4uXvRK0Q1RT5++KoCeM3l0lZ1k3eKOMIpSee3eGATodYve
        VbwD93ZHdkei6KRZ3teWZQO6Y8ON3ps=
X-Google-Smtp-Source: ADFU+vu8aXcZmkc/XCUQqzuaXyVvcwl9uGLCjk0I36vaYoZhOOFDI8V0TGGLDA2cdS7Fx4JvffJfqA==
X-Received: by 2002:a05:6102:20ca:: with SMTP id i10mr355004vsr.189.1583446851215;
        Thu, 05 Mar 2020 14:20:51 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id b19sm8784767vka.48.2020.03.05.14.20.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 14:20:50 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id n27so300568vsa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:20:50 -0800 (PST)
X-Received: by 2002:a05:6102:101d:: with SMTP id q29mr385638vsp.73.1583446849518;
 Thu, 05 Mar 2020 14:20:49 -0800 (PST)
MIME-Version: 1.0
References: <1583428023-19559-1-git-send-email-mkshah@codeaurora.org> <1583428023-19559-5-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1583428023-19559-5-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Mar 2020 14:20:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U8zaZCTrZvtipSmaQL8NGg+4aNpyP=KhQ5EYioKovnYA@mail.gmail.com>
Message-ID: <CAD=FV=U8zaZCTrZvtipSmaQL8NGg+4aNpyP=KhQ5EYioKovnYA@mail.gmail.com>
Subject: Re: [PATCH v12 4/4] soc: qcom: rpmh: Invalidate SLEEP and WAKE TCSes
 before flushing new data
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

On Thu, Mar 5, 2020 at 9:07 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> TCSes have previously programmed data when rpmh_flush is called.
> This can cause old data to trigger along with newly flushed.
>
> Fix this by cleaning SLEEP and WAKE TCSes before new data is flushed.
>
> Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state requests")
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index 1951f6a..63364ce 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -472,6 +472,11 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
>                 return 0;
>         }
>
> +       /* Invalidate the TCSes first to avoid stale data */
> +       do {
> +               ret = rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
> +       } while (ret == -EAGAIN);
> +
>         /* First flush the cached batch requests */
>         ret = flush_batch(ctrlr);
>         if (ret)

I think you should make this patch 3/4 instead of 4/4, and then:

1. In this patch remove the call to rpmh_rsc_invalidate() in
rpmh_invalidate().  You've already marked things "dirty" in
invalidate_batch() so no need to actually program the hardware--it'll
happen in the flush.

2. In patch 4/4 (the flushing patch) add a call to rpmh_flush() to
rpmh_invalidate() if you're in non-OSI mode.  Presumably you'll need a
spinlock around the rpmh_flush() call?


The end result of that will be that rpmh_invalidate() will properly
leave the non-batch sleep/wake sets programmed.


-Doug
