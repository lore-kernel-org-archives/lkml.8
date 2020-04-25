Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242FCC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9CD20714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="W01P/S7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgDYOCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:02:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:51215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDYOCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587823359;
        bh=cbbVI1PGCNAqbeyhd0rn3+oxRl+wxXYseCxr5QBOBU0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=W01P/S7JvlociG9FeQ4GrGUrkdfG1pKgbWIQDCeMEt3qaSoP15oRM3VwsiLdMrSzS
         PS0ZaJ1Ssryu3m4IJoNtoXc/iXxxeF5nxy+Is5ZSrLEkY4jNCRjAHl88GpL2gMeKfS
         MIcDgF7SVwkAYa7bCP3w7hSJAx3lhX1foFDXVRbw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlGq-1ixhSp2JcW-00dn93; Sat, 25
 Apr 2020 16:02:39 +0200
Date:   Sat, 25 Apr 2020 16:02:37 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] staging: vt6656: Add formula to the vnt_rf_addpower
 function
Message-ID: <20200425140237.GB3213@ubuntu>
References: <20200423170557.10401-1-oscar.carter@gmx.com>
 <20200425105714.GA2071664@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425105714.GA2071664@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:Azk07uiBcDqWvl5IdR2SJ0a5orfygJTMkzEvVInPXE/rufeIZw7
 +ONWWNso4Gqutk6/xuv2Boky+OMDG/cSxFy5e36//K2AuTFzmyCmRg6NvTvvwx3D2zgQGwN
 FfCxUsf7DERunEQ1miLQ7P76b3UfhleohSoxDZgdkiP1fUDLY8gwEyBBmDzj90edfJNacEK
 m8zZ7jf/Ixb9p1TdpUAhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nAjiWf6LWYs=:PG/MUaPGxZ06hcvjWN2f8U
 jBkRp0WLdpdYsP0b8IPRHiU0qq/xBcSq0yCLf2Bhd52dIQ/bWx7CXFiBDFNYjg7eikTZJAxG4
 wQbjhlRWJcSRpdwMCptGL2vo+6LffaOqOcci3OhROj7juUL1gEXVLoNhOTdsXcjSu6zMMfGCp
 WiE0kLdYb57V44aZGB/vcMfThS5aRGxdxCxQJ+23gaGidW/IsgVOYENEsdmJZiDldymSvASS1
 zFvIjhtxa1xHkKeI4holYEibNc4n9F1n0toTVMckCJ8yfji+dkt4t+3TiPm43REYQxLW/5zOJ
 4KXrUpc1GMyvjYNC2TgpjlEZ1Mqnu3J1goqSSHQpnlWT27sh/PBKAUxnr9iwKEkGIafmD3+E5
 wQO8GPFahn0IyBQMRZmATPB5vt2LriJk+gtjj5CIJJ1RUgytwiS/ZmORU1KNpwtuwh4LYo2KD
 JspDnhicXL0YLFvfL5WibN1kLh54DNu97rto+dEY3ToN4dYKPM+2eKdX2XAJFyszjyGCThVKC
 gJkvxN7QtyFqavIFUbKtU3GPAIiYe2Ch0JhycYBDc0qbSfRoXzYjHHi2NS0LdS0kfd6ApqRLn
 /4jIjaGhE/xl+M/+8MUEstvumpHzRlX0oBRe/l3n9teGalJTuOMMT9/dTSl4/t3uZvN73J1za
 ZrTU7JI0rS7mvNA/LyJnGeNWmDWWAW5iENJ5GO7H5jI3epH9sSNDtJzXyQ5rshOyp03290zQe
 J+i8pTPq8Jc6Zdj+Yp0u7JlMx782ZX04+Z8ven9+J3YxNjgRdjDE2rIitJogZpVAJ5hserVHa
 tGIa03QyWHi+6gCs9bXlJlWxOlmcYMXOwZEwNYdRgiv+yJhKxAC99CFJGgMEegWp3j0JGkTjR
 ADOSbLAQ4vQK1vDC7GiqulOSfdaCnPOQ1rGrPFJ7ETdYR3aoEBc4YUlObiONRbEcr4KJWE4od
 ivU5/AgeeIVem7Ipkd/wMuWFMuTWQ510pAfTjmosglKw4ERKsHK1dJyueTEEfdHp5E8HTMZKK
 itPcNDnr6aXaI8kWwwoCA0mpFzwfUW1PHRG+aealEpujwaJ7eKPg1xXJiCjd7DkBhDGGAEC6t
 By1o+gtnLlBLbaf2g4q53HnppZjFFw8d1BHsa5pu+0/MrJpoiWS9c16X0Vmmccgeq6PGJTn5x
 5sChTGqEfFUs/XtR4vxrZjRKXuX3zi/boMvSrmabjrJ2FRtgEscSrdPKftHMNelaw+O2VKBCP
 7w3Q24ZwGdkTsehrK
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 12:57:14PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 23, 2020 at 07:05:57PM +0200, Oscar Carter wrote:
> > Use a formula to calculate the return value of the vnt_rf_addpower
> > function instead of the "if" statement with literal values for every
> > case.
> >
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > ---
> > Changelog v1 -> v2
> > - Change the type of "base" variable from s32 to int as Dan Carpenter
> >   suggested.
> > - Remove the "--" postoperator and replace with (base - 1) as Dan
> >   Carpenter suggested. Also, as this expression has a minus before the
> >   parenthesis, remove it an apply the minus operator changing the sign=
 of
> >   "base" and literal "1".
> >
> >  drivers/staging/vt6656/rf.c | 20 +++-----------------
> >  1 file changed, 3 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/staging/vt6656/rf.c b/drivers/staging/vt6656/rf.c
> > index 06fa8867cfa3..612fd4a59f8a 100644
> > --- a/drivers/staging/vt6656/rf.c
> > +++ b/drivers/staging/vt6656/rf.c
> > @@ -538,28 +538,14 @@ int vnt_rf_write_embedded(struct vnt_private *pr=
iv, u32 data)
> >
> >  static u8 vnt_rf_addpower(struct vnt_private *priv)
> >  {
> > +	int base;
> >  	s32 rssi =3D -priv->current_rssi;
> >
> >  	if (!rssi)
> >  		return 7;
> >
> > -	if (priv->rf_type =3D=3D RF_VT3226D0) {
> > -		if (rssi < -70)
> > -			return 9;
> > -		else if (rssi < -65)
> > -			return 7;
> > -		else if (rssi < -60)
> > -			return 5;
> > -	} else {
> > -		if (rssi < -80)
> > -			return 9;
> > -		else if (rssi < -75)
> > -			return 7;
> > -		else if (rssi < -70)
> > -			return 5;
> > -	}
> > -
> > -	return 0;
> > +	base =3D (priv->rf_type =3D=3D RF_VT3226D0) ? -60 : -70;
> > +	return (rssi < base) ? ((rssi - base + 1) / -5) * 2 + 5 : 0;
>
> I _hate_ ? : functions, just spell this out please as a real if()
> statement.
>
Ok, I will do the modification and I will resend a new version patch.

> thanks,
>
> greg k-h

thanks,

oscar carter
