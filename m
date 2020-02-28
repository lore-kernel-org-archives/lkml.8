Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7B2C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C436124672
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QehJgRuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgB1GhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:37:22 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40689 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgB1GhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:37:22 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so875217pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 22:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sWuRilzkWYZAyZcN+NIINqDWTQC9Ad4zFhRqNEFgkTw=;
        b=QehJgRuGyVx8z9rSKmAD6g+auU5HoaMXW9zJbFfPLiggBLOu1zfe1nCsYSv3jIHHA9
         81XQOHQd7TKbEr8mX7faBOYVQrg1DXadDYIAcnHaZCSx9vh5Lux9/T8/tFX86UAHWrzl
         UH8HICUXcYBHshfyCCutETnbAkBnaIovyYOjxw1SbdubdUH5fEL9jCP4mwAeLbp4swFC
         ElLUA4b4YBAVlUSIyWJipJEsjEwWBSAE7460aGxKcNBlBKkIQhyJR1lKGKwSegzk1N0x
         fRgPbgmW1UxrSsa91qKk31073n5YDFpsf5KmFcl8mNO4CDEk1zZb1fo3oO5AYENP9klD
         vSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sWuRilzkWYZAyZcN+NIINqDWTQC9Ad4zFhRqNEFgkTw=;
        b=JLqrGPkD0AFWyenHBEHQ6fpi/gJeBsvSu3BklbP04jATLD+9NSfSi4KYUCv3wGCW1T
         PFMP3eBzncSg28b67T8IQhj2vqmf6iBY78dzxH6im6ZaTazrAhK0Mhit3A8j79JsM803
         kRrzuNtuggqtJqvHu4cWTYgeFhHljJV6j8EvCLBtJ+u3tSBktAAEsHvd3Lkx6wT/EW4s
         2IKCxrjSoDRAqFhW30yqwkOedfxarC1Q0EUh8l8JgdU2rJdWT0uLfamdiB+fe+1V8lf2
         hA7BiU+gs4c64yAVxLbGy3BEK/69nKnuQx/zBjnWQjNH+2W9TMwohuQp1nQNDAWyDQO4
         GLZQ==
X-Gm-Message-State: APjAAAWlDkbCL7SiqCBeyPl/cEg3eUNxYJJ+v2iVQH2ym4834RwjiF6c
        6zOnlrDidM35NddR5wG6zuRfhg==
X-Google-Smtp-Source: APXvYqw2AVYSRI6xdhUxPas/8l5T+VD5ebOml8D5RzfzJBtkwjtvAjJrDecbuRyx8K93vxbli58a1w==
X-Received: by 2002:a17:902:b949:: with SMTP id h9mr2705815pls.57.1582871841250;
        Thu, 27 Feb 2020 22:37:21 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f8sm9313696pfn.2.2020.02.27.22.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 22:37:20 -0800 (PST)
Date:   Thu, 27 Feb 2020 22:37:18 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org
Subject: Re: [PATCH v2 4/4] arm64: defconfig: Enable SoC sleep stats driver
 for Qualcomm
Message-ID: <20200228063718.GB857139@builder>
References: <1582274986-17490-1-git-send-email-mkshah@codeaurora.org>
 <1582274986-17490-5-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582274986-17490-5-git-send-email-mkshah@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 Feb 00:49 PST 2020, Maulik Shah wrote:

> Enable SoC sleep stats driver. The driver gives statistics for
> various SoC level low power modes.
> 
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0f21288..c63399d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -767,6 +767,7 @@ CONFIG_QCOM_SMD_RPM=y
>  CONFIG_QCOM_SMP2P=y
>  CONFIG_QCOM_SMSM=y
>  CONFIG_QCOM_SOCINFO=m
> +CONFIG_QCOM_SOC_SLEEP_STATS=y

Afaict the driver is not crucial to boot the system or to collect the
statics, so you should be able to make this =m.

Regards,
Bjorn

>  CONFIG_ARCH_R8A774A1=y
>  CONFIG_ARCH_R8A774B1=y
>  CONFIG_ARCH_R8A774C0=y
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
