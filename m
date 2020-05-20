Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0F1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E05207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZoRwbr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgETNmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgETNmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:42:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBF4C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 06:42:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f134so2586578wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=efHK0heU4u9WESqVZnTHKTlmxXTjN8bkm8eZD21cGM4=;
        b=tZoRwbr4ohqTaH4zK+LndEcka8bIwk/1CAJHJZAhOiYlqjao3Da0CALFxao/kyGrar
         hhJcVPMkCOVh0bmUj5FDihn+pjhIjhaO/LPbUr0pyMIlidxl+n3D2DeEI3fNDRfCCT56
         yZQuNDgQQX0iKoGMCo7WxP0BJBHsYi5rg5oi/2bFERWaPA99JXVOhry5FIUQHr/Lows7
         cgWU+gNG+5WB7KYZb0dVzZvep5ZF1RZNnD1mybrRRbiSEXNZdzJu+1B2WDVAMnTeEBYQ
         OSNhuGBtCgae2v5xTHfpJoFZKIZ0ZQiiKxT9FD2ypRE3Z0Kd56pHQw6eTk5lhAuAmr0N
         860Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=efHK0heU4u9WESqVZnTHKTlmxXTjN8bkm8eZD21cGM4=;
        b=JuwAf/A7BvQFGPl7kHW/28OvizLlvT9fR47rJPt3q2dQ0a4nrO//sbmE52gQS2vmKo
         wZfRVpSuSzye37C2FgKiltaG7YXAntrvXt4eYZQr7e36LZxEEa75cvHtt9warLVkStPK
         lJfG4C1XAs4rZYkEPU0fOP8Lis/wzxrLq9XBntNnOfisZzN8KMo+rHeqsf9M2E4D5XfZ
         XqFsJK8MRVrTYUpTb/SlIE3nLQMv8hZ0Ep8dCNmeOV1LkwdSx4NXR5j95TmeTITQ6Ip7
         3YbuAJpY7tNLr+KL4CAaIWxObqBQ9hoWVjCuof5AEmZsDY/HWT/GigTqr2qAG2nb56pF
         N0rA==
X-Gm-Message-State: AOAM532uUb65aK8BJlqYvLuuPTHz6QhTeWYvwcKSq+p5SNxTqIDrLhSh
        ggfMtSEWnq++AHqEa96VNJ4=
X-Google-Smtp-Source: ABdhPJyvONEEY5aIfYC/HYtbCMXbJkGB4yJbpqS3K5xs7h3w0l2KvJuZ5lJbBFWB3hdP+nM2QXCOcw==
X-Received: by 2002:a1c:408:: with SMTP id 8mr4399166wme.147.1589982131500;
        Wed, 20 May 2020 06:42:11 -0700 (PDT)
Received: from ?IPv6:2a00:23c6:9e09:2900:4423:7d1b:b637:c183? ([2a00:23c6:9e09:2900:4423:7d1b:b637:c183])
        by smtp.gmail.com with ESMTPSA id h133sm3259161wmf.25.2020.05.20.06.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 06:42:11 -0700 (PDT)
Subject: Re: [PATCH] smp: generic ipi_raise tracepoint
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <02b57f31-fc0c-df35-57bf-e0a297a7e6c4@gmail.com>
 <20200520133350.GN317569@hirez.programming.kicks-ass.net>
From:   Wojciech Kudla <wk.kernel@gmail.com>
Message-ID: <a9fbbf7d-28cd-2119-8519-2f1cd045acda@gmail.com>
Date:   Wed, 20 May 2020 14:42:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520133350.GN317569@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2020 14:33, Peter Zijlstra wrote:
> We have bright shiny links like: https://lkml.kernel.org/r/$MSG-ID for
> that. they allow me to go find the email in my local archive without
> having to use a browser.

Apologies, beginner's mistake.

>> +static const char *ipi_reason_missing __tracepoint_string = "";
> 
> That is a pretty crap reason ;-)
> 

I knew this was a long shot. There is no obvious way to 
get/infer ipi reason in generic smp code at the moment.
Any suggestions what we can put here in the meantime?
Would "none" be more appropriate?
