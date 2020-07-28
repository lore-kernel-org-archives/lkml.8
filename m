Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E4EC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4657206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnA2DYGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgG1InZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgG1InZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:43:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13EAC0619D5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:43:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x5so15947850wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6s5ORi0rHPtJiGgGsf/ouNzzeGn7KDq9L2gBSCc9Ezc=;
        b=dnA2DYGICyIMtS9q/uuEQCU7oYl3dh7IssuLenQcpsOLQ4ufUqQLb+HeaRZ/6b7u95
         cjxbV6DKy7GjHcu/leVmxG2RFPnpuXka8Z8UMQcbJ0aZcESZBIUvBYlxsZCfyOGKjVCS
         6NJ2N7YtjOFVJ5DDC0qClASK03IHqx8fJ+iktndvYiCxETw31bpfXGuYthPUTvRyy5tC
         j0BbjlgaZWi9iFzL76njvje8rnPRneK3S1n0P2ZpqoApvRdel/5TM86fklzNCgIZyODi
         3iqnrw6qpeE/lZHW43EBua5wcbzK5JClgMCn9a+8O5mKDUGjvUDJWArMB++iVluLjYOZ
         /M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6s5ORi0rHPtJiGgGsf/ouNzzeGn7KDq9L2gBSCc9Ezc=;
        b=CDOw7Nou3tY3MvquJWDB+JLBYpA//o75+vuR+kcTdkBthCRgbczOT7g15aDiHxTEbp
         NYUEedlechc1/omf86WrehfINlYwD6ZF1vWtC0Pqg0RHfrNNsDpnMbBSyLuz9f3scZXP
         p84Zt3H7OGFKbw6YQ9FyIrDaE3Vh2Lo4IiLFrLieNPg8x7IoekREErGKPi91T6AsP2SB
         ZVwzgoVLhFRCpzRTRGLaRTA0QAROgqZP3Wn7Gv048JIxBazctYdlCrfhkzxEuhjDP6th
         suN75a6IcBzAu+G2iQMnBEqelg0YFK9x0vS0w1CoN6aZmj7kOVV6qiR0CCezh53mUXIx
         hMfw==
X-Gm-Message-State: AOAM532z6wDeHEq+cAnv4WxiUgztuYjlQ7yVFrISbVCCUD+bwwiovUMx
        4tmUgSqe5BqyMUEgmzO7yy9ls2nt25W4wQ==
X-Google-Smtp-Source: ABdhPJwwu+F18+gwleovwZF0jYfx83SPzzBo/k68WX1LsAIkA5fzwkyv9D+UKxc72HZS9XNXCFWMAw==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr3146752wmi.161.1595925801819;
        Tue, 28 Jul 2020 01:43:21 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:19cd:2f7:8a44:adc5? ([2a01:e34:ed2f:f020:19cd:2f7:8a44:adc5])
        by smtp.googlemail.com with ESMTPSA id 33sm17393234wri.16.2020.07.28.01.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 01:43:21 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: update entry to thermal governors file name
 prefixing
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200728045850.22661-1-lukas.bulwahn@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d50f49c2-4d88-74f7-29e9-963b806c602e@linaro.org>
Date:   Tue, 28 Jul 2020 10:43:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728045850.22661-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2020 06:58, Lukas Bulwahn wrote:
> Commit 0015d9a2a727 ("thermal/governors: Prefix all source files with
> gov_") renamed power_allocator.c to gov_power_allocator.c in
> ./drivers/thermal amongst some other file renames, but missed to adjust
> the MAINTAINERS entry.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>   warning: no file matches    F:    drivers/thermal/power_allocator.c
> 
> Update the file entry in MAINTAINERS to the new file name.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---


Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
