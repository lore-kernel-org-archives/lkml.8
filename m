Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BC6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139892086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mOhZcWgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHGTCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHGTCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:02:15 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36A1C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dSQ55qZF/+1KL/4yLTuSgU8vfCk1Ou9csjN0s+BgZsQ=; b=mOhZcWgJWpWQU6juOT8JoylJOH
        6NAKNS6fxdeiYpEl/3VapaW3X3YztfZG0OQ6Rj3r7lPMzRtvlrhD9hCUPXlmUkFXd+hIUdBQYwIzW
        JyrMYzfvyVfTef1+7aqpmhWJ3kXntbxKqOSFNNVu5+HCMFzZ5qFq0xlRl4AawhvPkF6izv+2XSca/
        FY/mw5SqPWXXDZXHQipHdtmhSho2Xd0CS9BND7L1SdCGHHw+eiXDn1jfm/qXE/0Vd0u9HXbxId+7S
        l9BtW+b4w+IgLf5xkc9AqpytPMHFgTKzBRlk8fVbJmhXV5PGyn3vCLPuj07tuU/RHjRsh9opf3HPz
        9nkPKyug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k47d3-0003CW-60; Fri, 07 Aug 2020 19:02:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AEBA13010D2;
        Fri,  7 Aug 2020 21:02:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8391E200D415D; Fri,  7 Aug 2020 21:02:04 +0200 (CEST)
Date:   Fri, 7 Aug 2020 21:02:04 +0200
From:   peterz@infradead.org
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Oskolkov <posk@posk.io>, Peter Oskolkov <posk@google.com>,
        paulmck <paulmck@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>
Subject: Re: [PATCH 1/2] membarrier: add
 MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
Message-ID: <20200807190204.GN2674@hirez.programming.kicks-ass.net>
References: <20200806000859.160882-1-posk@google.com>
 <20200806134828.GA165568@hirez.programming.kicks-ass.net>
 <CAFTs51Ufyds5mypiysL=2ZwtyMk9hjLm-9tJbYz=xciY1f2=5g@mail.gmail.com>
 <1668913120.1621.1596735425601.JavaMail.zimbra@efficios.com>
 <CAFTs51VabphnoXOxLgUqDL288zfLpEugC-H5jxg=JGhTHB7QDg@mail.gmail.com>
 <1689650939.2607.1596823679392.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689650939.2607.1596823679392.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 02:07:59PM -0400, Mathieu Desnoyers wrote:
> One thing I find weird about Peter's patch is that it adds a
> MEMBERRIER_CMD_PRIVATE_EXPEDITED_RSEQ without a corresponding
> MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ. Considering that
> the SYNC_CORE variant already has its own register command, I
> find it weird that the RSEQ counterpart does not have one.

I thought the register thing was about global, not private membarriers.

Anyway, it was just a quick pseudo thing to show how one can go about
adding the rseq to the mm iteration we already have.
