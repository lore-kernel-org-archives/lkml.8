Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348CEC2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2EB207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585562817;
	bh=3o9CiMPDv2ulB3s1eeL74yE9hC5cLqBCahiz+ww/4WY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=UOlOovkT7N3oAoR4Fk/kSZXzNBNiNlsBMgA/b8DgDAzWcIwYMaNURYaNpbW3QGwqG
	 0FZugm7B9LD1fmjzl3EjfVokYTcCZCmpcXyDOqmSc3+mNxjxNdIIepeHxZQFuOHXSc
	 bUbxddyb925aVxwMMUKfByJiguEgicXStWyxKtk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgC3KGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:06:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40561 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgC3KGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:06:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so13607976lfe.7;
        Mon, 30 Mar 2020 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=+vFK/REGJ28lNnIx9XJDcDFAy32x7XZRYv6n8/oCC3o=;
        b=rmXYUmAS0S8liwONGVGKgukHeydVvYUU32fc9KSH4LOeU2+pakeC850iO0Ux6XULPk
         i4bigGyXwnJaIacE0TgpANFJ6mFZXk0J7wvc2cou8qn9ZfZGKzHM/iUkBF2hu+R9GWK8
         l/oYLzJ4a6DzVfU0vnIG9S6xrQeAxlvaKsbdzX5uasT+T/rlrWfj4owkz3o7NdTJNVB9
         FkOjowW6ABlHMtBnceHBOmCpsIzcBXWTCcYYWiWwZXpqG1yoDn1Jj0geWU3Y2UHPm6bc
         0MkK3apKiXC3Lc/c9VxXsmfPMEPSzTs2TXK9eUi/U1tbmoJBk4eBBZp6EL+vBfeRhlK2
         yb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=+vFK/REGJ28lNnIx9XJDcDFAy32x7XZRYv6n8/oCC3o=;
        b=g7Q8UKrkLqt4qJ7un9w5UlpJVNHQ+rNeO2KuyruM2XGcDLE23fQ1pcw1Kt4bqzAfrF
         HePCJc4BJXHQyXIxcWKjVkxFB0Yo+/1b2qSrYjbcJSPEu/iAZd58gl5yyf1s9solMV3J
         g6t71ebSn5Xey81H3jt66OsMQoHh1cM5KMCHP0G8ifyzXacNAx/FY76vL1TkSjNW8Mum
         Taej1LiyTqiEKGVJUezA82pu2SxWP1Tywp32dR6oLeYLTFIUDo6vBmMSshmQTRD0tWLs
         mTPmFa5N7IVA/UEU9JcRdm0gjyQAddJmcH+Acu6nlClZySkZN6zOduPzUhq11eS8Gu4U
         6g3Q==
X-Gm-Message-State: AGi0PuZHLsoa5NDSIGvZ/0t8N2riyrIyK8+lIGB140ODaNKnsLXWzqLk
        xQqKo1oDoNmD65WnbU8Gf2U=
X-Google-Smtp-Source: APiQypKf1xJM+mkIbFfq3ChMecOWnSFk84YGWDSqKTUVX7/A5KWKNQkmW0ua5/dShbfniM1HpMyelA==
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr7449398lfu.169.1585562809516;
        Mon, 30 Mar 2020 03:06:49 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id n17sm6628788ljc.76.2020.03.30.03.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 03:06:48 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     lars@metafoo.de, alexandru.Ardelean@analog.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        m.olbrich@pengutronix.de, kernel@pengutronix.de
Subject: Re: [PATCH] usb: dwc3: gadget: don't dequeue requests on already disabled endpoints
In-Reply-To: <20200330082548.GL27849@pengutronix.de>
References: <dc52d6a0-12ed-a34c-01c4-0fc5ccbf7b1d@metafoo.de> <20200327084302.606-1-m.grzeschik@pengutronix.de> <875zeokhoa.fsf@kernel.org> <20200329190244.GK27849@pengutronix.de> <87sghq2tum.fsf@kernel.org> <20200330082548.GL27849@pengutronix.de>
Date:   Mon, 30 Mar 2020 13:06:43 +0300
Message-ID: <878sji2m30.fsf@kernel.org>
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

Michael Grzeschik <mgr@pengutronix.de> writes:
>> >> > dwc3_gadget_ep_disable gets called before the last request gets
>> >> > dequeued.
>> >> >
>> >> > In __dwc3_gadget_ep_disable all started, pending and cancelled
>> >> > lists for this endpoint will call dwc3_gadget_giveback in
>> >> > dwc3_remove_requests.
>> >> >
>> >> > After that no list containing the afterwards dequed request,
>> >> > therefor it is not necessary to run the dequeue routine.
>> >> >
>> >> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> >> > ---
>> >> > @Lars-Peter Clausen:
>> >> >
>> >> > This patch addresses the case that not queued requests get dequeued.
>> >> > The only case that this happens seems on disabling the gadget.
>> >> >
>> >> >  drivers/usb/dwc3/gadget.c | 3 +++
>> >> >  1 file changed, 3 insertions(+)
>> >> >
>> >> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> >> > index 9a6f741d1db0dc..5d4fa8d6c93e49 100644
>> >> > --- a/drivers/usb/dwc3/gadget.c
>> >> > +++ b/drivers/usb/dwc3/gadget.c
>> >> > @@ -1609,6 +1609,9 @@ static int dwc3_gadget_ep_dequeue(struct usb_=
ep *ep,
>> >> >=20=20
>> >> >  	trace_dwc3_ep_dequeue(req);
>> >> >=20=20
>> >> > +	if (!(dep->flags & DWC3_EP_ENABLED))
>> >> > +		return 0;
>> >>=20
>> >> which driver is trying to call dequeue after the endpoint is disabled?
>> >> Got some tracepoints of the problem happening?
>> >
>> > I see the case when using uvc-gadget.
>> >
>> > Look into uvc_v4l2_release in uvc_v4l2.c:
>> >
>> > uvc_function_disconnect
>> >    composite_disconnect
>> >       reset_config
>> >          uvc_function_disable->usb_ep_disable
>> >
>> > uvcg_video_enable
>> >    usb_ep_dequeue
>> >       dwc3_gadget_ep_dequeue
>>=20
>> Oh, I see what you mean. We get a disconnect, which disables the
>> endpoints, which forces all requests to be dequeued. Now I remember why
>> this exists: we giveback the requests from disconnect because not all
>> gadget drivers will call usb_ep_dequeue() if simply told about the
>> disconnect. Then UDC drivers have to be a little more careful and make
>> sure that all requests are givenback.
>>=20
>> In any case, why is it a problem to call usb_ep_dequeue()? Is it only
>> because of that dev_err()? We could just remove that message,
>> really.
>
> In my case, it is not a problem removing the dev_err. The ep_dequeue
> will only be called once for each request at the stream end. I don't
> know about the case Lars has mentioned.

Okay

> If we have to search all lists for the request every n times while in
> traffic, only to find out that it was not enqueued, I think it would be
> worth it to keep the dev_err and let these cases trigger so we have an
> option to find and avoid/fix these.

Yeah, I agree. That's why the dev_err() was placed there to start
with. In fact, I found a few gadget drivers which were trying to reuse a
request a allocated for EPxIN and queueing it to EPxOUT, clearly a
violation of request lifetime rules.

As for the search on three separate lists, I never considered this to be
a problem since it happens so infrequently. One thing we can do to make
it maybe faster, is convert those list_for_each_entry() to
list_for_each_entry_reverse(). I'm betting that there's higher
likelihood that the oldest request will be dequeued first, then again,
this needs to be profiled.

>> Eventually, I want to move more of this logic into UDC core so
>> udc drivers can be simplified. For that work, though, first we would
>> have to add a "generic" struct usb_ep_hw implementation and manage list
>> of requests as part of UDC core as well.
>
> I don't know about the cases you plan to abstract but it sounds
> like a good idea to get some gadget logic out of the drivers.

Yeah, this will take a lot of time, though. Hopefully it'll happen :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6BxLMACgkQzL64meEa
mQYmnQ//Sp4Z3DHbK97n70PEb3EwQgRKz+iUQ5CeuzmxnbdvKst5+xQ4hu3UBfrs
B3gq+OQC0e2Y6LGzlpWX7hLZ0VQxrvU+iGgas7aJM5byclIIuzUagM9hAeW3JsPC
Mzw+P7+RTdxPtRvrQ0yoCB+qrH2qOnGlFk+eE1ToA84KythrYFYw2wBYqOUbqwTq
wZcntR2CjsWuLyoFo8EgiCFVF7UTwXAEpG7JYyjvbaSFnM9GJDafDpRbLkbvqcqK
ZTB/P0uQCQ4tiIgBBNNIocf31XAA9CuT+XGEYUr6kQfEGAyUCIivtQa9Oz+eZOrc
rxL/nOHXgEkvfbLjNFrfBKi0uLyyeF5O/ueVj5ExVzF/DeAgqjKy3fWzDTSWAjlc
ua9BrAQ0njFYDq0Cn5oGhdXq+sRFKeG4LYOPNH8qWaA0ZHKdOzq1XJ30tztC+XIs
Ri+/6uCCsBHdjxU5hL2qL/Vi/N6rzfebBN1Y/zvRAnCICRByVuvMyyBS70Mh/C52
EwIhAqn25IVngAIihjx2R7km3+4JaPlZfo0XifyZ/VKdmNPX26Zw5jJBVcrrOI3h
EEFGRaAqlnLE24SkLPXdVKonRcTZIHVDSJ89v/OnK65JxZDmZN9RuwCAePG8mkWb
F1bl6FLOnU0h1O6AQUL3C2kAEI5KASFAn+icRumKTZSlN107NJM=
=Ol2h
-----END PGP SIGNATURE-----
--=-=-=--
