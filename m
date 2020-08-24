Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC58EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C33482075B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yIT/7UWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgHXJgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgHXJgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:36:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB620C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:35:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x5so7660663wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a+qBqva1TzYQ5RnHnuZAT29wnXZU/+xs6tKfmNJfO0E=;
        b=yIT/7UWxUOXMSG5UryvbaY1Ck/9X1LWrS3GIdFRp7f9jKp1MojafFO7SlcdTqycmN9
         YOkAdQNb6x3hxaPpMyoC6HBnpKa+TPMoPrX4v5Bx8e/0rcQzz3rwDAwlVJ9ySDjdHa8P
         gxl+Alxxd3oh++LTDkXFX07MCvPy9AOHsxRLS33TQLbbJK98OjqhxguOU8kmCKbfGl+i
         SZFZAy1V1zlQbTGkiwk+ZVCmCR7cij4liuYQ5vCKnbkQeQdxp0gb3tZq9i0Cc0HS+JK3
         MvIYTmlkUcRDJSLOk1loa7GDDg3VUqTL4VEyL5Wu1q2wZdV4rpTx19Z4K0IQWg7MxPGC
         D+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a+qBqva1TzYQ5RnHnuZAT29wnXZU/+xs6tKfmNJfO0E=;
        b=p6prSnFklY9/aSyOQASKB5DWfKUVxrNrPSlhe2AjpZTDP2DLz9i2290AhxK70FvY7R
         uuZrscT3lgaeYZAqA+wMOSt2Lude6CEl36wadkPxU8HApWrcmjyp7g6OArzwOcirEE2I
         K6HMNZJP9YFvglEoOvFAR+VFABulW5WAvxnYA++3GvbDE9HkWQPQ8e6+5BTEwykXinI7
         hfb/XfvTF6ILOEJTFMalCN2EUmLt9L3KAftm+jgAHYO86Sjt+WR015OcypQrlZ/dydaC
         IedSuvDKcUAXoBlDfnMOVhc+cG1nz8YPms5IqRjJ+a+7h4iteyE7hSWX+DY9edojq5Xl
         +YVw==
X-Gm-Message-State: AOAM530fyzTZNpDyypPydeCwgZgWJNe1RUDLfD0mlMIqYnszeTcHdhPl
        C1uawMg9NhtW+fLCNtOJ0vSx9A==
X-Google-Smtp-Source: ABdhPJzIc6QSoUS9oxZsc9VLLMmsA6P6cy+Q5aHgP/cOCZLdV9bKWS8FvvqVA6WEuOaSKYKDEZPY4A==
X-Received: by 2002:a1c:f017:: with SMTP id a23mr4668754wmb.164.1598261758453;
        Mon, 24 Aug 2020 02:35:58 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0? ([2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0])
        by smtp.googlemail.com with ESMTPSA id f6sm30504901wme.32.2020.08.24.02.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 02:35:58 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/timer-gx6605s: Fixup counter reload
To:     guoren@kernel.org
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1597735877-71115-1-git-send-email-guoren@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8fae0fad-4211-61fa-b687-0eca4bffbdaf@linaro.org>
Date:   Mon, 24 Aug 2020 11:35:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597735877-71115-1-git-send-email-guoren@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2020 09:31, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> When the timer counts to the upper limit, an overflow interrupt is
> generated, and the count is reset with the value in the TIME_INI
> register. But the software expects to start counting from 0 when
> the count overflows, so it forces TIME_INI to 0 to solve the
> potential interrupt storm problem.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Tested-by: Xu Kai <xukai@nationalchip.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
