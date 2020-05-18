Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B34C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B23D207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 02:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589768467;
	bh=7RJuET2p1c9crhC6k5Md3KsYrDZ64Vq388qDBF/PKT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AY/i6uRVryO6UDg/6o3A/SpgypulRLYo4+3zoiV80ultZQ5VRptQvGFKoHz9ukceO
	 galUPdIweRiEx6+dtmWozU1THnkEq1l0Sv0UKxW03iUY0uhzqEE7HMWZuaWMTVbQpT
	 eQXIlcaqehELjyrIKUOVhZ0ABn533YHl3Y0T4P/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgERCVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 22:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgERCVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 22:21:05 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9334420758;
        Mon, 18 May 2020 02:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589768464;
        bh=7RJuET2p1c9crhC6k5Md3KsYrDZ64Vq388qDBF/PKT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qKUPHDhKfAvKoQDw6aUbF5oxk/2fSXt6cYTcG445x6tHLCS0hMJXSKIXc5Z28WHUO
         nlFuCGycnKryukgl1b3dKlivig1RoGMgEXo6P+4drDpHbZO6YsywoMt6lOz6h4/dae
         CgzG2Fh0kTL1dKHu4p+ITL+Ewb1+xwPHzKxpolUU=
Date:   Mon, 18 May 2020 11:20:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mhiramat@kernel.org, labbott@redhat.com,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: kprobes: Avoid fortify_panic() when copying
 optprobe template
Message-Id: <20200518112059.c19899ffb17a4843bf4f74ab@kernel.org>
In-Reply-To: <202005171447.00CFE0C@keescook>
References: <20200517153959.293224-1-andrew@aj.id.au>
        <202005171447.00CFE0C@keescook>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 May 2020 14:48:52 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Mon, May 18, 2020 at 01:09:59AM +0930, Andrew Jeffery wrote:
> > As mentioned, a couple of attempts have been made to address the issue
> > by casting a pointer to optprobe_template_entry before providing it to
> > memcpy(), however gccs such as Ubuntu 20.04's arm-linux-gnueabi-gcc
> > 9.3.0 (Ubuntu 9.3.0-10ubuntu1) see through these efforts.
> 
> Ah, dang. :P
> 
> How about converting them all to unsized arrays, which would also allow
> the code to drop the "&" everywhere, I think. This is untested:
> 

This looks good to me since it uses same technique in sections.h.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
> index 213607a1f45c..e26a278d301a 100644
> --- a/arch/arm/include/asm/kprobes.h
> +++ b/arch/arm/include/asm/kprobes.h
> @@ -44,20 +44,20 @@ int kprobe_exceptions_notify(struct notifier_block *self,
>  			     unsigned long val, void *data);
>  
>  /* optinsn template addresses */
> -extern __visible kprobe_opcode_t optprobe_template_entry;
> -extern __visible kprobe_opcode_t optprobe_template_val;
> -extern __visible kprobe_opcode_t optprobe_template_call;
> -extern __visible kprobe_opcode_t optprobe_template_end;
> -extern __visible kprobe_opcode_t optprobe_template_sub_sp;
> -extern __visible kprobe_opcode_t optprobe_template_add_sp;
> -extern __visible kprobe_opcode_t optprobe_template_restore_begin;
> -extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn;
> -extern __visible kprobe_opcode_t optprobe_template_restore_end;
> +extern __visible kprobe_opcode_t optprobe_template_entry[];
> +extern __visible kprobe_opcode_t optprobe_template_val[];
> +extern __visible kprobe_opcode_t optprobe_template_call[];
> +extern __visible kprobe_opcode_t optprobe_template_end[];
> +extern __visible kprobe_opcode_t optprobe_template_sub_sp[];
> +extern __visible kprobe_opcode_t optprobe_template_add_sp[];
> +extern __visible kprobe_opcode_t optprobe_template_restore_begin[];
> +extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn[];
> +extern __visible kprobe_opcode_t optprobe_template_restore_end[];
>  
>  #define MAX_OPTIMIZED_LENGTH	4
>  #define MAX_OPTINSN_SIZE				\
> -	((unsigned long)&optprobe_template_end -	\
> -	 (unsigned long)&optprobe_template_entry)
> +	((unsigned long)optprobe_template_end -	\
> +	 (unsigned long)optprobe_template_entry)
>  #define RELATIVEJUMP_SIZE	4
>  
>  struct arch_optimized_insn {
> diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
> index 7a449df0b359..c78180172120 100644
> --- a/arch/arm/probes/kprobes/opt-arm.c
> +++ b/arch/arm/probes/kprobes/opt-arm.c
> @@ -85,21 +85,21 @@ asm (
>  			"optprobe_template_end:\n");
>  
>  #define TMPL_VAL_IDX \
> -	((unsigned long *)&optprobe_template_val - (unsigned long *)&optprobe_template_entry)
> +	((unsigned long *)optprobe_template_val - (unsigned long *)optprobe_template_entry)
>  #define TMPL_CALL_IDX \
> -	((unsigned long *)&optprobe_template_call - (unsigned long *)&optprobe_template_entry)
> +	((unsigned long *)optprobe_template_call - (unsigned long *)optprobe_template_entry)
>  #define TMPL_END_IDX \
> -	((unsigned long *)&optprobe_template_end - (unsigned long *)&optprobe_template_entry)
> +	((unsigned long *)optprobe_template_end - (unsigned long *)optprobe_template_entry)
>  #define TMPL_ADD_SP \
> -	((unsigned long *)&optprobe_template_add_sp - (unsigned long *)&optprobe_template_entry)
> +	((unsigned long *)optprobe_template_add_sp - (unsigned long *)optprobe_template_entry)
>  #define TMPL_SUB_SP \
> -	((unsigned long *)&optprobe_template_sub_sp - (unsigned long *)&optprobe_template_entry)
> +	((unsigned long *)optprobe_template_sub_sp - (unsigned long *)optprobe_template_entry)
>  #define TMPL_RESTORE_BEGIN \
> -	((unsigned long *)&optprobe_template_restore_begin - (unsigned long *)&optprobe_template_entry)
> +	((unsigned long *)optprobe_template_restore_begin - (unsigned long *)optprobe_template_entry)
>  #define TMPL_RESTORE_ORIGN_INSN \
> -	((unsigned long *)&optprobe_template_restore_orig_insn - (unsigned long *)&optprobe_template_entry)
> +	((unsigned long *)optprobe_template_restore_orig_insn - (unsigned long *)optprobe_template_entry)
>  #define TMPL_RESTORE_END \
> -	((unsigned long *)&optprobe_template_restore_end - (unsigned long *)&optprobe_template_entry)
> +	((unsigned long *)optprobe_template_restore_end - (unsigned long *)optprobe_template_entry)
>  
>  /*
>   * ARM can always optimize an instruction when using ARM ISA, except
> @@ -234,7 +234,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
>  	}
>  
>  	/* Copy arch-dep-instance from template. */
> -	memcpy(code, (unsigned long *)&optprobe_template_entry,
> +	memcpy(code, (unsigned long *)optprobe_template_entry,
>  			TMPL_END_IDX * sizeof(kprobe_opcode_t));
>  
>  	/* Adjust buffer according to instruction. */
> 
> -- 
> Kees Cook


-- 
Masami Hiramatsu <mhiramat@kernel.org>
