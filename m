Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C29DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4550D207CB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rfWUQphX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391043AbgEYPpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391001AbgEYPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:45:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254F1C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TnVCZhEhDgEId/ne5umjodioE98Nb5LpIywLtK4Uy8Y=; b=rfWUQphXFwBLdziX8VTeEHMveF
        OwjrVTxX95J5/L6rS7shpvVH0eSY7g669NRuNnscfX9zEm42O2U8FeCeVuJMj3FbkhBHgIShaGvBn
        MMv0o/JvtmviNMSw1V02i0xP7+SIt3P3Xj2Cy3tqz92XDPvSU4QgML1p8LpIddILAhFuYmJUhmg1P
        d2GTV2lKc7tZv/ovG13C79GCEgEn0tB07QpanhytIXMg2A2T1HW92/DR+niSO5HYDHD52b4RM+NkY
        6SQjHJrOrAFj0q/2vE3iM2OWUa/CSi0wd+vgruCH1c4LOQ/NVM08i6Kk7p45HGL57n+Fj7pFCb8Jo
        LiRyXYGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdFHp-0007Mq-0W; Mon, 25 May 2020 15:45:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7FAD1300B38;
        Mon, 25 May 2020 17:45:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D0A120BD4F38; Mon, 25 May 2020 17:45:06 +0200 (CEST)
Date:   Mon, 25 May 2020 17:45:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 02/25] mm/swap: Don't abuse the seqcount latching API
Message-ID: <20200525154505.GZ325280@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-3-a.darwish@linutronix.de>
 <20200522145707.GO325280@hirez.programming.kicks-ass.net>
 <20200525152401.GA375786@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525152401.GA375786@debian-buster-darwi.lab.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 05:24:01PM +0200, Ahmed S. Darwish wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, May 19, 2020 at 11:45:24PM +0200, Ahmed S. Darwish wrote:

> > > +	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
> > > +	smp_wmb();
> >
> > You can leave this smp_wmb() out and rely on the smp_mb() implied by
> > queue_work_on()'s test_and_set_bit().
> >
> 
> Won't this be too implicit?
> 
> Isn't it possible that, over the years, queue_work_on() impementation
> changes and the test_and_set_bit()/smp_mb() gets removed?
> 
> If that happens, this commit will get *silently* broken and the local
> CPU pages won't be drained.

Add a comment to queue_work_on() that points here? That way people are
aware.

