Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07C1C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 774DD20674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TidL0ORJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgELMrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727783AbgELMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:47:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F90C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=j5f0cEjVT47LMjbR5r5vLspcnzuMNgALjw8aeh6aFX4=; b=TidL0ORJTKOVa0bDnGfXHzicek
        yKnXEi6hNoK93p3Tr1XDMTJaHw7dFVR+aCLJGxIgksFnEbxJjvAQmfstNWM2J1knXPlO/WyFB30OJ
        TWyA2kIteGpgKO293o8rmclkBYyGOsUV6/PszuR6UsPYtngq/zOwh4FtN8s14grfEddNEGmbXhk5T
        F8LJoimtAwW9TeIcEOzFiaidQBz7/5QWrFTSB21RMhBufMdpT+y3wD3C6M1Ph7CV061OQY7bQSaZS
        krFDdL+niMH7v/ZGmt+yFbG3toIgdIgAJ52dBEOBFNVn8rdA3l94rkOvTauIiUeJ8xUV3/ng9NUsS
        esJ0XPgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYUJE-0007C1-2F; Tue, 12 May 2020 12:46:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41329301EFB;
        Tue, 12 May 2020 14:46:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 22AB720962E53; Tue, 12 May 2020 14:46:53 +0200 (CEST)
Message-ID: <20200512124058.833263033@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 12 May 2020 14:40:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        sboyd@codeaurora.org, john.stultz@linaro.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 0/5] arm64: perf: Proper cap_user_time* support
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prompted by Leo's patches, here a series that corrects the arm64 perf cap_user_time situation.

