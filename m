Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968C5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A78F20724
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WUXn+tHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404010AbgFXN50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgFXN5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:57:25 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5C1C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:57:25 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i16so1701188qtr.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=44Zh5+rYkVPRlcsTE32vj+QjrYC3xiG5xkvOUL+shI0=;
        b=WUXn+tHmUYJ3O6KTmdkdwRxhdE4KXCLlCWezz/4E+B8cxgC7yT/oaR4YVS7tiq6vzg
         CsitnkYos8ET5+PD9GPZP+TU457iWx/Wipeo8KdEYgkpJoqSIdGTON17D/LN0cM0tAoh
         mofaSSCrvvNrdAq6kLL5xH/MxUhwhmdx2pPDAwLSoFvrzqasNfaJ8DLOsj8/1q7LTqGT
         vHpDJQ0Ay0wyLU0vDJOIjsrUaa3/Pj4R7rWLs+phtRQyiEvc2SrVwmb7bBNyxN6eHNzU
         cgk4qnbmDz2P0/3f2POyEPI/qSDOagWjJjbBNIW6lGkHieT8SDVNsspYDqHPCQLXfk/c
         usUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=44Zh5+rYkVPRlcsTE32vj+QjrYC3xiG5xkvOUL+shI0=;
        b=bilROJR58moTVBzFWPbZI7KT92K7eKixx4aPEOviKEfBdlwIFgpjSQyr2U4mzxgRGc
         1B4TZgH/QSpl4WiYtXef+4Rs4UowakbD6uXH0h85VqaTKHjuadQwi28N53hcgqkbwN6D
         XBe6y8WE8QOlv6vcyWZ+wioNtDlRWvf3ioFpYDEyO7JMW4HAZxWdKTW0s9KXuJxcUu46
         ij5/iR79pgxctvVs2Wcr9xd2YLuokUqRAG8iYni6RDrfThh0mc2qA2TgQMqquYt2dhVX
         piKdoyyeaAohY6l492un9ElCMPcwu8NZY8p72HqCIeNSeAhMYqJfVlPPPDWLzB/WVx+v
         dhQg==
X-Gm-Message-State: AOAM5331CXAKOE6Ybl+CF42slWJ0xVe25sQeypS5qXbUN1hDaFKlfndk
        8cvZsx+wUWD+GN4HlgoOlCFTsg==
X-Google-Smtp-Source: ABdhPJwkMI/JftIxqN/iLg8ct/1eBzUEBqBCm0HCslUHTKYsntACTZcO1US258+V9p0mp/S/6P33OQ==
X-Received: by 2002:ac8:6bc8:: with SMTP id b8mr26418117qtt.198.1593007044568;
        Wed, 24 Jun 2020 06:57:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id q24sm3464757qkj.103.2020.06.24.06.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 06:57:23 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jo5ty-00DVH3-PZ; Wed, 24 Jun 2020 10:57:22 -0300
Date:   Wed, 24 Jun 2020 10:57:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Will Deacon <will@kernel.org>, dianders@chromium.org,
        groeck@chromium.org
Subject: Re: [PATCH] kernel/trace: Add TRACING_ALLOW_PRINTK config option
Message-ID: <20200624135722.GF6578@ziepe.ca>
References: <20200624084524.259560-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624084524.259560-1-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 04:45:24PM +0800, Nicolas Boichat wrote:
> trace_printk is only meant as a debugging tool, and should never be
> compiled into production code without source code changes, as
> indicated by the warning that shows up on boot if any trace_printk
> is called:
>  **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
>  **                                                      **
>  ** trace_printk() being used. Allocating extra memory.  **
>  **                                                      **
>  ** This means that this is a DEBUG kernel and it is     **
>  ** unsafe for production use.                           **
> 
> If this option is set to n, the kernel will generate a build-time
> error if trace_printk is used.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>  include/linux/kernel.h | 17 ++++++++++++++++-
>  kernel/trace/Kconfig   |  9 +++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 196607aaf653082..b6addc6ba669e85 100644
> +++ b/include/linux/kernel.h
> @@ -721,10 +721,15 @@ do {									\
>  #define trace_printk(fmt, ...)				\
>  do {							\
>  	char _______STR[] = __stringify((__VA_ARGS__));	\
> +							\
> +	__static_assert(				\
> +		IS_ENABLED(CONFIG_TRACING_ALLOW_PRINTK),\
> +		"trace_printk called, please enable CONFIG_TRACING_ALLOW_PRINTK."); \
> +							\

Why __static_assert not normal static_assert?

Jason
