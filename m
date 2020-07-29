Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B8FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 560FA2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="REnBsV/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgG2Jgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgG2Jgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:36:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E57C061794;
        Wed, 29 Jul 2020 02:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n6aG/JmP+LzY7spLF8PmebYkIDE5NWl60aSZUAMzQuI=; b=REnBsV/RL/3Swngd02XYtxvMkJ
        A5qucqZ2sq6QgNrnmhpfaHNV2+tRL/vSJw18ayq8MpWa+XQfTA4rrJbgzvZgulK3RuKIdAWNZNa1P
        Vi8EjE/mDd9iNmzY+iPnHzUEQ4tkDuwWlpJUMYSuNUfU2wUuC2E9QqzxSyQYjBNFhPh1li5KG30c6
        dF0hV83NcqWXzmPSSOPtZB5jvNW6YABkwkJ9uBPLQVyC40SGVK8NhF2H8dde9w3rhPVRCOsyHatek
        aZgyhi0+dkE2n+9BhzjAbRdNhu9DxZc09gAIoOO4VjX/7D2CsOpQqsVW+aprG+/esEw7rWlM5mFmB
        6TyJFzGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0iVm-0001s8-Gc; Wed, 29 Jul 2020 09:36:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A274304B6D;
        Wed, 29 Jul 2020 11:36:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE8F02BB55740; Wed, 29 Jul 2020 11:36:32 +0200 (CEST)
Date:   Wed, 29 Jul 2020 11:36:32 +0200
From:   peterz@infradead.org
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>
Subject: Re: Minor RST rant
Message-ID: <20200729093632.GC119549@hirez.programming.kicks-ass.net>
References: <20200724132200.51fd2065@oasis.local.home>
 <20200724113325.44923f75@lwn.net>
 <20200728125252.GW119549@hirez.programming.kicks-ass.net>
 <20200728112828.459307a5@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728112828.459307a5@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 11:28:28AM -0400, Steven Rostedt wrote:
> Sometimes I do look at the html output on kernel.org, and it is nicely
> organized. The future of developers will probably prefer that format
> over plain text whether we like it or not, so I encourage that we

The future is doomed.

Anyway, the last time I checked, it was possible to select a monospace
font in HTML. For bonus points, use a green bar paper css [1], add
some line numbers, and use a daisy wheel font [2].

That renders any actual .txt document with style, even if you absolutely
must use a browser.


[1] https://gist.github.com/BigEd/56f6c0001c8670d1647d5448e91346d6
[2] https://www.dafont.com/daisy-wheel.font
