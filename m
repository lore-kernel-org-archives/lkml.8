Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C52C2D0ED
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B019206F6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585500242;
	bh=XlV166F2I6QWzShIWal68+LYAdyEdVn+wfqluo1OQkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=MBeH7FMxnGLxxNhldTF+yeMGPzTAVVvJa8gNgk2UyYui4kRiw4ugNFO+Iz2+b2jrG
	 UoymD41iOJcHgcr7MGBsio6ASI0kIsm0StBOZ9YUkGN8YQ5NxzgsiZQ+GCEV9Y/l72
	 g8Ynoz5CoPr4LQVNliqqlrzY1A53UTvJtnKYUbKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgC2QoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:44:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38931 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2QoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 12:44:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id h6so6201335lfp.6;
        Sun, 29 Mar 2020 09:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=0c8uaPF3N+GHT2An6yhCZHffyUb6jdEEzTgcTDxgCps=;
        b=Sos5BixyOxY5FOSKR6fW9+gG4JgIChPoNbwTsGqRNCTKgr+Vz33SJIYj0Bk7+0B15F
         OXO37FxGUBMoYY52xYMaRPZJSb5mtvy6ibiUy0iGVj/1p0PK34UU2zlMzMZ5JeTzq5bl
         DrfF3TI4UV6e7pAvqArl8o1RndG45a1StLIzIK0/7LtmshRyOq/XncQ7FturJTb2OLGJ
         caw1LXGQSE+Cx5Y2grTFRXgAUOUPHFm+lOYRiMaOPTXqCDk+yziISv6r/19FO1r16qE/
         mXRp7lW0RHMRCsHC22q4Z9kwwx5jTt2LGAzE627IqVNyHKmTIG72j1Vww8xlaEK2A1Q5
         YCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=0c8uaPF3N+GHT2An6yhCZHffyUb6jdEEzTgcTDxgCps=;
        b=spzJRSsIpDhBRFHgY3snRisRTaUIEnYYU+VjZxON6ZEnKGf3v59i0USwxr54mqI/i6
         w100tfrM89QPH4bUDY3+MEUQbDj1qxvD+lvR5x4q0QGcgKwFwNB6CWUeIBKKnBHPfvMj
         +9rKsgj+xwyoFzDN10lfOuKFgRNV38muC3k8pCv8KdWC5sqIcKmuj3jLMwYD4yXITmVK
         t6Qs12UrxFQ3cJhb0tCpxHWBCBPowPpRdqy0kny0v+x58JU0pT62g1ocTruMldkAGPQh
         tENjSrvS9qHhtcAi77Wu3WlJ+I7u7EU03I9Eq61wf5+pXVRosC3acCO3eAUUAPQPkijy
         krRQ==
X-Gm-Message-State: AGi0Puav4mcwRlCert1e3KbPUPITWXixsVZnapKMWo3B2jeWxiXM9dPp
        ehuVbdcAxag3XT6qqGkVylA=
X-Google-Smtp-Source: APiQypKBkS2c+nq8k4EGh/prRPLtE8K0t6Qsi9F9MT91f58F6gHa4TL7qK6SLkkRbrLJAYdJEGGbLg==
X-Received: by 2002:a19:7e01:: with SMTP id z1mr5600821lfc.196.1585500237140;
        Sun, 29 Mar 2020 09:43:57 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id 64sm5713315ljj.41.2020.03.29.09.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 09:43:56 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ashwini Pahuja <ashwini.linux@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH RESEND] usb: gadget: udc: bdc: Remove unnecessary NULL checks in bdc_req_complete
In-Reply-To: <20200329144703.GA9720@ubuntu-m2-xlarge-x86>
References: <87zhc0j2qi.fsf@kernel.org> <20200329011246.27599-1-natechancellor@gmail.com> <871rpb4nd1.fsf@kernel.org> <20200329144703.GA9720@ubuntu-m2-xlarge-x86>
Date:   Sun, 29 Mar 2020 19:43:52 +0300
Message-ID: <87mu7zdsc7.fsf@kernel.org>
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
>> > When building with Clang + -Wtautological-pointer-compare:
>> >
>> > drivers/usb/gadget/udc/bdc/bdc_ep.c:543:28: warning: comparison of
>> > address of 'req->queue' equal to a null pointer is always false
>> > [-Wtautological-pointer-compare]
>> >         if (req =3D=3D NULL  || &req->queue =3D=3D NULL || &req->usb_r=
eq =3D=3D NULL)
>> >                              ~~~~~^~~~~    ~~~~
>> > drivers/usb/gadget/udc/bdc/bdc_ep.c:543:51: warning: comparison of
>> > address of 'req->usb_req' equal to a null pointer is always false
>> > [-Wtautological-pointer-compare]
>> >         if (req =3D=3D NULL  || &req->queue =3D=3D NULL || &req->usb_r=
eq =3D=3D NULL)
>> >                                                     ~~~~~^~~~~~~    ~~=
~~
>> > 2 warnings generated.
>> >
>> > As it notes, these statements will always evaluate to false so remove
>> > them.
>> >
>> > Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for Broadcom USB3.0 =
device controller IP BDC")
>> > Link: https://github.com/ClangBuiltLinux/linux/issues/749
>> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>>=20
>> It's now in my queue for v5.8. It doesn't really look like a bug fix, so
>> it's not going in during v5.7-rc
>>=20
>> --=20
>> balbi
>
> Thank you for picking it up. It would be nice to see it in 5.7 since
> we're enabling this warning and this is one of two outstanding
> instances in -next and the other one's patch has been picked up plus the
> patch itself is rather benign. Not to mention that I did send this patch
> back in October. However, when it is merged into Linus' tree is
> ultimately your call so I won't argue as long as it gets there
> eventually.

If Greg's okay with this patch going in during v5.7-rc, I can send it as
a fix, no worries. Greg?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6A0EgACgkQzL64meEa
mQZiEw/+JF2SkxE/JgJAs1X5mOvM/c8aF7iFlroAgAhXO5LZL5YZiVOoNCd2UJdp
6VHA/jwvOtRStwzeSLleFAoyF8wozzp4REfUNyIogW6bwOHcb9T36Nn5rguSEaPN
t/g9kBb3CbfrQ8Wejfl7xINPN6NYaW2wqUbqPVUDEX0bGFCrXWWBn4o8vVlNtvZ2
cxwcuEOScN7o7rfrwqii1VHngY8CxHjl02yJ2F8Fcc+8rD0lCdNUB6DemSgBgFEk
HeEmZoCb5hjpXGc8obbStT0Ie9Rut9ItgA3XxoL4cFhIa5i3UUV+Mq9qXHY+W4It
+jhW1hK1fL+CEu+BlXb3AELgNOaxbDDwuXJMKuCbNnnP6z/4uOHjE4fxSKoUnFCw
XFCforp3+hheFJPlB8e+fNd+hjsWv6ipI4tuEL1mrpnXu3d2U3toTlDCNyTciy3J
sDg9TouHZqXOATisL1qPi2cFtdfUEGhVTuYbYGWUJA86f3IHVUmjU9LIJ4YmlEtI
5aQr7nsIkF0ERGCt56DcKD7DJxNI29dMWYPw5SCSOjN8mQ4elxoBekLCtYRdNrGh
EKmoP6TQuiPbndOzbNPuehQoDCoXao+4YfSubUfXQi484q0+DzAjQidcIJGV3efu
D+Sjn7bi/T0ngvHHYVZot4gXukoOIu9xwZrKLVM6mbCckIH2qrM=
=U6ai
-----END PGP SIGNATURE-----
--=-=-=--
