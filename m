Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E60C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E2A2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYCVe4KY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCTOjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:39:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46716 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgCTOjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:39:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id d23so6600303ljg.13;
        Fri, 20 Mar 2020 07:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0dEl+SmShjn8JFGibaEdqUe08SQ/fop8w6Anh4mWd4o=;
        b=bYCVe4KYulbtR1U9kqgxr9bUo+bUJf4Sk+tqIkstrlvbcvthXvNS4T3b3Vtp/OLHNM
         M0vcmMkhfBtUyiMouLbxxtiYdFpfXN62SRwSOI7isdHEnZmEojDK9K02i1oCmIQo1le0
         1yyZr0uW9JQbTmaZAqdTAoKbDfXngue53pMyYhaxXLYBSZMCommcA47UO5yChDYW0nCc
         MKXBpo03tztUkbe/S3nqNAArkZkS8pott/txqNy2tlnokwVH4+mua0LB8EZZMMPJq7B6
         GF2010y+6FCShcA8Yx/a3+RJVufGEsoFZ7k1GUr2MdH+bZ0hDrB/pPZOTf8yEPrrwaNX
         a9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0dEl+SmShjn8JFGibaEdqUe08SQ/fop8w6Anh4mWd4o=;
        b=ARXSAjWL1xfMtARTlhX0gwApMVidhYnGUiZWj9da4PAscSfJISdyxtjQipvk3VyFjc
         +X2spl3aBcUGOar5ZIGHAC32yuG7F15DMUszjnpWwjP+N5tkBCVgg8p0MnzN/ZZoU+zR
         52QfWZbidXt3bJapnl9WDIetC70jNSBUUGRu9dz9dFDH3zyXDq3CoJZ4khaVs7nsEu62
         1GLogd/cf1fa8suNHg6hDwfOKMbJieXwqebg0eGRjW/mR+LlE3uECM/Cgfm8JlXbMCTm
         4LALXdGOs2P6OMWdxP6iLP8/roiaN2byffJQx92cIj9iGfOll/C4jpG25oJbl7Fkpxon
         xJfg==
X-Gm-Message-State: ANhLgQ0/VAO62UNUFRF18IkKS1s/b4SvaNmRVfsZPemMLznIeJW2y+w7
        BYr31l5606gmC72FG8dGGhRNTDXr
X-Google-Smtp-Source: ADFU+vuppL2bu/7VNKqrTF0sxxbNBdd3Ln/+ORUh/2BGMHpKxMUg6rGLanCO+zBsFcM+lV96bMfGrw==
X-Received: by 2002:a2e:8ecf:: with SMTP id e15mr5797347ljl.223.1584715143094;
        Fri, 20 Mar 2020 07:39:03 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id l22sm3462776ljc.32.2020.03.20.07.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 07:39:02 -0700 (PDT)
Subject: Re: [PATCH 2/7] clocksource: Add Tegra186 timers support
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
 <20200320133452.3705040-3-thierry.reding@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <df532fef-1533-9da7-d676-f4671746fde3@gmail.com>
Date:   Fri, 20 Mar 2020 17:39:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320133452.3705040-3-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.03.2020 16:34, Thierry Reding пишет:
> From: Thierry Reding <treding@nvidia.com>
> 
> Currently this only supports a single watchdog, which uses a timer in
> the background for countdown. Eventually the timers could be used for
> various time-keeping tasks, but by default the architected timer will
> already provide that functionality.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/clocksource/Kconfig          |   8 +
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/timer-tegra186.c | 377 +++++++++++++++++++++++++++
>  3 files changed, 386 insertions(+)
>  create mode 100644 drivers/clocksource/timer-tegra186.c
Hello Thierry,

Shouldn't this driver reside in drivers/watchdog/? Like it's done in a
case of the T30+ driver.

...

> +static int __maybe_unused tegra186_timer_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int __maybe_unused tegra186_timer_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(tegra186_timer_pm_ops, tegra186_timer_suspend,
> +			 tegra186_timer_resume);

Perhaps will be better to remove these OPS for now?
