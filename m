Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F89C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDB020708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594276986;
	bh=8KiUdcfT1mg5zMfQ7m3FHfRFlZ9SnEE5+eC7+iJTfw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=W4LezlE3WFD3WYoE90pQsy44bXeN1gXN3nUjtjSNCFmNIyYrIadzrYEibecjlYrdZ
	 mS8lo6hZbeGOx8r4CXShKgZC//75CKpXN2C3TnUWgobYvvxS5OwPSU0XvXp4g/I8/A
	 c6FzO+LocbHGKcepS70BrXUvzXP1e/O/2esHjt0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgGIGnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGIGnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:43:03 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39B2C061A0B;
        Wed,  8 Jul 2020 23:43:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d17so1119755ljl.3;
        Wed, 08 Jul 2020 23:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=lcZQQSxCy0IEK8hiqOO5BqfdMhhuSov0Y+kqA/a3/rI=;
        b=ogVnGclOk5VQFYLbCrnG1ExJQdP3PexvJGsgXX7NdByB1BvhZycnGs/glKFEPTqEAL
         SJ5XIJHIzTfFgYbfGCHUftliczFeD4jVeMAPS7juBbCg/1sxo15AwtGPi8Jo9Y6x7suv
         JhZZJSRZpVMmc51N9f5vDNcNkifcli+rEWvlHo7Hnbpaz5Q3H9OIueuwsP0FLDcQ0ldc
         4LvD3f9RfGWEiSa5B7P5xdttOjocF7E0HRX8nkeDv5pCndDC6M5WevosR39coXWRlzFr
         XIMfQvgyd0dnv/lrFwIEUqkzyzD6rEHPmDiEj3UvwVcvvObfFDrOLT3+oMmQ2LvHbtVp
         EPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=lcZQQSxCy0IEK8hiqOO5BqfdMhhuSov0Y+kqA/a3/rI=;
        b=Hh/nGSKGsNCgImQ29aLHi9ERe80R4Lt7gon7l1M2MlEbuwtzdNKfpIkw+HP7fixJFU
         vTgkPiEDmL/2XZFpx/SFlCVBCYC9sdNa8qId3LG5ZkvZYW6ZyLjxnICi9iUCbOjTmyed
         2nWvnD86/PH0f2Y+5K/Assqm7C9FaEf5h0SYVSdjqTDhfzhL6nqNTj2gbc26yec+nUBR
         hv6YNxH/o4o12Zr0PSdw0wf6RjfWaSF2Y18ExxtZa1Ct+5Nue+IxIJITdRWeAyRTuKwc
         dzdAAL3UxMP6d9oXLiSVWvZT8xmGLQ8a0qjvswoBWM5iphgMDMc/oc/sY5dpAj6qtia3
         7phQ==
X-Gm-Message-State: AOAM5336qNF1S3GJITNyyugdSI7TcRZB3CEI+AUNNQIepyUC29lc1gSB
        YwErawMEj2vYe28CIqYZm4pUhl7w/yY=
X-Google-Smtp-Source: ABdhPJwnVyAuI4N9rXiPQHgqGOUY/7oxVUYgnUrsbPrWnPJbFYyTdE8oNt9lLDqVW3rTznEqPuwpTA==
X-Received: by 2002:a2e:a548:: with SMTP id e8mr36561777ljn.76.1594276980850;
        Wed, 08 Jul 2020 23:43:00 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id r11sm512119ljc.66.2020.07.08.23.42.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jul 2020 23:43:00 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [V2 PATCH] usb: mtu3: fix NULL pointer dereference
In-Reply-To: <1593658371.23885.16.camel@mhfsdcap03>
References: <1593502942-24455-1-git-send-email-chunfeng.yun@mediatek.com> <20200701115821.GA2184169@kroah.com> <1593658371.23885.16.camel@mhfsdcap03>
Date:   Thu, 09 Jul 2020 09:42:56 +0300
Message-ID: <87imex6vf3.fsf@kernel.org>
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

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
>> > @@ -373,8 +380,8 @@ static int mtu3_gadget_dequeue(struct usb_ep *ep, =
struct usb_request *req)
>> >   */
>> >  static int mtu3_gadget_ep_set_halt(struct usb_ep *ep, int value)
>> >  {
>> > -	struct mtu3_ep *mep =3D to_mtu3_ep(ep);
>> > -	struct mtu3 *mtu =3D mep->mtu;
>> > +	struct mtu3_ep *mep;
>> > +	struct mtu3 *mtu;
>> >  	struct mtu3_request *mreq;
>> >  	unsigned long flags;
>> >  	int ret =3D 0;
>> > @@ -382,6 +389,9 @@ static int mtu3_gadget_ep_set_halt(struct usb_ep *=
ep, int value)
>> >  	if (!ep)
>> >  		return -EINVAL;
>>=20
>> Same here, how can that ever happen?
> Maybe when the class driver has something wrong:)
>
> You mean it's better to remove these unnecessary checks?

if we need those checks, I'd rather have them at a central location,
such as udc/core.c. But, as Greg mentioned, the kernel doesn't call
these with NULL pointers.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8GvHAACgkQzL64meEa
mQbrYRAAml2Y+LWrWoV+FiUsizawyXWdMnK293fh4tAdEx26PRCockGvNBZDC/10
Bw+SsUEFg5Dv6HgqL6fnSJYER2NAzN13bcBo7hZBvFWce+4sNBh/w9q+sPjnAt2x
t0wWe1mv/k+XAPsQfJmgxmmI+o1Vo3Dzk2hGvvADYclCn7gEyjW/lYDx+Bq4qeYJ
9wEFLMiicZNMFEuIY8BMsNMzQmEP71AY6Cogwd5m2LkGOYyQ98AuvY4qHFFHwXaZ
RSclHhIcGdYifSq8IZuA9YXV5ayVQp+c7eec6i9dZ+Ne/s5hG04lV/5e6uXNtD3U
dgCpbZYbgftCU2iyDREbkJJEemzDXpKwcDX3R/48QidnmB25JOl0kxhZq6t8Qf7h
gQ0n5SwpKtyKA7lEX6wTHsIga9/dYRGY5vYnJFjgRjiE3l+O/Nyk1w3gaxC9LoFD
qh5RjrKbd0r3U5R1NxRUggF2cbbPNEl3O9DrD59sVgEnHrl13X/e5kBQXhOsYLaw
rKo9c1VFrtB3RPF0siao3noO44wZHvdMXDo+5MA5OevTQy9+k3Q9fH6+V2gcn0eY
fwi1/c7oE1WZ+awSsiZ2CZrbCSYhJGlkCkxw8GroOze5atFPnxKi9NENBJEZz5q9
nfFhcgIRdJwoiZaWyZ9dov2nXX+0K5BCKPPDU16jeg6IG6FHbcA=
=K726
-----END PGP SIGNATURE-----
--=-=-=--
