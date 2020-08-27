Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E82C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CD52087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598538937;
	bh=jyEOpDGF58EqMyy4CAA6ODNRwClS6tF5zgcHWbsZr48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=b9GW7r9MHx64u0pgPicHMwELXBBs4GNG/QE+aaGm9nikz4u407vTLn1NIBceSVNZp
	 A3xobMP4oP6sQDV/JNygkZQCWdhEs0Pq78W1q3qTwO2tUjLEVyfHdv/aEK0YHWg8xK
	 e5njJg6CRjkUPo/fdAk2ZHXQyEFwnKNOWiPDINdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgH0Of3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgH0O0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:26:48 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0192C2177B;
        Thu, 27 Aug 2020 14:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598538407;
        bh=jyEOpDGF58EqMyy4CAA6ODNRwClS6tF5zgcHWbsZr48=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KtE6g3myS01Vitmo+hD9Pu7YyaqLPHM39fwPCFEeR7pbRqbYl9marPKGXx4lRbxUM
         uHtNDJog4/9AwqmebNRgl1DsLiEyB5K8LHPop+cLk+Lvg2FuYk71ucVyztN2sjC/o8
         K76Zb9dWOimWG7W/S44b1S5KwzZw5ZzcUXLThxfk=
From:   Felipe Balbi <balbi@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        =?utf-8?B?5ZGo?= =?utf-8?B?5q2j?= <sernia.zhou@foxmail.com>,
        =?utf-8?B?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>, od@zcrc.me,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] USB: PHY: JZ4770: Fix uninitialized value written
 to HW register
In-Reply-To: <HG6QFQ.KLMIR92DB2D02@crapouillou.net>
References: <20200827124308.71963-1-paul@crapouillou.net>
 <20200827124308.71963-2-paul@crapouillou.net> <87v9h4i6t5.fsf@kernel.org>
 <PN4QFQ.KWNBY2ZWQ7XC2@crapouillou.net> <87bliwi5kx.fsf@kernel.org>
 <HG6QFQ.KLMIR92DB2D02@crapouillou.net>
Date:   Thu, 27 Aug 2020 17:26:40 +0300
Message-ID: <878se0i2qn.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Paul Cercueil <paul@crapouillou.net> writes:
>>>>>   @@ -246,9 +241,8 @@ static void x1830_usb_phy_init(struct usb_phy
>>>>>  *phy)
>>>>>    		USBPCR1_DMPD | USBPCR1_DPPD;
>>>>>    	writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>>>>=20
>>>>>   -	reg =3D USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT
>>>>>  |	USBPCR_TXPREEMPHTUNE |
>>>>>   +	return USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT |
>>>>>  USBPCR_TXPREEMPHTUNE |
>>>>>    		USBPCR_COMMONONN | USBPCR_POR;
>>>>>   -	writel(reg, priv->base + REG_USBPCR_OFFSET);
>>>>=20
>>>>  not a bug fix
>>>=20
>>>  Well, if you don't like my bug fix, next time wait for my=20
>>> Reviewed-by.
>>=20
>> why so angry? Take a break every once in a while. Besides, someone=20
>> else
>> already sent the oneliner before you ;-)
>
> I'm just pissed that this patch has not been tested. I don't like=20
> sloppy work.

yeah, s**t happens

>> In any case, why should I wait for your Reviewed-by? Get maintainer
>> doesn't list you as the maintainer for it. Do you want to update
>> MAINTAINERS by any chance?
>
> Yes, I thought I was (I'm maintainer of all Ingenic drivers), that also=20
> explains why I wasn't Cc'd for the oneliner patch you mentioned...
>
> IIRC Zhou has a patch to move the driver to drivers/phy/, I'll add=20
> myself as maintainer once it's moved there.

makes sense

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9HwqARHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQb56A/+OPhVliSrlBVVZ0goHmIdr+wMbvIICLEw
CtSbe/vqazexOfe9E/8b5W25JOz28Lv+3whz+gr81W66eL/8YpuBzVBkJxtUjJD8
iWq+5CXHTyNjBNSNx4aHuNCTnmLNcWHhxLf7oDBO5fpikyhMBNOIgUa5ciDEmjro
3eH/IekqlN35vmt51B6XoVLJVbAl5pnyKhdDDSZTqQMyJkMPaeinNnvxC48r9bQ/
fPnZkb2AjE5QLzeidFpRdOVBKP4SqtHjjVz3fObrcsxu65RHFqjmMDKdFNekNkdV
2UmJwuHWZxZL9z6EDotxXo5Kp9wUWxmm5aymhDmvtsvonb4iiNBuluhimVYXU5Hi
CxCH9mcGQWC9pi7BE1oIv8ECA1FAdQykmYbAkqqiTxoUN8pLw4Uox4ge5YFkGNPX
gxAOPNCFeWpG89WjUhIDBheGPgw/w7JEibrrUrm3kTnAZxmWyW0sj+gmW/SjZthR
jkf/qJg2Hh3P6lWOY4mTrKO3CObZv6WG0J41lVKkF+az+GwbEO4KGUYJJi8HK6hQ
rwp9pmaf7cZSrG1PBVsMh6Y+OIxqbwLCAz9IYY0jjKWCw0AeK7tMBYnUXdN8l1+e
bKDwZlp9v9SGdKkELAwNBW9tKlaaqNd5qsiKN7TchhM+XeuEXclWjSSE/FZCgD/Z
DxnwwE1DolM=
=VXAU
-----END PGP SIGNATURE-----
--=-=-=--
