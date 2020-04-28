Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE58C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C030820575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cBftCMNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgD1Szx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728913AbgD1Sb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:31:58 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0C4C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:31:57 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f13so25822743wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T4aY7SsGeGGlUnAvLytvyfsEd/infPH0ib2GDQYAca0=;
        b=cBftCMNiCqKAeas54VnN7viiIAfa5EJgrd35ITaFFqmxrziSmZj2jJzUWPCAXCLRC7
         awNd6HJqFM8xaHwiTVtc+sLsz9Lm6ae66v4KS5EIIyCzn9uqsmgwutBKfMJe+HdJfPOx
         eMe4mk0ZequzNTm2KPSA2zzDlHLUVmpLM+Fo8MkWMo+tLB6s+x+9Cr+KkESmTZJe1dEB
         e2e7SqHxlFavONFS6/vulJX4pypYwM8G27PejWzUzh6oMt1KeNh26G44tk3byx2YXJab
         NrOTV9Fzv8SpPae0hR3DRuGuWDdgYteR1DQp6cK48lIBvUgOQTsNJx381T4hb58d67M6
         ih+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T4aY7SsGeGGlUnAvLytvyfsEd/infPH0ib2GDQYAca0=;
        b=HseJORPECnxRSVLOfQ4wLUS/FdJmfLddUx4zVVPOt6rAVZYk+8iorAJGn0JqfGnd/v
         xv4f/0prycVKy3vwG7uQu76dcEkXQc7Ln5Dgx0Ygfe9LBlYJwK5d+IVBD5hVdNpd7QK8
         6A2oIydfsol2ArfGdvjiOPcC4eESUJLzvzogobPBsKA1mlrJYG02bPeIx8E5QhkhArlJ
         KjEsp7RMuyKr6ua0Gwzn5PLn1hySCnCtBrwB5NjEcz/wvZG4ZgYnnffQH7327jlj/z5y
         LpJmXuXB9VuM/C9vtfatV2CXbKgPoU007nlkfb5JBrnP/RkBC8aXRXQ94LGwdqIXuEA7
         XF1Q==
X-Gm-Message-State: AGi0PuYHzHKH3orAnZBs/8gxOBqfUZJ3jl1cj1clKDZkqzhFDqnF+WQ6
        3WVFDncT6SlKtp/7+y3i/tXl4Q==
X-Google-Smtp-Source: APiQypIcTV0jARth4etalPFOSqyN1yL0YRWUnf3fCeXNMXPjWOlzQUOAOyGClS/2GttKoNnGb4Fx8Q==
X-Received: by 2002:adf:8441:: with SMTP id 59mr35982612wrf.237.1588098716404;
        Tue, 28 Apr 2020 11:31:56 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id m8sm27877197wrx.54.2020.04.28.11.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 11:31:55 -0700 (PDT)
Subject: Re: [PATCH 1/2] drivers/clocksource/timer-of: Remove __init markings
To:     Saravana Kannan <saravanak@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Sandeep Patil <sspatil@android.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
 <CADBw62pmiguVmuq334eskLAZ5CkrjxohW_fXNjNev+O1U15=OQ@mail.gmail.com>
 <bd800f7b-05fd-b393-fba6-1965ba89e1b3@linaro.org>
 <CAGETcx9da-U+dXA6sreTKJQiS3brYh3Hfh_qVYt06=3UOSmT_g@mail.gmail.com>
 <429da47b-ad51-30eb-ff36-b05780c941ba@linaro.org>
 <CAGETcx9sc6oWSPK=aWJ+39i9eHAyg6iOf+Xf2oVECO+g1pFjtQ@mail.gmail.com>
 <573b7d9e-fb5d-5c81-a981-6d965db933f3@linaro.org>
 <20200427221752.GA166576@google.com>
 <7c508403-3b53-8285-5724-c2bca221b77a@linaro.org>
 <CAGETcx_peaPtmjF4s0iR6ObZ=f76EjaMOokyBYM3a7AX-8_ong@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <da25dc33-addb-298d-103a-fcf1cf0e6793@linaro.org>
Date:   Tue, 28 Apr 2020 20:31:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx_peaPtmjF4s0iR6ObZ=f76EjaMOokyBYM3a7AX-8_ong@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2020 20:23, Saravana Kannan wrote:
> On Tue, Apr 28, 2020 at 12:02 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Saravana,
> 
> You were replying to Sandeep :)

Oh, right :)

Sorry Sandeep. Thanks for taking the time to elaborate a clear statement
of the GKI.

[ ... ]

>> That was my understanding of the GKI, thanks for confirming.
>>
>> Putting apart the non-technical aspect of these changes, the benefit I
>> see is the memory usage optimization regarding the single kernel image.
>>
>> With the ARM64 defconfig, multiple platforms and their corresponding
>> drivers are compiled-in. It results in a big kernel image which fails to
>> load because of overlapping on DT load address (or something else). When
>> that is detected, it is fine to adjust the load addresses, otherwise it
>> is painful to narrow down the root cause.
>>
>> In order to prevent this, we have to customize the defconfig each
>> version release.
> 
> Sorry, I'm not sure I understand where you are going with this. Are
> you agreeing to pick up this change?

Right. I agree with the change but I would like to have Thomas opinion
on this before picking the patch.

Thomas ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
