Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F53C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F51322D00
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5kHZzSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgHEQ4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgHEQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:52:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FA8C0A889A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 06:59:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d190so5915177wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YePFlbgRyxtaEPeLEBJjJwQHaLa9kCxqtVKAjxXaA4s=;
        b=Z5kHZzSnP9D+z1S1WsCu3aU+IDWEOuiM0ivLzH6g4d78Fby9txad2tOtD4VRLX0SON
         bo2WmnHAebg1AO2RIEm869SD1tvMwl8PEaBPsEAVZPtvoelB5eNntVjHBEt792WPCvyM
         T2IW81BKntuaM9mYeIEK1ucA5T9vTVaPSCsXS3QkZbj+pec+NtmUUv4BG05QPXsim03v
         j10AWvoudWWqL3+g2ezwYQbIawxphTcsuOHXkc6PYaiJjmmylbxHnh5dKvT9OVxdgsd/
         PHReDlxwHaflM4HJKK0naHGVRMYSpIwHLj8pHWlhIoc07Y84msqkwko0powOpxjZaoOh
         0nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YePFlbgRyxtaEPeLEBJjJwQHaLa9kCxqtVKAjxXaA4s=;
        b=naqgIPJJG6qCiPhwzOimPa3InCserSodto6UxSSvNab7UAXRE2kohSpUCLSFuRg5fb
         YdIjJ5jEFwzn6dKsCui6gAhIJrNmg+Znx2PHR+xaJFv2W+icrnAl0sEA1qB8pwKJCA7f
         4+6AbBw8xxsZjL8T/ge85umi8tBwroPqM9sJfKw8iTBQrxWUd9HxNLw9z+TcZRQs5rz8
         gRBeQAXdE7JmexqrjDuj51atAkm7DeSk1PQojZF/6xgn2lkT32ev41rZVH2LGHmeGJ0K
         EX4oZmRWgL5scz3r89ZkN56IFPdr2sapuTp0LOZKTorjhIzAi5oXKGBae10yp97Mbbn8
         kiHA==
X-Gm-Message-State: AOAM532JGtu6SDVRyxyONvMB20Ox1j4PhqVPUd4V/MC+QU8KarVQRmLX
        z7bZnXDvYT1UVy/eCql/9d7Ziw==
X-Google-Smtp-Source: ABdhPJwtRJzQ0YudQiBCt4tmSW3vYnOL4vBIiSdBd03aC1QgGCDZKLTzEBmUkGpDmRTC7l9G+9mOWw==
X-Received: by 2002:a1c:96d7:: with SMTP id y206mr3357845wmd.9.1596635986525;
        Wed, 05 Aug 2020 06:59:46 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id p15sm2823841wrj.61.2020.08.05.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:59:45 -0700 (PDT)
Date:   Wed, 5 Aug 2020 15:59:40 +0200
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, fenghua.yu@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org, yu-cheng.yu@intel.com,
        jgross@suse.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev@googlegroups.com,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*()
 helpers
Message-ID: <20200805135940.GA156343@elver.google.com>
References: <0000000000007d3b2d05ac1c303e@google.com>
 <20200805132629.GA87338@elver.google.com>
 <20200805134232.GR2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134232.GR2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 03:42PM +0200, peterz@infradead.org wrote:
> On Wed, Aug 05, 2020 at 03:26:29PM +0200, Marco Elver wrote:
> > Add missing noinstr to arch_local*() helpers, as they may be called from
> > noinstr code.
> > 
> > On a KCSAN config with CONFIG_PARAVIRT=y, syzbot stumbled across corrupt
> 
> Cute, so I've been working on adding objtool support for this a little:
> 
>   https://lkml.kernel.org/r/20200803143231.GE2674@hirez.programming.kicks-ass.net
> 
> > diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> > index 3d2afecde50c..a606f2ba2b5e 100644
> > --- a/arch/x86/include/asm/paravirt.h
> > +++ b/arch/x86/include/asm/paravirt.h
> > @@ -760,27 +760,27 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
> >  	((struct paravirt_callee_save) { func })
> >  
> >  #ifdef CONFIG_PARAVIRT_XXL
> > -static inline notrace unsigned long arch_local_save_flags(void)
> > +static inline noinstr unsigned long arch_local_save_flags(void)
> >  {
> >  	return PVOP_CALLEE0(unsigned long, irq.save_fl);
> >  }
> >  
> > -static inline notrace void arch_local_irq_restore(unsigned long f)
> > +static inline noinstr void arch_local_irq_restore(unsigned long f)
> >  {
> >  	PVOP_VCALLEE1(irq.restore_fl, f);
> >  }
> >  
> > -static inline notrace void arch_local_irq_disable(void)
> > +static inline noinstr void arch_local_irq_disable(void)
> >  {
> >  	PVOP_VCALLEE0(irq.irq_disable);
> >  }
> >  
> > -static inline notrace void arch_local_irq_enable(void)
> > +static inline noinstr void arch_local_irq_enable(void)
> >  {
> >  	PVOP_VCALLEE0(irq.irq_enable);
> >  }
> >  
> > -static inline notrace unsigned long arch_local_irq_save(void)
> > +static inline noinstr unsigned long arch_local_irq_save(void)
> >  {
> >  	unsigned long f;
> >  
> 
> Shouldn't we __always_inline those? They're going to be really small.

I can send a v2, and you can choose. For reference, though:

	ffffffff86271ee0 <arch_local_save_flags>:
	ffffffff86271ee0:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
	ffffffff86271ee5:       48 83 3d 43 87 e4 01    cmpq   $0x0,0x1e48743(%rip)        # ffffffff880ba630 <pv_ops+0x120>
	ffffffff86271eec:       00
	ffffffff86271eed:       74 0d                   je     ffffffff86271efc <arch_local_save_flags+0x1c>
	ffffffff86271eef:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
	ffffffff86271ef4:       ff 14 25 30 a6 0b 88    callq  *0xffffffff880ba630
	ffffffff86271efb:       c3                      retq
	ffffffff86271efc:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
	ffffffff86271f01:       0f 0b                   ud2
	ffffffff86271f03:       66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
	ffffffff86271f0a:       00 00 00 00
	ffffffff86271f0e:       66 90                   xchg   %ax,%ax

	[...]

	ffffffff86271a90 <arch_local_irq_restore>:
	ffffffff86271a90:       53                      push   %rbx
	ffffffff86271a91:       48 89 fb                mov    %rdi,%rbx
	ffffffff86271a94:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
	ffffffff86271a99:       48 83 3d 97 8b e4 01    cmpq   $0x0,0x1e48b97(%rip)        # ffffffff880ba638 <pv_ops+0x128>
	ffffffff86271aa0:       00
	ffffffff86271aa1:       74 11                   je     ffffffff86271ab4 <arch_local_irq_restore+0x24>
	ffffffff86271aa3:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
	ffffffff86271aa8:       48 89 df                mov    %rbx,%rdi
	ffffffff86271aab:       ff 14 25 38 a6 0b 88    callq  *0xffffffff880ba638
	ffffffff86271ab2:       5b                      pop    %rbx
	ffffffff86271ab3:       c3                      retq
	ffffffff86271ab4:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
	ffffffff86271ab9:       0f 0b                   ud2
	ffffffff86271abb:       cc                      int3
	ffffffff86271abc:       cc                      int3
	ffffffff86271abd:       cc                      int3
	ffffffff86271abe:       cc                      int3
	ffffffff86271abf:       cc                      int3

	[... and the rest looking of similar size.]

Thanks,
-- Marco
