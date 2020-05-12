Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE85C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 407E220674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i6SU59fO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgELIX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726187AbgELIX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:23:27 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D172C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FeXpGIxuOOt5NISH1tSfIL+s7TUHX+8me1nLN/9ADvk=; b=i6SU59fOcGddhGDUD+VClLsFLL
        BwegR24zHzIlToIMxvSLrH+k3fQ4bqty2PopniUZNPhxUv6Fwtbz9GYab7Wj5uz/MeN/uzi692V+E
        bVvG/KZU6ErSqNEQfVpbCKmb5G9MX/OvHELkg+/s0KkUxMvoHL8QBgHQ8zPDaH7avq168QqN5ppTh
        A8/nbI3V/RXMfb6Y45F0JMNK8GVm2Ep9EuvAX/6bqG6Wa8wfzvSeM0YVtYEmMcmJaoQfwhfuv/5hO
        dElD35pQk92ZGSCSU1VJfCcTxJg0n23blhNaxeFhRCCTHRJssV41+Ql4mxxwc/lmPt5tDIGKQzhDk
        rHaY4LXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYQBv-0003H6-I3; Tue, 12 May 2020 08:23:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 642F63011E6;
        Tue, 12 May 2020 10:23:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4FDD82096103E; Tue, 12 May 2020 10:23:06 +0200 (CEST)
Date:   Tue, 12 May 2020 10:23:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, elver@google.com, tglx@linutronix.de,
        paulmck@kernel.org, mingo@kernel.org
Subject: Re: [PATCH v5 17/18] READ_ONCE: Use data_race() to avoid KCSAN
 instrumentation
Message-ID: <20200512082306.GF2978@hirez.programming.kicks-ass.net>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-18-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511204150.27858-18-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:41:49PM +0100, Will Deacon wrote:

> +	data_race(({ __WRITE_ONCE(*__xp, val); 0; }));			\

That had me blink for a little, I see how we got there, but urgh.

Anyway, it's all in *much* better shape now than it was, so no real
copmlaints.
