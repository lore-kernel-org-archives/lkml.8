Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8294620776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fJtbwXZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390508AbgE0PyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:54:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53448 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390381AbgE0PwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=gWuxMg7NlTEFrNlbUropzj9kFD0wZ/EZEXmaMx5s6w4=; b=fJtbwXZAChpjnqipnsX2w6QcoF
        xSeVz1feK9mkhUsKOCmyoWn+/N4p3p5PDny4N4E4UfphD/UkDTfIxT2CCV6xeY6MCQGz70wBALLNC
        TW5XStR9a9eO9jp18Dp9U1BdhcJq91W5BC2lSn2U6GtUB591V2kNUypzl1g6FTQShsldxrKfZEe+C
        CpcID7mhm+HXglFaLviR+ttQYTvmfXqSkcPnKimd5ftDk/Txpa7uiP3kR0Rq0j+lufrsIpHIb3fk+
        XSAY5X9i/Oa66MHyWqAhs6wZGBzj9fdZsd/Bo/7Cx2w/DHHJD3PYNRcavLl8jbFDIF0/e7T+obHok
        lfu8qbyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdyLX-00012v-3s; Wed, 27 May 2020 15:51:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F21EF30793C;
        Wed, 27 May 2020 17:51:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id ACFA52023E7C6; Wed, 27 May 2020 17:51:49 +0200 (CEST)
Message-ID: <20200527154527.233385756@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 27 May 2020 17:45:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, peterz@infradead.org
Subject: [PATCH 0/6] x86/entry,lockdep: Improve IRQ state tracking
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmed and Sebastian wanted additional lockdep_assert*() macros and ran
into header hell.

Move the IRQ state into per-cpu variables, which removes the dependency on
task_struct, which is what generated the header-hell.

And fix IRQ state tracking to not be affected by lockdep_off() (it really
should not have been anyway) and extends IRQ state tracking across (x86)
NMIs.


