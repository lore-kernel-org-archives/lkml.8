Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69E5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2737207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dpYm4/ZY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0DACqNRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgG2O3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:29:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42834 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgG2O3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:29:19 -0400
Date:   Wed, 29 Jul 2020 16:29:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596032957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3sa5woqKYeA9niXY861M55KgRqL865by23UeLzCeo0=;
        b=dpYm4/ZY0SO8cj6LB7NMVOxFOgdB4fC7CikWYYWxbRLa62sqz1nMfFU2WlYgQI5LMezTFQ
        Y2QTq+i7fI0dzqdhK15eqtBP6kcTdq9ZLARTd3BjINem3HI4Ab7JtGMy95WxIWMgAAIcTM
        GSt8X/X/fbdHRWdZZoDJtWQYSZ8es6icFAqMK7i2h7KkA8/PDRTZCZoLM4YXGK/qJCEfCl
        ZVZnd2PoV3bLV0cNwmd9A6r5AucChmLql1JX62Nor5ACVeDQhI2dPs8zPgc5Mc0FC2tlah
        b5xcDhl3w0lZFvEFrT65OBra1BJ1mKo8GICbL5wIfPDZlMVvYgZcrovkOQUioQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596032957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3sa5woqKYeA9niXY861M55KgRqL865by23UeLzCeo0=;
        b=0DACqNRdzAMN51HuPYvr2hPlMEpaH3GZQe22LKa/xphCLXSibWh49zzHn0hKZBxJihvONH
        SvTEh614EO6ccwDA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de,
        paulmck@kernel.org, bigeasy@linutronix.de, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, davem@davemloft.net,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] seqlock: s/__SEQ_LOCKDEP/__SEQ_LOCK/g
Message-ID: <20200729142917.GA9446@lx-t490>
References: <20200729135249.567415950@infradead.org>
 <20200729140142.277485074@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729140142.277485074@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 03:52:50PM +0200, Peter Zijlstra wrote:
> __SEQ_LOCKDEP() is an expression gate for the
> seqcount_LOCKNAME_t::lock member. Rename it to be about the member,
> not the gate condition.
>
> Later (PREEMPT_RT) patches will make the member available for !LOCKDEP
> configs.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Acked-by: Ahmed S. Darwish <a.darwish@linutronix.de>
