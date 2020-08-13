Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4542EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F54D2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="zR2bfU+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHMFNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgHMFNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:13:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243ABC061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 22:13:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ep8so2206190pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 22:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=+J8A0qF/eNe42BPDc+xMFoc9GcTD6VVzaJumEar2SQc=;
        b=zR2bfU+KPhwPWrAaEka7wqg4fbcY+CJtGs5VH5TN7eC9XPdneRbLFmgKDuwdEGZEkd
         iKF5arQVHJFrokETZHdZhjDq28L5ucSC2Km/IrQ93ZxQBjoVdIgpfHn3HO7W8OfGYUnj
         4XG0hqjFA4pz1L43K8NGXCZLvxeIggMc0oX7twkIYjhdGe1XpzMwaITtf0G9d+MLjZsj
         hUI9F+XUC9W277t1VloFb81EndIFF/0mNvO4GXJzIE/IaZnonp31b4M3h875MXXSdm+6
         +utAaaq5iKMCDW4w8te35PRDt0Tqy5eBENO/EfY0SbVoNv2L017aDVH1xxYKT6Ysmpx0
         iiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=+J8A0qF/eNe42BPDc+xMFoc9GcTD6VVzaJumEar2SQc=;
        b=uUo2f2arQ1VmbbWTrJ7EyyePVus4xlybKLCfGLOaO37/5CS6qq3rMLMNgbLNYuIfsl
         FOrvLXb2s0KiNCNPDYhLkq+Y6WpIlpTMzC2p14vpCm4n6yP5BMWRpXFboFU9JO+Fjo3g
         h1gz5H5+/o5/pppeyReRXRqixk2fMbdNEP94ep5wURp5wU7OWR5lx54hM2nML3yWsDrj
         msmmjCS6v3vKqiSMTuj9nxFj2TjliiwTOJyMzGEkpgfzRLseq+1TGh6Cb2gFCWIpCIfc
         XAVqp6kUnVUPL0fsetwo7MPbbeIngl/2KcuZ4zF1iQvp1DuBxXKge2zGOXA94tA60nVB
         LdqA==
X-Gm-Message-State: AOAM533W7dSv+1wrshf7U86Wrq9Br18hgURpir67UrYbFWeZ1UYFVv2t
        UUY+t+YamRdgUuy7j9g/IyYzXA==
X-Google-Smtp-Source: ABdhPJyF6AYwTg19jJKmW4oQqCoviEKZqDJ+3nXP9DnLdpgpKoNaMloOaDfSPDQQEeQZrAHvs1F8jg==
X-Received: by 2002:a17:90a:fa11:: with SMTP id cm17mr3466801pjb.153.1597295600514;
        Wed, 12 Aug 2020 22:13:20 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f63sm3821776pjk.53.2020.08.12.22.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 22:13:19 -0700 (PDT)
Date:   Wed, 12 Aug 2020 22:13:19 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Aug 2020 22:13:18 PDT (-0700)
Subject:     Re: [PATCH] ftrace: Fixup lockdep assert held of text_mutex
In-Reply-To: <CAJF2gTQjYyNnhg8KhFEm6MwOCb=c0hNsSq=HOeuSCrOzR9Qf0Q@mail.gmail.com>
CC:     rostedt@goodmis.org, Paul Walmsley <paul.walmsley@sifive.com>,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@linux.alibaba.com,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org
Message-ID: <mhng-609449f5-6f1e-4669-8cb0-f06493d58cf2@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Aug 2020 22:01:01 PDT (-0700), guoren@kernel.org wrote:
> On Fri, Aug 7, 2020 at 12:01 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> On Fri, 7 Aug 2020 10:59:16 +0800
>> Guo Ren <guoren@kernel.org> wrote:
>> > >
>> > > This looks like a bug in the lockdep_assert_held() in whatever arch
>> > > (riscv) is running.
>> > Seems you think it's a bug of arch implementation with the wrong usage
>> > of text_mutex?
>> >
>> > Also @riscv maintainer,
>> > How about modifying it in riscv's code? we still need to solve it.
>> >
>> > ----------------
>> > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
>> > index ace8a6e..fb266c3 100644
>> > --- a/arch/riscv/include/asm/ftrace.h
>> > +++ b/arch/riscv/include/asm/ftrace.h
>> > @@ -23,6 +23,12 @@ static inline unsigned long
>> > ftrace_call_adjust(unsigned long addr)
>> >
>> >  struct dyn_arch_ftrace {
>> >  };
>> > +
>> > +#ifdef CONFIG_DYNAMIC_FTRACE
>> > +struct dyn_ftrace;
>> > +int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>> > +#define ftrace_init_nop ftrace_init_nop
>> > +#endif
>> >  #endif
>> >
>> >  #ifdef CONFIG_DYNAMIC_FTRACE
>> > diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
>> > index 2ff63d0..9e9f7c0 100644
>> > --- a/arch/riscv/kernel/ftrace.c
>> > +++ b/arch/riscv/kernel/ftrace.c
>> > @@ -97,6 +97,17 @@ int ftrace_make_nop(struct module *mod, struct
>> > dyn_ftrace *rec,
>> >         return __ftrace_modify_call(rec->ip, addr, false);
>> >  }
>> >
>> > +int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>> > +{
>> > +       int ret;
>> > +
>> > +       mutex_lock(&text_mutex);
>> > +       ret = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
>>
>> Looking at x86, we have the following code:
>>
>> static int ftrace_poke_late = 0;
>>
>> int ftrace_arch_code_modify_prepare(void)
>>     __acquires(&text_mutex)
>> {
>>         /*
>>          * Need to grab text_mutex to prevent a race from module loading
>>          * and live kernel patching from changing the text permissions while
>>          * ftrace has it set to "read/write".
>>          */
>>         mutex_lock(&text_mutex);
>>         ftrace_poke_late = 1;
>>         return 0;
>> }
>>
>> int ftrace_arch_code_modify_post_process(void)
>>     __releases(&text_mutex)
>> {
>>         /*
>>          * ftrace_make_{call,nop}() may be called during
>>          * module load, and we need to finish the text_poke_queue()
>>          * that they do, here.
>>          */
>>         text_poke_finish();
>>         ftrace_poke_late = 0;
>>         mutex_unlock(&text_mutex);
>>         return 0;
>> }
>>
>> And if ftrace_poke_late is not set, then ftrace_make_nop() does direct
>> modification (calls text_poke_early(), which is basically a memcpy).
>>
>> This path doesn't have any checks against text_mutex being held,
>> because it only happens at boot up.
> The solution is ok for me, but I want to get riscv maintainer's
> opinion before the next patch.
> @Paul Walmsley
> @Palmer Dabbelt

Sorry, I'm not really sure what's going on here.  I'm not really seeing code
that matches this in our port right now, so maybe this is aginst some other
tree?  If it's the RISC-V kprobes patch set then I was hoping to take a look at
that tomorrow (or I guess a bit earlier this week, but I had some surprise work
stuff to do).  IIRC there were a handful of races in the last patch set I saw,
but it's been a while so I don't remember for sure.

That said, I certainly wouldn't be surprised if there's a locking bug in our
ftrace stuff.  It'd be way easier for me to figure out what's going on if you
have a concrete suggestion as to how to fix the issues -- even if it's just a
workaround.

>
>>
>> > +       mutex_unlock(&text_mutex);
>> > +
>> > +       return ret;
>> > +}
>> > +
>> >  int ftrace_update_ftrace_func(ftrace_func_t func)
>> >  {
>> >         int ret = __ftrace_modify_call((unsigned long)&ftrace_call,
>> > -------------------
>> >
>> > > > --- a/kernel/trace/ftrace.c
>> > > > +++ b/kernel/trace/ftrace.c
>> > > > @@ -26,6 +26,7 @@
>> > > >  #include <linux/uaccess.h>
>> > > >  #include <linux/bsearch.h>
>> > > >  #include <linux/module.h>
>> > > > +#include <linux/memory.h>
>> > > >  #include <linux/ftrace.h>
>> > > >  #include <linux/sysctl.h>
>> > > >  #include <linux/slab.h>
>> > > > @@ -6712,9 +6713,11 @@ void __init ftrace_init(void)
>> > >
>> > > ftrace_init() is called before SMP is initialized. Nothing else should
>> > > be running here. That means grabbing a mutex is useless.
>> > I don't agree, ftrace_init are modifying kernel text, so we should
>> > give the lock of text_mutex to keep semantic consistency.
>>
>>
>> Did you test your patch on x86 with lockdep?
> Ah.., no :P
>
>>
>> ftrace_process_locs() grabs the ftrace_lock, which I believe is held
>> when text_mutex is taken in other locations. So this will probably not
>> work anyway.
>>
>> text_mutex isn't to be taken at the ftrace level.
> Yes, currently it seemed only to be used by kernel/kprobes.c.
