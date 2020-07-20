Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE85C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E7822B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595255289;
	bh=jyRggwB3bfNpTpeprxhV4TjRHOze4OkPB8o1SEWCrM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WVAm0/jZlR68P5LUzMxwL6XkpuaY1Jvhu++E/P+WZkzQYrg9zw7iAPDBNW7ragYCA
	 y72gG2FjubEjciwGzq4iC9o+RprxDoa2RrLbmlcEWWRkzvK1wD50BycaPuC3O/+l2a
	 tpdEfQSznQRDPFdlJ92TyI6ybfCYg9FyIE9Ygif8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgGTO2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgGTO2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:28:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE9F2065E;
        Mon, 20 Jul 2020 14:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595255286;
        bh=jyRggwB3bfNpTpeprxhV4TjRHOze4OkPB8o1SEWCrM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gr9Eaq+omUbSnhnxksbHeS/wAnqkASYSWLF/neiGhHoCSVwYTc+dOcHtgLqFD95XX
         Fryabpbh2xXTNVtcarFIdwiO+FiItN2Z8zvTu7xNeIdWiuN36YaDS6dNWc+B7uyqBf
         LJ0+R1nDwSUHpR9iRvDN+P7ucjAYppLv+M321y0A=
Date:   Mon, 20 Jul 2020 15:27:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 3/4] regulator: core: Add basic enable/disable support
 for sync_state() callbacks
Message-ID: <20200720142753.GF4601@sirena.org.uk>
References: <20200716042053.1927676-4-saravanak@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
Content-Disposition: inline
In-Reply-To: <20200716042053.1927676-4-saravanak@google.com>
X-Cookie: Be different: conform.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2020 at 09:20:52PM -0700, Saravana Kannan wrote:

> There are Android devices that exhibit the issue in the example where
> regulator-X is an LDO, device-A is a camera device and device-B and
> device-C are UFS and USB. To avoid this, they have their own downstream
> changes to the regulator framework.

Can you provide any references to these bodges?

> 1. When a regulator is registered,
>    a. The sync_state() callback for the regulator's device is set to
>       regulator_sync_state(). The sync_state() callback is called when
>       all the consumers of the regulator's device have probed
>       successfully.

As I indicated on my previous review this doesn't seem OK, given that a
huge proportion of the regulators on most systems are part of a single
PMIC this means that devices won't be able to fully control regulators
for the majority of the boot process, possibly quite a long time after
userspace has started in systems where not all devices have drivers.
That seems unreasonably restrictive, it seems like this is shifting the
problem around so we have this new very late init phase where we
actually implement changes that devices asked for.  Devices can work
around it by using _get_exclusive() but that makes things more complex
if they can also support non-exclusive use.

I don't understand the motivation for doing things this way.  Like I
said last time it really feels like this turns the whole mechanism into
a very complicated way of implementing a new initcall.

>    b. If the regulator is ON at boot, a BOOT-LIMITS consumer is created
>       for the regulator and an enable vote is made.

If something was left partially set up by the bootloader this means that
drivers are no longer able to remove power from the device as part of
getting it into a known good state even if they are the only consumer.
Having to tune things in the bootloader isn't great for some development
flows.

> +	/*
> +	 * If regulator_cleanup_timeout is set to a non-zero value, it probably
> +	 * means some of the consumers will never probe or the regulators have
> +	 * some restrictions on how long they can stay ON. So, don't wait
> +	 * forever for consumer devices to probe.
> +	 */
> +	if (regulator_cleanup_timeout)
> +		class_for_each_device(&regulator_class, NULL, NULL,
> +				      regulator_boot_limits_timeout);

It feels like this should be a negative value rather than zero, if the
timeout is 0 someone might reasonably expect things to happen
immediately rather than never.

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8VqekACgkQJNaLcl1U
h9Cm2wf+M/0ivrwr2bBxjGc6df3+tAuqVXG1sq+77QTRKXLm4iAE1mvhl5fHqxZO
xKPp0Wx98PkCnJ6XmtQrXTMGYzktH2MZiUsy2Ph1vCno/bAI/K8A2wOKR5OSx/zr
IB8mMU/drE2o42rxT+ArpoxjeRGGCMmqzCllS8Z6aw6iOB4igCMsUN3p5ze0spC1
JUDz1ic0NlplsV62ursdetC75vpD97x3xUJkEGUS7ypenDSs1fEBldS4WR4MuXNB
Ycnzc0JNJjG94y1VWxzNocHqlifvt0tf0ZYVPLwoftERUGhmyHMUz51MPNYEiJ0w
h28pZWvuFXyuBkKIUOidHoxmC/JUEw==
=tuz3
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--
