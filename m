Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678B2C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3AA20674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6FGnNcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgBDRAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:00:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28604 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727363AbgBDRAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580835645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BFdwVowO5Pc/LBG+Jvt+X7iJw2Gji+5wFzeYmAIGpEU=;
        b=S6FGnNcHwNqhNC7PVm6atCEtANhjzH/5L6LVGd9X1VVXmMFX9XvwZq4jL1OH9Lo+sAzVni
        2tltMTfT6YA3VXAEbUG0l6+QQwmqV3c7QLzF09RFqBQRLO0roJcShvS/JQC4weMLEGJOaH
        RriqO13Nt2hC7+z9gz4YTyI0QbXoWhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-zrgRukzwM56pnykmTZdjjg-1; Tue, 04 Feb 2020 12:00:43 -0500
X-MC-Unique: zrgRukzwM56pnykmTZdjjg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4510C108838D;
        Tue,  4 Feb 2020 17:00:42 +0000 (UTC)
Received: from ovpn-116-174.phx2.redhat.com (ovpn-116-174.phx2.redhat.com [10.3.116.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A17871001B0B;
        Tue,  4 Feb 2020 17:00:41 +0000 (UTC)
Message-ID: <590e957e57f2fd83e583450c358e3282e5493709.camel@redhat.com>
Subject: Re: [PATCH] sched/core: sched_tick_remote: Remove duplicate
 assignment
From:   Scott Wood <swood@redhat.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Date:   Tue, 04 Feb 2020 11:00:41 -0600
In-Reply-To: <20200204142718.GA23972@pauld.bos.csb>
References: <1580776558-12882-1-git-send-email-swood@redhat.com>
         <20200204142718.GA23972@pauld.bos.csb>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-04 at 09:27 -0500, Phil Auld wrote:
> Hi Scott,
> 
> On Mon, Feb 03, 2020 at 07:35:58PM -0500 Scott Wood wrote:
> > A redundant "curr = rq->curr" was added; remove it.
> > 
> > Fixes: ebc0f83c78a2 ("timers/nohz: Update NOHZ load in remote tick")
> > Signed-off-by: Scott Wood <swood@redhat.com>
> > ---
> >  kernel/sched/core.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 45f79bcc3146..377ec26e9159 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3683,7 +3683,6 @@ static void sched_tick_remote(struct work_struct
> > *work)
> >  	if (cpu_is_offline(cpu))
> >  		goto out_unlock;
> >  
> > -	curr = rq->curr;
> >  	update_rq_clock(rq);
> >  
> >  	if (!is_idle_task(curr)) {
> > -- 
> > 1.8.3.1
> > 
> 
> Reviewed-by: Phil Auld <pauld@redhat.com>
> 
> Out of curiosity, why remove this one and not the one right before the 
> cpu_is_offline check?

This was the one that was recently added by mistake.

-Scott


