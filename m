Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A36C38A2D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 00:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F27F221EA
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 00:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="jj0M00ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDRAWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 20:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgDRAWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 20:22:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F2BC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 17:22:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a32so1771320pje.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 17:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bQUk53v9VOdk02hVWrUqNSdNvagncREzgVLd//ANno4=;
        b=jj0M00ke13t2PFFZmqZRD9jdeoDANpEbl1GhSr0wp5MuI/8i7/F79jZJ2vynDaTYZX
         jpzR7taNdqBJtJi1kD8rEcUb4jfSoUydAGZe9YnYIBZl0q5emC7eRUp1Gj4e2XvBaI/d
         4T0ZrNIfSe4DSYQFSyOrtIuk5Nw8ZSrid72hZRsjyGMn+HQkd+R3Lg2QMLBYaA5fGT31
         Qs/99ISt/QE9vk7uvvgWTb+ifjWB9XIB9kc/lH0FSaDeuJsNbQSV7e1HoteY9WCor5Ax
         eLBypFWVjjTe0dfWBfkr9nSXH7T8cvcFteqNriYTt9OmYamW+r1bCeuUfX/kJEHGVQwZ
         R+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bQUk53v9VOdk02hVWrUqNSdNvagncREzgVLd//ANno4=;
        b=frOI1uP+xfomtPVBYhukxJjUBc9uVUDN11N+TW+Lo1R5OY3GkOGujdenLK4Fkt9brt
         C4fOwTFGIYcrA9aBfO++s9O8XFMA3KOf1boPDLC8GanwOwN6t/SxiOxF2I1MYeKiioYn
         oGTo+QQag8LxqH9qqcCJu0KS7+Y3R8Ig4On8oUObqKZFzLTk+FfOJDmZJltngp6jLB81
         SnzxgsYYO8zdu3rUQaVp37EiaY6AhhEAsJhe0UggxrRaMnAfHg8842cLMkAumUqh/Nmh
         PgWpPyX8wpcXSksVp06XdDpYdJOqdgo3BSWnUnJuSqaCeMPExrl6QhbeJ5KI2Nta/Zue
         XE1A==
X-Gm-Message-State: AGi0PuZTYN34kpbcBwI2Si7/ddAtUe4AUYPOf4tuhWJGICzISVAnq79I
        Ggq8dcrQaPAso3ZIMO+GOEZwww==
X-Google-Smtp-Source: APiQypIiYakCBlEcBNiRMY3xlIehMNHDaNow7Nkg7hziixsb1qiGVspleiQER+W2i9WoIUlKQC0grA==
X-Received: by 2002:a17:902:8506:: with SMTP id bj6mr6170949plb.106.1587169368150;
        Fri, 17 Apr 2020 17:22:48 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id mq18sm7353814pjb.6.2020.04.17.17.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 17:22:47 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:22:47 -0700 (PDT)
X-Google-Original-Date: Fri, 17 Apr 2020 17:19:43 PDT (-0700)
Subject:     Re: [PATCH v5 3/9] riscv: patch code by fixmap mapping
In-Reply-To: <27f31750f58cd0ad2805579b16b001aa88103688.1586332296.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        mhiramat@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-69b9c99a-ee03-4927-acf8-3ba9388e3a0b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Apr 2020 00:56:58 PDT (-0700), zong.li@sifive.com wrote:
> On strict kernel memory permission, the ftrace have to change the
> permission of text for dynamic patching the intructions. Use
> riscv_patch_text_nosync() to patch code instead of probe_kernel_write.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/riscv/kernel/ftrace.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index c40fdcdeb950..08396614d6f4 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -7,9 +7,23 @@
>
>  #include <linux/ftrace.h>
>  #include <linux/uaccess.h>
> +#include <linux/memory.h>
>  #include <asm/cacheflush.h>
> +#include <asm/patch.h>
>
>  #ifdef CONFIG_DYNAMIC_FTRACE
> +int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
> +{
> +	mutex_lock(&text_mutex);
> +	return 0;
> +}
> +
> +int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
> +{
> +	mutex_unlock(&text_mutex);
> +	return 0;
> +}
> +
>  static int ftrace_check_current_call(unsigned long hook_pos,
>  				     unsigned int *expected)
>  {
> @@ -46,20 +60,14 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
>  {
>  	unsigned int call[2];
>  	unsigned int nops[2] = {NOP4, NOP4};
> -	int ret = 0;
>
>  	make_call(hook_pos, target, call);
>
> -	/* replace the auipc-jalr pair at once */
> -	ret = probe_kernel_write((void *)hook_pos, enable ? call : nops,
> -				 MCOUNT_INSN_SIZE);
> -	/* return must be -EPERM on write error */
> -	if (ret)
> +	/* Replace the auipc-jalr pair at once. Return -EPERM on write error. */
> +	if (patch_text_nosync
> +	    ((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
>  		return -EPERM;
>
> -	smp_mb();
> -	flush_icache_range((void *)hook_pos, (void *)hook_pos + MCOUNT_INSN_SIZE);
> -
>  	return 0;
>  }

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
