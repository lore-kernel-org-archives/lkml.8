Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13F1C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CEAF206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588089496;
	bh=9TW1ekAy/plmUmvDsp58sZbU5BRtwtBDznTog9YdzDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=USyS4N47BEa2DQnmNkodT6vsScuhAoPN499Kbtqe/eHHXWIWrcZGptFIEJHxImcjC
	 DAeDTZ/gulIbqufjtzQentxvD1WxpIFeZ7zexjeCul+Rkul3E5w1Jn1bph6jjmpD9O
	 NpYsmlzXr0aTqXBCBlhoKr8YIIlpzimVWdoWpn50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgD1P6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbgD1P6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:58:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E97F20661;
        Tue, 28 Apr 2020 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588089494;
        bh=9TW1ekAy/plmUmvDsp58sZbU5BRtwtBDznTog9YdzDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vggH6IunjsexihMHuZ1LkEoFGXuw/IsSxeF2VISAqmeWQP8cRjRMT7X2QWbDImWmx
         OkPGHCXNhAH5LR5or/+ahqXHmRVJV5D9ITw0a745tCajzLCI147NRzZ6E9/fKW6Ldi
         W1x0zIwY+AggNwLUsuJzGxqokq3OUMBXC0Ow9y10=
Date:   Tue, 28 Apr 2020 16:58:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v10 00/13] arm64: Branch Target Identification support
Message-ID: <20200428155808.GJ5677@sirena.org.uk>
References: <20200316165055.31179-1-broonie@kernel.org>
 <20200422154436.GJ4898@sirena.org.uk>
 <20200422162954.GF3585@gaia>
 <20200428132804.GF6791@willie-the-truck>
 <20200428151205.GH5677@sirena.org.uk>
 <20200428151815.GB12697@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvznHscUikHnwW2p"
Content-Disposition: inline
In-Reply-To: <20200428151815.GB12697@willie-the-truck>
X-Cookie: Eschew obfuscation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvznHscUikHnwW2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2020 at 04:18:16PM +0100, Will Deacon wrote:
> On Tue, Apr 28, 2020 at 04:12:05PM +0100, Mark Brown wrote:

> > It's probably easier for me if you just use the existing branch, I've
> > already got a branch based on a merge down.

> Okey doke, I'll funnel that in the direction of linux-next then. It does
> mean that any subsequent patches for 5.8 that depend on BTI will need to
> be based on this branch, so as long as you're ok with that then it's fine
> by me (since I won't be able to apply patches if they refer to changes
> introduced in the recent merge window).

That's not a problem, that's what I've got already and if I try to send
everything based off -rc3 directly the series would get unmanagably
large.  Actually unless you think it's a bad idea I think what I'll do
is go and send out a couple of the preparatory changes (the insn updates
and the last bit of annotation conversions) separately for that branch
while I finalize the revisions of the main BTI kernel bit, hopefully
that'll make the review a bit more approachable.

--GvznHscUikHnwW2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6oUo8ACgkQJNaLcl1U
h9ANJwf/WRlo08Mn6rULa8b3pqa1bQzdRN/zAGUfNf93UHKMH2yvxQZ6GTGie8us
Kw24VCNz5n7f6AjcO0v+vH6pAJxlD2DHraSawXDaEKZJ2YMnFSryzWFrWJr12klT
DRRRi3+D2+GBFPflADAl2YaCfEV9D2USZGPG6OB/gkF43dmK1VIAon0ixx8WL7dw
GtmV9U8DZlC9FrJd7gh9jbJGYiIgZ7hcMR2eyuzH5Z2gW4WPwWOkfd+pc9eBuyNl
vbBauk5tAYnPssGMtNUG7M9gakg5U1GsRBY7E1QUJ97iMAUqiKN2Z1mharmqU6cs
sswMEKQMo98MespYoImEM/wHQ5GqJw==
=KIkv
-----END PGP SIGNATURE-----

--GvznHscUikHnwW2p--
