Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824B2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60EAD207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390008AbgEYLCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgEYLCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:02:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93972C061A0E;
        Mon, 25 May 2020 04:02:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jdAs1-00079V-JZ; Mon, 25 May 2020 13:02:13 +0200
Date:   Mon, 25 May 2020 13:02:12 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 09/25] Documentation: locking: Describe seqlock design
 and usage
Message-ID: <20200525110211.GA375707@debian-buster-darwi.lab.linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-10-a.darwish@linutronix.de>
 <20200522180145.GR325280@hirez.programming.kicks-ass.net>
 <20200522182409.4016d83c@oasis.local.home>
 <20200525105012.GA375313@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525105012.GA375313@debian-buster-darwi.lab.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmed S. Darwish <a.darwish@linutronix.de> wrote:
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > Peter Zijlstra <peterz@infradead.org> wrote:
...
> > >
> > > So I really really hate that... I _much_ prefer code comments to crappy
> > > documents.
> >
> > Agreed. Comments are much less likely to bitrot than documents. The
> > farther away the documentation is from the code, the quicker it becomes
> > stale.
> >
> > It's fine to add "See Documentation/..." but please don't *ever* remove
> > comments that's next to the actual code.
...
>
> Then, the brlock comment:
>
>     This is not as cache friendly as brlock. Also, this may not work
>     well for data that contains pointers, because any writer could
>     invalidate a pointer that a reader was following.
>
> was removed not because it's moved to Documentation/locking/seqlock.rst,
> but because it's obsolete: 0f6ed63b1707 ("no need to keep brlock macros
> anymore...").
>

Hmm, the part about not including pointers is only mentiond in the RST
file though, and not at seqlock.h.

Anyway, ACK, I'll beef up the comments at seqlock.h and make sure they
are self-contained.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
