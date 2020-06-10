Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65A3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A872072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591807170;
	bh=r1yGF+uQ2Nr9wUo6VujDIN/5HHhoEEnJjSUViFks9pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IxuzN4ommw59LFE7n37Sx5asXoi5fB4brA5pWxWhAAtyM3MXBvFMk+5RPyTOsU1LT
	 9o5t+nApHg4giIqmrSZxhNSUYJHmNH7u+98K59BFElAkUXTR+SBQSy2Lsw3EvjzRzn
	 oGSavG3ZhDu6+ASQIseo+vQRCp2dGT3vf3bhFH9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgFJQj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgFJQj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:39:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23F9120734;
        Wed, 10 Jun 2020 16:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591807168;
        bh=r1yGF+uQ2Nr9wUo6VujDIN/5HHhoEEnJjSUViFks9pI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kcMyQZXVVFcaVhYcKP1Mz7m3D8KmlUakQUOP7v4amzUgrtHwCWgvNGtwyNoPqzPg8
         ImkkyxKHHZYMW00Mz6iLtceee5No3ywPW8kYRI2194rjW9O0BkwNmm4qjnF9wQib/d
         9GE2MqSMKzhRUJV8E7ANDsmEhq6SG/8ulrtE7PvQ=
Date:   Wed, 10 Jun 2020 17:39:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: sound/soc/meson/t9015.c:315:34: warning: unused variable
 't9015_ids'
Message-ID: <20200610163926.GI5005@sirena.org.uk>
References: <202005311147.iLK0hQoe%lkp@intel.com>
 <1jftb32b0o.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Content-Disposition: inline
In-Reply-To: <1jftb32b0o.fsf@starbuckisacylon.baylibre.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2020 at 05:31:03PM +0200, Jerome Brunet wrote:

> I'm not sure what to do with this report.
> I tried to reproduce has instructed, the log is full of warnings and the
> compilation eventually fails to link.

> It seems that most (if not all) drivers with a MODULE_DEVICE_TABLE() show
> this warning with the provided .config (COMPILE_TEST).

> When compiled with gcc, no such warning is shown.
> I can remove COMPILE_TEST for this driver, it will make the warning go
> away but I'm not sure it is appropriate.

I'd just ignore it for now - it seems like there's lots of false
positives from this warning which like you say are more global issues
and only show up at W=1.

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7hDL0ACgkQJNaLcl1U
h9BxXgf7BwJQWORKeCwngQf1DmeQvUUe+nF+p9S6HjqN0eAe6pNQaOCjFUp2T2TV
BdCBM1kFxSr1bQjpAErNa6mb8WijKyqlJQh0D5gDQNhRijQn4ay8lXDqQGuFi+NJ
wFc2cWUjyxV24o865SQdVbw8r0nYQcz1snHw5UJnNHo9Mmi+rRixy1Kl5D8qXf/R
kQi5Xvx/UDbvdIIhE6WnJGSzGf7M70hGb2zJ2q3bEmEVihdoOK+N+DNwHqYRMNny
SRXG4Zaj9xPhnoJJuLWyBhpw53tHJlWBeUriLsQssKkshbYOPWMDhd5ifowxtDuG
UgtRVEsCU+6KbkEWMTPIotbr4aOJXg==
=Fp9y
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--
