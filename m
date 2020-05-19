Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB64C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B38207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eq23zFrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgESQAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbgESQAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:00:45 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F55C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:00:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i15so16459272wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZgDKc3HEYEnyhOTY+wQvny/RRZ2rvIz9Ed6CzUywMNk=;
        b=Eq23zFrKqsJEF7WMk37RL9HDAg5eeAfNuJoLllOPXJZq5k3oneQ1YtMrHYsi4z39AL
         o4cJg/JHwMEUVYwWSoezsqcaXsMxGYv+nDOdlVBMgUI2MkOroGxR1QrYvy6VNMFqSnkM
         Xn+a2BnBAYcDYuYI8d1EdoYk8lxCoqkVhukHJSji8Q++Ywzqdt2eHIFg9K8GqFQ2R9Dg
         NnRYperS/dEp68p/jHcIdzoGjMVcCbW9I96vR/+S5CKl9kqL74rUj6nLWaAe/XWkILlv
         ngsJFGKW4rS0GS9ODLBTp7vdAJQGkQeque5riA0PgYITWqi2BRO847/Y1hNCfxaC5Cts
         UzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZgDKc3HEYEnyhOTY+wQvny/RRZ2rvIz9Ed6CzUywMNk=;
        b=RqRMqcJRX7U/Rc+K0MdfjkAVHTvqtYCbaq5iaaj2ADew4QIldv4/eBIOlbrGjnBIgC
         PHmCMzxQ6HvAKbf83U8CnBf9qsqcNjdWhliI5SmMYfYckivnR8iP66A6ne/SM6Xgceki
         L+zR6CsOeuiW/Wm3sUY6+dFUOja2jzzsEAVlm2PQ0DSsagTkCOIiEZ29/8N/u3t6VgBk
         nocC0RfuKCa2ZuCfqfCxPElSt7PhHDgnlrMo4yGHswvlF2phAKJe8OeAoIc8uloO2++c
         04blqYTFu3m9SXtorHPRC8/4ZHM8o6asKHqdepsY06Lu/ji9WquognEpAwEMO8yioXIV
         bupA==
X-Gm-Message-State: AOAM533xR1hmnJOui6lpnCqczAJ3egJWee0VH18KrqhrL3XwbWdzk3ef
        sSjdttrqruMuSQenAH/SJk/oqA==
X-Google-Smtp-Source: ABdhPJxGVpesohvaaRIa7+vBgDYIMXNEEmp86gTxM/Sz51g4e2Mut4SoxAPLfwG5D/qKdaXzK/rZ9g==
X-Received: by 2002:adf:e951:: with SMTP id m17mr26966121wrn.352.1589904042372;
        Tue, 19 May 2020 09:00:42 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e504:4297:986:ffb0? ([2a01:e34:ed2f:f020:e504:4297:986:ffb0])
        by smtp.googlemail.com with ESMTPSA id c17sm21759979wrn.59.2020.05.19.09.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 09:00:41 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Fix warning for set but
 not used
To:     Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kbuild test robot <lkp@intel.com>
References: <20200519155157.12804-1-tony@atomide.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2f67a110-e52f-94fc-fae2-c3171a67bb8a@linaro.org>
Date:   Tue, 19 May 2020 18:00:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519155157.12804-1-tony@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2020 17:51, Tony Lindgren wrote:
> We can get a warning for dmtimer_clocksource_init() with 'pa' set but
> not used. This was used in the earlier revisions of the code but no
> longer needed, so let's remove the unused pa and of_translate_address().
> Let's also do it for dmtimer_clockevent_init() that has a similar issue.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
