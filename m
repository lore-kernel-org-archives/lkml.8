Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1275C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7778206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBJI9IFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGWHP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgGWHP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:15:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3ADC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:15:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m9so2562207pfh.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=VR/NDI+ozBpNv5i6H/LGSP7yoKE3iYE0zpP1AoTLlT4=;
        b=vBJI9IFDmZI6MiAf44fmljKRlbNnO4ZasFgKep1ex6LosYIIjo7torR6Ha5JPVbJyi
         BUFOmrX9GjX3APpo8ePyWe5/tv52Ui8mgvJ2HIbGs/4ksEDKwvUvDKJvS0JtmNosYul8
         WU7MDmGbryziAdjmAEBxK5SHy08IdMCHtNsaW3uaW69IliUBMSTIrfBEb1Sx9+GwXB/V
         ukB55bHNP2CSZmKhap+0BSS8woaOKYyF/sj4/vvjnCmOE3AFjRshI+ei0J8nvisj+bpG
         n4tP4VCaKkZh12Wxr/pJUkswnaJSor7TVKDDoDFgJUjNYq2mCP37r2iZYOz9rDxCQEgg
         jE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=VR/NDI+ozBpNv5i6H/LGSP7yoKE3iYE0zpP1AoTLlT4=;
        b=lvNj94SFbTuBB4FfaxY3WGyn3VktWMl4StmOageP7EZZQg25RMOZXAK5czyIR6ZgCM
         I21+4+h0+K1A0muDqONnX9OoncYDdMAoapQ3STkNIZSNaRSX+i7b9reya7O30qxplk/7
         S6SfanJsY1RPxE2M5UxxpwR8cwMTbrXNNYAFc95sP/2f0P4LdzVo4JkG2yih7QC7T9FW
         JdUC939wxylsNVlDVC0R3VnnOV00YHZ+lKc85CKxnWm4o4SIr9OQSlWmf5IYUKXM2lYs
         wH7n+29Z/bfzzQNm1+H7YsohDJTpTB3xyw7fyO65nbao7YT1fdSyS+wPfs9MdOmG/8hn
         g/jA==
X-Gm-Message-State: AOAM530ado+KSSLBUk1vl+SyH4LSq955e2FwqeFK2X8+Ejh/O3XFd/6u
        HX1bbmEN3OPI2mPk4H+sOjc=
X-Google-Smtp-Source: ABdhPJw3nLDvjjVOGNbiGEyZt1VIatOakEbUn0NLgXBisL8qGgxdARcSXmlZIpvzylWYjrjh048ocg==
X-Received: by 2002:a63:9246:: with SMTP id s6mr3009420pgn.22.1595488557986;
        Thu, 23 Jul 2020 00:15:57 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id q5sm1784616pfc.130.2020.07.23.00.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 00:15:57 -0700 (PDT)
Date:   Thu, 23 Jul 2020 17:15:51 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3] mm: Fix kthread_use_mm() vs TLB invalidate
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     axboe@kernel.dk, hch@lst.de, jannh@google.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, mathieu.desnoyers@efficios.com,
        torvalds@linux-foundation.org, will@kernel.org
References: <20200721154106.GE10769@hirez.programming.kicks-ass.net>
        <20200721140623.4e8ecc6ef5d5ff42115d68fc@linux-foundation.org>
        <20200722083533.GK10769@hirez.programming.kicks-ass.net>
In-Reply-To: <20200722083533.GK10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1595487967.kclapwroks.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 22, 2020 6:35 pm:
> On Tue, Jul 21, 2020 at 02:06:23PM -0700, Andrew Morton wrote:
>> On Tue, 21 Jul 2020 17:41:06 +0200 Peter Zijlstra <peterz@infradead.org>=
 wrote:
>>=20
>> >=20
>> > For SMP systems using IPI based TLB invalidation, looking at
>> > current->active_mm is entirely reasonable. This then presents the
>> > following race condition:
>> >=20
>> >=20
>> >   CPU0			CPU1
>> >=20
>> >   flush_tlb_mm(mm)	use_mm(mm)
>> >     <send-IPI>
>> > 			  tsk->active_mm =3D mm;
>> > 			  <IPI>
>> > 			    if (tsk->active_mm =3D=3D mm)
>> > 			      // flush TLBs
>> > 			  </IPI>
>> > 			  switch_mm(old_mm,mm,tsk);
>> >=20
>> >=20
>> > Where it is possible the IPI flushed the TLBs for @old_mm, not @mm,
>> > because the IPI lands before we actually switched.
>> >=20
>> > Avoid this by disabling IRQs across changing ->active_mm and
>> > switch_mm().
>> >=20
>> > [ There are all sorts of reasons this might be harmless for various
>> > architecture specific reasons, but best not leave the door open at
>> > all. ]
>>=20
>> Can we give the -stable maintainers (and others) more explanation of
>> why they might choose to merge this?
>=20
> Like so then?
>=20
> ---
> Subject: mm: Fix kthread_use_mm() vs TLB invalidate
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue, 11 Feb 2020 10:25:19 +0100
>=20
> For SMP systems using IPI based TLB invalidation, looking at
> current->active_mm is entirely reasonable. This then presents the
> following race condition:
>=20
>=20
>   CPU0			CPU1
>=20
>   flush_tlb_mm(mm)	use_mm(mm)
>     <send-IPI>
> 			  tsk->active_mm =3D mm;
> 			  <IPI>
> 			    if (tsk->active_mm =3D=3D mm)
> 			      // flush TLBs
> 			  </IPI>
> 			  switch_mm(old_mm,mm,tsk);
>=20
>=20
> Where it is possible the IPI flushed the TLBs for @old_mm, not @mm,
> because the IPI lands before we actually switched.
>=20
> Avoid this by disabling IRQs across changing ->active_mm and
> switch_mm().
>=20
> Of the (SMP) architectures that have IPI based TLB invalidate:
>=20
>   Alpha    - checks active_mm
>   ARC      - ASID specific
>   IA64     - checks active_mm
>   MIPS     - ASID specific flush
>   OpenRISC - shoots down world
>   PARISC   - shoots down world
>   SH       - ASID specific
>   SPARC    - ASID specific
>   x86      - N/A
>   xtensa   - checks active_mm
>=20
> So at the very least Alpha, IA64 and Xtensa are suspect.
>=20
> On top of this, for scheduler consistency we need at least preemption
> disabled across changing tsk->mm and doing switch_mm(), which is
> currently provided by task_lock(), but that's not sufficient for
> PREEMPT_RT.
>=20
> Reported-by: Andy Lutomirski <luto@amacapital.net>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: stable@kernel.org
> ---
>  kernel/kthread.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1241,13 +1241,20 @@ void kthread_use_mm(struct mm_struct *mm
>  	WARN_ON_ONCE(tsk->mm);
> =20
>  	task_lock(tsk);
> +	/*
> +	 * Serialize the tsk->mm store and switch_mm() against TLB invalidation
> +	 * IPIs. Also make sure we're non-preemptible on PREEMPT_RT to not race
> +	 * against the scheduler writing to these variables.
> +	 */
> +	local_irq_disable();
>  	active_mm =3D tsk->active_mm;
>  	if (active_mm !=3D mm) {
>  		mmgrab(mm);
>  		tsk->active_mm =3D mm;
>  	}
>  	tsk->mm =3D mm;
> -	switch_mm(active_mm, mm, tsk);
> +	switch_mm_irqs_off(active_mm, mm, tsk);
> +	local_irq_enable();
>  	task_unlock(tsk);
>  #ifdef finish_arch_post_lock_switch
>  	finish_arch_post_lock_switch();
> @@ -1276,9 +1283,11 @@ void kthread_unuse_mm(struct mm_struct *
> =20
>  	task_lock(tsk);
>  	sync_mm_rss(mm);
> +	local_irq_disable();
>  	tsk->mm =3D NULL;
>  	/* active_mm is still 'mm' */
>  	enter_lazy_tlb(mm, tsk);
> +	local_irq_enable();
>  	task_unlock(tsk);
>  }
>  EXPORT_SYMBOL_GPL(kthread_unuse_mm);
>=20

Oh good, this is also needed as part of my preferred fix for the=20
io_uring mmget_not_zero->use_mm() vs mm_cpumask problem

https://marc.info/?l=3Dlinux-mm&m=3D159520550112106&w=3D2

I'll try to do arch fixes on top of this (I have the same hunks
locally!). After that, we should be able to allow mmget_not_zero
to be first class references to mm AFAIKS.

Thanks,
Nick
