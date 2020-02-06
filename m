Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52577C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288DF217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581003967;
	bh=qkTT9QVfoW5Hqi+5sQCx4C739P1VAWdOEN6lyWVwXek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KF9R1J9FI7j0b1268ssZOMBgtNreA/8bJshrmuCKDdn1D90EeqP8SZqJ3MDuna6Hv
	 FOhBH9qvp30533FkomXk5mzmgTdWi/zyAJCAivvDDcXj8Qi9DNSPcMFMKkMEvHuBjh
	 o/UDXfItNF6CTMfLnZSneHl19mq3kxOkgNHRHf+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgBFPqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgBFPqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:46:06 -0500
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C24214AF;
        Thu,  6 Feb 2020 15:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581003965;
        bh=qkTT9QVfoW5Hqi+5sQCx4C739P1VAWdOEN6lyWVwXek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eZiEGmPzLMlAvJlOgWtAC1//RnQHWe6BlLdIFgB4P21fSmFf73hVfnIE568YwqCdy
         6c1N/cnrZ39J4LVGQQbD3NH1KR9YIHKzsK2sxUGDUF40hT+LcM8ogCd019xQqqyfvp
         TE5ilZjcZtI8o7sUYgnr8wMRMvvQ8XHjO305gjBA=
Date:   Thu, 6 Feb 2020 16:45:59 +0100
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
Message-ID: <20200206164559.59c5eb6a@xps13>
In-Reply-To: <e135f947-226f-8dd0-b328-fb87c5064914@allwinnertech.com>
References: <1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com>
        <1579482233-2672-12-git-send-email-liaoweixiong@allwinnertech.com>
        <20200120110306.32e53fd8@xps13>
        <27226590-379c-8784-f461-f5d701015611@allwinnertech.com>
        <20200121094802.61f8cb4d@xps13>
        <2c6000b1-ae25-564b-911a-2879e9c244b2@allwinnertech.com>
        <20200122184114.125b42c8@xps13>
        <e135f947-226f-8dd0-b328-fb87c5064914@allwinnertech.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi liao,

liaoweixiong <liaoweixiong@allwinnertech.com> wrote on Thu, 6 Feb 2020
21:10:47 +0800:

> hi Miquel Raynal,
>=20
> On 2020/1/23 AM 1:41, Miquel Raynal wrote:
> > Hello,
> >=20
> >  =20
> >>>>>> +/*
> >>>>>> + * All zones will be read as pstore/blk will read zone one by one=
 when do
> >>>>>> + * recover.
> >>>>>> + */
> >>>>>> +static ssize_t mtdpstore_read(char *buf, size_t size, loff_t off)
> >>>>>> +{
> >>>>>> +	struct mtdpstore_context *cxt =3D &oops_cxt;
> >>>>>> +	size_t retlen;
> >>>>>> +	int ret;
> >>>>>> +
> >>>>>> +	if (mtdpstore_block_isbad(cxt, off))
> >>>>>> +		return -ENEXT;
> >>>>>> +
> >>>>>> +	pr_debug("try to read off 0x%llx size %zu\n", off, size);
> >>>>>> +	ret =3D mtd_read(cxt->mtd, off, size, &retlen, (u_char *)buf);
> >>>>>> +	if ((ret < 0 && !mtd_is_bitflip(ret)) || size !=3D retlen)  { =20
> >>>>>
> >>>>> IIRC size !=3D retlen does not mean it failed, but that you should
> >>>>> continue reading after retlen bytes, no? =20
> >>>>>     >> =20
> >>>> Yes, you are right. I will fix it. Thanks. =20
> >>>>   >>>>> Also, mtd_is_bitflip() does not mean that you are reading a =
false =20
> >>>>> buffer, but that the data has been corrected as it contained bitfli=
ps.
> >>>>> mtd_is_eccerr() however, would be meaningful. =20
> >>>>>     >> =20
> >>>> Sure I know mtd_is_bitflip() does not mean failure, but I do not thi=
nk
> >>>> mtd_is_eccerr() should be here since the codes are ret < 0 and NOT
> >>>> mtd_is_bitflip(). =20
> >>>
> >>> Yes, just drop this check, only keep ret < 0. =20
> >>>    >> =20
> >> If I don't get it wrong, it should not	 be dropped here. Like your wor=
ds,
> >> "mtd_is_bitflip() does not mean that you are reading a false buffer,
> >> but that the data has been corrected as it contained bitflips.", the
> >> data I get are valid even if mtd_is_bitflip() return true. It's correct
> >> data and it's no need to go to handle error. To me, the codes
> >> should be:
> >> 	if (ret < 0 && !mit_is_bitflip())
> >> 		[error handling] =20
> >=20
> > Please check the implementation of mtd_is_bitflip(). You'll probably
> > figure out what I am saying.
> >=20
> > https://elixir.bootlin.com/linux/latest/source/include/linux/mtd/mtd.h#=
L585
> >  =20
>=20
> How about the codes as follows:
>=20
> for (done =3D 0, retlen =3D 0; done < size; done +=3D retlen) {
> 	ret =3D mtd_read(..., &retlen, ...);
> 	if (!ret)
> 		continue;
> 	/*
> 	 * do nothing if bitflip and ecc error occurs because whether
> 	 * it's bitflip or ECC error, just a small number of bits flip
> 	 * and the impact on log data is so small. The mtdpstore just
> 	 * hands over what it gets and user can judge whether the data
> 	 * is valid or not.
> 	 */
> 	if (mtd_is_bitflip(ret)) {
> 		dev_warn("bitflip at....");
> 		continue;

I don't understand why do you check for bitflips. Bitflips have been
corrected at this stage, you just get the information that there
has been bitflips, but the data integrity is fine.

I am not against ignoring ECC errors in this case though. I would
propose:

	for (...) {
		if (ret < 0) {
			complain;
			return;
		}

		if (mtd_is_eccerr())
			complain;
	}
	=09
> 	} else if (mtd_is_eccerr(ret)) {
> 		dev_warn("eccerr at....");
> 		retlen =3D retlen =3D=3D 0 ? size : retlen;
> 		continue;
> 	} else {
> 		dev_err("read failure at...");
> 		/* this zone is broken, try next one */
> 		return -ENEXT;
> 	}
> }
>=20


Thanks,
Miqu=C3=A8l
