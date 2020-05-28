Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA93C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC4D20814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q3KYZHAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390649AbgE1N5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:57:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59454 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390540AbgE1N53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eNh6FvDcWvkaaVgpzJcJ5GkjE9HAsRA0sShTLPPAqgk=; b=Q3KYZHAemq10peFLZCn4hkuGao
        dJZJDIdr1WpGIrvFXrDW4MDgUl9SdzkEsiqIr6cwr8Ewg1Pih1sWkozAHFBEQOkAGgLGwj5FqCD/Y
        z4/06kKJfEBiUMb8z8rvBxGlx7L1Z6lmK9y/bgvgft9P6tXVfcCtbvBcXv0lTZrCk6I7S+7NHBYYE
        RUI+n691OBUHfm8TVqTDOa9qWCNLxRvD1T+BuBjwdOenHou7d927XS5L9kyFpmxHmVooIWXPM484X
        Odie50rgrRHnqNVvrDJPgCMd+KocPIKCPQOxfMBMb8mDMkxOotaa0nQ5h02NIxrxtYjuBaA0jT3nj
        SOb0bz1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeJ21-0000x7-78; Thu, 28 May 2020 13:57:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E321030704D;
        Thu, 28 May 2020 15:56:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D11C8201479A3; Thu, 28 May 2020 15:56:59 +0200 (CEST)
Date:   Thu, 28 May 2020 15:56:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: TSC problems with Acer TravelMate 5735Z
Message-ID: <20200528135659.GE706495@hirez.programming.kicks-ass.net>
References: <a8c0c572-6dba-8d35-69bd-5e7b19bf6aba@molgen.mpg.de>
 <20200524185800.GV325280@hirez.programming.kicks-ass.net>
 <874ks0p8li.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ks0p8li.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 02:06:17PM +0200, Thomas Gleixner wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> > On Sun, May 24, 2020 at 07:09:18PM +0200, Paul Menzel wrote:
> >> Dear Linux folks,
> >> 
> >> 
> >> I got my hands on an old Acer TravelMate 5735Z (Intel GM45/Cantiga) and
> >> installed Debian Sid/unstable with Linux 5.6.7 on it.
> >> 
> >> Booting the system it takes a long time, and the systemd units fail to
> >> start. The logs contain that the TSC is unstable. Adding `tsc=unstable` to
> >> the Linux kernel command line fixes this.
> >
> > It fixes nothing; it just doesn't get you the warning because you told
> > it upfront.
> 
> Well, it prevents the kernel to use TSC upfront and not wait until it's
> discovered to be crap. That might make a difference.

IIRC my Core2 machines bail at boot with the message that TSC stops in
idle. Which is pretty deterministic and avoids userspace wreckage after
the fact, like with the BIOS 'goodness'.
