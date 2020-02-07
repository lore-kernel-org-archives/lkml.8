Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFC2C352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74B5222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581064889;
	bh=ftSpoXeZxHN0HXl4ROg2gmPEVkCItqI4gGRo0hvYFis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DZ5L9pljoVRTsIKdeY/Jli1NdHcvnK31AqZmZiVSKuQYBNEiG0JAKJA6Qm6oHiODD
	 X3XsjtscQ6kAbDgQtpxHarGBvczaVueeOx4oQg1iecQX05vol5gvx1lBMwAum0fhn0
	 bf0nQdUgu7iZzg2WDsKXkWFZOPD60atox0Hgt8iY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgBGIl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:41:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgBGIl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:41:29 -0500
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B37920838;
        Fri,  7 Feb 2020 08:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581064887;
        bh=ftSpoXeZxHN0HXl4ROg2gmPEVkCItqI4gGRo0hvYFis=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T5Da9eCW6Uh3RS+hAHZPH1sE36gTfb/vddq2mw97GhUyAcqOD/rO8JcRD0vNWzce8
         zfn/iLGp7W9t+tf3mX8m9MdCJkIjT3MujojSh2uByo3y9ysAhTF4VeqbsUu7Q2EoDD
         TeJixPGGgVpfWjedjp8t+gN/LfhTZi6tXcWFvVDg=
Date:   Fri, 7 Feb 2020 09:41:21 +0100
From:   Miquel Raynal <mraynal@kernel.org>
To:     liaoweixiong <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v1 11/11] mtd: new support oops logger based on
 pstore/blk
Message-ID: <20200207094121.0ad702d0@xps13>
In-Reply-To: <6a1b50f4-320f-43d1-50e3-b0a2c3c7fb96@allwinnertech.com>
References: <1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com>
        <1579482233-2672-12-git-send-email-liaoweixiong@allwinnertech.com>
        <20200120110306.32e53fd8@xps13>
        <27226590-379c-8784-f461-f5d701015611@allwinnertech.com>
        <20200121094802.61f8cb4d@xps13>
        <2c6000b1-ae25-564b-911a-2879e9c244b2@allwinnertech.com>
        <20200122184114.125b42c8@xps13>
        <e135f947-226f-8dd0-b328-fb87c5064914@allwinnertech.com>
        <20200206164559.59c5eb6a@xps13>
        <6a1b50f4-320f-43d1-50e3-b0a2c3c7fb96@allwinnertech.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liao,

liaoweixiong <liaoweixiong@allwinnertech.com> wrote on Fri, 7 Feb 2020
12:13:08 +0800:

> hi Miquel Raynal,
>=20
> On 2020/2/6 PM 11:45, Miquel Raynal wrote:
> > Hi liao,
> >=20
> > liaoweixiong <liaoweixiong@allwinnertech.com> wrote on Thu, 6 Feb 2020
> > 21:10:47 +0800:
> >  =20
> >> hi Miquel Raynal,
> >>
> >> On 2020/1/23 AM 1:41, Miquel Raynal wrote: =20
> >>> Hello,
> >>> =20
> >>>    >>>>>>>> +/* =20
> >>>>>>>> + * All zones will be read as pstore/blk will read zone one by o=
ne when do
> >>>>>>>> + * recover.
> >>>>>>>> + */
> >>>>>>>> +static ssize_t mtdpstore_read(char *buf, size_t size, loff_t of=
f)
> >>>>>>>> +{
> >>>>>>>> +	struct mtdpstore_context *cxt =3D &oops_cxt;
> >>>>>>>> +	size_t retlen;
> >>>>>>>> +	int ret;
> >>>>>>>> +
> >>>>>>>> +	if (mtdpstore_block_isbad(cxt, off))
> >>>>>>>> +		return -ENEXT;
> >>>>>>>> +
> >>>>>>>> +	pr_debug("try to read off 0x%llx size %zu\n", off, size);
> >>>>>>>> +	ret =3D mtd_read(cxt->mtd, off, size, &retlen, (u_char *)buf);
> >>>>>>>> +	if ((ret < 0 && !mtd_is_bitflip(ret)) || size !=3D retlen)  { =
=20
> >>>>>>>
> >>>>>>> IIRC size !=3D retlen does not mean it failed, but that you should
> >>>>>>> continue reading after retlen bytes, no? =20
> >>>>>>>      >> =20
> >>>>>> Yes, you are right. I will fix it. Thanks. =20
> >>>>>>    >>>>> Also, mtd_is_bitflip() does not mean that you are reading=
 a false =20
> >>>>>>> buffer, but that the data has been corrected as it contained bitf=
lips.
> >>>>>>> mtd_is_eccerr() however, would be meaningful. =20
> >>>>>>>      >> =20
> >>>>>> Sure I know mtd_is_bitflip() does not mean failure, but I do not t=
hink
> >>>>>> mtd_is_eccerr() should be here since the codes are ret < 0 and NOT
> >>>>>> mtd_is_bitflip(). =20
> >>>>>
> >>>>> Yes, just drop this check, only keep ret < 0. =20
> >>>>>     >> =20
> >>>> If I don't get it wrong, it should not	 be dropped here. Like your w=
ords,
> >>>> "mtd_is_bitflip() does not mean that you are reading a false buffer,
> >>>> but that the data has been corrected as it contained bitflips.", the
> >>>> data I get are valid even if mtd_is_bitflip() return true. It's corr=
ect
> >>>> data and it's no need to go to handle error. To me, the codes
> >>>> should be:
> >>>> 	if (ret < 0 && !mit_is_bitflip())
> >>>> 		[error handling] =20
> >>>
> >>> Please check the implementation of mtd_is_bitflip(). You'll probably
> >>> figure out what I am saying.
> >>>
> >>> https://elixir.bootlin.com/linux/latest/source/include/linux/mtd/mtd.=
h#L585 =20
> >>>    >> =20
> >> How about the codes as follows:
> >>
> >> for (done =3D 0, retlen =3D 0; done < size; done +=3D retlen) {
> >> 	ret =3D mtd_read(..., &retlen, ...);
> >> 	if (!ret)
> >> 		continue;
> >> 	/*
> >> 	 * do nothing if bitflip and ecc error occurs because whether
> >> 	 * it's bitflip or ECC error, just a small number of bits flip
> >> 	 * and the impact on log data is so small. The mtdpstore just
> >> 	 * hands over what it gets and user can judge whether the data
> >> 	 * is valid or not.
> >> 	 */
> >> 	if (mtd_is_bitflip(ret)) {
> >> 		dev_warn("bitflip at....");
> >> 		continue; =20
>=20
> > I don't understand why do you check for bitflips. Bitflips have been
> > corrected at this stage, you just get the information that there
> > has been bitflips, but the data integrity is fine.
> >  =20
>=20
> Both of bitflip and eccerror are not real wrong in this
> case. So we must check them.
>=20
> > I am not against ignoring ECC errors in this case though. I would
> > propose:
> >=20
> > 	for (...) {
> > 		if (ret < 0) {
> > 			complain;
> > 			return;
> > 		}
> >  =20
>=20
> -117 (-EUCLEAN) means bitflip but be corrected.
> -74 (-EBADMSG) means ecc error that uncorrectable
> All of them are negative number that smaller than 0. If it just keeps
> "ret < 0", it can never make a difference between bitflip/eccerror
> and others.

I forgot about these, your're right, so what about:

	static bool mtdpstore_is_io_error(int ret)
	{
		return ret < 0 && !mtd_is_eccerr(ret)> && !mtd_is_bitflip(ret);
	}

	for (...) {
		if (mtdpstore_is_io_error(ret))
			return ret;

		/*
		 * Comment explaining why we still return valid data
		 * despite ECC errors.
		 */
		if (mtd_is_eccerr(ret))
			just-complain();
	}

This snippet makes a difference between any "controller/bus
timeout/error : data could not be retrieved" and "ECC error, maybe we
can still read it and try to understand (risky, must be warned)".

>=20
> > 		if (mtd_is_eccerr())
> > 			complain;
> > 	}
> > 		 =20
> >> 	} else if (mtd_is_eccerr(ret)) {
> >> 		dev_warn("eccerr at....");
> >> 		retlen =3D retlen =3D=3D 0 ? size : retlen;
> >> 		continue;
> >> 	} else {
> >> 		dev_err("read failure at...");
> >> 		/* this zone is broken, try next one */
> >> 		return -ENEXT;
> >> 	}
> >> }
> >> =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l
> >  =20

Thanks,
Miqu=C3=A8l
