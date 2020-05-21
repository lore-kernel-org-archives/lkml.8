Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8852AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E42A207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590068585;
	bh=B5c3UjkBmNmyt5mM0MfSvuhfYgcHNnoOLxnuIO2lEgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J8n6fx8vHt2CmuXmydVbYDR+oP/xnTgGFF/740V+jHpadwQUgGPvxvqF2Ki0+7xCU
	 XT8873ArwrxhkPxaVJFDG/hMvCMizLDx1S29anx3/Of3nHFQ9s6HmPKJ61WBXNwUG7
	 vDHyQ41w0Ez/oorKmoj5dJLLPMESDNvZCaIc3rAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgEUNnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgEUNnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:43:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 938BB2072C;
        Thu, 21 May 2020 13:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590068583;
        bh=B5c3UjkBmNmyt5mM0MfSvuhfYgcHNnoOLxnuIO2lEgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ToaY+1MyEC4snUXo9nWYEGAUTR2TagfeBt/iVuZMv8H6PSBUufM3GFLMGBJjt4Pm+
         VFq0TEkd4f38wq6+xbJmDgrws/zN1KuHANyVjo4hPaCTTPjDNjKf8M8+Rj9hGXLC0Z
         QvPlrdI+S90OTSJf5ttAJ0SUrIiKG3khW4GYbfoo=
Date:   Thu, 21 May 2020 14:42:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH -tip v2 00/11] Fix KCSAN for new ONCE (require Clang 11)
Message-ID: <20200521134257.GE6608@willie-the-truck>
References: <20200521110854.114437-1-elver@google.com>
 <20200521133626.GD6608@willie-the-truck>
 <CANpmjNMf7JRG4P1Ab2qsCy4Yw6vw2WC7yCgqUSBBOsBQdc_5bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMf7JRG4P1Ab2qsCy4Yw6vw2WC7yCgqUSBBOsBQdc_5bQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 03:42:12PM +0200, Marco Elver wrote:
> On Thu, 21 May 2020 at 15:36, Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, May 21, 2020 at 01:08:43PM +0200, Marco Elver wrote:
> > > This patch series is the conclusion to [1], where we determined that due
> > > to various interactions with no_sanitize attributes and the new
> > > {READ,WRITE}_ONCE(), KCSAN will require Clang 11 or later. Other
> > > sanitizers are largely untouched, and only KCSAN now has a hard
> > > dependency on Clang 11. To test, a recent Clang development version will
> > > suffice [2]. While a little inconvenient for now, it is hoped that in
> > > future we may be able to fix GCC and re-enable GCC support.
> > >
> > > The patch "kcsan: Restrict supported compilers" contains a detailed list
> > > of requirements that led to this decision.
> > >
> > > Most of the patches are related to KCSAN, however, the first patch also
> > > includes an UBSAN related fix and is a dependency for the remaining
> > > ones. The last 2 patches clean up the attributes by moving them to the
> > > right place, and fix KASAN's way of defining __no_kasan_or_inline,
> > > making it consistent with KCSAN.
> > >
> > > The series has been tested by running kcsan-test several times and
> > > completed successfully.
> >
> > I've left a few minor comments, but the only one that probably needs a bit
> > of thought is using data_race() with const non-scalar expressions, since I
> > think that's now prohibited by these changes. We don't have too many
> > data_race() users yet, so probably not a big deal, but worth bearing in
> > mind.
> 
> If you don't mind, I'll do a v3 with that fixed.

Works for me, thanks.

Will
