Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEC9C35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9773C21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUjft++C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBGSZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:25:46 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43568 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgBGSZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:25:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id dc19so503672edb.10;
        Fri, 07 Feb 2020 10:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GMiZo8m6MVwteC6MTZZKLG6FimFuIinamHp+P+KB9FQ=;
        b=mUjft++CBTt8AY80NHTjS5UiGF6uZzqJ3gy2o49fQU4PnoKfCu4IEwEQYdrXH+5XwP
         u7E2bN4mIOO/YZ88FwT0gmMwwabzhE7a96vAcQL+umRxmXlh3M0oaN7oJ7xyUF73rE5h
         nv0jIE5TZldSEs8X3pEHGG2LTUmmur5JgSsOT+YG5QAHKCqDtRPSQzmV2cSnHIumhhqw
         w1Gi2F4uIp4EItav1Verw+mqidD9pAf63TpEU45IFe0QxS7GyilJwXuZU/UX2/cvTE7X
         xT2eyZ3xEEpSiQyz/wfIXlcITyW250WsMg9Z9y/fgsnSYbmmaWC32pmooOM/yu5rQgNq
         C86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GMiZo8m6MVwteC6MTZZKLG6FimFuIinamHp+P+KB9FQ=;
        b=fc3U7a5Tzkg3d6lV0BIgVrRl9nI4WKpy8fN+BNQW2LDhwMNPb9NiL8WeK3X1ueSXR7
         xR5LQ30kCda7Od4J5O2633QM4c9rbHceL2A9BgprLkTtyk4ngFxI57NgEillU1KXBEIM
         +Z1MQUbtu0nR/1+xGMys97IbaD0zybu8ZRU+mRUs7ESFbf25Dr5787QIFVo2M7KWi0KI
         +7oqb1JRLNGIndClGn8thcrL59nlWksC/Yrdjea5YMVYje8ZDzheoB0eM4zl15Nww+KE
         zmKPYOqDlcJ58TcHQafrn03K4gbQ4gt+LlqVEM0W8JiCNq6WjVq0DvTApHhp//yRLDZ4
         CS/Q==
X-Gm-Message-State: APjAAAU6+VFIet2HJap8mAXDivL6f3b5FXMuBx9Se8Aus0m+lxiRRZa+
        13E2kOO9AyPJ3YI5qJELQiA=
X-Google-Smtp-Source: APXvYqw49WYYptXF2zK5xUtZHkEq6r6YXGLC4FRv/vjzsmj8o/wuALuNtCAWaKdWWXv/Vj7W5EaEaQ==
X-Received: by 2002:aa7:c71a:: with SMTP id i26mr203017edq.300.1581099943747;
        Fri, 07 Feb 2020 10:25:43 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e24sm208276edy.93.2020.02.07.10.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 10:25:43 -0800 (PST)
Subject: Re: [PATCH v2 0/9] add ASoC components for AHUB
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <fcab0af1-fe84-6028-701b-ab101feaa8de@gmail.com>
 <d17b2654-a888-8251-468d-12ef1451cd4b@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <40a4d544-7c33-3f28-0b9c-384bc9fe3b53@gmail.com>
Date:   Fri, 7 Feb 2020 21:25:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <d17b2654-a888-8251-468d-12ef1451cd4b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.02.2020 14:30, Sameer Pujar пишет:
> 
> 
> On 2/6/2020 11:06 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 30.01.2020 13:33, Sameer Pujar пишет:
>> ...
>>>   sound/soc/tegra/Kconfig                            |  56 ++
>> Probably won't hurt to enable the new drivers in the
>> arch/arm64/configs/defconfig?
> 
> Do you mean, if drivers can be enabled?

Yes, I mean to enable them in the default kernel configuration.
