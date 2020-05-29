Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1624C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B50532074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590757217;
	bh=Ul5BL5B0wXKS2W8VF4E3RxXHYaWsmGzUIYUPxpODXqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yvhr+fM+0wlGF9VqRiMKC4q3sqqNMCude8TaXBpaQ1CKSurXrvqMRJsRLctD8cCBZ
	 NfpvwGuEZxsPifui3bVSI+9lrp1UUJg7LayB1Y+j/tgBy+RaBMBe4dqtG/TiwRnnS2
	 lg1AIi7pCKQf4LdUo+tPyhFVAdX4sm5pXo7Ds4zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgE2NAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgE2NAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:00:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB712065C;
        Fri, 29 May 2020 13:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590757215;
        bh=Ul5BL5B0wXKS2W8VF4E3RxXHYaWsmGzUIYUPxpODXqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ptMqI9s5oKpdznq2RdoRz/jEXkvrL3jxeGxx3gG8nTkgBd153vRupvnWZKf9vVTsO
         SrJMv4YmlyERmHLU/qUFj/SSDBJsKVXc2hNyfimLbv6lZvZ5CjaBaBKpWATrzBdP4D
         c2HFDyXCLfsNPjdfzF9waFY/gkH68NIhMJTX9xCM=
Date:   Fri, 29 May 2020 14:00:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/2] regulator: Add support for sync_state() callbacks
Message-ID: <20200529130012.GJ4610@sirena.org.uk>
References: <20200528190610.179984-1-saravanak@google.com>
 <20200528190610.179984-3-saravanak@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VSaCG/zfRnOiPJtU"
Content-Disposition: inline
In-Reply-To: <20200528190610.179984-3-saravanak@google.com>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VSaCG/zfRnOiPJtU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2020 at 12:06:10PM -0700, Saravana Kannan wrote:
> When a regulator is left on by the bootloader or anything else before
> the kernel starts (let's call this a "boot on" regulator), we need to
> keep it on till all the consumers of the regulator have probed. This is

We we don't in general have a requirement that any of the consumers of a
regulator will ever probe.  As I thought I'd already made clear that
case really needs to be handled.

> especially important for regulators that might be powering more than one
> consumer. Otherwise, when the first consumer probes, enables and then
> disables the "boot on" regulator, it'd turn off the power to rest of the
> consumers of the "boot on" regulator.

Which is a problem because...?

> The sync_state() callback that's been added to drivers is meant for
> situations like this. It gets called when all the consumers of a device
> have probed successfully. To ease the transition to sync_state()
> callbacks, it is never called before late_initcall_sync().

This is not terribly useful for regulators where adding any of these
delays is going to create surprises.  Frankly I can't really see why
deferring things until late_initcall() would help anything.

> sync_state() callbacks become even more useful when combined with
> fw_devlink.  If fw_devlink is off, sync_state() is called at
> late_initcall_sync() or the regulator device probing successfully --
> whichever is later. This is because, with fw_devlink off, there would be
> no consumers to the regulator device when it probes.

This breaks the case where no driver ever instantiates for a device.

Oh, actually now I get to the very end of the patch I see there is
actually a timeout in here which wasn't mentioned in the changelog at
all.  I very nearly didn't read the actual code as according to the
changelog this issue hadn't been addressed.

> This commit adds a regulator_sync_state() helper function that takes
> care of all the "boot on" regulator clean up for any regulator driver.
> All one needs to do is add the following line to the driver struct.
>=20
> .sync_state =3D regulator_sync_state,

Exactly the same issues as before apply here, why are devices getting
involved here?

> +static void regulator_set_minimum_state(struct regulator_dev *rdev)
> +{

I find this name very confusing.  If anything it's doing the opposite of
setting a minimum state, it's trying to prevent that happening.

> +	/*
> +	 * Wait for parent supply to be ready before trying to keep this
> +	 * regulator on.
> +	 */
> +	if (rdev->supply_name && !rdev->supply)
> +		return;

I can't make sense of this.  This stuff only limits disabling, not
enabling, regulators, we're keeping things on here anyway and why would
we care about the supply for disabling?

> +static int regulator_rel_minimum_state(struct device *dev, void *data)
> +{
> +	struct regulator_dev *rdev =3D dev_to_rdev(dev);
> +
> +	if (dev->parent !=3D data)
> +		return 0;

I've just realised that this is even more restrictive than the
descriptions have suggested - it's not just preventing any changes until
all potential consumers of a given regulator have instantiated, it's
preventing changes until all potential consumers of all resources
provided by a given device have instantiated.  Given that many systems
have a single PMIC which may also be providing other things like GPIOs
that would mean that any consumer that doesn't instantiate would prevent
any device getting turned off which seems even more concerning.

> +	if (IS_ERR_OR_NULL(rdev->sync_supply))
> +		return 0;
> +
> +	regulator_disable(rdev->sync_supply);

I think sync_supply needs a better name, it's a consumer rather than a
supply any sync doesn't really fit with what it's doing either - getting
rid of it might be syncing but it's not syncing anything.

The other thing here is that we're doing this silently which is going to
make problems harder to debug, if something gets turned off that wasn't
supposed to be turned off and the system collapses users are going to
have fun working out what happened - this is why the current code to
tidy up idle regulators prints something before it disables things.

> @@ -5188,6 +5272,15 @@ regulator_register(const struct regulator_desc *re=
gulator_desc,
>  	    !rdev->desc->fixed_uV)
>  		rdev->is_switch =3D true;
> =20
> +	/*
> +	 * I'm not too enthusiastic about this. I'd rather just go set
> +	 * .sync_state() in all the regulator drivers. But let's get the rest
> +	 * of the patch sorted out first.
> +	 */
> +	if (dev_set_drv_sync_state(rdev->dev.parent, regulator_sync_state))
> +		dev_dbg(&rdev->dev, "parent sync_state() already set\n");
> +	regulator_set_minimum_state(rdev);

If you don't want this to be configurable per driver then why do you
want to force it to be configured per driver?  I also think that is a
bad idea, it's just make work as far as I can see.

> +	/*
> +	 * If regulator_cleanup_timeout is set to a non-zero value, it probably
> +	 * means some of the consumers will never probe or the regulators have
> +	 * some restrictions on how long they can stay ON. So, don't wait
> +	 * forever for consumer devices to probe.
> +	 */
> +	if (regulator_cleanup_timeout)
> +		class_for_each_device(&regulator_class, NULL, NULL,
> +				      regulator_minimum_state_cleanup);
> +

This is not a timeout, it is a boolean flag - nothing ever actually sets
a delay or timeout based on this number.  I really think this should
just be a separate patch adding configurability for the existing delay
before finalization not something that randomly only affects this new
magic stuff as that makes things more complex and confusing.

--VSaCG/zfRnOiPJtU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7RB1sACgkQJNaLcl1U
h9ChLgf/RjsuSx/5IaxgA737peEQTtycpUo3Fqf1NA6qaoSylyyVfMmrpbmS/d9i
2iU+U/p6nidsUAG2wTWACgXuy1gVA4rnR1gbAX6XDHpy9HQUYsZ8Tay4XpX63ZCi
TfO5+DY8uddnzUjG3pduP/u4UKTplZSrTJ6B/TPI0FuxUMJZc3hwevVZxIQkRu5p
iYN4as6jbDloxpESywM3HaMPZy3uXECsjH2w0LOBWtymx/PtPt47eETO4TtHkfA8
lPvFSCvOChG2jIOQ+F6s0SPjzQFS3IIPjlQ2KfPcrIaHuUEj0vonga9zfQtWSD6X
+H9EyY4MAqBY2KX0KTwBI6ADB/xdgg==
=jzaW
-----END PGP SIGNATURE-----

--VSaCG/zfRnOiPJtU--
