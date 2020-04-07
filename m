Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395A1C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1232075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586275344;
	bh=3VjqdLa0s70r8aebZrWtJwDbgUgBPZ4Fn9cPzsn7F8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nhSpTlDoaiHfIhQkGjaFjspiRMA/Il6ix+yyV1IyXvO8JBbtBEmyNm7Rg1/YVv7/z
	 ir598cBIhV7H2yZDvoRa+NDGju/v5wtJ2HaK1TeA4lNhrOjEsqoNd1TuqBza0qFNYb
	 j6Tm0MCwzvWp0BP1CZnq81UifrA7DnMF0SD9tCgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgDGQCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgDGQCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:02:23 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7CBB2075E;
        Tue,  7 Apr 2020 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586275342;
        bh=3VjqdLa0s70r8aebZrWtJwDbgUgBPZ4Fn9cPzsn7F8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gw12nJpwBaICSNfCelcRlTky9psIctNfr5AJaqWmlY49ejsFHlL99qIPglWjGUE6g
         lt8XQXYKRg8vkMPGLFA45y42nwSgDMDSWpCJnWHPa0OORNCkXAgpnZMm3xhLDod8Xu
         5vmKwu/nNjeR6eTeVFO7ruZlDGkVoOk0ro2Istk8=
Date:   Wed, 8 Apr 2020 01:02:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] riscv: patch code by fixmap mapping
Message-Id: <20200408010218.c601beb496712a1251e2c9a0@kernel.org>
In-Reply-To: <0b6ad2759b47731a83008b46dbbed7c92e68cae2.1586265122.git.zong.li@sifive.com>
References: <cover.1586265122.git.zong.li@sifive.com>
        <0b6ad2759b47731a83008b46dbbed7c92e68cae2.1586265122.git.zong.li@sifive.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Apr 2020 22:46:48 +0800
Zong Li <zong.li@sifive.com> wrote:

> On strict kernel memory permission, the ftrace have to change the
> permission of text for dynamic patching the intructions. Use
> riscv_patch_text_nosync() to patch code instead of probe_kernel_write.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

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
>  
> -- 
> 2.26.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
