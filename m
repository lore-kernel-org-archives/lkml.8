Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA0C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3937A2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z1cupcai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgGOJqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729592AbgGOJqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:46:36 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3A6C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:46:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mn17so2814656pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aWnhM4Btcn3KfukFrZhTbpY1jJowoLtpnNYgibe0Pxs=;
        b=z1cupcai6HHUX//qj/D4T1z0bqa+rnb8fjTtufSVinJuRHpi/N41f5hA2qY4tthIto
         Yf9o+zwKieu/jQxj4hPFUp3nn3Iagk6vS0YcWV0DjFzXyg6UOwxrH6dVWIK8PaDH4A4I
         pSSeTCk3O27Gp6HYNvH9GennQjh5iz9vbHSmSmP7wH6XQSrDlNW8i/NMgDdGfK5bqUFt
         82HrkqRQvCnSoIlFGdC05B2GeBnTK4cxtAmfBUItbjBFxx/WCEzbPUaFpR7ToXuYmoZX
         MjSfh6oYYVzgAj24toqUyKYxEA7cOaTydj81Un4gsCHQbZrgR7D0x032z5wRj7aM4xnp
         vJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aWnhM4Btcn3KfukFrZhTbpY1jJowoLtpnNYgibe0Pxs=;
        b=JudiAVHfbCKj9r2ZBYoGygwRnhlpeW9Cd709RSOBu3OWNLIZyl2M+P4XFJwQW7Svf8
         0npAjlE+Xkk0Xf3/+uSR1tg9n/9CxaUPE0vGiphIDFbgg8BTdFIgwfbb6x/4mpGj/P75
         p1WiC8go2ltv1MuN8Dgn7Lj9A5kGr3D4y4k2JL8MQP5zLRFHoMolWcRA12/KijdcGXN5
         FP3j6Urc6s/GkCmY41KI5tan4TH1j+BXopubH3rfmluJfaxBUMewZ2q+y022n96jRweI
         ib10BA9OE3hxpenfbyRaOGMsiK9HoG8iUXeVdXnDsZr1aa8IfuvLlmeSn4yRNLGIP0Jz
         oFsQ==
X-Gm-Message-State: AOAM533ryFt3YH2hYER6iA2yuBSLUgQCEMmCviFYAu09XFSoUhTgcWiv
        YNxkvFzwfOk+MWwK9t/ooTOlUw==
X-Google-Smtp-Source: ABdhPJyvmICM19LIRTnE4F/GGqLFbGi1ZydK84ycWBO8vErTCcVb4+nGPrhOrY44n3iA0Sn1KjiLWA==
X-Received: by 2002:a17:90b:3750:: with SMTP id ne16mr9222121pjb.6.1594806395785;
        Wed, 15 Jul 2020 02:46:35 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id f14sm1543484pjq.36.2020.07.15.02.46.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 02:46:35 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:16:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Rid W=1 warnings in CPUFreq
Message-ID: <20200715094633.s2xyn4wetafphpdt@vireshk-i7>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-07-20, 09:26, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> After these patches are applied, the build system no longer
> complains about any W=0 nor W=1 level warnings in drivers/cpufreq.
> 
> Hurrah!
> 
> Changelog
> 
> v1 => v2:
>  - Collect *-bys
>  - Use __maybe_unused instead of removing device IDs
>  - Use __always_unused instead of using unused variables
>  - Include architecture header instead of creating new include file

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
