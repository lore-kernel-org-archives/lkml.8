Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E090EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C712098B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEYH/6mg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgFWTpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733236AbgFWTpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:45:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD95C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 12:45:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so35320pgk.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a8zj1fuShwqowO3Wq+CdKkZzc+/xfslY1sGu/hpora8=;
        b=uEYH/6mg+aXLTRy+8y08DQPhyvQv5FbBjYDESBfb7SWp9kAXLu8qLQxnYBl05eYVLx
         dJm3DnxAgk7ewTRR29JeLsZxVvzkWEj5NGmIuHUcfp2LxYafb7Ku4i5GA43q6jWk3TAw
         4KpXANV7PupjzcXf+SBX0zhodfp+FX0xYZFlls+MG9KzYmK938dODcqLPfMbL67dBjbT
         KmIdJx4vv09EFGwqClpyOW6t3IS9ud191X9VT3aMywPr6YzOck3sLN5PMAefw+di0B0W
         CdmcDiOt7J4C2ef5V84R7Xo3IPa8FOW3e/8SeWGCGt2/XEY4blvIm3kywZ6cDEhY9j90
         fvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a8zj1fuShwqowO3Wq+CdKkZzc+/xfslY1sGu/hpora8=;
        b=ph4VmTNVuhKoQRiZTvz6xjd4lcrgvl95x7Gk/XTPMRI7z2zpqOmwvr+UakUJWk9Ai8
         LbhvsdPaku8jYE37sKSN0h64PsfY9npZML0boNsVJdxl4Odmp69b+lveS/5Hj1oecl+g
         l81glFWRiaoEmrgfDmulx/ZLTVO7eethGaEHRn4rNF5Bgb2Oz+Z9pvFRFNfDyfRVNDLq
         B10IoYH0EX5OsXGGwBmIbsTWiREAaCepx1YysjvXG6RQFy0njebqTv5gEVZIKQuBRY+2
         ItIr9yva4q9V4PG8SROptVU0lHcU9S7fpx413alltjK3D13N2qQvmYPf+udVa8bqPtm8
         fE3w==
X-Gm-Message-State: AOAM532M1YIgIwvfWt2fT/6CnuCizLBpDez98pofzwKfiVGGoMW16rLn
        9wcCzUWsfqs6eKtT2V/o10I=
X-Google-Smtp-Source: ABdhPJw+vaMWXj7tKULwm6c2gqug19cIRYX+JuuJNa7Rg3J8a2dc6aaGmQT7WoxC7T0KCgtEw0EE3w==
X-Received: by 2002:a63:5461:: with SMTP id e33mr18025430pgm.56.1592941531706;
        Tue, 23 Jun 2020 12:45:31 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id g19sm17668046pfo.209.2020.06.23.12.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 12:45:31 -0700 (PDT)
Date:   Tue, 23 Jun 2020 12:45:29 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Aaron Lu <aaron.lwe@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Oskolkov <posk@google.com>, avagin@google.com,
        "pjt@google.com" <pjt@google.com>, Ben Segall <bsegall@google.com>
Subject: Re: [RFC PATCH 1/3 v2] futex: introduce FUTEX_SWAP operation
Message-ID: <20200623194529.GA71413@gmail.com>
References: <cf7c83d0b58aa4912b465392ce8e40a974f250bb.camel@posk.io>
 <20200623132507.GA875@aaronlu-desktop>
 <d29a2ba031ecd96f785a602e703d97e24980ef15.camel@posk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <d29a2ba031ecd96f785a602e703d97e24980ef15.camel@posk.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:30:30AM -0700, Peter Oskolkov wrote:
...
> > >  /**
> > > +static int futex_swap(u32 __user *uaddr, unsigned int flags, u32
> > > val,
> > > +		      ktime_t *abs_time, u32 __user *uaddr2)
> > > +{
> > > +	u32 bitset = FUTEX_BITSET_MATCH_ANY;
> > > +	struct task_struct *next = NULL;
> > > +	DEFINE_WAKE_Q(wake_q);
> > > +	int ret;
> > > +
> > > +	ret = prepare_wake_q(uaddr2, flags, 1, bitset, &wake_q);
> > > +	if (!wake_q_empty(&wake_q)) {
> > > +		/* Pull the first wakee out of the queue to swap into.
> > > */
> > > +		next = container_of(wake_q.first, struct task_struct,
> > > wake_q);
> > > +		wake_q.first = wake_q.first->next;
> > > +		next->wake_q.next = NULL;
> > > +		/*
> > > +		 * Note that wake_up_q does not touch wake_q.last, so
> > > we
> > > +		 * do not bother with it here.
> > > +		 */
> > > +		wake_up_q(&wake_q);
> > 
> > wake_up_q() doesn't seem to serve any purpose in that the above
> > assignment of wake_q.first shall make it an empty queue now?
> > Also, I don't see a need to touch wake_q.first either so I think we
> > can
> > get rid of wake_q altogether here.
> 
> The futex at uaddr2 may have more than one waiter, so we cannot assume
> that wake_q will be empty when we remove the first element.

The third argument of prepare_wake_q is nr_wake which is one in this
case, so we can be sure that wake_q will be empty, can't we?

> 
> > 
> > > +	}
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return futex_wait(uaddr, flags, val, abs_time, bitset, next);
> > > +}
> > 
