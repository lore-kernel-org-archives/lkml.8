Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2553EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018B42068D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726443;
	bh=GmOf7ufLopIQ4dm5tWeT9BTmDlXoHbRAmXYulRxbARg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xm9BA28rth+HRvc3xLvO7wC72Be1eU0poMuSszvQaWp/QKPfyC1J7ekEtTloYSx6r
	 8TgZiz1L62YcJBh/81m5FGz/R5QWG1pWNudwpxq7/EVvT2x0WLZwK01jydnuOgio/A
	 oW4krY9Mc/YOuSesG1l3dEIyz0lmTZnihrkSz40A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbgFIRup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732604AbgFIRuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:50:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1500320801;
        Tue,  9 Jun 2020 17:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725002;
        bh=GmOf7ufLopIQ4dm5tWeT9BTmDlXoHbRAmXYulRxbARg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBlCD7TE7EFTt9PmZafc3XGZkCUYr70hyzrVUttbz0QUrhGE+ZKD3ilnm5gavV5aN
         NShzrd92zAMR12KJn5yRqWK6hNb+kNIOu8EonT++JAT1G7MwZYQUkMalwtLgErwqPA
         cfTOtJX7xuvIUUh1lI8qFVC5AfvWBZt9lRQe3g0g=
Date:   Tue, 9 Jun 2020 18:50:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] ASoc: tas2563: DSP Firmware loading support
Message-ID: <20200609175000.GO4583@sirena.org.uk>
References: <20200609172841.22541-1-dmurphy@ti.com>
 <20200609172841.22541-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vEfizQhTV1P/vojJ"
Content-Disposition: inline
In-Reply-To: <20200609172841.22541-3-dmurphy@ti.com>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vEfizQhTV1P/vojJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 12:28:41PM -0500, Dan Murphy wrote:

>  	.val_bits =3D 8,
> =20
> -	.max_register =3D 5 * 128,
> +	.max_register =3D 255 * 128,
>  	.cache_type =3D REGCACHE_RBTREE,
>  	.reg_defaults =3D tas2562_reg_defaults,
>  	.num_reg_defaults =3D ARRAY_SIZE(tas2562_reg_defaults),

Should some or all of the DSP memory be marked as volatile?  I guess if
we only write program to it then on reload after power off it should be
fine to just blast everything in again and ignore the fact that some
will have changed, but it might be helpful for debugging to be able to
read the live values back and do something more clever for restore.

>  #define TAS2562_PAGE_CTRL      0x00
> +#define TAS2562_BOOK_CTRL      0x7f

*sigh*  Of course the two levels of paging register are not located
anywhere near each other so we can't easily pretend they're one double
width page address.  :/

> +static int tas25xx_process_fw_single(struct tas2562_data *tas2562,
> +				     struct tas25xx_cmd_data *cmd_data,
> +				     u8 *fw_out)
> +{
> +	int num_writes =3D cpu_to_be16(cmd_data->length);
> +	int i;
> +	int ret;
> +	int offset =3D 4;
> +	int reg_data, write_reg;
> +
> +	for (i =3D 0; i < num_writes; i++) {
> +		/* Reset Page to 0 */
> +		ret =3D regmap_write(tas2562->regmap, TAS2562_PAGE_CTRL, 0);
> +		if (ret)
> +			return ret;

Why?

> +
> +		cmd_data->book =3D fw_out[offset];
> +		cmd_data->page =3D fw_out[offset + 1];
> +		cmd_data->offset =3D fw_out[offset + 2];
> +		reg_data =3D fw_out[offset + 3];
> +		offset +=3D 4;
> +
> +		ret =3D regmap_write(tas2562->regmap, TAS2562_BOOK_CTRL,
> +				   cmd_data->book);
> +		if (ret)
> +			return ret;

This manual paging doesn't fill me with with joy especially with regard
to caching and doing the books behind the back of regmap.  I didn't spot
anything disabling cache or anything in the code.  I think you should
either bypass the cache while doing this or teach regmap about the
books (which may require core updates, I can't remember if the range
code copes with nested levels of paging - I remember thinking about it).

> +static ssize_t write_config_store(struct device *dev,
> +				struct device_attribute *tas25xx_attr,
> +				const char *buf, size_t size)
> +{

This looks like it could just be an enum (it looks like there's names we
could use) or just a simple numbered control?  Same for all the other
controls, they're just small integers so don't look hard to handle.  But
perhaps I'm missing something?

> +	tas2562->fw_data->fw_hdr =3D devm_kzalloc(tas2562->dev, hdr_size,
> +						GFP_KERNEL);
> +	if (!tas2562->fw_data->fw_hdr)
> +		return -ENOMEM;
> +
> +	memcpy(tas2562->fw_data->fw_hdr, &fw->data[0], hdr_size);

Should validate that the firmware is actually at least hdr_size big, and
similarly for all the other lengths we get from the header we should
check that there's actually enough data in the file.  ATM we just
blindly copy.

It'd also be good to double check that the number of configs and
programs is within bounds.

--vEfizQhTV1P/vojJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fy8cACgkQJNaLcl1U
h9DyjAf/U3fDLekpB9MZStpSggO6T3wCfTbWFhFNd8RAcNjhjzxnoumprzpXP7vS
0udC8M7ISpLr6EIdhF6WScsoEWCM/1quzrZ8T3TSAz5pfAiuepmWMYgZiLr532vv
jGtuTYBno7H+Kx4CKOc5+mnd7cFWaSQkxWui3/uwDrWrdQRQRva9oZRW5NdYLFGY
5H2uzDpRDnRetbs4xJztGJ7d4FcgSutaJFsfhe6xMEaN8Hgk73m5UBAK1Epv2LTz
kswZnjp6SO8jdJCLyiblXnliDIRn/ftQz5hTY2ZLUmZ1ylwpbtuoTdGwpp4NoYfU
2Qo3ZYiD2Gd7QnI6Jqb6H6LM/8IMNw==
=c5qv
-----END PGP SIGNATURE-----

--vEfizQhTV1P/vojJ--
