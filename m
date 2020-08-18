Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F12C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5750A206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GFlw44Sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHRN4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHRN4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:56:35 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ABBC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 06:56:35 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id r197so4316802vkf.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQHECpOUmUIUn/BlEGYsCVfl8NoL6sE1Zq5USMNyPsA=;
        b=GFlw44Sp9NvIROQShqLUaqn4pvZMQJmHC9t78x2jciAp3VCTruRs3JKFPbGAdavqdA
         jjRu4+46WRShUl2tgpcae4KqfCCmG8mTS2YQJgacVlzlgzqWEW+Y+2RPD4A4lrMKKttT
         yOKhXnEcWWI+FwdcvX4J7AZCbJaepBlthLTbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQHECpOUmUIUn/BlEGYsCVfl8NoL6sE1Zq5USMNyPsA=;
        b=aLUvHVbbt3ke8BygYpOMBJkoLiBgek0+I/Vu6NtIKtEIS/jyc9Wilok7e6Ecvlb2r2
         FnthTrh+vmrUcNc2PIaLh0sEsx14udO2DlSQybXUEQ2cnUDHLXN5Uu8zk3Q8E9APEsmu
         BNhfoM12i+nTT88PjzUzhNBnlsPkdw6pndaFpDSDjRMAkSPJjuBHzBElIesVyPXN+G3R
         P4pjIEfhTVIJJQImUvfHRTD3/5wZYu3+Cr11Aigs3zwomWOtA+NqxEx6OHpLex5uaBnm
         /mxdj9nVBZhAN9eqNu9omu3sWSVr6MHAtl5R0MKvm9TGI3C2LUXhR3q7tCHrGOgoYPO8
         bivg==
X-Gm-Message-State: AOAM530QNq/aS9/GUwjAAF/1/K9ynATe1I1FzUWhlfKpZdBiWuAAWv0y
        rCQ19YcWA4iu3oUFArB/Oq4G3O8drvQHhw==
X-Google-Smtp-Source: ABdhPJzuO26kID1fY/wM4Cc387lawJ+V7hJZwXvOy7omXdexvkKiXyLcbCEc2ltUxxI/tJ66AC/SkA==
X-Received: by 2002:a1f:4646:: with SMTP id t67mr596496vka.75.1597758994355;
        Tue, 18 Aug 2020 06:56:34 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id n123sm4157854vkf.41.2020.08.18.06.56.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 06:56:33 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id a1so10143388vsp.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 06:56:33 -0700 (PDT)
X-Received: by 2002:a05:6102:213a:: with SMTP id f26mr11637826vsg.6.1597758992748;
 Tue, 18 Aug 2020 06:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200817040417.11111-1-saiprakash.ranjan@codeaurora.org>
 <CAD=FV=VVeoqOsVzJiCxjYTpJc8JX4Qx3vB+0evzp8oMdYsRZvQ@mail.gmail.com> <5c8b1664adceab8c600c80058e40cc97@codeaurora.org>
In-Reply-To: <5c8b1664adceab8c600c80058e40cc97@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 18 Aug 2020 06:56:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VJB=6PxaG6LZsjQdWxKbVonnm9WTHwqCeoXPMD=uWjfw@mail.gmail.com>
Message-ID: <CAD=FV=VJB=6PxaG6LZsjQdWxKbVonnm9WTHwqCeoXPMD=uWjfw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Fix the LLCC base register size
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 18, 2020 at 12:38 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> There is one LLCC logical bank(LLCC0) on SC7180 SoC and the size of the
> LLCC0 base
> is 0x50000(320KB) not 2MB, so correct the size and fix copy paste
> mistake
> carried over from SDM845.

Sounds fine, thanks!

-Doug
