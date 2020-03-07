Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BFAC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 06:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14E020684
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 06:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYj04wty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgCGGs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 01:48:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35918 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgCGGs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 01:48:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id g12so1802591plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 22:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qllPESSc2Lk51pmSOF1Cje56g6TCrSuyTFey48WdPLA=;
        b=oYj04wtyq2tI/CyhVx89yOKNdUBywh3PV+ap2B3yqZcF+9f8ekTJjite0emNQOKlzO
         ui3U9hoReI9QegstBbtvspLU2iGu16gclFh39UCOuUl5o9ZviyN8ui0VcbiyFHqZyMUL
         k0O88vqLnqirtieUgTUVaS4RPPapD6wRD2+96X8saRElV0N1ftDLhz1xe5wsquWiAL8a
         NGJUkh8QKpJn3CIERa7dOP+qCjBx45IVguLmGe6F93N9ge1F/3Pb2uppXIzm0DRKrolX
         rOSIgkOqPj35dPCrhBG4q46GwvoQRXMdaJz6QlNKWkcIYALNnNmKNfAJKXV5ZauWzayR
         AhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qllPESSc2Lk51pmSOF1Cje56g6TCrSuyTFey48WdPLA=;
        b=Lx6V0SzJoxEsHub/lJtxxI2QYKH4ZGHcTL9BR1juh4amqubBNtF/5Df1HE8Jx9Nz3V
         iUis2uagKbY6MhDE56bnsKn6wUvKAAb5HdQe27Zle7/mYKsiBlj4i6LpEoyzzyHj6tlk
         jDhzYYq4H3msmPas5/ximeQW0/iJ4P/EA0Y7ov/QsY98DQxMSQs6miztAqimSRrmWSEf
         Mqtn4nnKIEWxRTpXC14s8iCIU49uwUVmHKLsx9jn8LFoK81+SFEgjrOMLQ38R9qONAel
         h//6KUo7/Ay/E5yTp9UvkhGuY/olFHPbwK94LVuGHyaWpXTPj+NT7EqirJ4hj+ZI3Ahg
         Q0nA==
X-Gm-Message-State: ANhLgQ0tS1T+ELMK9hnhDDkq8LFeK5Af3USeHUwSM/cHVZzAO3zq9TDP
        8fQMI+N+DZ9AIYlRn2AomrPZwS3caNU=
X-Google-Smtp-Source: ADFU+vs/Ut0Bo1SjS+PWqL3kvYRpVqLtaXfMl7A/GAt0IPidZkuHuUzW4rpYuRO8I8A5ILvqT5lX6g==
X-Received: by 2002:a17:90a:3188:: with SMTP id j8mr7337615pjb.82.1583563703667;
        Fri, 06 Mar 2020 22:48:23 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z3sm11460708pjr.46.2020.03.06.22.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 22:48:23 -0800 (PST)
Date:   Fri, 6 Mar 2020 22:48:20 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org
Subject: Re: [PATCH v3 4/4] arm64: defconfig: Enable SoC sleep stats driver
Message-ID: <20200307064820.GH1094083@builder>
References: <1583479412-18320-1-git-send-email-mkshah@codeaurora.org>
 <1583479412-18320-5-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583479412-18320-5-git-send-email-mkshah@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05 Mar 23:23 PST 2020, Maulik Shah wrote:

> Enable SoC sleep stats driver. The driver gives statistics for
> various low power modes on Qualcomm Technologies, Inc. (QTI) SoCs.
> 
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a8de3d3..2dd543b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -793,6 +793,7 @@ CONFIG_QCOM_SMD_RPM=y
>  CONFIG_QCOM_SMP2P=y
>  CONFIG_QCOM_SMSM=y
>  CONFIG_QCOM_SOCINFO=m
> +CONFIG_QCOM_SOC_SLEEP_STATS=m
>  CONFIG_ARCH_R8A774A1=y
>  CONFIG_ARCH_R8A774B1=y
>  CONFIG_ARCH_R8A774C0=y
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
