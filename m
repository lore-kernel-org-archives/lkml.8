Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40272C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D29C20758
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndeZkgTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgEQRwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 13:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgEQRwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 13:52:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D3EC061A0C;
        Sun, 17 May 2020 10:52:22 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so3765602pfa.1;
        Sun, 17 May 2020 10:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+C97Gq4KJubJIcHPbkTJGpTHN9vsY4KHjuqSmBqZUeQ=;
        b=ndeZkgTjN1/SBongK5H2lbIiQYmOG+a5nD4L7iYRU6uHmp8pLqXhtF6OGaND1s51er
         vKXI73P5t3f0wlGe8gRig7RfkXbebj81TeHfKhiwMra8OfF783WBSg9wV8qTuv3/V2i5
         CZ80gDsfoW601TICLNbi3icTRsochknF+1i4xtaF6o/GCUOhKhnNtuWhJslYgZ4x4QjT
         8cBxWEEL2JbuVZ8wzq2Ee1EZeYVmsNf8djDPSeEBAArvx3FqURsum9I1Onkjqxg055a7
         YnpPPunf/h1341hk9CLtVt4NN5q7vw7ly/v4RpiNGc5Uz7j6H+TienIz/xdLcgyAPOdi
         lfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=+C97Gq4KJubJIcHPbkTJGpTHN9vsY4KHjuqSmBqZUeQ=;
        b=t6LLva9IcacceZM8eqMn63V0Yfu/fH0h9cJ2a9He+Il4cIzy2PFHKcxpcv5AGXH6AY
         AtQAeyOryV18fdARtObxbeuNdONPn6zJfn2OGAlrcG0ta/VDBEcKkL4ilK3G+4WsumB0
         S1OWAa1ZohygzZnxl03jMnXk38FNUqTpwHujdpp8yD+udI+yDQ6yDF3NxEB3YtQ0VT7W
         7z5GMZwybTs3ldcVc13WdQ9JLZc3qkmseoRT1Zy2KgMhnEK2X/UkHS4a/8/PRo+wybr4
         3XSZuFeSaGHwv44WDy/Gk8QHAp43TOpqDu0Ytl0RF/Wmuc3sAJrCXkwnpb9TMWjCuk0N
         +dug==
X-Gm-Message-State: AOAM530DViYt5o5HVVlxzI4Mom4Aku4/CPY23sZyJYl0ctpX3R6IadeY
        ymvgkAMLFNLSXnLgykIY9rSdPJ2y
X-Google-Smtp-Source: ABdhPJyZKUFY+0Vv/jG56FfsR4Kevaou7/BiaiahUsG3Ctu0HH2TxFN8/lOcCdQ1X/aTh56lI/WIJQ==
X-Received: by 2002:a62:ed02:: with SMTP id u2mr13717273pfh.60.1589737942085;
        Sun, 17 May 2020 10:52:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z18sm6734907pfj.148.2020.05.17.10.52.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 10:52:21 -0700 (PDT)
Date:   Sun, 17 May 2020 10:52:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] csky: Fixup calltrace panic
Message-ID: <20200517175220.GA48379@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 13, 2020 at 03:15:25PM +0800, Guo Ren wrote:
> The implementation of show_stack will panic with wrong fp:
> 
> addr    = *fp++;
> 
> because the fp isn't checked properly.
> 
> The current implementations of show_stack, wchan and stack_trace
> haven't been designed properly, so just deprecate them.
> 
> This patch is a reference to riscv's way, all codes are modified from
> arm's. The patch is passed with:
> 
>  - cat /proc/<pid>/stack
>  - cat /proc/<pid>/wchan
>  - echo c > /proc/sysrq-trigger
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>

This patch results in:

gcc version: csky-linux-gcc (GCC) 9.3.0

Building csky:defconfig ... failed
--------------
Error log:
csky-linux-gcc: error: unrecognized command line option '-mbacktrace'; did you mean '-fbacktrace'?
csky-linux-gcc: error: unrecognized command line option '-mbacktrace'; did you mean '-fbacktrace'?
make[2]: *** [scripts/mod/devicetable-offsets.s] Error 1
make[2]: *** Waiting for unfinished jobs....
csky-linux-gcc: error: unrecognized command line option '-mbacktrace'; did you mean '-fbacktrace'?
make[2]: *** [scripts/mod/empty.o] Error 1
make[1]: *** [prepare0] Error 2
make: *** [sub-make] Error 2

when trying to build csky images with upstream gcc 9.3.0.

What version of gcc is needed to build csky images ? Also, would it be
possible to support the upstream version of gcc ?

Thanks,
Guenter
