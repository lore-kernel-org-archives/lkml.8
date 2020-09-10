Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC6DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0DB20829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oD1xRjIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgIJVBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731218AbgIJOkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:40:15 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EC2C061799
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:40:15 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id l1so2059976uai.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JlHSJzzDMd2cH/FNwWRua8Mp268amVy5W9EWLGVmUPc=;
        b=oD1xRjIlRnK44AUoNaWNO/km7pvdC4CuwaFjutnksJPfr5b6oJmdEgdZ9yNz7Xk2Gm
         bpWVhEtYTCTfJtAz6L1JEx6u/7KKahQo8ztrJBFbVTUqiD5g0ViXtUYWrkuVf7U4IKSh
         OltoiL9sRb/sIZiVWKa1ZI4bJymSa/9pkerP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JlHSJzzDMd2cH/FNwWRua8Mp268amVy5W9EWLGVmUPc=;
        b=ZWqrLmS5L3pEyDKEMM4Ap29ga1rehA3GVqEuqISIivfKUR0maxNaf/ztT9mPanOQTY
         ZVFwEG404e9j5cIIxVUsMswliNNXM1ATqfkmNTJJMj7OIvTcUY6zhZeCjBbGIq9ouaTg
         Thxm1hGsuquif47JJbBJCQlnhOjh48+QsjweHW0YlFGqPfac4ePmNNIhcDuD58Tct8Eq
         XtOwDigJ2NmIDjIV1lkXWM8fRwX56Gt6BEAxOlWdu0wxBuWj/u6STMIkYtW7WudxPX06
         a6SOOwwW7OJjWGSP5+cGP/syc6W6zKiGzj/GcYldDO3bYWnU4UKh4Cpm2brg6ZuP5NAM
         ocag==
X-Gm-Message-State: AOAM532Xh7lyzCNwSACpP2FXKmFWQ2mq0c3y6XVRdzDdnJCcu2nU4Gi2
        5nWF9KlGum3CcQt3g5bw4HlzKlKX9+yDww==
X-Google-Smtp-Source: ABdhPJy2aII55ju5fI5ma1k+BGPNamszfPR0oLKGh37acAn5lkHnnJjXQd7FJtcKMw+4ZNUQWqKkEA==
X-Received: by 2002:ab0:2a93:: with SMTP id h19mr4064430uar.18.1599748813338;
        Thu, 10 Sep 2020 07:40:13 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 89sm756370ual.11.2020.09.10.07.40.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:40:12 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id a16so3493763vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:40:12 -0700 (PDT)
X-Received: by 2002:a67:d907:: with SMTP id t7mr4542751vsj.8.1599748811523;
 Thu, 10 Sep 2020 07:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <1599742438-16811-1-git-send-email-skakit@codeaurora.org> <1599742438-16811-2-git-send-email-skakit@codeaurora.org>
In-Reply-To: <1599742438-16811-2-git-send-email-skakit@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Sep 2020 07:40:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XYqiGk3QEPxVKCgnYA0FVrizyarSW52HPRGVyAUSugrQ@mail.gmail.com>
Message-ID: <CAD=FV=XYqiGk3QEPxVKCgnYA0FVrizyarSW52HPRGVyAUSugrQ@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] arm64: dts: qcom: sc7180: Improve the pin config
 settings for CTS and TX
To:     satya priya <skakit@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        msavaliy@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 10, 2020 at 5:55 AM satya priya <skakit@codeaurora.org> wrote:
>
> Remove output-high from CTS and TX as this is not really required. During
> bringup to fix transfer failures this was added to match with console uart
> settings. Probably some boot loader config was missing then. As it is
> working fine now, remove it.
>
> Signed-off-by: satya priya <skakit@codeaurora.org>
> Reviewed-by: Akash Asthana <akashast@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in V4:
>  - This is newly added in V4 to separate the improvements in pin settings
>    and wakeup related changes.
>
> Changes in V5:
>  - As per Doug's comment configured pull-down for CTS pin as earlier.
>
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Looks fine to me.  Slight nit that this only applies to the IDP board
but ${SUBJECT} makes it sound as if this applies to all sc7180.  I
wouldn't spin just for that, though.  If Bjorn agrees, he can always
adjust the subject when applying.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
