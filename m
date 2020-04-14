Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06750C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49BE2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kYEogDVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438120AbgDNKGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438097AbgDNKGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:06:17 -0400
X-Greylist: delayed 2360 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Apr 2020 03:06:16 PDT
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD93AC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zRbIhkRTth0h/We8PXb627DVJp3T2IM7e0L6aaERpUc=; b=kYEogDVdl6bmOzX4nQkttpVVB5
        84XOkDu3cl4CQ8p4NYCdZbDaglqAbjjU20apeP4fcp+hdRwBUSeQNdbpcm/+QfZSWPUfSKXf2by7W
        Nmh7kXjLlO/KSMXDgBxn7BrBmVpnaGuPS/1FeJdH4mPtY0XyDsERlSIs0LgNDV5arcAj68DMNTtUV
        txfyLgHN5YUNMTcOy1YJ1ryh7V+GYNf3pf4yaIJX9WJQ3fC20l+4IxozIQLI8wFoba27sUyUxO6jI
        6ZUa1Ler7eZ8PCg8glPW1N1iexhkQoAlyAhknzr514hS88GXm+bipOGJom0YWCM3MOklTqWCUxuVV
        dOaBaGHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOIS6-0000Cp-RY; Tue, 14 Apr 2020 10:05:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF59E3012D8;
        Tue, 14 Apr 2020 12:05:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97BA020B07BF9; Tue, 14 Apr 2020 12:05:55 +0200 (CEST)
Date:   Tue, 14 Apr 2020 12:05:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Wang Qing <wangqing@vivo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        jinho lim <jordan.lim@samsung.com>,
        Dave Martin <Dave.Martin@arm.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH 1/2] [V2 1/2]sched:add task_running_oncpu
Message-ID: <20200414100555.GJ20713@hirez.programming.kicks-ass.net>
References: <1586779466-4439-1-git-send-email-wangqing@vivo.com>
 <1586779466-4439-2-git-send-email-wangqing@vivo.com>
 <CAKfTPtDSk31p5xF9aHef4T7ixgx8m1H86Py=deu7L6dG4Z1vzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDSk31p5xF9aHef4T7ixgx8m1H86Py=deu7L6dG4Z1vzw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 09:20:57AM +0200, Vincent Guittot wrote:
> On Mon, 13 Apr 2020 at 14:04, Wang Qing <wangqing@vivo.com> wrote:
> >
> > We have no interface whether the task is running,
> > so we need to add an interface and distinguish CONFIG_SMP.
> >
> > Signed-off-by: Wang Qing <wangqing@vivo.com>
> > ---
> >  include/linux/sched.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 4418f5c..13cc8f5 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1843,6 +1843,11 @@ static inline unsigned int task_cpu(const struct task_struct *p)
> >
> >  extern void set_task_cpu(struct task_struct *p, unsigned int cpu);
> >
> > +static inline int task_running_oncpu(const struct task_struct *p)
> 
> This function name is too close from task_running_on_cpu() and can be
> misleading as the difference is only "_"
> Also, how task_running_oncpu() is different from task_running() ?

It doesn't have the (arguably superfluous) rq argument. But yes, agreed,
if anything lift that thing (without the argument).
