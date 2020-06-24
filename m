Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6AFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1CD2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593015851;
	bh=hC/tMOp7XJE7LWrTe6wekS6ygzz+JEMjzao1qQnF1v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A7BsQujPgVShEv9qb41Yd1H4pm2aTjcvj7jnUusei+o0nbVN/1eEEqUqGcZTm7+yh
	 FwyKJQPg+QmEl6wQGuirt6LtmTC2ul1PQjSXL3rFi7TVFh6quK5UbovSWL5PZV8x3R
	 +9u/LqU0ZQAeXkuYitbejfE2pMyGCoIQDH7xcwdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404906AbgFXQYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404468AbgFXQYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:24:09 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE7D520823;
        Wed, 24 Jun 2020 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593015849;
        bh=hC/tMOp7XJE7LWrTe6wekS6ygzz+JEMjzao1qQnF1v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLrXpIVURABHgMMI8XW4SBezPTaxd8k6qBHCtcS7hBctySTX09+7Vc+1dT5Nvj89J
         H/YiN+pARpsz4bBJFTithpf2P7gjj2+NoODPyF0Ps3mEUPFFvUZnSKyYtMrwUldTPU
         nL7qH2fiqF3wY6dZYQvYDRaoB6UEGz5EM7cCPFkU=
Date:   Wed, 24 Jun 2020 09:24:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     agk@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, dm-crypt@saout.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: [dm-crypt] [RFC PATCH 1/1] Add DM_CRYPT_FORCE_INLINE flag to
 dm-crypt target
Message-ID: <20200624162407.GB200774@gmail.com>
References: <20200619164132.1648-1-ignat@cloudflare.com>
 <20200619164132.1648-2-ignat@cloudflare.com>
 <20200624050452.GB844@sol.localdomain>
 <CALrw=nFduv_X83V1Dfz+bt4bZqT19OSi3q5f7umhty1-DQ2SPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALrw=nFduv_X83V1Dfz+bt4bZqT19OSi3q5f7umhty1-DQ2SPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 09:24:07AM +0100, Ignat Korchagin wrote:
> On Wed, Jun 24, 2020 at 6:04 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Fri, Jun 19, 2020 at 05:41:32PM +0100, Ignat Korchagin wrote:
> > > Sometimes extra thread offloading imposed by dm-crypt hurts IO latency. This is
> > > especially visible on busy systems with many processes/threads. Moreover, most
> > > Crypto API implementaions are async, that is they offload crypto operations on
> > > their own, so this dm-crypt offloading is excessive.
> >
> > This really should say "some Crypto API implementations are async" instead of
> > "most Crypto API implementations are async".
> 
> The most accurate would probably be: most hardware-accelerated Crypto
> API implementations are async
> 
> > Notably, the AES-NI implementation of AES-XTS is synchronous if you call it in a
> > context where SIMD instructions are usable.  It's only asynchronous when SIMD is
> > not usable.  (This seems to have been missed in your blog post.)
> 
> No, it was not. This is exactly why we made xts-proxy Crypto API
> module as a second patch. But it seems now it does not make a big
> difference if a used Crypto API implementation is synchronous as well
> (based on some benchmarks outlined in the cover letter to this patch).
> I think the v2 of this patch will not require a synchronous Crypto
> API. This is probably a right thing to do, as the "inline" flag should
> control the way how dm-crypt itself handles requests, not how Crypto
> API handles requests. If a user wants to ensure a particular
> synchronous Crypto API implementation, they can already reconfigure
> dm-crypt and specify the implementation with a "capi:" prefix in the
> the dm table description.

I think you're missing the point.  Although xts-aes-aesni has the
CRYPTO_ALG_ASYNC bit set, the actual implementation processes the request
synchronously if SIMD instructions are currently usable.  That's always the case
in dm-crypt, as far as I can tell.  This algorithm has the ASYNC flag only
because it's not synchronous when called in hardIRQ context.

That's why your "xts-proxy" doesn't make a difference, and why it's misleading
to suggest that the crypto API is doing its own queueing when you're primarily
talking about xts-aes-aesni.  The crypto API definitely can do its own queueing,
mainly with hardware drivers.  But it doesn't in this common and relevant case.

- Eric
