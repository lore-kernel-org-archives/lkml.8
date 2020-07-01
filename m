Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8ECC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCF62074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593586443;
	bh=XG5IrfPqFAODeX37wABpsWPR1Qcdn+nRAStVK56+SEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=GL4sDbPvML5iW0ejbII245oRIvB+F+Eka9mEiuvZywvLLMFlu9B4GiH/QS4oJ4HcK
	 ET3FMIF7WfZPZrY8ef363QdVbPqI1TuAxuEPeNeBr2VtPXKhONwotr5npp+2JpvT1V
	 3nMrQjVdtbu5FLFfpqMOe83L9ORY3+g9fxGk/DFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgGAGyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAGyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:54:01 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7ECC061755;
        Tue, 30 Jun 2020 23:54:00 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id n23so25663951ljh.7;
        Tue, 30 Jun 2020 23:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Fqs/N/rO+/7/27zLn1NjeBPX6gogMZPC9+Bx69TLz98=;
        b=KhHrOzp+5hON1PGwZCOHUxadlzCY6D/Ywg1sxRsU9bdO+DktULgAFyIImiPKwzsXBl
         tTvr4vsJ0YDPCiCqEtSYlVcv8IaV/R4rt284mBbrgOYXyZxZoNjVnWaIaJvTtPhyZGw8
         4CrZ6u/NLrURii8r04tBsPotQCAlgnAUjTblpops2/qVSoR8igMYJ+ciY9HI2XVh4yuX
         aXqksIxW8TkVEeWApSu8eqyj3wjxHVoUh+JkECF8YESl0jnZEoEUWfYLjBBXv4wDr4do
         atiN4hh+QQWSAhwksgASYHUIaBBxcGBY2w0k3hbgZY0RqdLiSXjwwfVCghZNky7EG6sE
         dVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=Fqs/N/rO+/7/27zLn1NjeBPX6gogMZPC9+Bx69TLz98=;
        b=Lj31X3SakkPoKaIWguFRIdzYp4JaPdaUyUG2K+F6huNLaDiZerJaCDz4bFKLM7Ng5g
         mHi+Pgyz4+e4QW2fhy8JJjhdpMUGRlIA4y5pI6ke3yay0/G0+loBhzhm+xqL7mKiXPN1
         Kk8jf5VcCmNXx/hCX6+zZIR0VQoV4MtMHq5xMWgb8Cz1YBAD2Uiu6KFfHAhj0gW8NNem
         Qp+8+D2K2RN/uc+yDSl8Y1cAB184A5V4pmSbLx9Z9vEUbbhpzATIWVmsU8Uj7XHe+4ga
         rX1Zn9zeXzTbHZRaUZKEh8fgkZrdxr+O8jR+wdP9gb7JQm3kbaR4b5R5YyBah8t2h3W4
         4c+w==
X-Gm-Message-State: AOAM531uzDfbLu//Fe4TsUWO1UAmQLPdLEe1k4u7/3UB+dQWxAFjukwY
        jCiR77CWoYk9IlZqZzkYF78fLOTm
X-Google-Smtp-Source: ABdhPJxUTcwigMhm0iyT5tBRduk4OGkaYRjPdF3zoFD3F7PzDXdxYZ/sc9nuE9MZ0NikOUlMpv3W1A==
X-Received: by 2002:a2e:5c44:: with SMTP id q65mr11783055ljb.156.1593586439010;
        Tue, 30 Jun 2020 23:53:59 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id p2sm1489475ljg.95.2020.06.30.23.53.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 23:53:58 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Peter Chen <peter.chen@nxp.com>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: f_acm: don't disable disabled EP
In-Reply-To: <AM7PR04MB715735B54F24293ABF7B37908B8C0@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <237e4bc8c63680f9ce0388d35b4c34a856ed8595.1590690518.git.mirq-linux@rere.qmqm.pl> <20200529081104.GD32755@b29397-desktop> <20200529135524.GA14614@qmqm.qmqm.pl> <AM7PR04MB715735B54F24293ABF7B37908B8C0@AM7PR04MB7157.eurprd04.prod.outlook.com>
Date:   Wed, 01 Jul 2020 09:53:54 +0300
Message-ID: <87zh8j7mkd.fsf@kernel.org>
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

Peter Chen <peter.chen@nxp.com> writes:

>=20=20
>> > > @@ -425,9 +425,11 @@ static int acm_set_alt(struct usb_function *f, =
unsigned
>> intf, unsigned alt)
>> > >  	/* we know alt =3D=3D 0, so this is an activation or a reset */
>> > >
>> > >  	if (intf =3D=3D acm->ctrl_id) {
>> > > -		dev_vdbg(&cdev->gadget->dev,
>> > > -				"reset acm control interface %d\n", intf);
>> > > -		usb_ep_disable(acm->notify);
>> > > +		if (acm->notify->enabled) {
>> > > +			dev_vdbg(&cdev->gadget->dev,
>> > > +					"reset acm control interface %d\n", intf);
>> > > +			usb_ep_disable(acm->notify);
>> > > +		}
>> >
>> > But it does not fix any issues, the usb_ep_disable checks 'enabled' fl=
ag.
>>=20
>> It generates spurious trace events if you enable them.
>>=20
>
> You mean the trace events from core.c? If it is, we could try to improve =
it
> and indicate it is already enabled or disabled.

I agree :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl78MwIACgkQzL64meEa
mQaEhA/9FX2Rt90P2cv0yV8OH6+R6yinveawhOOllasJKyZZ8AiPo/63DpV3Yq/M
b7MkdyqExd0OTZTZ5fEeBRE/P8QoMpUYFfztAzM6jE6mz+Vun42B6xgPf0D5w8AP
OQGV2ZBBPoPNzTTA+3mYY8sUevKSWfFTl2srrQSYEvmQMWzlXuMZn1deUsSEf3e8
JLi7SvgFEhqMS2Er/1LoHF++zZSlMQFUir0rNoLdaSX6Cp7TwMGmwm6Dt9MOlByz
sXvBR4mC8LY0iA5NyR0BVl0D4RUwPG9BxyXDOIJ8sGeIVvkrPz0omUUf+6y9uzlf
r/VJk9wOKBbuoosSalYUo50SxSYvReNxMbAENuXf6S3yJ4iq1/71xKBKcr0pkyzi
CXhbJJhXCKGOAWyZV7tM+n6sRDdpLIB7/qcTxKsZOGcBGb7qoydcpVKYu8f+yUq/
nu23yRjbGzeL5QwcP6ZsO+s1H+CE9o7pLizKIdSHEhVbMg1dkWKdwr8uJRbb8mjY
2NKVm+I7iNGOZDQtOgkmHi1FascF5+Qfe3H/E/qbFgnuIQGyiDzozoRk9xYzR+Hq
1WrKXPbdIWienJA1H/ecshyKd7tUm0nzRqeNZnsXrucHbjliHxWEUvuqGN7Vh2NZ
o1K8X7QOScZeCEY1TquXDuKylONHyzzuXTVsFLc3XZrekQ0I6nU=
=R+dN
-----END PGP SIGNATURE-----
--=-=-=--
