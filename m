Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A499DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA85207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sTrS92pL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgFLUjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 16:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLUjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 16:39:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA3CC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 13:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k9rr+bJa+wvpicmcp96o9dB5/Zk/Wh3kQ8l8EsVqpHg=; b=sTrS92pLgzia6EgeNkneVXnp7T
        gteNaeroiO39119L7oHqgt4DnnDUTNJPSE8dHV4M3PT+FsKmhdRqt1KGeRkQMI1HqNRC2KesPoSGe
        YzzWNcUEfVYnuLGMcuAbbKN+DV/e2KqL8J1wZGa8Tz+A6Bl2x+CynzewhI2AO2u71ZwsqXKP974Dn
        EhBwvz6cRvJqWdozcUoIdsQo/cIz3ZByrmWHaHycxsjswLZJgvh4snWh8d17XUmAgFO0/gzN35PLM
        VzCwW6D6svC53e35oxJ3pegnEld+AuMXS97jIwlvhPq5ks7k8PPW64uOIy/0iDcx6FijD4FdcT/fw
        QRIwKzCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjqSg-0002DW-1X; Fri, 12 Jun 2020 20:39:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B532E300F28;
        Fri, 12 Jun 2020 22:39:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5FA3213DCC6A; Fri, 12 Jun 2020 22:39:35 +0200 (CEST)
Date:   Fri, 12 Jun 2020 22:39:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/msr: Filter MSR writes
Message-ID: <20200612203935.GH2497@hirez.programming.kicks-ass.net>
References: <20200612105026.GA22660@zn.tnic>
 <CAHk-=wjKr+eAdPg3q7S6N4Cwd1aMEOHc5qLaKE-wwhouZRo=uw@mail.gmail.com>
 <20200612174801.GE22660@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612174801.GE22660@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 07:48:01PM +0200, Borislav Petkov wrote:
> On Fri, Jun 12, 2020 at 10:20:03AM -0700, Linus Torvalds wrote:
> > Since you already added the filtering, this looks fairly sane.
> > 
> > IOW, what MSR's do we expect people to maybe write to normally? You
> > added MSR_IA32_ENERGY_PERF_BIAS as an allowed MST, maybe there are
> > others?
> 
> Right, this MSR is being written by cpupower in tools/. My search was
> confined within the kernel source only so there very likely are others.

So that tool writing to /dev/msr has already caused pain; the direct
result is that the intel pstate driver doesn't want to use an MSR shadow
variable to avoid RDMSR because that'd loose input.

https://lkml.org/lkml/2019/3/25/310

(sorry, that's what google found me)

So ideally we'd just disallow it too. It already has a sysfs file (per
those patches):

  Documentation/admin-guide/pm/intel_epb.rst
