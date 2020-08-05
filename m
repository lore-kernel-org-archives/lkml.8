Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFF8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6272122D6D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SNRJxYhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgHERhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgHERfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:35:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15536C001FC2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ihXFtoBSuvtLohh/RvNeAjifvCivLgmoMzFjTemcXXU=; b=SNRJxYhcymyueDueAlAmzlc+wu
        mTrx+TaefdMhYPmbw3mUXokg5Svh3p2wlp9zpr0FcUX0wH2Mz/TsKW/6dndyvKP+Eii5XHUMdnQr2
        tDK7+CM8aOaxmoAdFcZ9UZKdsbeYM5uDJVfLQ4kxzYsUHYrkAUuXSK+fkrsIER12IM/0eIeprk76r
        mLjwDUZU6E7zGtmBtF5zfDvPJ815weh5P7ydY9i5qUPDbmrXWdDHadj1s7uB7KB6phhuuMZJ7Eal4
        DzCgaE1nAqa3+pJ06Rhmh532fUOyRbKO4BADXpJacMZu2i+iapPcW6TV+GvKGkM2gBSWX2Gebh3TA
        3WYhVMMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3LO1-0001kt-22; Wed, 05 Aug 2020 15:31:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 04026301A66;
        Wed,  5 Aug 2020 17:31:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B77A922B957E9; Wed,  5 Aug 2020 17:31:20 +0200 (CEST)
Date:   Wed, 5 Aug 2020 17:31:20 +0200
From:   peterz@infradead.org
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level
 IRQ time accounting
Message-ID: <20200805153120.GU2674@hirez.programming.kicks-ass.net>
References: <87mu3ho48v.fsf@kurt>
 <20200730082228.r24zgdeiofvwxijm@skbuf>
 <873654m9zi.fsf@kurt>
 <87lfiwm2bj.fsf@nanos.tec.linutronix.de>
 <20200803114112.mrcuupz4ir5uqlp6@skbuf>
 <87d047n4oh.fsf@nanos.tec.linutronix.de>
 <jhjh7tjivew.mognet@arm.com>
 <875z9zmt4i.fsf@nanos.tec.linutronix.de>
 <20200805134002.GQ2674@hirez.programming.kicks-ass.net>
 <jhja6z9i4bi.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhja6z9i4bi.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 02:56:49PM +0100, Valentin Schneider wrote:

> I've been tempted to say the test case is a bit bogus, but am not familiar
> enough with the RT throttling details to stand that ground. That said, from
> both looking at the execution and the stress-ng source code, it seems to
> unconditionally spawn 32 FIFO-50 tasks (there's even an option to make
> these FIFO-99!!!), which is quite a crowd on monoCPU systems.

Oh, so it's a case of: we do stupid without tuning and the system falls
over. I can live with that.
