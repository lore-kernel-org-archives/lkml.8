Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1187C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 864A720739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594916435;
	bh=PQee4AgUCogpdQDHjbReNKdVn4/HmPns+3W+57MW024=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bGCqTu/2HjtBsyd0PeTjGoq0xRmKvZk6D00Fdl5uZ3tOiqiaSeQU7hp7Tj2k4DEph
	 j06Z/SdFcDXmfKkZqA1qrJHwJDRaG1wyZx/J+w5Fn8lnl1mLolW+eZFbRsGpaWb4As
	 qXxZf8xq0TCMI5GOe5f0EgGMOJh+/VwVoqXVkW3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgGPQUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgGPQUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:20:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33BB52065F;
        Thu, 16 Jul 2020 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594916432;
        bh=PQee4AgUCogpdQDHjbReNKdVn4/HmPns+3W+57MW024=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JT0hUr3L+wdrMfMmF4x7T3mOiKvbORNaf+cg8byMoUqpCF/R8tQuHUC9zY4oK6e0y
         maThQaJ3F32XtkVS48seOhsmAlBGXCHIBMJHffyQNXRsEmgLyH+Rc/hikEd+NxVBTN
         xGGgSlc30fdsiLwwygFoRts3sW9CXnTL5JJYHi9A=
Date:   Thu, 16 Jul 2020 17:20:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: stacktrace: Convert to ARCH_STACKWALK
Message-ID: <20200716162022.GD5105@sirena.org.uk>
References: <20200715202821.12220-1-broonie@kernel.org>
 <20200715202821.12220-4-broonie@kernel.org>
 <alpine.LSU.2.21.2007161342290.3958@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2007161342290.3958@pobox.suse.cz>
X-Cookie: This login session: $13.99
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 01:56:13PM +0200, Miroslav Benes wrote:
> On Wed, 15 Jul 2020, Mark Brown wrote:

> > -void save_stack_trace(struct stack_trace *trace)
> > -{
> > -	__save_stack_trace(current, trace, 0);
> > +	walk_stackframe(task, &frame, consume_entry, cookie);
> >  }

> just an idea for further improvement (and it might be a matter of taste).=
=20

Yeah, there's some more stuff that can be done - the reason I'm looking
at this code is to do reliable stack trace which is going to require at
least some changes to the actual unwinder, this just seemed like a
useful block moving things forwards in itself and I particularly wanted
feedback on patch 1.

> Wouldn't it be slightly better to do one more step and define "struct=20
> unwind_state" instead of "struct stackframe" and also some iterator for=
=20
> the unwinding and use that right in new arch_stack_walk() instead of=20
> walk_stackframe()? I mean, take the unbounded loop, "inline" it to=20
> arch_stack_walk() and replace the loop with the iterator. The body of the=
=20
> iterator would call to unwind_frame() and consume_entry() and that's it.=
=20
> It would make arm64 implementation very similar to x86 and s390 and thus=
=20
> easier to follow when one switches between architectures all the time.

That's definitely on the radar, the unwinding stuff needs other changes
for the reliable stack trace (if nothing else we need to distinguish
between "errors" due to reaching the bottom of the stack and errors due
to bogosity) which so far looked sensible to bundle up together.

> Tangential to this patch, but another idea for improvement is in=20
> unwind_frame(). If I am not missing something, everything in=20
> CONFIG_FUNCTION_GRAPH_TRACER could be replaced by a simple call to=20
> ftrace_graph_ret_addr(). Again see for example unwind_next_frame() in
> arch/s390/kernel/unwind_bc.c (x86 has it too).

Yes, I'd noticed some divergence there and was going to look into it.

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8QfkYACgkQJNaLcl1U
h9AnkAf/cGt+i9TOTKfVzPwxvPOYxIgZQpSMlmklR0SY1sWmcGtHD2GGLY5vutZq
ew2RXblS1fSUHU/84tOR89SZP7ly/ojyOKifIZPvsxti8/cQK+UadByeJYCagHiu
25hGCUDK509xYFPbhqOUI7jb8PWSdwGqBYBV9SPZS4nZEEQpK4FaHNIs/Wu6vC+k
kuq976EB9160ZfH1k/iMUzNU4Sj2AKMqM70J8hEgMFxX8SlxkASobyqsS+nG0s9R
7Xsr/icmleu1Mi2Xli7p/+QZFsTXESSAv8yZusyAXu+Fz9YNK4JNBI9BaetkDV6A
9nPWgwOXONiJKps0DAdipNj5frMfmw==
=/UMo
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
