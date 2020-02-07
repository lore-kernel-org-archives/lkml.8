Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D18C35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F100B22464
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVFjTA0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgBGSXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:23:06 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36315 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBGSXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:23:06 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so543842edp.3;
        Fri, 07 Feb 2020 10:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2rEL+fZ+atRGcdqc0v6HR9KvKwcDJaTmCDh9SEZyi2k=;
        b=CVFjTA0mdflE33CmzdBoRt7RrT5W9DMHFpCIEmHOUSFpJQJ0oxYa4sqdU+jFJDlinh
         NYDIAkS58ouzX5NyhERarOe6g5KVJ3pqwSnAB9Fvt+cTTNKawK+enONTCTutSRTu0SWq
         M/Pz51Yte9XeHMccGnIfpPvQwFFgPoqU+x55OkyXSRbhLEVtlfSj+VZXd1WDa2PuS0Kc
         5p9bYFmcE6Obyp5xw3Ui+SKIWfZRLtJraYc60ZALpB1sO9DTousQznQiU/b9GXrJ5b/y
         Xw65cQWZDyb+9j6KjPIzC4oUhz9L9/1Rx04gvj9CAYPoFLmKmXK0yfS7FFp7esFWMSSk
         2IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2rEL+fZ+atRGcdqc0v6HR9KvKwcDJaTmCDh9SEZyi2k=;
        b=qJdRi9vfVYdb0zgzUJXCSkDNEf88Tu4rnmFjjiGKYo1owKMAGsDyZnKRKU2KndYq88
         9LhdtIZtIt954Qe71oOgXZBhAXqwHjIz+MAo6gqdJVVsETMmgfbLw8iYQxy4yIpbcz30
         BZLcUr6QR3YcT7lxboamAcUV9YECpML+WVh3irkYVKoStwI1/OikUoiJTAiQeNHZzrX2
         41MV8bBnibgBfD99HNlm9KgA8VH+5CphWevpmqaWgHeqeb4x3iJsqy43KvZck85VvoLe
         WkyI/VBva+//TGHKuntNMr+JNtf4rbMeoMyOc8CYN8/vLU5ydsmoIA6Lvb3/BlwNBri7
         L/7Q==
X-Gm-Message-State: APjAAAWXEvOcMPGHDyV0tWilx7KLyWJMkFWxYV7K8H1nPo4KnvQWbJX4
        E+lUYoH5MCbmHw72a2gPLBA=
X-Google-Smtp-Source: APXvYqwwT93CRJa4E1zobDD7odgAbkjWITZXCmyEkFHpgxyLmhB3dllkCjhnWXfogkZpMI/yf2i94A==
X-Received: by 2002:a17:906:4ecc:: with SMTP id i12mr501758ejv.227.1581099783984;
        Fri, 07 Feb 2020 10:23:03 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id i26sm452051ejx.8.2020.02.07.10.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 10:23:03 -0800 (PST)
Subject: Re: [PATCH v2 6/9] ASoC: tegra: add Tegra186 based DSPK driver
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-7-git-send-email-spujar@nvidia.com>
 <f8ed8c4a-af40-44b2-b720-4d3a9b660fda@gmail.com>
 <75a63cb3-7d79-7216-6791-3cec57464cd9@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <847f4512-7118-e087-1004-685e476e11d8@gmail.com>
Date:   Fri, 7 Feb 2020 21:22:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <75a63cb3-7d79-7216-6791-3cec57464cd9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.02.2020 14:26, Sameer Pujar пишет:
> 
> 
> On 2/6/2020 10:45 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 30.01.2020 13:33, Sameer Pujar пишет:
>>> +static const struct dev_pm_ops tegra186_dspk_pm_ops = {
>>> +     SET_RUNTIME_PM_OPS(tegra186_dspk_runtime_suspend,
>>> +                        tegra186_dspk_runtime_resume, NULL)
>>> +     SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>>> +                                  pm_runtime_force_resume)
>>> +};
>> Could you please explain why drivers need the "late" system sleep?
> 
> It was done to ensure core drivers are suspended first and defer the
> codec driver suspend

Suspend order is opposite to the drivers registration order. If there is
no real problem with that, then you should use the default suspend
level. Please don't try to fix a non-existent problems.
