Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF09C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 01:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDAC20709
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 01:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHSBT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 21:19:59 -0400
Received: from smtprelay0125.hostedemail.com ([216.40.44.125]:40192 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgHSBT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 21:19:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A882B181D330D;
        Wed, 19 Aug 2020 01:19:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wash41_4712ceb27023
X-Filterd-Recvd-Size: 2169
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Aug 2020 01:19:55 +0000 (UTC)
Message-ID: <3ca05f10dec479a70f6c33274ded8d4fab9c01ec.camel@perches.com>
Subject: Re: [PATCH v2 11/25] powerpc/signal: Refactor bad frame logging
From:   Joe Perches <joe@perches.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 18:19:54 -0700
In-Reply-To: <fa094445c119fc00315e1c13783b493346306c6a.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
         <fa094445c119fc00315e1c13783b493346306c6a.1597770847.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-18 at 17:19 +0000, Christophe Leroy wrote:
> The logging of bad frame appears half a dozen of times
> and is pretty similar.
[]
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
[]
> @@ -355,3 +355,14 @@ static unsigned long get_tm_stackpointer(struct task_struct *tsk)
>  #endif
>  	return ret;
>  }
> +
> +static const char fm32[] = KERN_INFO "%s[%d]: bad frame in %s: %p nip %08lx lr %08lx\n";
> +static const char fm64[] = KERN_INFO "%s[%d]: bad frame in %s: %p nip %016lx lr %016lx\n";

Why not remove this and use it in place with
%08lx/%016x used as %px with a case to (void *)?

> +void signal_fault(struct task_struct *tsk, struct pt_regs *regs,
> +		  const char *where, void __user *ptr)
> +{
> +	if (show_unhandled_signals)
> +		printk_ratelimited(regs->msr & MSR_64BIT ? fm64 : fm32, tsk->comm,
> +				   task_pid_nr(tsk), where, ptr, regs->nip, regs->link);

	pr_info_ratelimited("%s[%d]: bad frame in %s: %p nip %016lx lr %016lx\n",
			    tsk->comm, task_pid_nr(tsk), where, ptr,
			    (void *)regs->nip, (void *)regs->link);


