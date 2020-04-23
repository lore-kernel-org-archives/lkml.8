Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEE2C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3D720784
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOQaxwnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgDWXZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgDWXZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:25:52 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39885C09B042;
        Thu, 23 Apr 2020 16:25:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m2so6148049lfo.6;
        Thu, 23 Apr 2020 16:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E9KRQCDqxAF8SCbzQvjCVbo33PvnYBdovSuRnzrHi/c=;
        b=UOQaxwnOypHEkmUokdqjq9EpPZbuK7EwWL15XS/2STZBBznO0iCdZFxCmSO5hHluga
         mGYtwrxnQ2bcq0jIm6dEDd8YiUMWN2dP/xJQjiDZPZJSlS51qSb7pHUO/Xr6Z3XZOl2g
         QNxr1XF4z6YU1FO6eC3w2nB/M7uB/i2nPZUCfIRw72ritx/WqEbKD5oTzftyg7qmNxTD
         h9ugPG2SJbJgGEKLWeDDZ6ZDB9qg8gJKLcRo25t0p88eh3eiGxqvf9AOzkK85arOXzNy
         OMwYLjKS0W3sDArGG5NDaIE1/9eLU7AYimrr1z55md4ozg+GAuc10jKH+Qo0huh1G5pD
         b9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E9KRQCDqxAF8SCbzQvjCVbo33PvnYBdovSuRnzrHi/c=;
        b=QgnU1T9QDWZjSCJzJXaT985TB6Qw2xfZtT1a83LYNf/M924pUcpk7AT8wWsjLWiGV9
         RTkEKlvVuAiqh+IHAedwuIjxInYleh7jDMhOVUsstpwJ2EnIa8O4FDdTmb9e+CPQ7Hx3
         uS9keI+DblZEqtcBrMXlmM3ZUiN65qcBylkjJZOYOY405jAoXp3Be1fkrEiZ8qgVNFUw
         oACgaw8NGkX1K9kwbpklBGQ7k4WpgePcPsNe1OYnLwz8tDReFvmXixIp2QtURulixZHH
         qW6pB8mDHZ9O5PqBoJWeZMro6azt/Xt+swtYZhSwxyaqzy6YrGzCH/4x4/fJ8hWF8gRG
         Q3qg==
X-Gm-Message-State: AGi0PuZjDah5IpmmEv3IIyNB+6197aK/sWRRHytTZdfy97qq3h2iC1tG
        3VGhI+KVYWotCOEpfl2OHddm/zez
X-Google-Smtp-Source: APiQypJxxvu/bSWZzbAhl8wC+OWe9vqnGAvlnoBTzjRvhT35QS3gGs5JMiH0J9+AnAllv3hm4rHdhQ==
X-Received: by 2002:a19:550a:: with SMTP id n10mr3982776lfe.143.1587684350334;
        Thu, 23 Apr 2020 16:25:50 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id 12sm1836804ljq.0.2020.04.23.16.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 16:25:49 -0700 (PDT)
Subject: Re: [RFC PATCH v9 6/9] media: tegra: Add Tegra210 Video input driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        hverkuil@xs4all.nl, sakari.ailus@iki.fi, helen.koike@collabora.com
Cc:     sboyd@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1587536339-4030-1-git-send-email-skomatineni@nvidia.com>
 <1587536339-4030-7-git-send-email-skomatineni@nvidia.com>
 <7e473fa9-0409-d868-e818-2e7928a8acca@gmail.com>
 <a83bfc89-35de-85b5-fe5f-71e62456f5e9@nvidia.com>
 <3691c4b5-1ecc-2ad3-23ed-72ef6b8d25fa@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fce6dfbb-0b8d-319b-2d6f-976953a3c36c@gmail.com>
Date:   Fri, 24 Apr 2020 02:25:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3691c4b5-1ecc-2ad3-23ed-72ef6b8d25fa@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.04.2020 02:20, Sowjanya Komatineni пишет:
> 
> On 4/23/20 4:19 PM, Sowjanya Komatineni wrote:
>>
>> On 4/23/20 4:16 PM, Dmitry Osipenko wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> 22.04.2020 09:18, Sowjanya Komatineni пишет:
>>>> +static int chan_capture_kthread_start(void *data)
>>>> +{
>>>> +     struct tegra_vi_channel *chan = data;
>>>> +     struct tegra_channel_buffer *buf;
>>>> +     int err = 0;
>>>> +
>>>> +     set_freezable();
>>>> +
>>>> +     while (1) {
>>>> +             try_to_freeze();
>>>> +
>>>> +             wait_event_interruptible(chan->start_wait,
>>>> + !list_empty(&chan->capture) ||
>>>> +                                      kthread_should_stop());
>>>> +
>>>> +             if (kthread_should_stop())
>>>> +                     break;
>>>> +
>>>> +             /*
>>>> +              * Source is not streaming if error is non-zero.
>>>> +              * So, do not dequeue buffers on capture error.
>>>> +              */
>>>> +             if (err)
>>>> +                     continue;
>>> This will result in an endless loop, I suppose it wasn't the intention.
>>
>> no it will not. on error we report vb2_queue_error which will do
>> streaming stop request.
>>
>> So thread will be stopped on streaming stop request thru kthread stop
>> signal
> To be clear on error it reports vb2 queue error and waits for stop
> streaming to happen

If thread should exit on error, then it should do it on the actual
error. Otherwise it looks very error-prone.
