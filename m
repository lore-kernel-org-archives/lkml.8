Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F215C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA725208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PpEFd8FQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHJJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgEHJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:09:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DC9C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 02:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xb+C9x4SIhmpbdhdXWMSHO37biGDOHtvQ/W2i8m4dTo=; b=PpEFd8FQp6vNcOZNu0Da+9bMtN
        ni4z8WEXHbTgTA/hc+iJOW5x9YzTaZGBxvGXE0nAMoMgl1bv7rVhPRZICHOpI+3E1SmxpOo4lsXp5
        tgWZ9jwG5edPLnkQDPx+jzc1rFXgKXYxM+3O5svw0NqHXy52TeQCEQkxwAc9J4u82MgPzx/AfKRvN
        omg53m7OHKaJ9Sgdn1MesdG0HiOKnERmt2/T44n2nYYhP5w+3IZ8QrtNtowI7LaTG7TmkEAOrSnjx
        X/rVrEv3u3zPcMCnhkVODO25lHbaM+cecIk2taXFGHLWOasfNHX/paoS+/OCP7eje7t6u4EobX3zC
        WYEtHesQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWz0b-0007QA-9s; Fri, 08 May 2020 09:09:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A776A301DFC;
        Fri,  8 May 2020 11:09:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C9942B93BDCE; Fri,  8 May 2020 11:09:25 +0200 (CEST)
Date:   Fri, 8 May 2020 11:09:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lwe@gmail.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH updated v2] sched/fair: core wide cfs task priority
 comparison
Message-ID: <20200508090925.GV5298@hirez.programming.kicks-ass.net>
References: <20200415033408.GA168322@ziqianlu-desktop.localdomain>
 <20200415040741.GA169001@ziqianlu-desktop.localdomain>
 <CANaguZAXsjD=X-bB7dvQZ3FSqLioiZU=YREHH_7JqiFsZCTxHA@mail.gmail.com>
 <20200417094045.GA197704@ziqianlu-desktop.localdomain>
 <20200420080759.GA224731@ziqianlu-desktop.localdomain>
 <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
 <20200421025131.GA227300@aaronlu-desktop>
 <20200424142443.GA263207@aaronlu-desktop>
 <20200506143506.GH5298@hirez.programming.kicks-ass.net>
 <20200508084419.GA120223@aaronlu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508084419.GA120223@aaronlu-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 04:44:19PM +0800, Aaron Lu wrote:
> On Wed, May 06, 2020 at 04:35:06PM +0200, Peter Zijlstra wrote:

> > Aside from this being way to complicated for what it does -- you
> > could've saved the min_vruntime for each rq and compared them with
> > subtraction -- it is also terminally broken afaict.
> >
> > Consider any infeasible weight scenario. Take for instance two tasks,
> > each bound to their respective sibling, one with weight 1 and one with
> > weight 2. Then the lower weight task will run ahead of the higher weight
> > task without bound.
> 
> I don't follow how this could happen. Even the lower weight task runs
> first, after some time, the higher weight task will get its turn and
> from then on, the higher weight task will get more chance to run(due to
> its higher weight and thus, slower accumulation of vruntime).

That seems to assume they're mutually exclusive. In that case, as I
argued, we only have a single runqueue and then yes it works. But if
they're not exclusive, and can run concurrently, it comes apart.

