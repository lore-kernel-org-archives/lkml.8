Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E4AC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDD724670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqG/2fTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgBSUYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:24:30 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36779 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgBSUY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:24:29 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so25173449oic.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 12:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3jjA5d9l5RFn/2ac3ZJYASA8bJIB/hpXsU0f3AYcaxo=;
        b=EqG/2fTWa3Qq2VSkbtl3PyvzEXSJd4rLo8j9f/SQUxuVgB57MYOY6FUbQI4d3Mi3wC
         GXPgw6N6oP29V+lzEu7eYJLx7dy0R2TcqVG+ix9j4p8sKePRVbdgi0pIX9ANC5NKi7CX
         BkKXFcptZa55Ow6en4+ToTwny6NdcXtIf8u8gT28Wr5VK/KzbEbKSZWhluhagFCq/dL9
         iZwMTdbYrep5rasm/Hv+exAeSAgVxGRd6/yUaKQN2XGhct4W5UOoiLySKk6UkpHAPdnE
         9u5xXCZOpsE5e6gIenB3iPMT+bxl2ujat8dd2qlKgjRrA9UQZUqO4S0Ppqin1kP7tQu3
         ylLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3jjA5d9l5RFn/2ac3ZJYASA8bJIB/hpXsU0f3AYcaxo=;
        b=EHGAEMFunZL2TL0JTTzu8zFfBWPgOfQr8qj0s5b4xod3h/H4Z4x/NCgtUbqp2PmFG3
         +4XwyGiP2QeIUKZT8dZsflwufuxQnwgiHqMVIbIx23rjbtoTd+wDT1oUY7nZ7cEi9CQZ
         rWnuC3SYzCg5JIFu2sTnLQZe3N2t6FveQ3nXkGwka5mv5cLxCC7To1UVGRWb9GWzCUYo
         U0lab5a5Pl1Q9dH8gxxsus9OeaVvgkYpGrRcqfd5ed1i9l4IRPNeMaYS/0R2jbT+YHkC
         FivJ2447OqdCOjcJEaQsUCLLNT5C+ekRZVRBf9A485ra0EQ3TzVL4zT5/Y6lSf7pvk8p
         +MUA==
X-Gm-Message-State: APjAAAWNrPg6w6TPExrDvIiNpf92SS2Xn3DrPwVRGkeU7k0yHEA0K+hC
        zdCneHsi7vwiWiJ3PP+I6SMjD8z9
X-Google-Smtp-Source: APXvYqx9tdweuxVlqKxzSXIEVstwnqam5rrt4Akk0nyBUlFZbvK3Q3yYFaBIfNzKNfsB5gXLj2cWxQ==
X-Received: by 2002:aca:120e:: with SMTP id 14mr5482307ois.135.1582143868409;
        Wed, 19 Feb 2020 12:24:28 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id q9sm305168oij.38.2020.02.19.12.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 12:24:27 -0800 (PST)
Date:   Wed, 19 Feb 2020 13:24:26 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] kernel/extable: Use address-of operator on section
 symbols
Message-ID: <20200219202426.GA32182@ubuntu-m2-xlarge-x86>
References: <20200219202036.45702-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219202036.45702-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:20:37PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> ../kernel/extable.c:37:52: warning: array comparison always evaluates to
> a constant [-Wtautological-compare]
>         if (main_extable_sort_needed && __stop___ex_table > __start___ex_table) {
>                                                           ^
> 1 warning generated.
> 
> These are not true arrays, they are linker defined symbols, which are
> just addresses. Using the address of operator silences the warning and
> does not change the resulting assembly with either clang/ld.lld or
> gcc/ld (tested with diff + objdump -Dr).
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/892
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Gah this should have:

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>

I can send a v3 if necessary.

> ---
> 
> v1 -> v2: https://lore.kernel.org/lkml/20200219045423.54190-3-natechancellor@gmail.com/
> 
> * No longer a series because there is no prerequisite patch.
> * Use address-of operator instead of casting to unsigned long.
> 
>  kernel/extable.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/extable.c b/kernel/extable.c
> index a0024f27d3a1..88f3251b05e3 100644
> --- a/kernel/extable.c
> +++ b/kernel/extable.c
> @@ -34,7 +34,8 @@ u32 __initdata __visible main_extable_sort_needed = 1;
>  /* Sort the kernel's built-in exception table */
>  void __init sort_main_extable(void)
>  {
> -	if (main_extable_sort_needed && __stop___ex_table > __start___ex_table) {
> +	if (main_extable_sort_needed &&
> +	    &__stop___ex_table > &__start___ex_table) {
>  		pr_notice("Sorting __ex_table...\n");
>  		sort_extable(__start___ex_table, __stop___ex_table);
>  	}
> -- 
> 2.25.1
> 
