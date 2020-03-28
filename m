Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AF3C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4871520716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585384558;
	bh=CVjc8VcqeeM0Mu6jULSyiTT7sAY1j9rILNGN4MzK8+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=kZjXAsuqFl1m9MV2dbx4XDtEAazh65M/1mRnq4keX2kxfqkNPAuLHKSJosnv/1MEX
	 FYyN9THWCtMlIgaOiMdAPCN3aB/KFh1hRD7yc4Tdzq7gma9c6iPdSxe/VE7n3u0OR5
	 C4aEDFFnlVZt49oVgGeojrnIIFWza8gacKsLUR9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgC1If5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:35:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34612 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgC1If4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:35:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10so12400483ljn.1;
        Sat, 28 Mar 2020 01:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Qer0UP/wnwHE4FuvM+cjbdyplCq3YOMP2VWFL2KepzY=;
        b=JPnvBuAmpjUWgPGXLMn3Vxolnj7wRcGcfI4VpdjvIq87JIx7F/OP/9eqhY5zzJnLXr
         Z8Osg9OAPckk7So5lxx8yImBnegyyYsWfQ0kjuFHvZOtLTkby7EJq+g8cyhowXmmFTnN
         C+Ib41iCyI3lMyEuzSHYZBqXAG6NZgW9iav7TMfbi7Ct2Oc9/UJyzv6wE8BfPYH2AGq3
         RTgRb9urkFYkwRQnjcQDa+9+amynT+y51Vc3dUBTPaYZ6iD2o+20D3G9XW7y1i7fomv3
         cq9ecCd38dE/PFYuw9pVVYasw1BstmLc/4/0mhilE75uEhVYjYx2EFWXOe9Pzw96AVKw
         q8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=Qer0UP/wnwHE4FuvM+cjbdyplCq3YOMP2VWFL2KepzY=;
        b=WlRdIOY3pFk2lzdxfhCr0cc432MXn8mI6Gfcrb/Sw4Zxptkoql+jo+C5w+lmUmsmGc
         ob9WkPjT1gewP0x3hnj6TJ2Ji30f2vZlpzDk6+gdojZxkLln/Nc0t5HMW9qfaKq8xCNQ
         KoAc2xhKaHHMzx1UHHFNN0H0aMG4U+fm73WspITFEowlRc2q01+4izg+YXs84x2kHCMx
         MIVdiwNvomqKHLLuzJqEkqX87E7iYimRU6MfJlyZnxtBYadfChj17GejdQlMBKJFQnlW
         F/6RuEzSXiPYlYz9tK56hiQL++f/SsZlKhalWN3hisiUdXWkFpGGiAQBsP0Fuh677S5+
         8suw==
X-Gm-Message-State: AGi0PuacAcafbDi3izw4s2JGM25kXaArrqO1E5sv3i0CSnhlEexlXCYj
        YJ3vXPYPQCqYEZ44N78KNX8=
X-Google-Smtp-Source: APiQypJdG7yVb7jCeHtVzTnszdmd2+Jd+KCHpGnPX/km82WU8taCy6cbV2xBW3d8iCpCpNAcXh6X6w==
X-Received: by 2002:a2e:9ad2:: with SMTP id p18mr1670420ljj.15.1585384554120;
        Sat, 28 Mar 2020 01:35:54 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id 9sm4096123ljf.0.2020.03.28.01.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 01:35:53 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ashwini Pahuja <ashwini.linux@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] usb: gadget: udc: bdc: Remove unnecessary NULL checks in bdc_req_complete
In-Reply-To: <20200326195855.GB29213@ubuntu-m2-xlarge-x86>
References: <20191023002014.22571-1-natechancellor@gmail.com> <20200221045740.GA43417@ubuntu-m2-xlarge-x86> <CAKwvOdku24UV8J4uSKFFc7gmwOP28-8K352BJepb_z-octFoPw@mail.gmail.com> <20200326195855.GB29213@ubuntu-m2-xlarge-x86>
Date:   Sat, 28 Mar 2020 10:35:49 +0200
Message-ID: <87zhc0j2qi.fsf@kernel.org>
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

Nathan Chancellor <natechancellor@gmail.com> writes:
> On Mon, Feb 24, 2020 at 01:42:57PM -0800, Nick Desaulniers wrote:
>> On Thu, Feb 20, 2020 at 8:57 PM Nathan Chancellor
>> <natechancellor@gmail.com> wrote:
>> >
>> > I know it has been a while but ping?
>>=20
>> Sorry! Too many bugs...barely treading water! Send help!
>>=20
>> >
>> > On Tue, Oct 22, 2019 at 05:20:15PM -0700, Nathan Chancellor wrote:
>> > > When building with Clang + -Wtautological-pointer-compare:
>> > >
>> > > drivers/usb/gadget/udc/bdc/bdc_ep.c:543:28: warning: comparison of
>> > > address of 'req->queue' equal to a null pointer is always false
>> > > [-Wtautological-pointer-compare]
>> > >         if (req =3D=3D NULL  || &req->queue =3D=3D NULL || &req->usb=
_req =3D=3D NULL)
>> > >                              ~~~~~^~~~~    ~~~~
>> > > drivers/usb/gadget/udc/bdc/bdc_ep.c:543:51: warning: comparison of
>> > > address of 'req->usb_req' equal to a null pointer is always false
>> > > [-Wtautological-pointer-compare]
>> > >         if (req =3D=3D NULL  || &req->queue =3D=3D NULL || &req->usb=
_req =3D=3D NULL)
>> > >                                                     ~~~~~^~~~~~~    =
~~~~
>> > > 2 warnings generated.
>> > >
>> > > As it notes, these statements will always evaluate to false so remove
>> > > them.
>>=20
>> `req` is an instance of a `struct bdc_req` defined in
>> drivers/usb/gadget/udc/bdc/bdc.h as:
>> 333 struct bdc_req {
>> 334   struct usb_request  usb_req;
>> 335   struct list_head  queue;
>> 336   struct bdc_ep   *ep;
>> 337   /* only one Transfer per request */
>> 338   struct bd_transfer bd_xfr;
>> 339   int epnum;
>> 340 };
>>=20
>> So indeed the non-pointer, struct members can never be NULL.
>>=20
>> I think the second check that was removed should be
>> `req->usb_req.complete =3D=3D NULL`, since otherwise `&req->usb_req` may
>> be passed to usb_gadget_giveback_request which tries to invoke the
>> `complete` member as a callback.  There are numerous places in
>> drivers/usb/gadget/udc/bdc/bdc_ep.c that assign `complete =3D NULL`.
>>=20
>> Can the maintainers clarify?
>
> $ sed -n 537,555p drivers/usb/gadget/udc/bdc/bdc_ep.c
> /* callback to gadget layer when xfr completes */
> static void bdc_req_complete(struct bdc_ep *ep, struct bdc_req *req,
> 						int status)
> {
> 	struct bdc *bdc =3D ep->bdc;
>
> 	if (req =3D=3D NULL  || &req->queue =3D=3D NULL || &req->usb_req =3D=3D =
NULL)
> 		return;
>
> 	dev_dbg(bdc->dev, "%s ep:%s status:%d\n", __func__, ep->name, status);
> 	list_del(&req->queue);
> 	req->usb_req.status =3D status;
> 	usb_gadget_unmap_request(&bdc->gadget, &req->usb_req, ep->dir);
> 	if (req->usb_req.complete) {
> 		spin_unlock(&bdc->lock);
> 		usb_gadget_giveback_request(&ep->usb_ep, &req->usb_req);
> 		spin_lock(&bdc->lock);
> 	}
> }
>
> It looks like req->usb_req.complete is checked before being passed to
> usb_gadget_giveback_request. So the patch as it stands is correct,
> unless those checks needed to be something else.
>
> Felipe, could you clarify or pick up this patch if it is correct? This
> is one of two warnings that I see for -Wtautological-compare and I want
> it turned on for 5.7 and it'd be nice to be warning free, especially
> since I sent this patch back in October :/

hmm, I don't have that patch in my inbox. Could you resend it?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl5/DGUACgkQzL64meEa
mQafUA/9Ht2zH4aYtwxtqPtB+xyMdI4MdcpS+/CjkBgHkTpkpp1WOnANeG7xLxf3
pbnPBkQiPqDuDbGiM0lZ1tlwwS7+fFswxlqON8gmwH+xcq/BOVe/S5duy3G/Kbkl
J5LQz6cR/uEvISqJRp8bKgBcy1kR0EgO8o2/nxlNbGNzZEjfq8LtZOqI0yAY0Gw7
Ken1JOvAw/1uHa0gAWbpkIDD5wHPRCN47Lw93aCm4ZhjOe4fPK6XN+rXA1I9t2Bt
Ra+rwTz37Biz2s90PWd+XveKCIjFUzNEsxRp+/1lnFv26/WTl4u8GNzqmePNtTx5
iHSRwQBpqeHA5CpNPgFVmmrU1Y3eoMiBaPZO1pUGu+2e7JzWXuzdS3lgPrvVNXpv
w723kiTG7E8M68fDiVztC/ii/63v081J+6OxPxHC+vvFtN7lX2hAjcaJGp8LRwQn
NtlFkXszqk04EeGSebTmEyTTg823hsE+EWA/dVYQxUDJOtmBHttyyRKmeWf9k13f
9DLJYekjXtbAikddtjRyVwLmKipuU0DfcstggkUm3wzu+JwS7e1HH1aDlZfZW/2A
3wzpnEjtscMMuXXQlm2tzGE7cQTrHFdwFcQEptJ9JScFDlNYP+fsK8v7XcH2fLLt
U8Ro3+BqJKKJgz1yXegLP9bDcKjDEjofgpAp3hvQoYfG3WCd8Bc=
=5F2y
-----END PGP SIGNATURE-----
--=-=-=--
