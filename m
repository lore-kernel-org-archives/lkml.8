Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7156C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD95320736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eaSzW00D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgDWIrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 04:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:47:06 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA938C03C1AF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 01:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pdOPuyAEsL0uTW547isQ3x2UrY6A2JZipdSfI4TDH+o=; b=eaSzW00DUSBBbn/OWLhd07a5Vf
        gFxPFHWEN58PlGfVTwU126p0M/FLh6VB6I8VwF1+GwbtmqGZc94vnNpexjDjcgEHQ2DmDk2RTj4A4
        fr5p8pnnLuPTKqw5z9KRic5rumyAbZyXq/GEgDq441mWKmQAxlGC4CDo8lLFxMpKBTjHT2XdnnlqU
        p3WASS7gBokwwT8n4eGZzLYkDnwf8FYVA4Xewke4nGp+yznD28/m51DUHPg7I6uAyPAA+MUbhUWc5
        jSgZP01tPnIGKIlmk9fHYbd/FyYdkC3niXjZAPm5Ug7zzLkgwTh4Z2vXb7gNi+J+xXpTEzIgCUs1M
        SY22pWbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRXV7-0002uN-Im; Thu, 23 Apr 2020 08:46:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D02C93010C8;
        Thu, 23 Apr 2020 10:46:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F19A20BE0448; Thu, 23 Apr 2020 10:46:26 +0200 (CEST)
Date:   Thu, 23 Apr 2020 10:46:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, bsegall@google.com, mgorman@suse.de,
        rafael.j.wysocki@intel.com
Subject: Re: [PATCH 04/23] sched,acpi_pad: Convert to sched_set_fifo*()
Message-ID: <20200423084626.GT20713@hirez.programming.kicks-ass.net>
References: <20200422112719.826676174@infradead.org>
 <20200422112831.455977635@infradead.org>
 <c620bb30-eeee-336b-f8d6-a98e903a48e2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c620bb30-eeee-336b-f8d6-a98e903a48e2@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 06:45:36PM +0200, Dietmar Eggemann wrote:
> On 22/04/2020 13:27, Peter Zijlstra wrote:
> > Because SCHED_FIFO is a broken scheduler model (see previous patches)
> > take away the priority field, the kernel can't possibly make an
> > informed decision.
> > 
> > In this case, use fifo_low, because it only cares about being above
> > SCHED_NORMAL. Effectively no change in behaviour.
> > 
> > XXX: this driver is still complete crap; why isn't it using proper
> > idle injection or at the very least play_idle() ?
> > 
> > Cc: rafael.j.wysocki@intel.com
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  drivers/acpi/acpi_pad.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > --- a/drivers/acpi/acpi_pad.c
> > +++ b/drivers/acpi/acpi_pad.c
> > @@ -136,12 +136,11 @@ static unsigned int idle_pct = 5; /* per
> >  static unsigned int round_robin_time = 1; /* second */
> >  static int power_saving_thread(void *data)
> >  {
> > -	struct sched_param param = {.sched_priority = 1};
> >  	int do_sleep;
> >  	unsigned int tsk_index = (unsigned long)data;
> >  	u64 last_jiffies = 0;
> >  
> > -	sched_setscheduler(current, SCHED_RR, &param);
> 
> I was wondering what happened to the SCHED_RR cases but as I can see now
> they are handled here and in the next patch.

Oh right; I completely forgot to mention that in the Changelog didn't I
:-(

In this case, this driver is a broken piece of crap and doing fake idle
with RR is just plain idiotic. Also note the WARNs in play_idle().

Also, rjw, what was the point of renmaing play_idle() to
play_idle_precise() if there is only one anyway? The changelog talks
about adding play_idle_precise() but the patch (rightfully) doesn't add
another version but replaces the existing one. But why change the name?!
