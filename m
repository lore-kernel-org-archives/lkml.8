Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7633C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8874620853
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594383908;
	bh=8EsGM1/sIwTVcpAQe7TEUsY+6kH9ifOWJML/Kic2iSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TFYF+5hy2hasmQvQxFgPd6DCB1p0oEefDfOZC4jDbpfOPpvWCxadfGsCKHpSgd2BH
	 lstEr+lL4iRNaGk0n5n70acZCJvcMets7SwgFbTavR+aFs3cZI+t9INO1jYC2eJkZT
	 wc9PAGV+PN747nUqr5EYum0Ho37pCypB8ZnQSyH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgGJMZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgGJMZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:25:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C45C20748;
        Fri, 10 Jul 2020 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594383905;
        bh=8EsGM1/sIwTVcpAQe7TEUsY+6kH9ifOWJML/Kic2iSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qs3++11iHmi6cHhyL2ddXR+69yYnAcSTUfjvJ0rEtCPSGwhGnwMmyN0ilbN3gnaU0
         i6VQCxj+JDFg728QUQ0q3xK7n6OGn+C34qjRXj6KxaDzROxXluUTyUKPzDlqLAgxh5
         7q/yuFywcbrbpJuSzMwQ3V00QRO8tP2uo6Y4a17Y=
Date:   Fri, 10 Jul 2020 13:24:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: sound/soc/codecs/zl38060.c:614:34: warning: unused variable
 'zl38_dt_ids'
Message-ID: <20200710122459.GE5653@sirena.org.uk>
References: <20200710024100.GA2055744@ubuntu-n2-xlarge-x86>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline
In-Reply-To: <20200710024100.GA2055744@ubuntu-n2-xlarge-x86>
X-Cookie: Use only in a well-ventilated area.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2020 at 07:41:00PM -0700, Nathan Chancellor wrote:

> When CONFIG_SND_SOC_ZL38060 is y, MODULE_DEVICE_TABLE expands to nothing
> so zl38_dt_ids will be unused. This is a pretty common construct in the
> kernel and the only way I can think of to resolve this through the code
> is by adding __used annotations to all of these variables, which I think
> is overkill for this.

> Personally, I think this warning should be downgraded to W=2, thoughts?

We've had that warning available for ever, we shouldn't need to disable
it now.  I had thought there was supposed to be magic which caused
of_match_ptr() to make things look referenced when !OF but don't seem to
actually see any sign of it.  The other thing is to just have ifdefs
around the table.

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8IXhsACgkQJNaLcl1U
h9DSGwf+MlJ4XSqif2TolBc5SBPYppVlodlEgCHk63vcT2C70y5Ddq4UJ3FrWKTQ
qWkFsOf+ACwdiYjrJAD91zKvpMimbnvSzUdMg3hkLTieIrAv7OAmvG3eyXP1pYpX
5lYunnsdyrIgikmN2pZZDwi8gXkIerPjyYmI1P353ZnPS2MG/B79F8VQmFyxzqdm
bx9wJ12Xd23mMm22I3UI816P2U8kAwph9kfio1OEgTjGspflwgWOjib4zGkeABJT
e39lX81b4/vUg420RgSnKVRQ8OOn3SN1mumsQzGD4scsJw+iVXEpgCLUu+lv6VvU
8hptWqRd09bWQneLsD7Qy15R1/+4HQ==
=5G8g
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--
