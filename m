Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D46C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F0924655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EMrra8Ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgCIXma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 19:42:30 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38602 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgCIXma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:42:30 -0400
Received: by mail-ua1-f67.google.com with SMTP id y3so4012333uaq.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 16:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HbFlXIeA0nZ82kqTFusW9Y5ddM630bUBZPbaTnSWK9Q=;
        b=EMrra8TaXWr/XpsjFWwAXJ9M92aRqXDRr5qcC8JIRzVmcEK13C29b79SejteQwZFSv
         KyRd3SxhqJinTM29vmxs9cL6TpTO+mZPsKy7TfCdcle2Ekttc3FrSeII9T2wZ6/knwXv
         3y6ciY0SDUjk+wP55PranRh+l1WBiTPSuAscc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbFlXIeA0nZ82kqTFusW9Y5ddM630bUBZPbaTnSWK9Q=;
        b=oJybNvM8uslhoribO5dqn9n2mPr7VcCKefH+urJayJLOqQblYMihzimeBkzSq0oD8k
         XmQrdFzogWSIx23kAls8Y/CbNNeMMUeYI+A6IPqlC6mIBVpLpz0ABijH+70w0trpWW9p
         k92w1DjK6SEy7sC9ctShYkDQ3w2PBdJ06KohQDv9oQ/8BpPFsi8bUD/m3rw2FU0UvkPc
         iYEq5YOtZRK4OyqoQjyHZNXhQeEPAwFLPEiyN7KU9luCXeqvDwYFBfpnvaYaf07czuwq
         icAu4vCyE74XzfqysIhIdZNcFy8Ee+hRT5jymouaEdbEjKsynH763P7unhjKXLmALP2U
         hw/g==
X-Gm-Message-State: ANhLgQ1wpllD7iL5mhU+5T9e4UwVpAEyhqMH48IUtIPtIxhGZ8clTT9H
        r7XYpEGfzLMcqFlKOa3M7anPx6c/mwE=
X-Google-Smtp-Source: ADFU+vsEGkj1yjCbmiBmxAV/bi0D1wjiSylajiryvsM3R5nHjDyfrrRzTtFyFpsGLjfvQ7scWCwx2Q==
X-Received: by 2002:ab0:44e4:: with SMTP id n91mr4670593uan.88.1583797348257;
        Mon, 09 Mar 2020 16:42:28 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id m11sm12853911vkm.52.2020.03.09.16.42.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 16:42:27 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id d19so3997010uak.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 16:42:27 -0700 (PDT)
X-Received: by 2002:a9f:2478:: with SMTP id 111mr3162014uaq.0.1583797346690;
 Mon, 09 Mar 2020 16:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <1583746236-13325-1-git-send-email-mkshah@codeaurora.org> <1583746236-13325-3-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1583746236-13325-3-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Mar 2020 16:42:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X9BFJZtgmVeDpr1mCP1C5kg9+3gQo2i5RMfBuQOVMkDg@mail.gmail.com>
Message-ID: <CAD=FV=X9BFJZtgmVeDpr1mCP1C5kg9+3gQo2i5RMfBuQOVMkDg@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] soc: qcom: rpmh: Update dirty flag only when data changes
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

On Mon, Mar 9, 2020 at 2:31 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Currently rpmh ctrlr dirty flag is set for all cases regardless of data
> is really changed or not. Add changes to update dirty flag when data is
> changed to newer values. Update dirty flag everytime when data in batch
> cache is updated since rpmh_flush() may get invoked from any CPU instead
> of only last CPU going to low power mode.
>
> Also move dirty flag updates to happen from within cache_lock and remove
> unnecessary INIT_LIST_HEAD() call and a default case from switch.
>
> Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state requests")
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Srinivas Rao L <lsrao@codeaurora.org>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/soc/qcom/rpmh.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
