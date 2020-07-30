Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512C2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1212B206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cBWmwJHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgG3Ndr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgG3Ndr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:33:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41684C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AGA2ockqtuV8jLCR10gJ+dJi/iY4EZc6RqaG3EAXAhw=; b=cBWmwJHyCGVegRMAisPHlPwKue
        HRkNawp8li5bgYBzo7yhGXZz+UsmhK3emnS5K2ErkEZgC+hkAjonYpSqxXHvX41vSIrZ8+9gglOaA
        HszEBK+/c2Z8IRzuRcJVknA/QubK6coJRMpLHcJOgr2+F1J/oTDn7MOsuzEInf04uU8id/GmMzRYF
        rKFJX9bbMRYd0b7wJJjZTX/qydxX06fA44lUhPrPJORyLO1/knniSZ2aab2iqOnvwHslJMFZMF5ZI
        MO44HmTtk+KWwydQLvOtFWcYO+r6xgL8JAYvwx9rI60XGT76UmSxbLRBpBOOZyr94lWYN4jfAe74L
        uD5gfQdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k18gq-0008D1-4B; Thu, 30 Jul 2020 13:33:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B913A304D58;
        Thu, 30 Jul 2020 15:33:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DF51203DB3A4; Thu, 30 Jul 2020 15:33:43 +0200 (CEST)
Date:   Thu, 30 Jul 2020 15:33:43 +0200
From:   peterz@infradead.org
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mhelsley@vmware.com, mbenes@suse.cz
Subject: Re: [PATCH v3 4/4] objtool: orc_gen: Move orc_entry out of
 instruction structure
Message-ID: <20200730133343.GN2655@hirez.programming.kicks-ass.net>
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730094143.27494-5-jthierry@redhat.com>
 <20200730100304.GI2655@hirez.programming.kicks-ass.net>
 <e4e239ad-120e-bd8f-4128-6976146c8512@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4e239ad-120e-bd8f-4128-6976146c8512@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 01:40:48PM +0100, Julien Thierry wrote:
> 
> 
> On 7/30/20 11:03 AM, peterz@infradead.org wrote:
> > On Thu, Jul 30, 2020 at 10:41:43AM +0100, Julien Thierry wrote:
> > > One orc_entry is associated with each instruction in the object file,
> > > but having the orc_entry contained by the instruction structure forces
> > > architectures not implementing the orc subcommands to provide a dummy
> > > definition of the orc_entry.

> I guess I forgot about the usecase of running objtool on vmlinux...

Right, and LTO builds will even do ORC at that level.

> On a kernel build for x86_64 defconfig, the difference in time seems to be
> withing the noise.

Good.

> But I agree the proposed code is not ideal and on the other we've tried
> avoiding #ifdef in the code. Ideally I'd have an empty orc_entry definition
> when SUBCMD_ORC is not implemented.
> 
> Would you have a suggested approach to do that?

How ugly is having that:

struct orc_entry { };

?
