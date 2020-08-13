Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7684C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACCFD20781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iCF8GCR+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hGxrqA03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHMIIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:08:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56930 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMIIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:08:49 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597306127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=okLOdd4hFigu3F8BJVOWQHTTv93/xVX4l7N8L/QNtPw=;
        b=iCF8GCR+vz1Zr7a4sw4CrWOwg2Coe+3Atwa6XZPGJ0vulQKW6CQUFKKZP0YDkWp3PSMSuG
        +zny4uqgT9R6l2B0v3H0EPq9l2OK/2Cs+PbGgr0SIIUkhZ0MkKpzFqPSqUtrSZienATRje
        2YBCbWKWZSYRGyD2FlYbcTeuB7SQ0QTwnzf1qoRXklulR0d/ig/rY+XLyTnWFYoqzh9Ulk
        TgAqGrzTn0cqmWI59vFs2ijjh1g2K+AsPgpGUzLECSM0d5E9rTDe9JkqrbGzlX71qo1wJy
        f2EHkKUqrSl52F+CtofuBBJOU3dMAafSuNjw7OLbkNwfFgZj6hBi+nrOLNyunA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597306127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=okLOdd4hFigu3F8BJVOWQHTTv93/xVX4l7N8L/QNtPw=;
        b=hGxrqA03ITU7sVs4lNkl0pqnF8U5L9oMk/Y4jeyWjWhLA1NsXUyJNymgQNxPt7ncUOTsYB
        88k+ATL2WPToHoCw==
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/affinity: show managed irq affinity correctly
In-Reply-To: <b55d8b8c-8afc-0046-44b6-514ad012936f@huawei.com>
References: <b55d8b8c-8afc-0046-44b6-514ad012936f@huawei.com>
Date:   Thu, 13 Aug 2020 10:08:46 +0200
Message-ID: <877du355o1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yunfeng Ye <yeyunfeng@huawei.com> writes:

> The "managed_irq" for isolcpus is supported after the commit
> 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed
> interrupts"), but the interrupt affinity shown in proc directory is
> still the original affinity.
>
> So modify the interrupt affinity correctly for managed_irq.

I really have no idea what you are trying to achieve here.

1) Why are you moving the !chip !chip->irq_set_affinity check out of
   irq_do_set_affinity() ?

   Just that the whole computation happens for nothing and then returns
   an error late.

2) Modifying irqdata->common->affinity is wrong to begin with. It's the
   possible affinity mask. Your change causes the managed affinity mask
   to become invalid in the worst case.

      irq->affinity = 0x0C;        // CPU 2 - 3
      hkmask   = 0x07;             // CPU 0 - 2

   Invocation #1:
      online_mask = 0xFF;          // CPU 0 - 7

      cpumask_and(&tmp_mask, mask, hk_mask);
         -->   tmp_mask == 0x04    // CPU 2

      irq->affinity = tmp_mask;	   // CPU 2

   CPU 2 goes offline

   migrate_one_irq()

      affinity = irq->affinity;	  // CPU 2
      online_mask = 0xFB;         // CPU 0-1, 3-7

      if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
		/*
		 * If the interrupt is managed, then shut it down and leave
		 * the affinity untouched.
		 */
		if (irqd_affinity_is_managed(d)) {
			irqd_set_managed_shutdown(d);
			irq_shutdown_and_deactivate(desc);
			return false;
		}

  So the interrupt is shut down which is incorrect. The isolation
  logic in irq_do_set_affinity() was clearly designed to prefer
  housekeeping CPUs and not to remove them.
    
You are looking at the wrong file. /proc/irq/$IRQ/smp_affinity* is the
possible mask. If you want to know to which CPU an interrupt is affine
then look at /proc/irq/$IRQ/effective_affinity*

If effective_affinity* is not showing the correct value, then the irq
chip affinity setter is broken and needs to be fixed.

Thanks,

        tglx
