Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074E6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68A72075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ioXEcsyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391027AbgE1ORZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390834AbgE1ORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:17:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29117C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XU7Xog5/tE3DKQ0e/CcxbOISXbLE6LbC6jt4KWUIBY0=; b=ioXEcsyIA8fX32O4GPHRyNizUg
        LtPESZaVuv/lgQks728GCkGY1kuoJUWZ3dMsGdl4SgqGK++mtjxAMALmkcifw7C2MGVHMoTI7MV5I
        bg3bltDICqdmTZ7WULbxMzTCuc1wQBUvMX/kYdUlpC2MsE2UoQb1iCrvSS6nuZWU47UtEKT4Dh8ZS
        fYJHMl4RAHBfeKUJqzhUC8c+qOH6OnkaXA+lbSL7OaYLi7nW8MMRnGEBM//36l8pvzu2Nq5I9ShMq
        t98G0QUQwnAcvaehCa0YWtAOwFPRuXgiZc2r7rpna7aM2CajvbrajI1U/p0GmMhf8AHbjUmp96Aqp
        n64J7llQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeJLI-0007a5-SV; Thu, 28 May 2020 14:17:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25E9F306108;
        Thu, 28 May 2020 16:17:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D22E720D0904E; Thu, 28 May 2020 16:17:06 +0200 (CEST)
Message-ID: <20200528140535.206916549@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 28 May 2020 16:05:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        a.darwish@linutronix.de, rostedt@goodmis.org,
        bigeasy@linutronix.de, peterz@infradead.org
Subject: [PATCH v2 0/6] x86/entry,lockdep: Improve IRQ state tracking
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

They now survive a kbuild+perf-top load.

Changes since v1:

 - this_cpu_inc_return() fix
 - reordered patches
 - fixed up changelogs
 - fixed the actual NMI bits; we can't use IF on exit.

