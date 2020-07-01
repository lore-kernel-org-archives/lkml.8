Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A002C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFD220663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593586491;
	bh=LRuEsOskI9OWO+zJuhGY0M3v9eVJzuziVHJuA35tIyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=snQxqOWRCeMZvMflzeXHT5t8hfrJoCGseCDnXATEXkWTun65XSROR9ukoMhSzosvu
	 60aQUu8w+Nw13bVPnHrsT8V3S1ym4DhKYgtTYZ2TsAiYCtiwTRZy91fIKnjltYPWOe
	 w7x6rhf6aUgxurT7nFN/cTR+suZVU99nn+2DpoY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgGAGyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAGyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:54:49 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055DBC061755;
        Tue, 30 Jun 2020 23:54:49 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m26so12929826lfo.13;
        Tue, 30 Jun 2020 23:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=9g7wo6p4SIfl7KphCrqXahJWH4i2z/J2Fi+S70YB3tA=;
        b=UaQKb03f4mzsLqbOtdvk54lvpmB3nButuWCATwYPqyccYzorCPqYysjY8zq7L+GPax
         EMzXblWewudZk78Pxva1CrYBf9UHd+sTv9p1ADle7/L3WYjbN0e/fhBfGOcll8/fJ4tn
         IsDd0z7tmmnNli0YEAuzPORDB7zpcVu/pY4DVVIHK9+rlRLeN68Bs5ZAAAS0FnsSG87C
         kkYrEw4V1rRWWgl38tTnnJsHGTm6WD9JPeIfaNbmRmunAFBUM4o2jrCmD1Csy/tGcdv9
         9ma3RnKv7crSfUL9FqL1pBERgEmv360L+pG+r1Ru9DxSuJS6CMZqyVHxfhQOQ8fl6eiB
         4Y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=9g7wo6p4SIfl7KphCrqXahJWH4i2z/J2Fi+S70YB3tA=;
        b=LmN9fool5K68zBy+dWPt7JEvqnIFWOb7akUpGiOfVOOdR3Pg0WZAlouAzmd6p5pTk5
         pJ1MwcHmaiHyFKWzNRdLDupZKCLxHmT7oPnhzkI0pQnfUMR+0ZkA5HhUPShyo9y9nAYT
         lcoK+yjDuERNmuXJSsJxdfIAaHpiSuW3V/cAnDOwa+jMsWAMaWQG5UYohPqUE+Cf68GK
         79fLWzRk/wPKNfb1an6OiXE7oVQXl4tHlBb82nBTVYJK/IXez4n3KSK2o0wxOHmEf0mT
         RM5u/DBJvR2WE55KvdDAX8RQf1MaKmOBoGQ3VmD9UTEnawiixvwdgeD39eZTLkxZA1G1
         dyQQ==
X-Gm-Message-State: AOAM531ThCS2ii/suQMxA/mLFH8M0wF2t7Hgr2HoqvUeC8IsYsDH9/lX
        CgNh1YWG/+j7XdOoUbiw3fAfd1Do
X-Google-Smtp-Source: ABdhPJznMlaxzgBCk/7T55atRUGJVe5R8H12KJ3tZBsrdDH9nf6R3d4XNFTsQ8OwtK31PpuNXpsaFA==
X-Received: by 2002:a19:4143:: with SMTP id o64mr14068362lfa.157.1593586487290;
        Tue, 30 Jun 2020 23:54:47 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id j17sm1695865lfk.31.2020.06.30.23.54.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 23:54:46 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Chen <peter.chen@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: f_acm: don't disable disabled EP
In-Reply-To: <20200530171552.GC16333@qmqm.qmqm.pl>
References: <237e4bc8c63680f9ce0388d35b4c34a856ed8595.1590690518.git.mirq-linux@rere.qmqm.pl> <20200529081104.GD32755@b29397-desktop> <20200529135524.GA14614@qmqm.qmqm.pl> <AM7PR04MB715735B54F24293ABF7B37908B8C0@AM7PR04MB7157.eurprd04.prod.outlook.com> <20200530171552.GC16333@qmqm.qmqm.pl>
Date:   Wed, 01 Jul 2020 09:54:42 +0300
Message-ID: <87wo3n7mj1.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl> writes:

> On Sat, May 30, 2020 at 01:03:17AM +0000, Peter Chen wrote:
>>=20=20
>> > > > @@ -425,9 +425,11 @@ static int acm_set_alt(struct usb_function *f=
, unsigned
>> > intf, unsigned alt)
>> > > >  	/* we know alt =3D=3D 0, so this is an activation or a reset */
>> > > >
>> > > >  	if (intf =3D=3D acm->ctrl_id) {
>> > > > -		dev_vdbg(&cdev->gadget->dev,
>> > > > -				"reset acm control interface %d\n", intf);
>> > > > -		usb_ep_disable(acm->notify);
>> > > > +		if (acm->notify->enabled) {
>> > > > +			dev_vdbg(&cdev->gadget->dev,
>> > > > +					"reset acm control interface %d\n", intf);
>> > > > +			usb_ep_disable(acm->notify);
>> > > > +		}
>> > >
>> > > But it does not fix any issues, the usb_ep_disable checks 'enabled' =
flag.
>> >=20
>> > It generates spurious trace events if you enable them.
>> You mean the trace events from core.c? If it is, we could try to improve=
 it
>> and indicate it is already enabled or disabled.
>
> It is indicated in return code, but the problem is that this generates
> noise and wastes debugging time. The problem I was seeing manifested
> itself as disabling disabled EPs and desync of EP state between core
> and UDC driver. The patch avoids the noise and makes the code obvious.
> (This check was there at some point in time, BTW.)

I agree with this as well. But still, $subject doesn't look like a
candidate for the -rc :-) I'll apply it for the next merge window.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl78MzIACgkQzL64meEa
mQb8NxAAyEILBMyca53t6KeP5XmYc8AkhP7RVNnTUtfSNQ+bPLieCmLtvZUKs9kc
EiNjRyA0PXt29gHQW/7D0v03XpDuoSiylB44SIEN9MHZd9QkOoGSjWs4jjGncHnG
trFiTOUuX5JzHhdOH+1LFLesqief/3gh86rkyVjQ1ElY7T5greNX+oIah+nwFUuF
zIv5jxEWUjbZII2rZcwU2LluXP8tA9R/Dcj4nF25AfiZQ3Mpz3UiFvPTt5J0WV0h
qJNFICg1c1K232YTfzjvFLm9mUjiU4xMQweQDpRM88fHXkmHMsJ3e8aSH5r6SC81
rF9Lfu9CacE/goGwLGb1GCj62OU+K7vyXUiwOyFdVOGtYQEzIR3lDbVRL7OKrOeO
W9Ex7jVteGrtsSy3gWK+KQKj0f0A7lOwVvJwi47qnKYiKjsXTROxt3zKc52T0Jou
3HG3SZS7lBcym8UlMfEvXaiqPaOZAYn7v8bVsWrFEPd6DC33nflX+jmY/J8xrfLD
MQSe7fHR2amTfJdyNq7uFRBav51aeHGa12Pp6fy4V6Cqrb0tqSPvBf1XJ6+k4Rkh
qxW58jgs3gV2Qcj3CMjP8mLr/Or82TwCeCjmAY19JMbmrWsMJo0ZlG/AaFE1PB/K
CzsRtWTC2YlOPTeW48FpwKY+BfmnykUKzOSisg7eXP3T/kSmtv8=
=xfht
-----END PGP SIGNATURE-----
--=-=-=--
