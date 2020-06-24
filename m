Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8687C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C404520724
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LT6KTMwz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391159AbgFXNyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391150AbgFXNye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:54:34 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4CFC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:54:34 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id m25so1420232vsp.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6p40MsHSjWo5H0Bxrz9MYk9ZRj7p6reI+RPdQAxE94=;
        b=LT6KTMwzqi9u/IBPmxy4zhm6Oi65biD58CVNoanp3EsX3NEk35jvumPLyeQN7zWy5Q
         pkXb/u3XGnyXyhh+PofR7VhwO3otsMdBVyyV7Y22RFM4ucFacJTaHJmSENLovLghLfJM
         C9gk+K3Gb5lu0d4mnwGBo2cHQQJ6k4Vh2Etm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6p40MsHSjWo5H0Bxrz9MYk9ZRj7p6reI+RPdQAxE94=;
        b=FOMqhbvp5a2koPob3qG1XcvizjHIP3JFuG+hDh11gfbXHkcgOllqvTYiuTD5Os/MTC
         r4InUtgK7FFIkQUEviWp2+SbEH63oWzA3Y0NZUszRCSHQ6cVGEQfsWJYwnCBY87eKzET
         MPet+S7F3rXFTbwf57G1TFLlWUGNQKVa1aMtZ1dtD8CDP4S7I2WKI8+35kwoAVFHtRk5
         1r1iVd0G7EtPkKpcYr8FFoEBY4QNqQmYWrCPm0/dwCSibpjpyldqpnCmY3FtvDYsgwem
         lfNv5hZaGs8ZI7IQMAPAfnnVpiRDptMuYHjY1Oo4gUL5FpGuMX7hfZXcgMreQ2Q2mrfq
         GA4Q==
X-Gm-Message-State: AOAM533yVeIhH3FE6m750QaoaoosrZe6DtD5kGtByShaVosZJE9cU3HW
        +VAnVsArg5Ollhi8P40S+AmdM1bvioo=
X-Google-Smtp-Source: ABdhPJzNV+SEiGFc8+6OZnOxcBlt/lKr3pBCJv+UFxVVz93huwexAi0MK72FW1oehPmleYq3+jd/Xg==
X-Received: by 2002:a67:ec95:: with SMTP id h21mr16908711vsp.28.1593006873574;
        Wed, 24 Jun 2020 06:54:33 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id x69sm3281434vke.0.2020.06.24.06.54.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 06:54:32 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id b10so712872uaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:54:32 -0700 (PDT)
X-Received: by 2002:ab0:6e8e:: with SMTP id b14mr20672618uav.0.1593006871986;
 Wed, 24 Jun 2020 06:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200624123406.3472-1-saiprakash.ranjan@codeaurora.org>
In-Reply-To: <20200624123406.3472-1-saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Jun 2020 06:54:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UAa7RNsHJem1pPT-FAWfSzSzfBsd9aeMg_Ty6CH5jP2g@mail.gmail.com>
Message-ID: <CAD=FV=UAa7RNsHJem1pPT-FAWfSzSzfBsd9aeMg_Ty6CH5jP2g@mail.gmail.com>
Subject: Re: [PATCH] arm64: kpti: Add KRYO{3,4}XX silver CPU cores to kpti safelist
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 24, 2020 at 5:34 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> QCOM KRYO{3,4}XX silver/LITTLE CPU cores are based on Cortex-A55
> and are meltdown safe, hence add them to kpti_safe_list[].
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  arch/arm64/kernel/cpufeature.c | 2 ++
>  1 file changed, 2 insertions(+)

Reported-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
