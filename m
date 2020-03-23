Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB68C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0138020637
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnrXSUpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCWQF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:05:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36775 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgCWQF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:05:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id g12so15212597ljj.3;
        Mon, 23 Mar 2020 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E5FPfWElFKdMpZuvQ9h2jaYCgsUPtm/4IuEU5E0aiwA=;
        b=OnrXSUptfAUolkAuOXhiZeTpTm8ihay0iQKBsP3Kd/dLGggrA1xtTPVI0Rgw2fCYXE
         iFEnxMki/UGXNKKOKs80goGAZ65RfvVxSUrMwyPb5KDSnpvFUrQ/Bw8s9qouc3OCVbJC
         /8oF4FV+HiB+E5d4Q7gHX2DktkCNR0wrHs6x5arcC319JecRoRLS4tHpvgxsNmLFDntZ
         A/bbpAx25k+hhK0qucX+RFWPbHGvxI3+IBY3r6+VFWKCYzxKxUjumeMgmMYzGYHerZ5Q
         g95YVOMXMz9d+h+yAwwY6FW8t0yTs3jSmYaJH5ziagHNeik+wYpuNASDNwBPkQUMjON0
         kWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E5FPfWElFKdMpZuvQ9h2jaYCgsUPtm/4IuEU5E0aiwA=;
        b=nTUJl7BqG5Ef6sMp7GMmNMNnjQcrTzSgRxFgh0GoyCQBSy1uLC3O7Di8C7Q4FvOxeB
         BpHk11x8iq3uTNs9BiKHmud7Jqb6Rpc9shyC5eazFeYiReu1D17kEZWygWvkv2luTdbe
         7QWV30BtXpexpUi/OQQ1Y8CPV6yJVj9q4vvBK1RFd8DrSiME1UK5NRuEm8ujZaygH2x2
         OEcpplrjWPCaGCxvzu6BXS6zaK0eqM94wXostRZFg5EALStR3X91Atfk+bbRXPmXpzJh
         LzfN2ZIae47QFYLeuwNZ/MZDY60JU2JjcT3cb6iqhnut3KndD9ezkQtGc1yHLubyuuk5
         OTJw==
X-Gm-Message-State: ANhLgQ2DS05uJWPaOWR4DZz/MqUeKhAtHwzP7GJnUq31ceAjdvZBEC2z
        L/gKqrmyExZWVKik/7mhL3Rtq0HJ
X-Google-Smtp-Source: ADFU+vs/52TdNiAJfdd41fBWuyLzmoaHbR0mqPud/4CTPhvMMKxvtjN9OkjWJMiXDjzMGMQp1+xibg==
X-Received: by 2002:a2e:9982:: with SMTP id w2mr14229389lji.11.1584979525397;
        Mon, 23 Mar 2020 09:05:25 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id c13sm941220ljj.37.2020.03.23.09.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 09:05:24 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] Support built-in Mic on Tegra boards that use
 WM8903
To:     Jon Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-tegra@vger.kernel.org
References: <20200320205504.30466-1-digetx@gmail.com>
 <c27c2087-14cf-614d-a8c0-05072a54f24b@wwwdotorg.org>
 <da88ddff-e665-8cee-6f03-1a396602b076@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8b7a8eb3-98ed-71cb-5bd7-9c784ec24d68@gmail.com>
Date:   Mon, 23 Mar 2020 19:05:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <da88ddff-e665-8cee-6f03-1a396602b076@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.03.2020 18:59, Jon Hunter пишет:
> 
> 
> On 20/03/2020 22:30, Stephen Warren wrote:
>> On 3/20/20 2:55 PM, Dmitry Osipenko wrote:
>>> Hello,
>>>
>>> This small series adds audio route for built-in microphone on NVIDIA Tegra
>>> boards that use WM8903 CODEC. In particular this is needed in order to unmute
>>> internal microphone on Acer A500 tablet device. I'm planning to send out the
>>> device tree for the A500 for 5.8, so will be nice to get the microphone
>>> sorted out. Please review and apply, thanks in advance.
>>
>> It's been a long time since I looked at this code, but the series looks
>> plausible,
>> Acked-by: Stephen Warren <swarren@nvidia.com>
>>
>> (I wonder why machine->gpio_int_mic_en was already parse but never used!)
> 
> Looking at the ventana schematics, it appears that the internal-mic
> signals was connected to a header and not an actual mic, so maybe we
> never had a proper internal-mic on any board but allowed one to be
> connected.

I guess cardhu may have a mic, judging by downstream kernel sources (I
don't have cardhu schematics).

> Anyway, looks good to me as well.
> 
> Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
