Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AE7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 16:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03DD12078D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 16:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593361532;
	bh=4MsHQYCfwDNcgoFMDxuBklP42iO6H/Lxo4tZHOVpT+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=07p1BLJdsgAB6o1ssU2MKR3TFBwZCh2frTcD9W7DklL83tlF08O4sV/YJHC6YMPk9
	 PMP4yE5w9AlfOFK7kI2IbX44XHog7B1GFjp/edWdfMWdK6+/sZKOHv2LlsIZqOXYG4
	 DGavZBuETQLz5NtZcQcpxxwC5rVw/BZHhfC4apow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgF1QZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 12:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgF1QZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 12:25:29 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA64420771;
        Sun, 28 Jun 2020 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593361529;
        bh=4MsHQYCfwDNcgoFMDxuBklP42iO6H/Lxo4tZHOVpT+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y3OerUbSLeNsgby2H3gQ4ClZuu9Zc3iA1DveyUjBNkbUmzJjyjMVL6Vb326AxTmc+
         d1F44707pI8ZM34pAusrVj+gcJP9Yco0Ubr0359g2vTm8O/xdQkr6AzJo1+9hh6/GA
         b87a/tUXaPeXFae/mUxAQbck2dPswuPgYMtjP/74=
Date:   Mon, 29 Jun 2020 01:25:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     guoren@kernel.org
Cc:     greentime.hu@sifive.com, palmerdabbelt@google.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org,
        linux-csky@vger.kernel.org, zong.li@sifive.com,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2] riscv: Fixup compile error BUILD_BUG_ON failed
Message-Id: <20200629012524.c941a5f18aa7f312d325f714@kernel.org>
In-Reply-To: <1593360457-23827-1-git-send-email-guoren@kernel.org>
References: <1593360457-23827-1-git-send-email-guoren@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jun 2020 16:07:37 +0000
guoren@kernel.org wrote:

> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Unfortunately, the current code couldn't be compiled:
> 
>   CC      arch/riscv/kernel/patch.o
> In file included from ./include/linux/kernel.h:11,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/preempt.h:11,
>                  from ./include/linux/spinlock.h:51,
>                  from arch/riscv/kernel/patch.c:6:
> In function ‘fix_to_virt’,
>     inlined from ‘patch_map’ at arch/riscv/kernel/patch.c:37:17:
> ./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_205’ declared with attribute error: BUILD_BUG_ON failed: idx >= __end_of_fixed_addresses
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^
> ./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
>     prefix ## suffix();    \
>     ^~~~~~
> ./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>   ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>   ^~~~~~~~~~~~~~~~
> ./include/asm-generic/fixmap.h:32:2: note: in expansion of macro ‘BUILD_BUG_ON’
>   BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
>   ^~~~~~~~~~~~
> 
> Because fix_to_virt(, idx) needs a const value, not a dynamic variable of
> reg-a0 or BUILD_BUG_ON failed with "idx >= __end_of_fixed_addresses".

Looks good to me :)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Zong Li <zong.li@sifive.com>
> ---
> Changelog V2:
>  - Use __always_inline as same as fix_to_virt
>  - Use const "const unsigned int" for 2th param
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/kernel/patch.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index d4a64df..3179a4e 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -20,7 +20,12 @@ struct patch_insn {
>  };
>  
>  #ifdef CONFIG_MMU
> -static void *patch_map(void *addr, int fixmap)
> +/*
> + * The fix_to_virt(, idx) needs a const value (not a dynamic variable of
> + * reg-a0) or BUILD_BUG_ON failed with "idx >= __end_of_fixed_addresses".
> + * So use '__always_inline' and 'const unsigned int fixmap' here.
> + */
> +static __always_inline void *patch_map(void *addr, const unsigned int fixmap)
>  {
>  	uintptr_t uintaddr = (uintptr_t) addr;
>  	struct page *page;
> @@ -37,7 +42,6 @@ static void *patch_map(void *addr, int fixmap)
>  	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
>  					 (uintaddr & ~PAGE_MASK));
>  }
> -NOKPROBE_SYMBOL(patch_map);
>  
>  static void patch_unmap(int fixmap)
>  {
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
