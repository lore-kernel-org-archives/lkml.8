Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42B8C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D8820739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wSiHnFOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgCTQy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:54:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33990 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCTQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:54:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id f3so7602995qkh.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7285IhCSSBT15iW2Q2eR5fvPtG69GQ4u+ypVdruEBmY=;
        b=wSiHnFOGohFnM89TGZsMvNdn7fQHYp/jIDzOnu2eVjZJ1WdOi7Yxld9BnWTMYn3FmJ
         Sq+ZK7ZfpKRLk+TKy3F9ZRhKD78DBBjvO4gBqBcS5XDsfousY32veKAENdhAXEG/dfwa
         DhEXoBvcOhvZis8wfr9Ht+b8NKDB7rN9AEDkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7285IhCSSBT15iW2Q2eR5fvPtG69GQ4u+ypVdruEBmY=;
        b=fZ9ubQrYURUhETGaukESOh6zjGOMd7t/TMc8cMTGS9x4bhji48rzS1/GEY3TYUpvvr
         CasqBjg/5zT3x8M/JCokwCDouUPRMcmcjkxjCmHzI3sqmCVmjk7ETWf7hu2J0OU0xLV6
         x8G8t5ReNsIcB08X8kVVA19e+QWilb7Hyr8nYVhw/s18aREUtoL+P/uY/dU1MtzFMApq
         IURjHzYzYF9uxozGFUQFa/8J/Vv1+VYzhBZhrYHC6jD5kL122AzXsgsGfgQrxl5ANrnq
         otZmT6KPDK35Sb2VePjF6f3paTwXJQaRxEkhO4lr5VLdKd4YYhPzLUzwgwTGbuETC7jQ
         zZYg==
X-Gm-Message-State: ANhLgQ1DKEWbWBKydom0uCfA8Rev484apoVjx1ZOP2fvYpnIRa83fPr+
        NuCO/sazTHDKasmBRG1Z7VoR2Q==
X-Google-Smtp-Source: ADFU+vulLoHlR563V1moHA8eR15I3kHirfQLyvZInTWb9FE37SMNRwa2Bo3vqeSw84Pch6eTHGnRUg==
X-Received: by 2002:a37:50d4:: with SMTP id e203mr8724974qkb.153.1584723296834;
        Fri, 20 Mar 2020 09:54:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w28sm5250664qtc.27.2020.03.20.09.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:54:56 -0700 (PDT)
Date:   Fri, 20 Mar 2020 12:54:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/3] LKMM: Add litmus test for RCU GP guarantee where
 updater frees object
Message-ID: <20200320165454.GA155212@google.com>
References: <20200320102603.GA22784@andrea>
 <Pine.LNX.4.44L0.2003201104220.27303-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2003201104220.27303-100000@netrider.rowland.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 11:07:10AM -0400, Alan Stern wrote:
> On Fri, 20 Mar 2020, Andrea Parri wrote:
> 
> > On Fri, Mar 20, 2020 at 02:55:50AM -0400, Joel Fernandes (Google) wrote:
> > > This adds an example for the important RCU grace period guarantee, which
> > > shows an RCU reader can never span a grace period.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  .../litmus-tests/RCU+sync+free.litmus         | 40 +++++++++++++++++++
> > >  1 file changed, 40 insertions(+)
> > >  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+free.litmus
> > > 
> > > diff --git a/tools/memory-model/litmus-tests/RCU+sync+free.litmus b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
> > > new file mode 100644
> > > index 0000000000000..c4682502dd296
> > > --- /dev/null
> > > +++ b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
> > > @@ -0,0 +1,40 @@
> > > +C RCU+sync+free
> > > +
> > > +(*
> > > + * Result: Never
> > > + *
> > > + * This litmus test demonstrates that an RCU reader can never see a write after
> > > + * the grace period, if it saw writes that happen before the grace period. This
> > > + * is a typical pattern of RCU usage, where the write before the grace period
> > > + * assigns a pointer, and the writes after destroy the object that the pointer
> > > + * points to.
> > > + *
> > > + * This guarantee also implies, an RCU reader can never span a grace period and
> > > + * is an important RCU grace period memory ordering guarantee.
> > > + *)
> > > +
> > > +{
> > > +x = 1;
> > > +y = x;
> > > +z = 1;
> > 
> > FYI, this could become a little more readable if we wrote it as follows:
> > 
> > int x = 1;
> > int *y = &x;
> > int z = 1;
> 
> Also, the test won't work with klitmus7 unless you do this.

Will do.

> > The LKMM tools are happy either way, just a matter of style/preference;
> > and yes, MP+onceassign+derefonce isn't currently following mine...  ;-/
> > 
> > 
> > > +}
> > > +
> > > +P0(int *x, int *z, int **y)
> > > +{
> > > +	int r0;
> > 
> > This would need to be "int *r0;" in order to make klitmus7(+gcc) happy.

Sorry fixed it now, my version of herd did not complain on this so I missed it.

> > > +	int r1;
> > > +
> > > +	rcu_read_lock();
> > > +	r0 = rcu_dereference(*y);
> > > +	r1 = READ_ONCE(*r0);
> > > +	rcu_read_unlock();
> > > +}
> > > +
> > > +P1(int *x, int *z, int **y)
> > > +{
> > > +	rcu_assign_pointer(*y, z);
> > 
> > AFAICT, you don't need this "RELEASE"; e.g., compare this test with the
> > example in:
> > 
> >   https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Grace-Period%20Guarantee
> > 
> > What am I missing?
> 
> If z were not a simple variable but a more complicated structure, the
> RELEASE would be necessary to ensure that all P1's prior changes to z
> became visible before the write to y.
> 
> Besides, it's good form always to match rcu_dereference() with 
> rcu_assign_pointer(), for code documentation if nothing else.

Yes, adding to what Alan said, you can see the effect of not using
rcu_assign_pointer() in: MP+onceassign+derefonce.litmus

Alan and Andrea, may I add your Reviewed-by or Acked-by tags on the v2?

thanks,

 - Joel

