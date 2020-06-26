Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A81AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DEE207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cVnSP+/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgFZUWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZUWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:22:14 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA2FC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:22:14 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e6so4865895vsm.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bYsvRQj/KxO7y6dcHjKoVfFZMfrtTcsCp4sG21kGBU=;
        b=cVnSP+/m+7yKuZx6yu96KuQZagQE2QwRL8rlUKUdf7JB8RzaML0YfYX0XCNHk3q2AL
         1sEoS7KqNSGVHu8R9gM8PQc7xETIM3LxOnV1tHenKcyY7IWU/uqES3yBkHhO6rUuWOlw
         3F5uTuzCOzTOE8hRDq9rJCCArcCMLmk11dPUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bYsvRQj/KxO7y6dcHjKoVfFZMfrtTcsCp4sG21kGBU=;
        b=lqFCjGyaejsxGML2eG4YKcqE/x7xondygERJfkbb7W9w77RNjKN8Ttr+C8Tnc4ZMft
         kZK1NpBH7lsyC0wrgIihN8I1r5RDiTWRS7GVKlAM2moRLi5L4mTiA/qRjqDggr0KidDM
         VGE2hv4jKtWSxXj8Cl8MRXSagwurokZiNxgD1Zl7OeyHtLSdwAZwVFGwCbpx8m3ZQYzN
         ayDtReN9vPnSGPByEl4ZloYNkRegh6SvtHf+58u+FN0oP/P7UrsaJQlhN3lLYpKCFWls
         K0qTbE0sM/9yoNmCoOPelh0wjAWUhRRk3v1qZ+CXz9VrtpVBkbJIoEMjuRyKoai8FS5v
         MKnw==
X-Gm-Message-State: AOAM530bmWCVM+hTGasELWpEhDj2CxVABY9FFt4BNiAXyhmOUp7TBsRY
        2nb+BaI8NgPsLKsQkjLVDSfi411tj0g=
X-Google-Smtp-Source: ABdhPJxcweHfS+z9vr4wbFrdaSju/JV5hPbjS70PRTIzGhHxqP3mrG4njbhMvTkttPuw/stIysd7fA==
X-Received: by 2002:a67:db0b:: with SMTP id z11mr3807269vsj.25.1593202933154;
        Fri, 26 Jun 2020 13:22:13 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id x22sm1527400vkx.6.2020.06.26.13.22.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 13:22:10 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id e3so3441046uan.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:22:09 -0700 (PDT)
X-Received: by 2002:ab0:2eab:: with SMTP id y11mr3463084uay.22.1593202929409;
 Fri, 26 Jun 2020 13:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200626190808.8716-1-sibis@codeaurora.org>
In-Reply-To: <20200626190808.8716-1-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Jun 2020 13:21:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X_0s-YOCj72F3rzu0oFkNBx82MeHsP2Yqrj0=LAOF_tg@mail.gmail.com>
Message-ID: <CAD=FV=X_0s-YOCj72F3rzu0oFkNBx82MeHsP2Yqrj0=LAOF_tg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180: Add cpu OPP tables
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 26, 2020 at 12:09 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add OPP tables required to scale DDR/L3 per freq-domain on SC7180 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>
> v2:
>  * drop interconnect-tag property
>
> v1: https://patchwork.kernel.org/patch/11527597/
>
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 160 +++++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)

This is a huge perf boost and I'd love to see it land while waiting
for the interconnect-tag stuff to get resolved.  In theory I guess we
could land the sdm845 one too...

Tested-by: Douglas Anderson <dianders@chromium.org>

I'm also not really an expert here, but the patch seems sane to me, so
I'd give it a weak:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


-Doug
