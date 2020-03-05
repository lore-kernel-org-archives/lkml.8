Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F759C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89E920842
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="0wg1GFbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgCEBoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:44:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39597 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgCEBoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:44:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id s2so1925200pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 17:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=IHAud99V8DFRxBHpmis+LJ7v4tcSxMXp83sRWPaOQ6A=;
        b=0wg1GFbRZt9EYVJPPBIibJ4+vxqpirlX1n7xGBocQk8m8sFNyLXg+XQlO9I7VPjdGq
         ygs1+EDHjMXmicC5J+YkPLbjCw3vU8SvShFAEEpAEs2xn4buuTv1/Pze2GJVuptMMQwB
         Sm4ndHpC+3hWMN6FPQlbkcHcXGUp4lcfmL0+dxOUJ9+CAjhzi3SVqVScYxnPiCqnI3/o
         5fmVd9WwQ+2gZZ0f9TYMbMNTH7b8KxDygdUTJt116xu1RHxptaHh3hF6miYehENNw5Ea
         3/i42PhkPZhpRrDdQt7DLlMQ/vaIBzy8VWA3XfZs8EsWMhDKWz4NSGLc86EGMEC/+YUX
         qPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=IHAud99V8DFRxBHpmis+LJ7v4tcSxMXp83sRWPaOQ6A=;
        b=XYrmP6/RzT8JHlXDLOHlbo0ce3D/ljswa7+55iuw/F4ncM7XP4Tlyb8j/Maei3WS5v
         HVCOg1qjCOaDXjPoF04xK9evOmJJnKEj4n/Yr8X8O5pwMwKP9skOGHOC6rdb10YA+IF3
         0EQ+AtmlRGXRAbJ4Yevl7TA95B2+NF8Kre5hnDY4R+NOPnpjgHvU5nzR5HoazCkIziQI
         uU4xNwA7+GkbWTsE6ma8H/jDdsr0euo/FAooX9sxuyrSQU/adQtwD9r7upTi8D1QzBKw
         cqIFdaW1IZz0P3MpJwLr4XDISvMHyt9QW3gOpiiv4WVHK+wDJPRK3or8b6RItwWjG7JH
         ZQkQ==
X-Gm-Message-State: ANhLgQ3B2L/BKU77FfWIXkVpF/ahZyx/wq0IFl9icSt46vb/Pgy/UFGM
        DyrOff0uygS93jTzFCA8UNY0e2iBY/g=
X-Google-Smtp-Source: ADFU+vvYsRYq0ZvKWZHSVa/lorXisjU+Cg1rGxrzNdk4psSdnQvpfS6puzFu4FutPOgd9NHmSertlg==
X-Received: by 2002:aa7:8805:: with SMTP id c5mr5968810pfo.142.1583372660245;
        Wed, 04 Mar 2020 17:44:20 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id f20sm2432438pfk.69.2020.03.04.17.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 17:44:19 -0800 (PST)
Date:   Wed, 04 Mar 2020 17:44:19 -0800 (PST)
X-Google-Original-Date: Wed, 04 Mar 2020 17:44:16 PST (-0800)
Subject:     Re: [PATCH 8/8] riscv: add two hook functions of ftrace
In-Reply-To: <20200217083223.2011-9-zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-da89b7a8-70ef-4ac2-9d56-a4ddab325e9c@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 00:32:23 PST (-0800), zong.li@sifive.com wrote:
> After the text section be mask as non-writable, the ftrace have to
> change the permission of text for dynamic patching the intructions.
> Add ftrace_arch_code_modify_prepare and
> ftrace_arch_code_modify_post_process to change permission.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/kernel/ftrace.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index c40fdcdeb950..576df0807200 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -7,9 +7,27 @@
>
>  #include <linux/ftrace.h>
>  #include <linux/uaccess.h>
> +#include <linux/memory.h>
> +#include <asm/set_memory.h>
>  #include <asm/cacheflush.h>
>
>  #ifdef CONFIG_DYNAMIC_FTRACE
> +int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
> +{
> +	mutex_lock(&text_mutex);
> +	set_kernel_text_rw();
> +	set_all_modules_text_rw();
> +	return 0;
> +}

None of the other architectures are doing anything remotely like this in these
functions, despite many supporting STRICT_KERNEL_RWX.  Having a function that
maps all text as RW seems super dangerous, as one stack attack means NX is
gone.

Looks like FIX_TEXT_POKE0 is the magic that makes the other ports work.

> +
> +int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
> +{
> +	set_all_modules_text_ro();
> +	set_kernel_text_ro();
> +	mutex_unlock(&text_mutex);
> +	return 0;
> +}

Presumably this needs a icache flush as well?  Probably better to do so when
installing the instructions, though.

> +
>  static int ftrace_check_current_call(unsigned long hook_pos,
>  				     unsigned int *expected)
>  {
