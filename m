Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6659C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764352078D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qp88Dfbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKIlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgIKIlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:41:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09961C061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pJCvxMblvhsagAFEWK/7Z4eAuEJyUBEGptfkcNVrs2U=; b=Qp88Dfbj2kU63ejJeePstw993c
        9ULY0XI/ZJiAwFlosbhy5/rxfSQpfVI28U6NRPozvRZw3pScTxBJC/iTG2F2/uAatcaYtH80dBfK8
        s9hshNYGY/LYe6R2ZBFFSVwEtrpy0aJMhkQPtzwcLyteueKQZA6ZIS+HQqMiYjhxKlKXnui00UGE0
        r1FeIleAOlBY569AoSyTahIRWC0JR+ZsUPGZEdCPK1Oe3wKHipY0093J/XWrEwqro2CSTTWpQC3Eb
        54NKCGa2J6HxNediT804ZTxBja3b7TDiklVBEyLP2UYslYOiRB4vbZ5epcMZjxfN1QYLv9hR2MuCR
        wNo4domQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGecY-0007cM-Dg; Fri, 11 Sep 2020 08:41:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49C5A303DA0;
        Fri, 11 Sep 2020 10:41:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8785A2143B27B; Fri, 11 Sep 2020 10:41:21 +0200 (CEST)
Message-ID: <20200911081745.214686199@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 11 Sep 2020 10:17:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bristot@redhat.com, swood@redhat.com,
        valentin.schneider@arm.com, peterz@infradead.org
Subject: [PATCH 0/2] sched: migrate_disable() preparations
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

These two patches are the result of Thomas pestering me with migrate_disable()
patches for upstream. The first one is a cleanup/fix for the existing
balance_callback machinery. The second (ab)uses the context_switch() tail
invocation of balance_callbacks() to push away 'undesirables' during CPU
hotplug after we've marked the CPU as !active.

With this in place, Thomas can do his horrible migrate_disable() thing ;-)

