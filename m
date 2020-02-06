Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA5C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A274921D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRo6PM95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBFQ73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:59:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33339 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFQ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:59:28 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so6903246lji.0;
        Thu, 06 Feb 2020 08:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=og0ADzsSpshRIcdeT+Ks5xnjpqRL7rIYjLZFqgQChC8=;
        b=HRo6PM95VaVbLvysaWne6f1YcD6Xn8ky7qGhXssAk+65rmhIhxrSsaq1vkT4jVTRWJ
         Vcg3sSdqitzIy5JSWb03RkBU8I/AWKITP9G5QxgsvxVSJKIIUUoUpfPzFdybKYxboX8m
         KiwDB9pm+oXNwHJ9gMCaR2lVltrz6cj9O2C4RTILmHCSu4jevdPaDT0WkensyZEykNCQ
         XevyWbBJbNfxFTQOsguMTpusj2kEjDl3Ppqzd0/Cs7bjkxI2lZIqBmbkqUSZDhOkxPwj
         CCAIvnNKUrs1OdnnVGd5zb99/zb075vJPrcfM0c76n9AoWoiQVOsJdJkoAYvK++HUC0j
         NSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=og0ADzsSpshRIcdeT+Ks5xnjpqRL7rIYjLZFqgQChC8=;
        b=g3ZhjIOjkz6+Rmms5yaS8IocBcVAwArcuYfl3BPhY3W7/QBSWe9PJ3n2PzYxgX0rQm
         5SsE8D0JMDEbBUHoe3kYSaLRH2fwoiieAPhp6rV8yYKxeX13vm/fGHAnWzdxgIaXrB2e
         qac7LjmWunD3WKqw2FPNlW8+6ZXfGVwlVRJdezOxNFhwEmVkPaXRR+r8hvyxO71B7Fu7
         XzMWH7ERFS1CcL+/tLPKA1harnjgYHqBfzs1PLlngJk2K9CLletfQmqSyiruShdsp25M
         S+drOhQHrSjNpIPQnrix86WhZSJGvRP2blWxDY0MQpOLirPTs7t9TQSXkhV8wSfkjEy6
         z5eQ==
X-Gm-Message-State: APjAAAW1jjieDOJ+u/qeuEJpfSWXH/zRlhYotKQC3yoVomgtXMJ7VYSA
        PBhpS6gE2syps4lT2TH3rxc=
X-Google-Smtp-Source: APXvYqyguhImDG7VTsNciB0wVBuwnFI+0C60WcsTjlt52pFAY46lNafpCyeCJnDDsMLILiEPwTOYGg==
X-Received: by 2002:a2e:9c85:: with SMTP id x5mr2681644lji.50.1581008366212;
        Thu, 06 Feb 2020 08:59:26 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id p15sm1546166lfo.88.2020.02.06.08.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:59:25 -0800 (PST)
Subject: Re: [PATCH v2 4/9] ASoC: tegra: add Tegra210 based I2S driver
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-5-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3a586a6b-5f53-dc44-b9fc-67c633c626ef@gmail.com>
Date:   Thu, 6 Feb 2020 19:59:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1580380422-3431-5-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.01.2020 13:33, Sameer Pujar пишет:
...
> +static const int tegra210_cif_fmt[] = {
> +	0,
> +	TEGRA_ACIF_BITS_16,
> +	TEGRA_ACIF_BITS_32,
> +};
> +
> +static const int tegra210_i2s_bit_fmt[] = {
> +	0,
> +	I2S_BITS_16,
> +	I2S_BITS_32,
> +};
> +
> +static const int tegra210_i2s_sample_size[] = {
> +	0,
> +	16,
> +	32,
> +};

static const *unsigned* int?
