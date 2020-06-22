Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C893EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1C32073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqyfynf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbgFVWtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbgFVWtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:49:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F320C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:49:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so8226737plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SP3dyPHUmHcuUaUcIWcrCUYi0/7CkhHaUVAQAIGPRiw=;
        b=rqyfynf7UAFDwDSb/T55QtDTBnFfCHVZCses4sSuiYO2dgUm7t8zd3wVI44JPOhk/S
         msAc41Xsv0jlK17XIEwc4UIIukR6wMdrfDGWYMITucg8XL9elbqousD6Y5vQn4ZQdYbP
         x+rAgSVOwRngX0FpZ9a1EZp0U2D65wKG/ilw7iY9UHEp/x5B1kDOIdC3c1R4W9X9APVt
         H1ybAP4FBK7ngwH7RpHzxzxQEj7UMXtaSqKgY+yMYpdcvdNixWsChNFKjCtXQiJHpWgX
         T39C419wCjJcWLVWFr7VKvD3YZsYCR06gGDDAsl64X3N5rC8FlTET8lbIbBRDstc+gi8
         42aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SP3dyPHUmHcuUaUcIWcrCUYi0/7CkhHaUVAQAIGPRiw=;
        b=II1e+9+F+FGCk/Tj8UA6m7jf9i+d5KJ/smNsRXAu7ovfWbRNjwpTJ/3s4gDZo+3EG6
         Zzd+DIqPY5s2+qKxZ0po0Amk9DLp4JH5YDn7PSzTsp3/lfjNWNIjByd41DOtzG93eWBK
         j4K2QiRD9Ax4jlKxi/Eh6CoftSOeHoBObeuwmHtibHzK8sawieukEJj+Nkw9Hd0IgRAu
         T0kO6Mv1VsKZoRpagKtmsxRQut9re09s2VNUYOhYUpRQBdSvTTw/7M8p9oy/F2JdkIyi
         Mvbq+7ngQZoYNz4v+mddpzxWU+wvsxES37Bbg7QvPuRr34V2gy6fJ4TgWfTS25QRwPAg
         WNxA==
X-Gm-Message-State: AOAM533iEcKCz0/D2chYvCDQr2QTcPr2ITn6TvXlXs7NClOvHxqYa/Om
        iggDwbDjcTIlZ/EQpq5UgkrGvQ==
X-Google-Smtp-Source: ABdhPJwQ2Ixe/aYho5JT0ddHM/v5RvncJ3WmbpOAhsM4vvBeH77HFDofl5WlPL5D4DTiBlLrPGJvRA==
X-Received: by 2002:a17:902:46b:: with SMTP id 98mr22227335ple.259.1592866171384;
        Mon, 22 Jun 2020 15:49:31 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id a5sm14858353pfi.41.2020.06.22.15.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:49:30 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:49:28 -0700
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] x86/boot: Warn on orphan section placement
Message-ID: <20200622224928.o2a7jkq33guxfci4@google.com>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-4-keescook@chromium.org>
 <20200622220628.t5fklwmbtqoird5f@google.com>
 <202006221543.EA2FCFA2FF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202006221543.EA2FCFA2FF@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-22, Kees Cook wrote:
>On Mon, Jun 22, 2020 at 03:06:28PM -0700, Fangrui Song wrote:
>> LLD may report warnings for 3 synthetic sections if they are orphans:
>>
>> ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
>> ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
>> ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'
>>
>> Are they described?
>
>Perhaps:
>
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index db600ef218d7..57e9c142e401 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -792,6 +792,9 @@
> 		.stab.exclstr 0 : { *(.stab.exclstr) }			\
> 		.stab.index 0 : { *(.stab.index) }			\
> 		.stab.indexstr 0 : { *(.stab.indexstr) }		\
>+		.symtab 0 : { *(.symtab) }				\
>+		.strtab 0 : { *(.strtab) }				\
>+		.shstrtab 0 : { *(.shstrtab) }				\
> 		.comment 0 : { *(.comment) }
>
> #ifdef CONFIG_GENERIC_BUG

This LGTM. Nit: .comment before .symtab is a more common order.

Reviewed-by: Fangrui Song <maskray@google.com>
