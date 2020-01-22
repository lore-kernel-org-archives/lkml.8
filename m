Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44F5C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E2724656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579714889;
	bh=YGZ2cRqG5u4bxPklZHpHWDQi8QEwqwd/Zc28kRnomzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rE3sRqiBuHiSfWWVb+moc9kHa0dda24OegNLbSxxK9tXOV89nk31brYf5aAGDObHl
	 u9a6kPFMWT3aEAwjL4JDeq06K9qgK+C7WXYS3+TZ4b9p4yAr6SGuOXQthwvbVdU3Vq
	 1HmYXKu26zNrS0iIpKXMY4qN70T8FGUswjlb0WrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAVRl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:41:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVRl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:41:28 -0500
Received: from xps13 (98.197.23.93.rev.sfr.net [93.23.197.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7289F24125;
        Wed, 22 Jan 2020 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579714887;
        bh=YGZ2cRqG5u4bxPklZHpHWDQi8QEwqwd/Zc28kRnomzE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V8Ya36BDaBIBQBr6PhRda8ehKTO24jQw4a2r6ushXaJ8q2k3IY2Ebytd6NzFYjUTQ
         0zLl/q7dHK1rIepkQM2BYPSSmvKSiQXevCDQmKnsyYsJmF26mtKwIA21USoS+pDf6T
         +1Rs5gVzvPKqm+G2MG6hUO5lqY4UtMFX3HWoUekI=
Date:   Wed, 22 Jan 2020 18:41:14 +0100
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
Message-ID: <20200122184114.125b42c8@xps13>
In-Reply-To: <2c6000b1-ae25-564b-911a-2879e9c244b2@allwinnertech.com>
References: <1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com>
        <1579482233-2672-12-git-send-email-liaoweixiong@allwinnertech.com>
        <20200120110306.32e53fd8@xps13>
        <27226590-379c-8784-f461-f5d701015611@allwinnertech.com>
        <20200121094802.61f8cb4d@xps13>
        <2c6000b1-ae25-564b-911a-2879e9c244b2@allwinnertech.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


> >>>> +/*
> >>>> + * All zones will be read as pstore/blk will read zone one by one w=
hen do
> >>>> + * recover.
> >>>> + */
> >>>> +static ssize_t mtdpstore_read(char *buf, size_t size, loff_t off)
> >>>> +{
> >>>> +	struct mtdpstore_context *cxt =3D &oops_cxt;
> >>>> +	size_t retlen;
> >>>> +	int ret;
> >>>> +
> >>>> +	if (mtdpstore_block_isbad(cxt, off))
> >>>> +		return -ENEXT;
> >>>> +
> >>>> +	pr_debug("try to read off 0x%llx size %zu\n", off, size);
> >>>> +	ret =3D mtd_read(cxt->mtd, off, size, &retlen, (u_char *)buf);
> >>>> +	if ((ret < 0 && !mtd_is_bitflip(ret)) || size !=3D retlen)  { =20
> >>>
> >>> IIRC size !=3D retlen does not mean it failed, but that you should
> >>> continue reading after retlen bytes, no? =20
> >>>    >> =20
> >> Yes, you are right. I will fix it. Thanks.
> >> =20
> >>> Also, mtd_is_bitflip() does not mean that you are reading a false
> >>> buffer, but that the data has been corrected as it contained bitflips.
> >>> mtd_is_eccerr() however, would be meaningful. =20
> >>>    >> =20
> >> Sure I know mtd_is_bitflip() does not mean failure, but I do not think
> >> mtd_is_eccerr() should be here since the codes are ret < 0 and NOT
> >> mtd_is_bitflip(). =20
> >=20
> > Yes, just drop this check, only keep ret < 0.
> >  =20
>=20
> If I don't get it wrong, it should not	 be dropped here. Like your words,
> "mtd_is_bitflip() does not mean that you are reading a false buffer,
> but that the data has been corrected as it contained bitflips.", the
> data I get are valid even if mtd_is_bitflip() return true. It's correct
> data and it's no need to go to handle error. To me, the codes
> should be:
> 	if (ret < 0 && !mit_is_bitflip())
> 		[error handling]

Please check the implementation of mtd_is_bitflip(). You'll probably
figure out what I am saying.

https://elixir.bootlin.com/linux/latest/source/include/linux/mtd/mtd.h#L585


|...]

> >>>> +		return;
> >>>> +	}
> >>>> +	if (unlikely(info->dmesg_size % mtd->writesize)) {
> >>>> +		pr_err("record size %lu KB must align to write size %d KB\n",
> >>>> +				info->dmesg_size / 1024,
> >>>> +				mtd->writesize / 1024); =20
> >>>
> >>> This condition is weird, why would you check this? =20
> >>>    >> =20
> >> pstore/blk will write 'record_size' dmesg log at one time.
> >> Since each write data must be aligned to 'writesize' for flash, I am n=
ot
> >> sure
> >> all flash drivers are compatible with misaligned data, that's why i
> >> check this. =20
> >=20
> > I think you should enforce this alignment instead of checking it.
> >  =20
>=20
> Do you mean that mtdpstore should enforce this alignment while running?
> The way I can think of is to handle a buffer aligned to writesize and
> write to flash with this aligned buffer.
>=20
> That causes some error. The MTD device will be divided into mutil
> chunks accroding to dmesg_size. Each chunk stores a individual
> OOPS/Panic log. If dmesg_size is misaligned to writesize, the last
> write results in next write failure because the page of flash can only
> be programed once before next erase and the page shared by two chunks
> has been used by the last write. Besides, we can not read to buffer,
> ersae and write back as there is no read/erase for panic case.

I mean: what is the usual size of dmesg? I don't get why you need it to
be ie. a multiple of 2k. It probably is actually, I don't know if there
is a standard. But if dmesg_size is eg 3k, just skip the end of the
partially written page and start writing at the next page?

>=20
> >> =20
> >>>> +		return;
> >>>> +	}
> >>>> +	if (unlikely(mtd->size > MTDPSTORE_MAX_MTD_SIZE)) {
> >>>> +		pr_err("mtd%d is too large (limit is %d MiB)\n",
> >>>> +				mtd->index,
> >>>> +				MTDPSTORE_MAX_MTD_SIZE / 1024 / 1024); =20
> >>>
> >>> Same question? I could understand that it is easier to manage blocks
> >>> knowing their maximum number though. =20
> >>>    >> =20
> >> It refers to mtdoops. =20
> >=20
> > What do you mean?
> >  =20
>=20
> To me, it's unnecessary to check at all, however it is really there
> on codes of mtdoops. I refer to module mtdoops when I design mtdpstore.
> It may be helpfull for some cases out of my think, that's why I keep it.

Why not.

[...]

> >>
> >> In case of repeated erase when users remove several log files, mtdpsto=
re
> >> do remove jobs when exit.
> >>
> >> Besides, mtdpstore do not check the return code to ensure write back v=
alid
> >> log as much as possible. =20
> >=20
> > You are not in a critical path, I don't understand why you don't check
> > it? If it returns an error, it means the data is not written. IMHO it
> > is best to alert the user than to silently fail.
> >  =20
>=20
> This function will be called only when mtd device is removing. It's
> useless to alert the user but try to flush the other valid data to

It is useful to alert the user! It means something went wrong while
everything seems fine.

> flash as mush as possible by which reduce losses. If it's just
> because of busy, what happens next time?

Just because of busy? I don't get it.

I'm okay with the idea of trying to write the other chunks though:

	while (remaining_chunk) {
		ret =3D mtd_write()
		if (ret) {
			alert-user;
			continue;
		}
	}

>=20
> >> =20
> >>>> +. >>>> +		off +=3D zonesize;
> >>>> +		size -=3D min_t(unsigned int, zonesize, size);
> >>>> +	}
> >>>> +
> >>>> +free:
> >>>> +	kfree(buf);
> >>>> +	return ret;
> >>>> +}
> >>>> + =20
> >=20
> >=20
> > [...]
> >  =20
> >>>
> >>> Thanks,
> >>> Miqu=C3=A8l =20
> >>>    >> =20
> >> I will collect more suggestions and submit the new version at one time.
> >> =20
> >=20
> > Sure, no hurry.
> >  =20
>=20
> I am on holiday, please forgive me for my slow response.

Take your time, as I said, no hurry.

>=20
> >=20
> > Thanks,
> > Miqu=C3=A8l
> >  =20




Thanks,
Miqu=C3=A8l
