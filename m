Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86ADC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8670E207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hbGVRH3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHRO5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHRO5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:57:53 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A4C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:57:53 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id j188so10269175vsd.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TV7ie8YQzzCwxQWHVrIBTQKXy/oaWTjxbImglzQ6zZQ=;
        b=hbGVRH3BGMrwNufK6iwkScF4wgv806ZBXZDcJCRIPddAOmGq1Fm5FWiW+VdokAM2/+
         +w/sFtvsijDh0eHR69yXym0B1iwEHzEHK8Az8EdNtFj0/mTzzi9Iw0FtnpbQ2F7eIIX8
         voFTbtK4Bux+4SL0ScZh+F4IRH5ehPrmv6wyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TV7ie8YQzzCwxQWHVrIBTQKXy/oaWTjxbImglzQ6zZQ=;
        b=P7JAEaGeuDVh8TY5sMa+us0Ll9aDwdbuc6IgL8rHkI6A1JwnKwJlBwd4uEJ5NTItsQ
         PQ0nkZcwDnxwCu4Acz7rYmbTdnuorfJ5m202SdH3UOdJNa5kmP2sFuzO76ERxOIvisgd
         rlqMc1HvLb4lWG7lZj9xCQKEa3bhOnX+nEjfPKaAIyGaEPjLeGS6hWGCs6IvhHJVAx9W
         2NomS+tVLeznXtFoGE/wrLVpe6Ec58P6agW+rT87da2ogv02j9Fw3zuIoHvI84pvqVAC
         mOc1mpktjqCbrDSORzSem3TNdDhunjPCtc2RffXkN0iAwV68xpwPBvF1Z0TJAVvoLyD2
         2ceg==
X-Gm-Message-State: AOAM533cNqDM/vP91P6ojqvNONmAuuNWFlH2B23Vu9Z+RzCqo+UsrJpd
        U/VshBvW93xAlNuycBuFbzmpcm8A9zhlaw==
X-Google-Smtp-Source: ABdhPJzHU7KqVY3aZkE/wPmc/5bRciwXta1A2+UM1XRHdKOCiWyoDbCeFSzEw6nL4KyvSmTbV9PrbQ==
X-Received: by 2002:a67:66c1:: with SMTP id a184mr12150102vsc.23.1597762671221;
        Tue, 18 Aug 2020 07:57:51 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id e124sm1777600vsc.2.2020.08.18.07.57.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 07:57:50 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id q200so4379077vke.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:57:50 -0700 (PDT)
X-Received: by 2002:a1f:a302:: with SMTP id m2mr12131702vke.28.1597762669752;
 Tue, 18 Aug 2020 07:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200818145514.16262-1-saiprakash.ranjan@codeaurora.org>
In-Reply-To: <20200818145514.16262-1-saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Aug 2020 07:57:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vzk=qkemLRU3gaZ1K4P-9=tMqB+HUoGCQL4Zxv6q8XFQ@mail.gmail.com>
Message-ID: <CAD=FV=Vzk=qkemLRU3gaZ1K4P-9=tMqB+HUoGCQL4Zxv6q8XFQ@mail.gmail.com>
Subject: Re: [PATCHv2] arm64: dts: qcom: sc7180: Fix the LLCC base register size
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Tue, Aug 18, 2020 at 7:55 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> There is one LLCC logical bank(LLCC0) on SC7180 SoC and the
> size of the LLCC0 base is 0x50000(320KB) not 2MB, so correct
> the size and fix copy paste mistake carried over from SDM845.
>
> Fixes: 7cee5c742899 ("arm64: dts: qcom: sc7180: Fix node order")
> Fixes: c831fa299996 ("arm64: dts: qcom: sc7180: Add Last level cache controller node")
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>
> Changes in v2:
>  * Edit commit msg to remove confusing references (Doug).
>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I can't validate against any datasheets, but it does what it says and
seems sane.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
