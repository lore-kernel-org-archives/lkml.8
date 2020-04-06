Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBA2C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB59D2072F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St5YRqDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgDFUhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:37:06 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40839 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFUhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 16:37:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so581686lfe.7;
        Mon, 06 Apr 2020 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nXizthaMTicKWla5rnFRaG/Dw6aG4Ur5ba/ZZmsNGZc=;
        b=St5YRqDp5+5eFgze+JRinOkicwqp60XJCW/C4jnB/NYZbG0km5zrFhqf3omlBICIKU
         DVPij5zOf0W3F7ZB4neHmAS6RGUHzjVGtAZCTtIa97UQ7PR0mixypFiIsScmCgw6Y5j1
         WjqS/N7CQF8XX0+mCAJqnuVtKkzU2Dygc9NkHM+dkGohvXCQmiSxKt+QlaZgYkMDwDDT
         Kh4Bj8oba5K24atz55YEdVyzOtGICT/RKTA3JFzOKxEiIkUCuWA7Jhj2Vty8orJSJTOI
         sUZjNYVA9AAw9Zps385jAy98hszxzNtwXFbBm72rVjvXR3U550Tf77qHM0ssbeNQXT+J
         YC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nXizthaMTicKWla5rnFRaG/Dw6aG4Ur5ba/ZZmsNGZc=;
        b=q7E33gL0DwnkDvUftCHfUOua8E8lwZCK82ChMGin8sM/LnjiUwqGGrYJdGX9HicEpo
         ZzjnEj68hF1W2v1EbcT2V6vaiK5Rts5C9gGSbNymZJmuZQxP5hDTgK6X8fUXf6Mcktus
         d8wXWyujdeTqQliycvkZoc1HPndVePNPPzXc+K4I1XU+OkVadM/beHsMwss2/Wz8TroS
         0Ld30gWKjB6XZTfrlp1N2lnL3cg5BNBWzT937kIYAf0/1tLe3ZuKNcZLqqjlYuLriHDc
         U9q3ICEpWjanHnk6nOgytOTXyGGKYD+ZPkMRGuAP2QKKC7icxgBJXTt7VdgRSRQAdIwD
         y68g==
X-Gm-Message-State: AGi0PuZ417ripz4QNCgP8ZwTQkC1bFzG+JM9mbNViTiT6YuT7wW8egS6
        WyMu080YnbX5e+A/+prNOIuPlN73
X-Google-Smtp-Source: APiQypIqBjCh4Y6h0QVZnWAfUa2J9a6gGenc8Dd5VL44VC1fz5tfmC8OgkT0pv1uNHlBfEQgOzlfuA==
X-Received: by 2002:a05:6512:443:: with SMTP id y3mr14509605lfk.166.1586205422648;
        Mon, 06 Apr 2020 13:37:02 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id 22sm10532792ljq.69.2020.04.06.13.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 13:37:02 -0700 (PDT)
Subject: Re: [RFC PATCH v6 6/9] media: tegra: Add Tegra210 Video input driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        hverkuil@xs4all.nl, sakari.ailus@iki.fi, helen.koike@collabora.com
Cc:     sboyd@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1585963507-12610-1-git-send-email-skomatineni@nvidia.com>
 <1585963507-12610-7-git-send-email-skomatineni@nvidia.com>
 <782c8c4e-f5c2-d75e-0410-757172dd3090@gmail.com>
 <ac225ff3-8de8-256c-7f81-0225b4153540@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <86bbcd55-fa13-5a35-e38b-c23745eafb87@gmail.com>
Date:   Mon, 6 Apr 2020 23:37:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ac225ff3-8de8-256c-7f81-0225b4153540@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.04.2020 23:20, Sowjanya Komatineni пишет:
> 
> On 4/6/20 1:02 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 04.04.2020 04:25, Sowjanya Komatineni пишет:
>> ...
>>> +static int chan_capture_kthread_start(void *data)
>>> +{
>>> +     struct tegra_vi_channel *chan = data;
>>> +     struct tegra_channel_buffer *buf;
>>> +     int err = 0;
>>> +     int caps_inflight;
>>> +
>>> +     set_freezable();
>>> +
>>> +     while (1) {
>>> +             try_to_freeze();
>>> +
>>> +             wait_event_interruptible(chan->start_wait,
>>> +                                      !list_empty(&chan->capture) ||
>>> +                                      kthread_should_stop());
>> Is it really okay that list_empty() isn't protected with a lock?
>>
>> Why wait_event is "interruptible"?
> 
> To allow it to sleep until wakeup on thread it to avoid constant
> checking for condition even when no buffers are ready, basically to
> prevent blocking.

So the "interrupt" is for getting event about kthread_should_stop(),
correct?


