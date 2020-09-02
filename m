Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA25C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D9520658
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dckr91+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgICO6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729083AbgICOJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599142150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AsDU97yPtXUIgx3X3eSsp3sqqPMSM2dtQaXgynJpGX8=;
        b=Dckr91+/2we/Y94xJgypUfDGcI7AmWZXGKYkfKdi8BowdfS/Dq1848M2KpMDh0bq7Z7RlK
        l0GiRwrVRjskh7VJkVuen/EBx2zZzeIf0Yw+o1caL1/mig6dqqlD4sqLFXpJ9D6sgItig9
        GTWFunrYQjA58ZaxyKxbFPCuk0dimYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-IrTADZdnNQq1I3hpiR1V-Q-1; Thu, 03 Sep 2020 09:27:50 -0400
X-MC-Unique: IrTADZdnNQq1I3hpiR1V-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC4EE10199A6;
        Thu,  3 Sep 2020 13:27:49 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A8F0105DFA1;
        Thu,  3 Sep 2020 13:27:49 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id C55A74168BB3; Wed,  2 Sep 2020 16:42:40 -0300 (-03)
Date:   Wed, 2 Sep 2020 16:42:40 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] nohz: try to avoid IPI when configuring per-CPU
 posix timer
Message-ID: <20200902194240.GA986833@fuller.cnet>
References: <20200825184147.948670309@fuller.cnet>
 <20200825184414.442457749@fuller.cnet>
 <20200901233858.GA9322@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901233858.GA9322@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 01:38:59AM +0200, Frederic Weisbecker wrote:
> On Tue, Aug 25, 2020 at 03:41:48PM -0300, Marcelo Tosatti wrote:
> > When enabling per-CPU posix timers, an IPI to nohz_full CPUs might be
> > performed (to re-read the dependencies and possibly not re-enter
> > nohz_full on a given CPU).
> > 
> > A common case is for applications that run on nohz_full= CPUs 
> > to not use POSIX timers (eg DPDK). This patch skips the IPI 
> > in case the task allowed mask does not intersect with nohz_full= CPU mask,
> > when going through tick_nohz_dep_set_signal.
> > 
> > This reduces interruptions to nohz_full= CPUs.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> [...]
> >  /*
> > + * Set bit on nohz full dependency, kicking all cpus
> > + * only if task can run on nohz full CPUs.
> > + */
> > +static void tick_nohz_dep_set_all_cond(struct task_struct *tsk,
> > +				       atomic_t *dep,
> > +				       enum tick_dep_bits bit)
> > +{
> > +	int prev;
> > +	unsigned long flags;
> > +
> > +	prev = atomic_fetch_or(BIT(bit), dep);
> > +	if (prev)
> > +		return;
> > +
> > +	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
> > +	if (cpumask_intersects(&tsk->cpus_mask, tick_nohz_full_mask))
> > +		tick_nohz_full_kick_all();
> 
> So that's for one task but what about the other threads in that
> process? We are setting the tick dependency on all tasks sharing that
> struct signal.

Hi Frederic,

Yep, fixing in -v2, thanks.


