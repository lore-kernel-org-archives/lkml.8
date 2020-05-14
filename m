Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B457C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 650F720671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G+TRj94C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgENONx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgENONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:13:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43318C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=24DpN9zNO9oQkKgQN/LTrZSM6weAKUr94T8Nr9pkRko=; b=G+TRj94C7NwDSva0dqVIEmncc4
        Sl/U3vVasaBDWzTVfLHIAoe5PFcF6z57yuCCn9daZKiAdsgiRC5ZDn4KhDPUHMR3cz3csZ+Aii3b4
        Oeo3MhZHt2KbyvTh8sMDzVEPJKUuxv8eXLGWsnnYk439hqHguZSxAB695mlmlzI6SzoBV/NgMKIUW
        P8goBUMM6J1G5L8URDNqoCDTGuDUX+aHaVUInaFO2KZsQW42CB01ly9mgrwqEwsj88cDexTzs2ggV
        AC9Ft+tFas0gMBLTXm6rc+1+b6nn7CilvFAvRdNYL9clr9i+r2DEFOWD38HtEsBq8KegS9QsGS6Vt
        ExtLQ8+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZEcM-0000AE-Nl; Thu, 14 May 2020 14:13:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 01967301A66;
        Thu, 14 May 2020 16:13:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB9382B852D45; Thu, 14 May 2020 16:13:44 +0200 (CEST)
Date:   Thu, 14 May 2020 16:13:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200514141344.GB2978@hirez.programming.kicks-ass.net>
References: <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net>
 <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net>
 <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net>
 <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513132440.GN2978@hirez.programming.kicks-ass.net>
 <CANpmjNM5dD1VH0hoQwsZYEL=mhWunKwAEJMQgASzHSN019OCnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM5dD1VH0hoQwsZYEL=mhWunKwAEJMQgASzHSN019OCnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 03:58:30PM +0200, Marco Elver wrote:
> On Wed, 13 May 2020 at 15:24, Peter Zijlstra <peterz@infradead.org> wrote:

> > Also, could not this compiler instrumentation live as a kernel specific
> > GCC-plugin instead of being part of GCC proper? Because in that case,
> > we'd have much better control over it.
> 
> I'd like it if we could make it a GCC-plugin for GCC, but how? I don't
> see a way to affect TSAN instrumentation. FWIW Clang already has
> distinguish-volatile support (unreleased Clang 11).

Ah, I figured not use the built-in TSAN at all, do a complete
replacement of the instrumentation with a plugin. AFAIU plugins are able
to emit instrumentation, but this isn't something I know a lot about.
