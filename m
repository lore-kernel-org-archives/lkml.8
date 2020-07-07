Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EDFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EAE206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gHN/Y9Ht";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j1uRTfXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgGGKME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGGKME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:12:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F95C061755;
        Tue,  7 Jul 2020 03:12:04 -0700 (PDT)
Date:   Tue, 7 Jul 2020 12:12:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594116722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TN3dQ6Y8up4F4+xRJpOHdsTv6BtN9trwRIPiVoj5mfA=;
        b=gHN/Y9HtYQvJ0XlzC1IBLtJAL/nddtt82FVhFcQJEa4Px8KNYb23wDYLQiOCBWl1ko9lt6
        RXamDKb76a//kBZG41b9DGRvo4eiRCpoc9+kSNEly7Ih3/CbIaqYlb6GPDiPcQK95+3Ufh
        JNDO+L3qXDIruVJqnqmmhTgMhtAW6jS2F1/SJchZauuFrHBBqT9a/HAMP6R0P5kQepJJPr
        hvLX2tFrLVcbJhxAmGvi+aDSsLCfn35/OG3mrsF9Y/H53lXhAsmMx7MRD4xMVqC7F72wxt
        Wp2COZ8OY7y4WgmxRgZb5V5fy8iLkazMLec4pSlwnnmZueR6XDaumj1RYHjvSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594116722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TN3dQ6Y8up4F4+xRJpOHdsTv6BtN9trwRIPiVoj5mfA=;
        b=j1uRTfXLiJTDpk3AaEc+Irw5duiYEr3SbB+KqVFVxuDu++fGvZoyLSnRA3Q+VxuX7slF3k
        Yq+IoMfocnaRNUCQ==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 01/20] Documentation: locking: Describe seqlock design
 and usage
Message-ID: <20200707101200.GA4102575@debian-buster-darwi.lab.linutronix.de>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-2-a.darwish@linutronix.de>
 <20200706210439.GD5523@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706210439.GD5523@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 11:04:39PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 30, 2020 at 07:44:33AM +0200, Ahmed S. Darwish wrote:
> > +Sequence counters (:c:type:`seqcount_t`)
> > +========================================
>
> > +.. code-block:: c
>
> I so hate RST, of course it's C. Also, ISTR Jon saying you can leave
> that all out without issue.

There you go again.

  linux$ git grep 'code-block:: c' | wc -l
  ==>  470

  linux$ git grep ':ref:' | wc -l
  ==>  3171

  linux$ git grep ':c:type:' | wc -l
  ==>  1533

In writing this, Documentation/doc-guide/ was followed, and literally
the thousands of examples above.

But honestly, I don't want to block merging documentation because of
this, and the point of making the docs as readable as possible from text
editors also has merit.

So... I'll just make that file as "RST-lite" as possible.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
