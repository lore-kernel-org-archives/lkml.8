Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14769C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65522075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YnzhO/UF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VYP2gybb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgH1I7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgH1I67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:58:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D122C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:58:59 -0700 (PDT)
Date:   Fri, 28 Aug 2020 10:59:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598605137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GmU8AAPW1+rQRjQVKnNtyU0wtD0uH65CO+M6xximNpg=;
        b=YnzhO/UFbdwlJThK+sAKvpR7v6mpKuuYB/R1lewMQeeDO8xS+jwz/k9xhSf890jW9e5Zkl
        iRtPT3ULag2INy3HOFTiUbMRqtt7TDSMv13TqWdPjnKtKIuO9Hy4GSo1vX5dVaaqdZJ35J
        eX3qjqtlcVZE6IQbUpqIQEoiLsITBHxMsp2hbN1LVST2IDlInkYQrz80+9zY9XElSRF5Gr
        LN4013/wx8Fd5T7i5vkZdnorzmMNDWTHKScoEUwlWcewl8x8X7dkogsZhSdu4JlOA2UNfX
        e7+h98NalzfOLoLXzTAx2gakKPm3O+8q0M7eyOiRWOAkT7gDlC5jwkFFz5EseQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598605137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GmU8AAPW1+rQRjQVKnNtyU0wtD0uH65CO+M6xximNpg=;
        b=VYP2gybb44CwkG7K2QMc2nCuVFcU+n9/xiQ5cIOb+wrJ6lTqge83XyZA5xwC0Xh/ipkZyf
        qOHaqhZQNskSDqBQ==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     peterz@infradead.org
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/5] seqlock: Use unique prefix for seqcount_t
 property accessors
Message-ID: <20200828085917.GA7205@lx-t490>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
 <20200828010710.5407-3-a.darwish@linutronix.de>
 <20200828082754.GN1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828082754.GN1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 10:27:54AM +0200, peterz@infradead.org wrote:
> On Fri, Aug 28, 2020 at 03:07:07AM +0200, Ahmed S. Darwish wrote:
> > Differentiate the first group by using "__seqcount_t_" as prefix. This
> > also conforms with the rest of seqlock.h naming conventions.
>
> >  #define __seqprop_case(s, locktype, prop)				\
> >  	seqcount_##locktype##_t: __seqcount_##locktype##_##prop((void *)(s))
> >
> >  #define __seqprop(s, prop) _Generic(*(s),				\
> > -	seqcount_t:		__seqcount_##prop((void *)(s)),		\
> > +	seqcount_t:		__seqcount_t_##prop((void *)(s)),	\
> >  	__seqprop_case((s),	raw_spinlock,	prop),			\
> >  	__seqprop_case((s),	spinlock,	prop),			\
> >  	__seqprop_case((s),	rwlock,		prop),			\
>
> If instead you do:
>
> #define __seqprop_case(s, _lockname, prop) \
> 	seqcount##_lockname##_t: __seqcount##_lockname##_##prop((void *)(s))
>
> You can have:
>
> 	__seqprop_case((s),	,		prop),
> 	__seqprop_case((s),	_raw_spinlock,	prop),
> 	__seqprop_case((s),	_spinlock,	prop),
> 	__seqprop_case((s),	_rwlock,	prop),
> 	__seqprop_case((s),	_mutex,		prop),
> 	__seqprop_case((s),	_ww_mutex,	prop),
>
> And it's all good again.
>
> Although arguably we should do something like s/__seqcount/__seqprop/
> over this lot.
>

ACK.
