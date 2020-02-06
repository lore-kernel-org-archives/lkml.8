Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95603C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1B821D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHh9IMna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBFQuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:50:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37795 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbgBFQuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:50:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id v17so6848069ljg.4;
        Thu, 06 Feb 2020 08:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rz0LRSNwEyC05fPXK6mf1Cdt7QThOLZZfr/HLHN5E7g=;
        b=PHh9IMnal7LVehy5NVdPWmSIXmBATvpNMGAAbJVB/LYFbsVpkutCxV7HTdv01UfUM2
         Tgqcr0tnHuPygnsjZxSUIKEhJPqMZlTMHKKlXV5yRr2c4PFe3FRnZ/m4kG5a9oksWZyX
         KcJ6RmKmk1wROM0LupA5vznlEhk7xKx/Tv5NzWBGlh5DkeVDYgQqnKpGH+Bd+tYai0go
         uYaQKOf0sTX+rPzllBIZPWlV9O90AoagdsiSeQwm4FVG5+sGuATmSsKDTGS7ReaEtcee
         jUHwezctnurbVLRlEd2PXktH1LzRGSupSzSpw5HqHh0ok9FR3+JtZQ3ICWK0PhXC4K5c
         GDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rz0LRSNwEyC05fPXK6mf1Cdt7QThOLZZfr/HLHN5E7g=;
        b=ezFfZOC6j4b2dw/gSYaTwNzvmqZ1Q6tFti4BdJo+jz4uw39MTt4sjIlSjtyrqWpj7J
         rXMFiaRjHnUDPp1TF+0SLtrdmRNbOLgNm/y3zxlZchLoN6MERhtyQZ1KUqgZNqo/SG7H
         loR57S3C39SNEJ/Sh8BP5O5/oslQg1t42ZS8B+2g/QzAKMvNEAjEStjzTmgzeESfa0kW
         q6XtOX9nqCJz3eaF63TG7ym87mNCCF8GPvqBrvXXFHtJhwwfTAl0AugATASkb9xG8OfB
         ywWcD/ky/nVtQ1M75K3cIMpsMaugC0OiX1oT0hTH8e0meT6YBKgRyVnVzsxwNfjin9F+
         bbeg==
X-Gm-Message-State: APjAAAXRDpcp1RzvGccw0bx/mrzag5oSu1PiZlCeWKaG9Pa30yWmrrc6
        dzs33ksjQEkNZ74xYuLHX2A=
X-Google-Smtp-Source: APXvYqylplfy+0XtZ/0fP3I86GFfK9ygbsHF33Fl6eXd5pn7p64WdygUib4gE2B5b9AxF0UhvOHYUg==
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr2481251ljj.206.1581007799031;
        Thu, 06 Feb 2020 08:49:59 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id s22sm1669570ljm.41.2020.02.06.08.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:49:58 -0800 (PST)
Subject: Re: [PATCH v2 2/9] ASoC: tegra: add support for CIF programming
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-3-git-send-email-spujar@nvidia.com>
 <7239e858-16b7-609f-c4e3-8135bee8450b@gmail.com>
 <1305a6db-a492-eec2-111e-ddc801d58d86@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fb0a96bd-ac3c-0916-0337-0c86de196527@gmail.com>
Date:   Thu, 6 Feb 2020 19:49:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1305a6db-a492-eec2-111e-ddc801d58d86@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2020 14:56, Sameer Pujar пишет:
> 
> 
> On 2/5/2020 10:32 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 30.01.2020 13:33, Sameer Pujar пишет:
>> ...
>>> +#include <linux/module.h>
>>> +#include <linux/regmap.h>
>>> +#include "tegra_cif.h"
>>> +
>>> +void tegra_set_cif(struct regmap *regmap, unsigned int reg,
>>> +                struct tegra_cif_conf *conf)
>>> +{
>>> +     unsigned int value;
>>> +
>>> +     value = (conf->threshold << TEGRA_ACIF_CTRL_FIFO_TH_SHIFT) |
>>> +             ((conf->audio_ch - 1) << TEGRA_ACIF_CTRL_AUDIO_CH_SHIFT) |
>>> +             ((conf->client_ch - 1) <<
>>> TEGRA_ACIF_CTRL_CLIENT_CH_SHIFT) |
>>> +             (conf->audio_bits << TEGRA_ACIF_CTRL_AUDIO_BITS_SHIFT) |
>>> +             (conf->client_bits << TEGRA_ACIF_CTRL_CLIENT_BITS_SHIFT) |
>>> +             (conf->expand << TEGRA_ACIF_CTRL_EXPAND_SHIFT) |
>>> +             (conf->stereo_conv << TEGRA_ACIF_CTRL_STEREO_CONV_SHIFT) |
>>> +             (conf->replicate << TEGRA_ACIF_CTRL_REPLICATE_SHIFT) |
>>> +             (conf->truncate << TEGRA_ACIF_CTRL_TRUNCATE_SHIFT) |
>>> +             (conf->mono_conv << TEGRA_ACIF_CTRL_MONO_CONV_SHIFT);
>>> +
>>> +     regmap_update_bits(regmap, reg, TEGRA_ACIF_UPDATE_MASK, value);
>>> +}
>>> +EXPORT_SYMBOL_GPL(tegra_set_cif);
>> Are you going to add more stuff into this source file later on?
> 
> Yes I plan to add Tegra30 and Tegra124 CIF functions in this. Anything
> related to CIF can be moved here.
>>
>> If not, then it's too much to have a separate driver module just for a
>> single tiny function, you should move it into the header file (make it
>> inline).
> 

You should consider whether it's worth to move anything else to this
module first, because if the functions are not reusable by the drivers,
then the movement won't bring any benefits and final result could be
negative in regards to the code's organization.

I suggest to start clean and easy, without the driver module. You will
be able to factor code into module later on, once there will a real need
to do that.
