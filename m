Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E295C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168A42080D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOIRCA/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgFQWt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:49:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50196 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726909AbgFQWt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592434197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=orWx+/3XMb05Rqs5NYz0sIWDOdOQGOdIAEzCS5djo9E=;
        b=IOIRCA/+0CP3fAJCQ1lbEo/TiqppwUdzhM5pkJ7fSf9zqZy5oRag5zD32EG+ClHjN/7YPi
        aa2WKF4m+X4zzkw5B63fnQMQmmaNkhcLPf0IHFG4yRJTEGadEVeaGdpLpNPZKxFg9yNscy
        jo+TRyeIte3RAh2k9LF179I1EhWc0z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-kidHweHCNA6cszRyDcFJqg-1; Wed, 17 Jun 2020 18:49:55 -0400
X-MC-Unique: kidHweHCNA6cszRyDcFJqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFAF78005AD;
        Wed, 17 Jun 2020 22:49:53 +0000 (UTC)
Received: from ovpn-112-150.phx2.redhat.com (ovpn-112-150.phx2.redhat.com [10.3.112.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70EB85D9D3;
        Wed, 17 Jun 2020 22:49:49 +0000 (UTC)
Message-ID: <696309d91635fa965ad8436388e7ae7d098420a1.camel@redhat.com>
Subject: Re: [PATCH] sched: __set_cpus_allowed_ptr(): Check cpus_mask, not
 cpus_ptr
From:   Scott Wood <swood@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 17 Jun 2020 17:49:48 -0500
In-Reply-To: <jhjmu51eq2k.mognet@arm.com>
References: <20200617121742.cpxppyi7twxmpin7@linutronix.de>
         <jhjmu51eq2k.mognet@arm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-17 at 15:15 +0100, Valentin Schneider wrote:
> On 17/06/20 13:17, Sebastian Andrzej Siewior wrote:
> > From: Scott Wood <swood@redhat.com>
> > 
> > This function is concerned with the long-term cpu mask, not the
> > transitory mask the task might have while migrate disabled.  Before
> > this patch, if a task was migrate disabled at the time
> > __set_cpus_allowed_ptr() was called, and the new mask happened to be
> > equal to the cpu that the task was running on, then the mask update
> > would be lost.
> > 
> > Signed-off-by: Scott Wood <swood@redhat.com>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  kernel/sched/core.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1637,7 +1637,7 @@ static int __set_cpus_allowed_ptr(struct
> >               goto out;
> >       }
> > 
> > -	if (cpumask_equal(p->cpus_ptr, new_mask))
> > +	if (cpumask_equal(&p->cpus_mask, new_mask))
> >               goto out;
> > 
> >       /*
> 
> Makes sense, but what about the rest of the checks? Further down there is
> 
>         /* Can the task run on the task's current CPU? If so, we're done
> */
>         if (cpumask_test_cpu(task_cpu(p), new_mask))
>                 goto out;
> 
> If the task is currently migrate disabled and for some stupid reason it
> gets affined elsewhere, we could try to move it out - which AFAICT we
> don't
> want to do because migrate disabled. So I suppose you'd want an extra
> bailout condition here when the task is migrate disabled.
> 
> ISTR in RT you do re-check the affinity and potentially move the task away
> when re-enabling migration, so that should work out all fine.

On RT the above test is:

        /* Can the task run on the task's current CPU? If so, we're done */
        if (cpumask_test_cpu(task_cpu(p), new_mask) ||
            p->cpus_ptr != &p->cpus_mask)
                goto out;

...so we do bail out if we're migrate disabled.

-Scott


