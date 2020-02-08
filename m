Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98844C352A1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 16:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E96F22522
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 16:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsLTdWXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBHQTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 11:19:32 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37933 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgBHQTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 11:19:31 -0500
Received: by mail-ed1-f65.google.com with SMTP id p23so3106933edr.5;
        Sat, 08 Feb 2020 08:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mv9CXRSXinT9pUfCdHcC8w/h9QEiS/MWjIBy22YGISM=;
        b=IsLTdWXitIJnPxQXm5N2vrrx0+APBrwkC/lnKsI+ChUKkiUEiVVPn248x6uc4OOL2B
         WhKCF0Us5CQF4bS5ItrgRSGtz9T37DVULgpurgkW0f65s6bwZAJlNpqmFcd8DsMy7Wbv
         O0ov72kMYwoxQT01discBEfj5U5fnYzFv0sANSzzWctL4Ql+cqDht5KvCvIio5uFpJkQ
         C9MrdLSykbv6TfVl5DDD7At4PosJU2zbgrckyvESDCRYYXuGg5jFfcb8gv3FY1kwS183
         3Ur14qf7IMKVGdWpcdFXWG+1Z9RYSMBHv5CAj16blJMb/E7RM0Lsm6ZSl1qFFOcdWymd
         g3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mv9CXRSXinT9pUfCdHcC8w/h9QEiS/MWjIBy22YGISM=;
        b=NM2n8xmcGQm7E0GV5qpIuTBBW2ggdMW7QsU+rtcT8EMktvk0ApbWG5KQoTIGTC12PJ
         TRrifM0LVJDtA68ehMvdAxKNCexKTOMHmDUgkuKQD6510dbvWabMnBaKOu0bBVyS78un
         QqWApQ43qK+8621B2KsVFPNfzq5Et0WT49Wx3mGdk1wY7nyEl9wjE4LYu4nt5CzCXFFC
         vrfEkgbJQctTYhRvM/5vdpTABc3z3WLjROgWtBmAavnmpcy2ywtl2MRRYhykWowt6aE0
         WTb3dm+O2UrY6SfATrgdPRiYfax3YOrJpIEa7SIG3XybErW7XU9Ey5EY+yyD1vuaYj5d
         ghlQ==
X-Gm-Message-State: APjAAAURpF0AToEqGC50WRrRALggsRIZ8n7OWKByqiACqJ4SyHCt05A/
        MV1GZX6G80/Ozqwx4wvRR30=
X-Google-Smtp-Source: APXvYqxFBrwSNHP8rHVNvl1+mdeTMxa3S7krUi5FWVenbML3btPUFFaRm+GkItM8LB7NGYZjrmgBFQ==
X-Received: by 2002:a17:906:2596:: with SMTP id m22mr4635957ejb.167.1581178769061;
        Sat, 08 Feb 2020 08:19:29 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id w18sm717049eja.57.2020.02.08.08.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2020 08:19:28 -0800 (PST)
Subject: Re: [PATCH v2 3/9] ASoC: tegra: add Tegra210 based DMIC driver
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-4-git-send-email-spujar@nvidia.com>
 <9ada4090-169e-0767-db5d-739f6e621812@gmail.com>
 <3e89e75d-2f5a-dc42-98f7-8e1262afe380@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b635bf45-f61e-266e-89bd-2b57ed47a807@gmail.com>
Date:   Sat, 8 Feb 2020 19:19:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <3e89e75d-2f5a-dc42-98f7-8e1262afe380@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.02.2020 14:06, Sameer Pujar пишет:
> 
> 
> On 2/6/2020 10:23 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 30.01.2020 13:33, Sameer Pujar пишет:
>> ...
>>> +static const struct reg_default tegra210_dmic_reg_defaults[] = {
>>> +     { TEGRA210_DMIC_TX_INT_MASK, 0x00000001},
>>> +     { TEGRA210_DMIC_TX_CIF_CTRL, 0x00007700},
>>> +     { TEGRA210_DMIC_CG, 0x1},
>>> +     { TEGRA210_DMIC_CTRL, 0x00000301},
>>> +     /* Below enables all filters - DCR, LP and SC */
>>> +     { TEGRA210_DMIC_DBG_CTRL, 0xe },
>>> +     /* Below as per latest POR value */
>>> +     { TEGRA210_DMIC_DCR_BIQUAD_0_COEF_4, 0x0},
>>> +     /* LP filter is configured for pass through and used to apply
>>> gain */
>>> +     { TEGRA210_DMIC_LP_BIQUAD_0_COEF_0, 0x00800000},
>>> +     { TEGRA210_DMIC_LP_BIQUAD_0_COEF_1, 0x0},
>>> +     { TEGRA210_DMIC_LP_BIQUAD_0_COEF_2, 0x0},
>>> +     { TEGRA210_DMIC_LP_BIQUAD_0_COEF_3, 0x0},
>>> +     { TEGRA210_DMIC_LP_BIQUAD_0_COEF_4, 0x0},
>>> +     { TEGRA210_DMIC_LP_BIQUAD_1_COEF_0, 0x00800000},
>>> +     { TEGRA210_DMIC_LP_BIQUAD_1_COEF_1, 0x0},
>>> +     { TEGRA210_DMIC_LP_BIQUAD_1_COEF_2, 0x0},
>>> +     { TEGRA210_DMIC_LP_BIQUAD_1_COEF_3, 0x0},
>>> +     { TEGRA210_DMIC_LP_BIQUAD_1_COEF_4, 0x0},
>>> +};
>> I'd add a space on the right side of `}`, for consistency with the left.
> 
> Do you mean like this?
> { TEGRA210_DMIC_TX_INT_MASK, 0x00000001 },
> { TEGRA210_DMIC_TX_CIF_CTRL, 0x00007700 },
>     . . .

Yes
