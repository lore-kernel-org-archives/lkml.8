Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD8DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD3A206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593598576;
	bh=zaXs2CbDvdszPriMRibslBZHNsXjv65VQsj0rfFmR+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cqZ53b0BgzF5uUaRmAdc1iZS5ThIJ55O6+60VFM+K2BqRFhVfmiCsfFHO+6MG7OeV
	 I+SJLJMCLXm7giG4rTRj/3dB9x9tZYpos9eaXq7kcnqhQzrrf76TLbA5hM3h5uXMDj
	 bOh6ZjfH9TpliNBzyeqkPmG2hlyOuCOV+jTs7ci4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgGAKQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbgGAKQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:16:11 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AECE206B6;
        Wed,  1 Jul 2020 10:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593598570;
        bh=zaXs2CbDvdszPriMRibslBZHNsXjv65VQsj0rfFmR+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x9F1GjIcBBX3hdCVHlt6wJhlZPB1N66WRkkqZTlXlWM63OjP7z5kH6BN/nqF+TGdK
         0l2eDCnBkdVi58H2QL0fQ2HW5wh+cQZXqBCv4zjoK3BLLwxqaxwskMx48hdn7mC2PX
         hIbO1vcmH/rJuuU6I20zoA0/9Lb9QB1M0qPY6kII=
Date:   Wed, 1 Jul 2020 11:16:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        alpha <linux-alpha@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 02/18] compiler.h: Split {READ,WRITE}_ONCE definitions
 out into rwonce.h
Message-ID: <20200701101603.GB14959@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-3-will@kernel.org>
 <CAK8P3a136e2k-iGoJ4X51mnj0f0KSLJKOw6b=s4F2QHHeyAMEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a136e2k-iGoJ4X51mnj0f0KSLJKOw6b=s4F2QHHeyAMEQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Jun 30, 2020 at 09:11:32PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 30, 2020 at 7:37 PM Will Deacon <will@kernel.org> wrote:
> >
> > In preparation for allowing architectures to define their own
> > implementation of the READ_ONCE() macro, move the generic
> > {READ,WRITE}_ONCE() definitions out of the unwieldy 'linux/compiler.h'
> > file and into a new 'rwonce.h' header under 'asm-generic'.
> >
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  include/asm-generic/Kbuild   |  1 +
> >  include/asm-generic/rwonce.h | 91 ++++++++++++++++++++++++++++++++++++
> >  include/linux/compiler.h     | 83 +-------------------------------
> 
> Very nice, this has the added benefit of allowing us to stop including
> asm/barrier.h once linux/compiler.h gets changed to not include
> asm/rwonce.h.

Yeah, with this series linux/compiler.h _does_ include asm/rwonce.h because
otherwise there are many callers to fix up, but that could be addressed
subsequently, I suppose.

> The asm/barrier.h header has a circular dependency, pulling in
> linux/compiler.h itself.

Hmm. Once smp_read_barrier_depends() disappears, I could actually remove
the include of <asm/barrier.h> from asm-generic/rwonce.h. It would have to
remain for arch/alpha/, however, since we need the barrier definitions to
implement READ_ONCE(). I can probably also replace the include of
<linux/compiler.h> in asm-generic/barrier.h with <asm/rwonce.h> too (so it's
still circular, but at least a lot simpler).

I'll have a play...

Will
