Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F464C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2231720707
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nX3d4InQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgE2EDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:03:45 -0400
Received: from ozlabs.org ([203.11.71.1]:51873 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgE2EDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:03:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Y9sj5HBgz9sSp;
        Fri, 29 May 2020 14:03:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1590725021;
        bh=vH7zLNvGS4BorTtKtZ0BBnktSfHbH6n56wdkXjECHz8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nX3d4InQK8Spy3nzTCnyC/tJh184bN8xV/DKJUXBHc+k91/ltQT0HX1oj9OKljgJR
         OLBlxEdkOMO2UH1U/HXyF59BNbJ1RlJvukmPZiqTcBC3xgs2VkgbFhx8ixuSyr2KAT
         M0lkxxj9Oty+elmuy31hudyP/Ep7VWnZf9VzI9CiFbT5otkmKHKXv7l6h/LaaV/QzN
         8eO407IHRENzXzexTNDi6CRDn32/fao2j1rE4WSG2wgP+/1wTTIHfV4mjUT2E7Gg8H
         GjOPSpJ7fYmHNQQ7hYnWNHJ/KLadbDTjUeMNQ6aqugzEkMlpaXsWHPtlHP9aGiwJVt
         kRxxe8XPoB1jw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     benh@kernel.crashing.org, paulus@samba.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: Re: [PATCH] powerpc/nvram: Replace kmalloc with kzalloc in the error message
In-Reply-To: <1590714135-15818-1-git-send-email-wang.yi59@zte.com.cn>
References: <1590714135-15818-1-git-send-email-wang.yi59@zte.com.cn>
Date:   Fri, 29 May 2020 14:04:01 +1000
Message-ID: <87r1v3idzi.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yi Wang <wang.yi59@zte.com.cn> writes:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
>
> Use kzalloc instead of kmalloc in the error message according to
> the previous kzalloc() call.

Please just remove the message instead, it's a tiny allocation that's
unlikely to ever fail, and the caller will print an error anyway.

cheers

> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index fb4f610..c3a0c8d 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -892,7 +892,7 @@ loff_t __init nvram_create_partition(const char *name, int sig,
>  	/* Create our OS partition */
>  	new_part = kzalloc(sizeof(*new_part), GFP_KERNEL);
>  	if (!new_part) {
> -		pr_err("%s: kmalloc failed\n", __func__);
> +		pr_err("%s: kzalloc failed\n", __func__);
>  		return -ENOMEM;
>  	}
>  
> -- 
> 2.9.5
