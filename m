Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FABC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF932187F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hjQAvxqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgCBNmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:42:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbgCBNmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3246N1bjqYNelqGVD9ra7Pr6Ut19StfgYoYD6Vm/w0w=; b=hjQAvxqV1TnH9mSNMLxgScr6Gx
        mWLXcGJoT+xPs7DjXUhcKtOlJ0jQ2nsry1ncD1/CMkH8sfe5MQKBVvzZuqbAoTi1JxGGELKVxLkrH
        S7ZvmFzxIswHKLuU1/3sFJKSPwl0eLSDmD9pPABEmOLD9yA/lwSyG5ifh37J7NsRAzCBjZY1sXNAV
        FP/PzK01CB1UdaU+Aba67VVOmEXI97NW80owQTbw75dbqBeDv4/nKoN/UdwuzlZus/7NLddhtr+yA
        /ZYPnSlWooMnoWh1fkIr1P4BXlSSpiEpxAHRL5qVmpSFKvyi6hZZfUVspd4ONtYjU8PgJdZLVZyAD
        tVEdou8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8lL7-0004VZ-KR; Mon, 02 Mar 2020 13:42:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1AF62304D2B;
        Mon,  2 Mar 2020 14:40:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FDE52119B2EA; Mon,  2 Mar 2020 14:42:31 +0100 (CET)
Date:   Mon, 2 Mar 2020 14:42:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        morten.rasmussen@arm.com, qperret@google.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 0/2] sched, arm64: enable CONFIG_SCHED_SMT for arm64
Message-ID: <20200302134231.GB2562@hirez.programming.kicks-ass.net>
References: <20200227191433.31994-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227191433.31994-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 07:14:31PM +0000, Valentin Schneider wrote:
> Hi,
> 
> Strictly speaking those two patches are independent, but I figured it would
> make sense to send them together (since one led to the other).
> 
> Patch 1 adds a sanity check against EAS + SMT.
> Patch 2 enables CONFIG_SCHED_SMT in the arm64 defconfig.
> 

Thanks!
