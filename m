Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F45C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD3220810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mMdqz80A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgE2VfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgE2Ve6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:34:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7878C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 14:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Y983c9v/CXu+qNOWjXrZmxewWC1dZWbypksdujlXb0w=; b=mMdqz80AaK9veXLNdD2wEGB0AE
        26nmoclqFo4wTWMYeUdZgtuPPHDFAfBHrF2X+mAZkF2tQ08llKuVFF4Tvza1JNFzu21R0mPhpxU98
        nTDnZEz6UFRgVPzb6EgUp5KC18OLrqipmwSE5Mg9kd1bc2itLEqoYECFnhjr/sXeQH5tBiu/7dftK
        JTMSZapM0P62h2Pc1mRUzUg7H/O9rSTL1WQ+0hOQ/CNY1N42sM7vHt9y/f83038J88YdR9g6Ypffe
        QBFgYABcwT1i2FuKiKIPsagiToynAOE3sIohXGBFhsfXk5tMb2VuLtnXi4Kro83HFJrCTrWqynLlX
        Wvu5ipYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemeJ-0000Kl-Kr; Fri, 29 May 2020 21:34:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B2043011FF;
        Fri, 29 May 2020 23:34:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 16C612021AF90; Fri, 29 May 2020 23:34:41 +0200 (CEST)
Message-ID: <20200529212728.795169701@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:27:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
Subject: [PATCH 00/14] x86/entry: disallow #DB more and x86/entry lockdep/nmi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches disallow #DB during NMI/#MC and allow removing a lot of fugly code.

And also include 4 patches from the lockdep/nmi series that clean up x86/entry
bits.

I'll send the rest of the lockdep patches seperately.

