Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20356C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C90206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="BGjm8Ah3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgFBT3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBT3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:29:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934E8C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:29:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p30so5599018pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jt9wTvbBB9l8BA385ydswer9G/ASNFMgQz2sVTAlGwY=;
        b=BGjm8Ah3Pr7hHscdoJXTL21nGZPG4PnLKU6jA9IWJJGiA3WnGcbIzvTS7bxWuFIUQw
         DPDRWnq2PLJmKzmq5Uf8cCKL7sHZKR5bCnU/j65E0birBHYZWTXje41hiOgnXH/qTjow
         ijI6FUsie6nRXhrLqyHtL+qqUQrZ4bpjgliRZtslnm1Vt4k9hkLunsOH+efJeWr01hLj
         dz/uqXkmODoVaCaF2mdefg2ay3SvWLgY93xskoihdt1S3hQ3siqSAumw2cYrhovzu4SV
         u+OwNhe5YYDzQaxC9jimnrgVzhr3cV5o4cYRthNKu3/euNBxL6MW2ywxy4cd4kbCMYMF
         V4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jt9wTvbBB9l8BA385ydswer9G/ASNFMgQz2sVTAlGwY=;
        b=O2EONbgnFOm32O1U0wApYmHngBh3eD+RJ3nTw3VvXo8AQ4seF3B9y5Ysk6UcTXmUew
         vpcA3BktBNjS1orfek6QOFcsfE5cLRWSsGfvo73UH1D+dLhXFnMKyZyXtqkAVRVI90Gr
         KgDBLoC4UK4G1kJ2F6sGNFgP+przRnLgTB8gCSZoGtX5KsW3EhbZhN5OuNCX0nc9+5HI
         pPRqic93VTGFo7n4SwQt75+ch9RhmXOTPJ7JKz/upj7vC+ml9f23jifBJ5U/SZqz39Me
         CoZDmwMMhrOWzajDIJaA5fk1KAQMzyFrRHTCz/VzUekEKDsdyvIU9YfOlv1WXkFf20az
         28DA==
X-Gm-Message-State: AOAM5314nPkZIqrcWDroCNvwANC3uMz4LpFc6yAvhrh2coj9clN5mwhu
        LMj+mQG7xl7qOfdRD1YpU3JyoA==
X-Google-Smtp-Source: ABdhPJzONNh6ti+mI0rlAqkmgvqRBA1IcAxfDD8TOiWcba6fmr7wI9/I20P9retKbEDJLLAu40knuQ==
X-Received: by 2002:a63:565b:: with SMTP id g27mr24394556pgm.166.1591126163012;
        Tue, 02 Jun 2020 12:29:23 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id s197sm3267932pfc.188.2020.06.02.12.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 12:29:21 -0700 (PDT)
Subject: Re: [PATCH 3/6] arm64/vdso: Add time namespace page
To:     Andrei Vagin <avagin@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200602180259.76361-1-avagin@gmail.com>
 <20200602180259.76361-4-avagin@gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <fd789c85-f08b-3397-d463-501f7ee5c974@arista.com>
Date:   Tue, 2 Jun 2020 20:29:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200602180259.76361-4-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrei,

On 6/2/20 7:02 PM, Andrei Vagin wrote:
[..]
> --- a/arch/arm64/include/asm/vdso.h
> +++ b/arch/arm64/include/asm/vdso.h
> @@ -12,6 +12,12 @@
>   */
>  #define VDSO_LBASE	0x0
>  
> +#ifdef CONFIG_TIME_NS
> +#define __VVAR_PAGES    2
> +#else
> +#define __VVAR_PAGES    1
> +#endif
> +
>  #ifndef __ASSEMBLY__

Not an issue as-is, but:

on x86 vdso+vvar is always the same size with/without CONFIG_TIME_NAMESPACE.

Timens page isn't allocated on !CONFIG_TIME_NAMESPACE, but vma is the
same size. Which simplifies criu/vdso migration between different kernel
configs.

Not any critical, but just to note..

Thanks,
          Dima
