Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B624C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42233206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CdtkJPlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgIDID2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbgIDIDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:03:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6F8C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 01:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KoEt7dwJzHzc0zmg3gPZoBe1ae26mzuh+FezXIxiqQ4=; b=CdtkJPlLhr2CA3JmAOmUGekyb3
        DIIv5ks3CQQDGi4J+JV/C0PqE0iFZYr3tF/ucWUhCFwq4Vp15IunEDl0mcDEO2Eed1cQpLwNQCpPj
        jKzZH7sKBErtd3axqGdsvBJg3hz+t0pezWAHXhzmOi35uqsEhV8leOLYkWaapLAFetGCeAZeWmucK
        i63UgVjO/VXapEiN8vdPz+PyTTCSAj8CVWc44bBSMe3FWmFUOZ4YapKEEayRHv/MjBNRLTdAhNtQQ
        DRtAqzlTdqpWI6+y7+ZgJuvBrCnF+nGleYyJZdL/DlrpgGVVuOLcpUonnPaSODsIEDnsX1yiWCZdI
        G+kSouGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kE6gm-0000Uk-8l; Fri, 04 Sep 2020 08:03:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1C52301179;
        Fri,  4 Sep 2020 10:03:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B14A32B9A6885; Fri,  4 Sep 2020 10:03:12 +0200 (CEST)
Date:   Fri, 4 Sep 2020 10:03:12 +0200
From:   peterz@infradead.org
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 6/8] x86/tsc: Use seqcount_latch_t
Message-ID: <20200904080312.GZ35926@hirez.programming.kicks-ass.net>
References: <20200827114044.11173-1-a.darwish@linutronix.de>
 <20200827114044.11173-7-a.darwish@linutronix.de>
 <20200904074142.GL2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904074142.GL2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 09:41:42AM +0200, peterz@infradead.org wrote:
> On Thu, Aug 27, 2020 at 01:40:42PM +0200, Ahmed S. Darwish wrote:
> 
> >  __always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
> >  {
> > +	seqcount_latch_t *seqcount;
> >  	int seq, idx;
> >  
> >  	preempt_disable_notrace();
> >  
> > +	seqcount = &this_cpu_ptr(&cyc2ns)->seq;
> >  	do {
> > -		seq = this_cpu_read(cyc2ns.seq.sequence);
> > +		seq = raw_read_seqcount_latch(seqcount);
> >  		idx = seq & 1;
> >  
> >  		data->cyc2ns_offset = this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
> >  		data->cyc2ns_mul    = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
> >  		data->cyc2ns_shift  = this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);
> >  
> > -	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.sequence)));
> > +	} while (read_seqcount_latch_retry(seqcount, seq));
> >  }
> 
> So I worried about this change, it obviously generates worse code. But I
> was not expecting this:
> 
> Before:
> 
> 196: 0000000000000110   189 FUNC    GLOBAL DEFAULT    1 native_sched_clock
> 
> After:
> 
> 195: 0000000000000110   399 FUNC    GLOBAL DEFAULT    1 native_sched_clock
> 
> That's _210_ bytes extra!!
> 
> If you look at the disassembly of the thing after it's a complete
> trainwreck.

The below delta fixes it again.

---
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -68,21 +68,19 @@ early_param("tsc_early_khz", tsc_early_k
 
 __always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
 {
-	seqcount_latch_t *seqcount;
 	int seq, idx;
 
 	preempt_disable_notrace();
 
-	seqcount = &this_cpu_ptr(&cyc2ns)->seq;
 	do {
-		seq = raw_read_seqcount_latch(seqcount);
+		seq = this_cpu_read(cyc2ns.seq.seqcount.sequence);
 		idx = seq & 1;
 
 		data->cyc2ns_offset = this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
 		data->cyc2ns_mul    = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
 		data->cyc2ns_shift  = this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);
 
-	} while (read_seqcount_latch_retry(seqcount, seq));
+	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.seqcount.sequence)));
 }
 
 __always_inline void cyc2ns_read_end(void)
