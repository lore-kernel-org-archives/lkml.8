Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACC7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40EED20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zcQlv+AM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGPH7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPH7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:59:14 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C94C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4yHrVwlLmRJ5Bhrf6xotNIxowaqaP9OKLVsYKTRYeZY=; b=zcQlv+AMirIGkhjBtwpzK2apBM
        LECXQoNcXnetlLH3TUpxSzOT4dAIe+3P5RvOpmiOOkQJf9fY42LZ1Oa454qrZh6gAiH7pSbjQ9QPj
        sSpHdkRNFxJegyMI3el3sfTQ2kfwJBPccx71ES1wY12YtiSih6hA/mS+7i7xYFM611sThJ60zW2r3
        J2Kykcgghbp/ijLUQkcbyL75Bb9GBb9MK+GLVNHofez61TEKQE/xZTTqc1Q55FnGcKhDuffTrA2my
        bRuwhRAUWsL9VEdTr+vYu47sCo+JdXZRvQgDo7MI2nMWaQ7Kvd5LzZ8QRJkvIBZQoGGKqxL1jYXmE
        dgyahRkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvynJ-0001Y8-QW; Thu, 16 Jul 2020 07:59:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94DA9300130;
        Thu, 16 Jul 2020 09:59:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BD9F23D64B97; Thu, 16 Jul 2020 09:59:04 +0200 (CEST)
Date:   Thu, 16 Jul 2020 09:59:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] trace/events/sched.h: fix duplicated word
Message-ID: <20200716075904.GN10769@hirez.programming.kicks-ass.net>
References: <25305c1d-4ee8-e091-d20f-e700ddad49fd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25305c1d-4ee8-e091-d20f-e700ddad49fd@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 06:31:38PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Change "It it" to "It is".

So I read the diff 2 times, gave up and went to read the Changelog
before I noticed the change... clearly I need more wake-up juice :-)

Thanks!
