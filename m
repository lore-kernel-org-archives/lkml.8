Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3ACC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B38D20B80
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nvb+ggfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgFZVU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgFZVU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:20:57 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4121C03E97E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:20:57 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b5so5147481pfp.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3v+OF208XUrXXCW8iavBboKmEzUrVOLh/1qRIFYBNoU=;
        b=Nvb+ggfcnASyU5yhjpLMt6peljFaQfiHoHtcJLghh8SOevSBFghSaqeuZcJueBgfGg
         WZgC5DlW9UptaHMBha2Yi+d7BZxdIdIsRVIxr6sT/EGiBCa7riY2jk+3OoPm9Dm2cBgE
         Oe16AFCAHqXoIwIvcpbOh0WaehkQSk4CbVyto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3v+OF208XUrXXCW8iavBboKmEzUrVOLh/1qRIFYBNoU=;
        b=n7jGEMPkNl6r9ktiZ8GginkaM6hcGTveU0GWxcG3A7lUn74cHOHpbNng5Vm6kwiQNH
         sswH4Hcjq24QEQbqLSSpO0SIVerYF1umEFTcJp5HU7/xOrrZPrLQRmKpxIz3EURY8Veu
         e1yVvVObHS0pR44ZTW3KzjL37aby6gIU1C1/gAx/6dYSdybDNHFZaxvRKRWAr3wx0S0H
         A/D4VfkT+UlVH5Rj7KvR8dRB67BEcELe0myXNUiEQ25phYy9A2aOl83s551c7ibKvDzA
         mA5wuW6f2IgYnOs2AD+OMhQyYMx1TCCs3uC6bb3a54SwjqjIOsanCLNhy9XHLKTZt6w0
         Lalg==
X-Gm-Message-State: AOAM530QGUYjtgk8PjRNiVPYKt4BMoHkgXxHcv3diJr5Y9VT8IVtcRQP
        ezlB16fIWlAK6n0GU3UdSs1L6g==
X-Google-Smtp-Source: ABdhPJwbIChL+NPgK/ZZynTiHBVtRn0Pm3+yrJJiDfCLTGOFZovkou+N1wtQIeNq/GeuCZhx4HWPUQ==
X-Received: by 2002:aa7:9e09:: with SMTP id y9mr4461464pfq.314.1593206457324;
        Fri, 26 Jun 2020 14:20:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b71sm17221453pfb.125.2020.06.26.14.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:20:56 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:20:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org,
        rppt@linux.ibm.com, frowand.list@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v5 02/12] arch: arm64: add linker section for KUnit test
 suites
Message-ID: <202006261420.02E8E62@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-3-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-3-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:09:07PM -0700, Brendan Higgins wrote:
> Add a linker section to arm64 where KUnit can put references to its test
> suites. This patch is an early step in transitioning to dispatching all
> KUnit tests from a centralized executor rather than having each as its
> own separate late_initcall.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 6827da7f3aa54..a1cae9cc655d7 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -181,6 +181,9 @@ SECTIONS
>  		INIT_RAM_FS
>  		*(.init.rodata.* .init.bss)	/* from the EFI stub */
>  	}
> +	.kunit_test_suites : {
> +		KUNIT_TEST_SUITES
> +	}

See my reply to 01/12. Then this patch can be dropped. :)

>  	.exit.data : {
>  		EXIT_DATA
>  	}
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 

-- 
Kees Cook
