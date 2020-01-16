Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90740C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F51220728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTHCSL4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388566AbgAPV6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:58:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33637 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388409AbgAPV6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579211912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NLaw4B7huFIwZYCLSPZwzOsmw0wrqPy7mWFaVTWj5mc=;
        b=iTHCSL4XQZtr2LJ6hNcct0R6FH3PJLW/CO93NlfU1I/CWBgo3Oq0/+6HbHiTumh2vd8OD5
        yu7bGV1I64Ls1rmRElrHLTuPO5ZH9qytCCNlB6U6a9ZUTNhyMjI7nAe0twm6i9AGgQFBXn
        upaPUHlpLB6ixGHPDi6XtpcEsWp73uE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-lfqB6_TkP7qCQUyQ7P3ndA-1; Thu, 16 Jan 2020 16:58:31 -0500
X-MC-Unique: lfqB6_TkP7qCQUyQ7P3ndA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FD52100550E;
        Thu, 16 Jan 2020 21:58:30 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F4617DB4F;
        Thu, 16 Jan 2020 21:58:19 +0000 (UTC)
Date:   Fri, 17 Jan 2020 05:58:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/isolation: isolate from handling managed interrupt
Message-ID: <20200116215814.GA24827@ming.t460p>
References: <20200116094806.25372-1-ming.lei@redhat.com>
 <875zhbwqmm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zhbwqmm.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Jan 16, 2020 at 01:08:17PM +0100, Thomas Gleixner wrote:
> Ming,
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > @@ -212,12 +213,29 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
> >  {
> >  	struct irq_desc *desc = irq_data_to_desc(data);
> >  	struct irq_chip *chip = irq_data_get_irq_chip(data);
> > +	const struct cpumask *housekeeping_mask =
> > +		housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);
> >  	int ret;
> > +	cpumask_var_t tmp_mask = (struct cpumask *)mask;
> >  
> >  	if (!chip || !chip->irq_set_affinity)
> >  		return -EINVAL;
> >  
> > -	ret = chip->irq_set_affinity(data, mask, force);
> > +	zalloc_cpumask_var(&tmp_mask, GFP_ATOMIC);
> 
> I clearly told you:
> 
>     "That's wrong. This code is called with interrupts disabled, so
>      GFP_KERNEL is wrong. And NO, we won't do a GFP_ATOMIC allocation
>      here."
> 
> Is that last sentence unclear in any way?

Yeah, it is clear.

But GFP_ATOMIC is usually allowed in atomic context, could you
explain it a bit why it can't be done in this case?

We still can fallback to current behavior if the allocation
fails.

Or could you suggest to solve the issue in other way if GFP_ATOMIC
can't be done?


Thanks,
Ming

