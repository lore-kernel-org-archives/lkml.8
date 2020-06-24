Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC320C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDF820738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X4otQ9hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404742AbgFXP5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404670AbgFXP44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:56:56 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27389C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HaGz/HVQE50ILeg2IOwzYzlt5KjI+sgPEtrzC6WZDAg=; b=X4otQ9hfkB1OnBKvE40Rtopx6N
        ts+uo6KeCkj9SrrVrNvNwNBUkGXCt4FehbA87W07luGo/J4biUaJTk3nozW7C3wMfHtpmp0BV2UJZ
        Gqk0fmcPCbjL77zXJ9u/t7ZfbmbEmXq1w2IRDrXMInkLYq+1qseMw3w0RnWseBg1BzGSGkFM1mWLK
        PBPfPkFx8UJfNnYdLdVVw0eSl9OpdNy4iycy15Ry1PLrd0nBcjgAp5oOE3MMmfNg/b2643dj/csFA
        YdEe084dTMrwx8oQNCjy5oW1In1aTN1PbShA+51ahxNsZsfZI2dTuIM041qYHnLf/7xj+vZ1eGnU1
        Thm/ZDQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo7lJ-0004EU-N1; Wed, 24 Jun 2020 15:56:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 504F93003E5;
        Wed, 24 Jun 2020 17:56:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A927203CDC50; Wed, 24 Jun 2020 17:56:32 +0200 (CEST)
Date:   Wed, 24 Jun 2020 17:56:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Joel Fernandes <joelaf@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Quentin Perret <qperret@google.com>, ctheegal@codeaurora.org,
        Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
Message-ID: <20200624155632.GJ4781@hirez.programming.kicks-ass.net>
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200612125250.7bwjfnxhurdf5bwj@e107158-lin.cambridge.arm.com>
 <CAD=FV=WuYZRO=sv4ODr0SFk0gTtvCW0dNQXbFGrBDqRgjYv-jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WuYZRO=sv4ODr0SFk0gTtvCW0dNQXbFGrBDqRgjYv-jA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 02:18:23PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jun 12, 2020 at 5:52 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 06/10/20 15:18, Douglas Anderson wrote:

> > > +     struct sched_attr sched_attr = {
> > > +             .sched_policy   = SCHED_FIFO,
> > > +             .sched_priority = MAX_RT_PRIO / 2,
> > > +             .sched_flags    = SCHED_FLAG_UTIL_CLAMP_MIN,
> > > +             .sched_util_min = 0,
> >
> > Hmm I thought Peter already removed all users that change RT priority directly.
> >
> > https://lore.kernel.org/lkml/20200422112719.826676174@infradead.org/
> 
> Yeah, I mentioned that patch series "after the cut" in my patch and
> also made sure to CC Peter on my patch.  I'm not sure what happened to
> that series since I don't see it in linuxnext...

Right, I got busy with other stuff and it languished a bit.

I tried to merge it recently (it's actually in tip/sched/fifo atm), but
then 0day robot found a problem with it and I've not yet had the time to
deal with that.

Specifically these patches unEXPORT the schet_setscheduler() family, but
kernel/trace/ring_buffer_benchmark.c can still be a module :-(
