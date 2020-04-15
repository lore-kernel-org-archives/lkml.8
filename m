Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30632C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF7420732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cv3rxyDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbgDOWmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbgDOWmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:42:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9980C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 15:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JqnU3FiYkxhe22VoesEFoLo/gHlhsSJU/4hzBKMpg3Q=; b=Cv3rxyDxWJ+e5kZKPFr3Z6q7Bx
        WfBgIbBM5z7kP4Po6SwYoFxkTZIlZ3yosQT2TEU9e5Akbe8KNX4Y03LY5rDUfw4VuWs8WZIubAve9
        aRTWWcvTCQrC2VpsWnKFTgGTr5p8sKpdHofDpEYMZnpa/b0wQZ1qdmTAZ72x4YtNmzb3va/Xog+zm
        uLloJ+uBqgW9bhikrAbzdl5xq7zW7F7GOmyyUkWHfmNUuuYbluMsefZyUtCBXd4PCvBpgqLpzdPBp
        cvZioaGvVACLyheHlc2hcV//109vHzmjI6dQAzye6KswkT1O4tDveN8CZu9o062zM9+LkebayiFUP
        pDamFrpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOqjY-0006wW-DR; Wed, 15 Apr 2020 22:42:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82492981086; Thu, 16 Apr 2020 00:42:14 +0200 (CEST)
Date:   Thu, 16 Apr 2020 00:42:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Josh Triplett <josh@joshtriplett.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: On trace_*_rcuidle functions in modules
Message-ID: <20200415224214.GP2483@worktop.programming.kicks-ass.net>
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
 <20200415085348.5511a5fe@gandalf.local.home>
 <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
 <20200415161424.584d07d3@gandalf.local.home>
 <CALAqxLU26PVFPSza5GceSF6gTVdzo_2D3G0dBp0KZXvAWFUktA@mail.gmail.com>
 <20200415164116.40564f2c@gandalf.local.home>
 <CALAqxLW6jqr38bk8pp-Hom2=MLm3coTmzCP8MMfrDvMfx388=Q@mail.gmail.com>
 <20200415174918.154a86d0@gandalf.local.home>
 <20200415220459.GE17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415220459.GE17661@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 03:04:59PM -0700, Paul E. McKenney wrote:
> 
> My guess is that invoking rcu_irq_enter() and rcu_irq_exit() around every
> potential call into module code out of the PM code is a non-starter,
> but I cannot prove that either way.

Isn't that exactly what cpu_pm_notify() is doing?
