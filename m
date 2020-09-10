Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5E6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1287421556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKVS6dK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgIJTlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731316AbgIJPgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:36:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2217C06138E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:36:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so4853063pfi.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+NphFAz+bbbGOLPoViKWvapYAGN08JtmjYnLzZIKOxo=;
        b=GKVS6dK77bx/0jZLujlXrhsPEnEfKJjffubPbjyONPpDBt8aKV+/WikhO98lFUcqBg
         fknNlKQUgg0UcuMI4rvH6oQicx7azui4MD9+lZC8HzP87Vi4TbpnL5wsy+KtaRvsh2LC
         56er56VCnPG1cwnDpL+FZu4sdinoEO6m0lag595MpAp4J3HgJxKTp/ftgfAClZ5xpG9e
         IGh4od5fDmnNKVRLqhekiwgA0ji4hW/l6rP7Ub0rdSacgB+QsToPnSt5fJEOro/bh0y5
         tfWDEo6mZ+GCGnCsbnFxd4FHFyfq+MjpuaQe3PdZTqbmYXIk7DHpN7njMs/8y0p1rs/E
         iOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+NphFAz+bbbGOLPoViKWvapYAGN08JtmjYnLzZIKOxo=;
        b=LDxbVRX/9O6Ak8TXqgctU2zsmxggeRzdSOCBjtTahYK8aGhDiemCMvRqFd15DLfql5
         1Mrx/r1SVvg+PsQAI2QY2X9UjOFmaCxEXPqGp/5DV5jFjbBOqdNGqkkgAVbGnHfa7qyR
         GZyxQfyKcYGXDQUjZmNfvxvNRkZj4kWXgcxyNMF3QAw78Y8+j9yER/SSCphOsEHfO7fz
         1ane7AUQeqm/1nXgemBR666+PMihDrUTJSoF33uS4aKGWJiAdeBOFcSwQi60JuUiIjVc
         8mR/Zdx0xwtrQF8HyD3MQkfjezH3rqO0y/LZPhJyTSZOUzP71q3LTPUa1M0dEN6Nm47f
         4DVg==
X-Gm-Message-State: AOAM530VoUJL4fY0yBiSHfpbup8Nfm7tigEByG0UPHVgXvDk8h1N3Z4A
        6B0Qqbk7sN2wCpYdKrrOG1XvmA==
X-Google-Smtp-Source: ABdhPJxIZ4y5XTc4IrXUnrqP73HVFyQx7PSmSplY3yEEr1jJKnjEfVZhyGyxvSD2g5MX5wlOI8kPiA==
X-Received: by 2002:aa7:8bd4:0:b029:13c:1611:6538 with SMTP id s20-20020aa78bd40000b029013c16116538mr6137309pfd.10.1599752207202;
        Thu, 10 Sep 2020 08:36:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
        by smtp.gmail.com with ESMTPSA id s187sm6690150pfc.134.2020.09.10.08.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 08:36:46 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
To:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Peter Maydell <Peter.Maydell@arm.com>,
        Haibo Xu <Haibo.Xu@arm.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <8e661984-70bc-790c-8636-39dcd8b00131@linaro.org>
 <842807ac-562a-36ce-8061-aa323341b605@arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c6043c5c-4bf1-e42c-1337-a892e6fd7402@linaro.org>
Date:   Thu, 10 Sep 2020 08:36:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <842807ac-562a-36ce-8061-aa323341b605@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/20 3:24 AM, Steven Price wrote:
> It is a shame, however I suspect this is because to use those instructions you
> need to know the block size held in GMID_EL1. And at least in theory that could
> vary between CPUs.

Which is no different from having to read DCZID_EL0 in order to implement
memset, in my opinion.  But, whatever.


> When we have some real hardware it would be worth profiling this. At the moment
> I've no idea whether the kernel entry overhead would make such an interface
> useful from a performance perspective or not.

Yep.


r~
