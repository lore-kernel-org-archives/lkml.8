Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F438C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBF1207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Le6cJcuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgEUPrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUPrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:47:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822D2C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:47:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id n5so6858207wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ygXdshwZ6sqhNV/RMFYuAUef1d1MehMWLgDXSG2EHPs=;
        b=Le6cJcuobanbwKgpp8zSivcyXze9t07R/UHYuERqTibtsy7X/7SAiRx3kKbE9q+2t7
         a8LBUq/lE7CMVR3EFaUHcSr6o0pkzVkQudm8mbe8Brwi3sfop8yoJ0l/GyFhcrZqAQ89
         OOtxQ24xQK1ODH4tvY+VAqxgZEWS0RFpiQGMo1SvpLsrxxJNEyA/2/ly+qvNOrvJDcnb
         DJeOIaYP2xcpraV7aoTkNImBo83FCkvNbnqOlSTZk5cESrtBKP1XP9WZ/MsN9k+v2K4a
         Uyhm1gX5Cn6BH6d+FSF9oaRhFniCeNWam4cS6kt+Om7gD86vLeCEhg32UKpaUKqtbDPb
         zKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ygXdshwZ6sqhNV/RMFYuAUef1d1MehMWLgDXSG2EHPs=;
        b=e4gjaAQOenkJ75/4/r+medt7tew2IE9OErYMtOAVcH7QA6nhtf+qobYruUkwKDndfZ
         UaOvO/mkpFg9+GNCVhnBHKQ3PY8tj7dNNrxwR6XA4FgjOysSLhgbhi54D4mvNr5La11v
         oLjJoI9QnLflei+2spcQ2cMKVJjEh3WOBkoy8IBhQuA8tiZCf80vw3IjmFrPTlWUNhwX
         UN7ah3xsfZ5ew6mq8p41dCSqtsGV0rYQvnk6dZElR+RTKki/q2zwfdKSbExiYCvn7efb
         6H/4u02bJN2BXZ8aZ5Qq3twujlrg0j/GNyEGbYcHeszbY3XBna+8OvZMzmcH1zlyxNIW
         oq2w==
X-Gm-Message-State: AOAM531orW1JghCjJRBIKlNbyKnisc/gDCCHa5Qrmx3YKGxmTfN7+70N
        ZrNJ96l4f65zxwm+hmLMWFDn4L244qA=
X-Google-Smtp-Source: ABdhPJw5aqhrGaCS0GkssHgUIq4kYKj48KGgn6bMqFfY0W6t9kiBEGtCB7dkNiSteJamudE6T3LTbA==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr9933734wmi.135.1590076062001;
        Thu, 21 May 2020 08:47:42 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a10sm7076374wmf.46.2020.05.21.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 08:47:40 -0700 (PDT)
Date:   Thu, 21 May 2020 16:47:39 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Kgdb-bugreport] [PATCH v3] kdb: Remove the misfeature 'KDBFLAGS'
Message-ID: <20200521154739.ukfro4uuxpmnrpsx@holly.lan>
References: <20200521072125.21103-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521072125.21103-1-liwei391@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 03:21:25PM +0800, Wei Li wrote:
> Currently, 'KDBFLAGS' is an internal variable of kdb, it is combined
> by 'KDBDEBUG' and state flags. It will be shown only when 'KDBDEBUG'
> is set, and the user can define an environment variable named 'KDBFLAGS'
> too. These are puzzling indeed.
> 
> After communication with Daniel, it seems that 'KDBFLAGS' is a misfeature.
> So let's replace 'KDBFLAGS' with 'KDBDEBUG' to just show the value we
> wrote into. After this modification, we can use `md4c1 kdb_flags` instead,
> to observe the state flags.
> 
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
> v2 -> v3:
>  - Change to replace the internal env 'KDBFLAGS' with 'KDBDEBUG'.
> v1 -> v2:
>  - Fix lack of braces.
> 
>  kernel/debug/kdb/kdb_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 4fc43fb17127..392029287083 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -418,8 +418,7 @@ int kdb_set(int argc, const char **argv)
>  				    argv[2]);
>  			return 0;
>  		}
> -		kdb_flags = (kdb_flags &
> -			     ~(KDB_DEBUG_FLAG_MASK << KDB_DEBUG_FLAG_SHIFT))
> +		kdb_flags = (kdb_flags & ~KDB_DEBUG(MASK))
>  			| (debugflags << KDB_DEBUG_FLAG_SHIFT);
>  
>  		return 0;
> @@ -2081,7 +2080,8 @@ static int kdb_env(int argc, const char **argv)
>  	}
>  
>  	if (KDB_DEBUG(MASK))
> -		kdb_printf("KDBFLAGS=0x%x\n", kdb_flags);
> +		kdb_printf("KDBDEBUG=0x%x\n",
> +			(kdb_flags & KDB_DEBUG(MASK)) >> KDB_DEBUG_FLAG_SHIFT);

For this expression to work correctly, kdb_flags, need to be unsigned
(otherwise we get an arithmetic right shift and mis-report when
KDBDEBUG == 0xfff).

This is just FYI, I think I can fix this up when applying...


Daniel.
