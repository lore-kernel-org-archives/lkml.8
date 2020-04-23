Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D4FC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE2D20781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f+hLv/O8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgDWI7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 04:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWI7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:59:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5932FC03C1AF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FslEljpf0Qls1zpokxi+kAyLc7T9TEQnExUjq1hOBc4=; b=f+hLv/O867JLig1vEuHlSpjIrH
        SdGYwQ3AZuc9qm8Sj/zRmjlnQc4o7tsH5EBrV6AC9TRxDIsYPFTDtYz5DzARh2lTQHGmlIVzrSeV9
        aekNBjgAs5/oNvndIjGDJ6fi+Ce49F928IcX4SwQe7BmTtACAkyuxoYv+0TweEY8HwXFUl8gWCZsg
        38wpdFy1EnJk0yJOk4aYDRvPb3IO2d70pzpz9nVlWBHODFMEi0B93cBo/humNDnCQMCRx5nZOfeTu
        OT/kl5Z9e7ObxbWosVHy/6JdgVVtsEUyamSmHSw9kvVuRf+mllnGwHqGwgIGMd2o+AqtY7Yv6DE/n
        DvIQMbtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRXhr-000632-Vi; Thu, 23 Apr 2020 08:59:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B55D3010C4;
        Thu, 23 Apr 2020 10:59:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 473BA21420DB1; Thu, 23 Apr 2020 10:59:38 +0200 (CEST)
Date:   Thu, 23 Apr 2020 10:59:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, qais.yousef@arm.com,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        bsegall@google.com, mgorman@suse.de
Subject: Re: [PATCH 10/23] sched,mmc: Convert to sched_set_fifo*()
Message-ID: <20200423085938.GV20713@hirez.programming.kicks-ass.net>
References: <20200422112719.826676174@infradead.org>
 <20200422112831.811655681@infradead.org>
 <CAPDyKFo+qCZU=snj==4CFRfL9R0KLcG2RMYeFW_BMX=-Mo5rtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo+qCZU=snj==4CFRfL9R0KLcG2RMYeFW_BMX=-Mo5rtg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 06:59:35PM +0200, Ulf Hansson wrote:
> On Wed, 22 Apr 2020 at 13:29, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Because SCHED_FIFO is a broken scheduler model (see previous patches)
> > take away the priority field, the kernel can't possibly make an
> > informed decision.
> >
> > In this case, use fifo_low, because it only cares about being above
> > SCHED_NORMAL. Effectively no change in behaviour.
> >
> > Cc: ulf.hansson@linaro.org
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Ingo Molnar <mingo@kernel.org>
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

> FYI: I am slowly moving towards removing the entire kthread for the
> sdio_irq_thread(). It shouldn't be too far off to be posted, one or
> two kernel releases or so.

Moving over to regular threaded interrupts? Anyway, cool, if these
series collide it's easy enough to drop this patch on the floor if it
turns out obsolete.
