Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7A1C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81382082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581336809;
	bh=DRxz5Ry7jRSt0sOgGil4GDYbZpOzpI5d3zflKn3sTyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fZ3zwV+adfkItgF/mzm146dOegLkvrOGZ6OcV2W5LsNYmpNmsngXYBBeydTBeD85L
	 pDaFqtzTC8BxiRAVXaElbqSotM0IROLyhCpxAQCzNdJsDDg7LWE3SeLL4R/lZWDmQM
	 ZT4X7iOD+ezEscojM9WSIfmu+2WaDh1gPfjkgY1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBJMN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:13:28 -0500
Received: from foss.arm.com ([217.140.110.172]:59552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgBJMN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:13:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 531B81FB;
        Mon, 10 Feb 2020 04:13:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBFB83F6CF;
        Mon, 10 Feb 2020 04:13:26 -0800 (PST)
Date:   Mon, 10 Feb 2020 12:13:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Mark Salyzyn <salyzyn@android.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] random: add rng-seed= command line option
Message-ID: <20200210121325.GA7685@sirena.org.uk>
References: <20200207150809.19329-1-salyzyn@android.com>
 <20200207155828.GB122530@mit.edu>
 <d35bacd4-ba3f-335d-85c4-57e87abd8e9a@android.com>
 <20200208004922.GE122530@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20200208004922.GE122530@mit.edu>
X-Cookie: Avoid gunfire in the bathroom tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 07, 2020 at 07:49:22PM -0500, Theodore Y. Ts'o wrote:

> "add_device_randomness()" and so what this commit is doing is simply
> counting the length of xxx in "rng_seed=xxx" and assuming that those
> bytes are 100% entropy and simply crediting the trusted entropy by
> length of xxx.  If xxx happened to be a hex string, or worse, was

That'd been what I'd intially read the commit message as saying :/

> The second is that we're treating rng_seed as being magic, and if
> someone tries to pass in something like rng_seed=0x7932dca76b51
> because they didn't understand how rng_seed was going to work, it
> would be surprising.

We already have a kaslr-seed property on arm64 since we need a seed for
KASLR *super* early, we could generalize that I guess but it's not clear
to me that it's a good idea.  One fun thing here is that the kernel
command line is visible to userspace so we go and erase the seed from
the command line after reading it.

> My preference would be to pass in the random seed *not* on the
> command-line at all, but as a separate parameter which is passed to
> the bootloader, just as we pass in the device-tree, the initrd and the
> command-line as separate things.  The problem is that how we pass in
> extra boot parameters is architecture specific, and how we might do it
> for x86 is different than for arm64.  So yeah, it's a bit more
> inconvenient to do things that way; but I think it's also much
> cleaner.

Anything that requires boot protocol updates is going to be rather
difficult to deploy for the use it'll likely get - as far as I can see
we're basically just talking about the cases where there's some entropy
source available to the bootloader that the kernel can't get at
directly.  With the arm64 kaslr-seed it's not clear that people are
feeding actual entropy in there, they could be using something like the
device serial number to give different layouts on different devices even
if they can't get any useful entropy for boot to boot variation.

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5BSOQACgkQJNaLcl1U
h9Auzwf/av2aK6TmqdtmdtPDkrEB5Ek3/DfxaTDm2Pq+d6v4WVPoruo4dJ33Hg8a
QDBj0QbfLZuf7iMHKt1ZXQhZdwKlBvS1LeFQ+c7u9Dg4jQSHaPHARfgJbkKwWM01
yDLCytGbz9Fek2mxF01MQGeF1FKofeZpix5ANWdUQDYIZilMCPeWjzjUtQHW7d7e
ewQLu6jFtCGSFOl+dTyXRKagh0avbTmJY4s/hboTZAq8/dcI4xWq+gU6TS7leadx
qS5L35dcFQvm3GCANMei52mTz+BXaT7EbNuHaBL8n08hFBC8Ajwmn+2170sA7z0n
qS90ap7mJsFpE0jNINaZ0JIDFmvNlw==
=rsy5
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
