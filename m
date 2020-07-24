Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0993C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B195E206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595602645;
	bh=UAvrshxQEJ0Ykt7yvu37iIenplAoYeh9Ny04iEuSMGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wf/Wtqw7vtTwqzvzzJUviBK/hjlOi2Bs4Aa6+TIVR9FE7RkjDYhnDv6nsVtQZaWXQ
	 NHvbdz5wFTH3vTDKu9PewjWzH9ZGAOQWGAapdmY84HorKpmkIVeFBAP7XQBpY6/pw5
	 E2ys8zFz1Sb5k4sggQAT8hH1TPhFXuTq1DMIpMAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGXO5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXO5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:57:24 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FF1B206D8;
        Fri, 24 Jul 2020 14:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595602643;
        bh=UAvrshxQEJ0Ykt7yvu37iIenplAoYeh9Ny04iEuSMGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=crC5S/FGJPAWRBT9ywxQN/+7BmOHwIP6uS8JJxRhcF24ZZFiW7/n6ooDey+u2lHjL
         +Z9LNEz5VWQTMMlZj1QTz5KdYzPnqSv2afZS3EfbTpgwlcwuhYfMhXRAFfWIaJO64+
         9jnMvXCY8vIBQoQCZnMZtHvWrU031I+B42EQBeu0=
Date:   Fri, 24 Jul 2020 23:57:19 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()
Message-Id: <20200724235719.a64952a8a92a42db9ea0cd94@kernel.org>
In-Reply-To: <20200724102748.GD2831654@kernel.org>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
        <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
        <20200724102748.GD2831654@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 13:27:48 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> On Fri, Jul 24, 2020 at 08:05:52AM +0300, Jarkko Sakkinen wrote:
> > Use text_alloc() and text_free() instead of module_alloc() and
> > module_memfree() when an arch provides them.
> > 
> > Cc: linux-mm@kvack.org
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  kernel/kprobes.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 4e46d96d4e16..611fcda9f6bf 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -40,6 +40,7 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/errno.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/vmalloc.h>
> >  
> >  #define KPROBE_HASH_BITS 6
> >  #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
> > @@ -111,12 +112,20 @@ enum kprobe_slot_state {
> >  
> >  void __weak *alloc_insn_page(void)
> >  {
> > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > +	return text_alloc(PAGE_SIZE);
> > +#else
> >  	return module_alloc(PAGE_SIZE);
> > +#endif
> >  }
> >  
> >  void __weak free_insn_page(void *page)
> >  {
> > +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> > +	text_free(page);
> > +#else
> >  	module_memfree(page);
> > +#endif
> >  }
> 
> Both alloc_insn_page() and free_insn_page() are __weak and can be simple
> overriden in arch/x86 code.

No, we can't use module_alloc/memfree() without CONFIG_MODULES, so
we can not escape from this #ifdefs. (and I think this is not so bad.)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
