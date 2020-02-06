Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7E8C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6666E217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580969670;
	bh=myzIXywhqBqhOUO0uftdTPKfYvoF2YvHRGj7DK1sJHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=LRWTNbOG8tfTeBc5xL4PAlXmJ9sHjBqqMpN6LkNcDNFlOpIjW2I0aNSFTsDWwIfeb
	 bkRbOUFYWpDeEruYAhFYhyHAhyR5ez/m1PrqTxst4Nr6pb9lXuRgy2vLlVAtLVKDwc
	 jWgTP/1FgXBtpAVhDeP7UgBvUXxB8lgNSSLvO7WI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgBFGO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:14:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40962 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbgBFGO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:14:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so4795320ljc.8;
        Wed, 05 Feb 2020 22:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=D6Y9HdoriA0o8rqnyJU7KKT2aOOU0xj/IRORVJiMPtI=;
        b=AzQRaqlXD8rAiSLepqUjv4kQJ/oaeoW64+f1NVEJtZ1f0Ucp96U+WYpjpz+/CCeT5e
         sJZq8ddXGHd2BXhrfiPmJiLDCCbZWYp1XhEkvT/e1QSiNNR8AtHibDwK6ygjBJTwyvp4
         wSJgwEseC4FLHmvIYA5efrU71HJRMYAJ+/aQkvlmHQeXF2X/p0VJDpAcK5BcJB/+8y/R
         I8GZFQlhecbflpDVIZ4F7AErj7CroccDDWxhQVxxWCHrT7lC/BDm1KXrp4GbdRZpbYV+
         3P3NNSsgwJ2NGiP9rIYHkTJuYiKkApvvtRKGt6FoENs8Zcaj4E0twgxXqCLlASy/r6hF
         djWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=D6Y9HdoriA0o8rqnyJU7KKT2aOOU0xj/IRORVJiMPtI=;
        b=p2By6aLGOZOO+rS6WYJ1S6adXvOz8TU/JP9UHVItfCj5Q/v84pMGEGXIrkZ9OYFFRm
         mJn4J18lw+7/oEeDpgOV81JwDPGluE+fcLsmP86t8wKwNUbKOaRWpkGU/wuuUJdR/vdM
         JFuwkwi8tYwABvjZYNCloAmx/wCEZfVLBDRhmuILmLeAyU7d9jrLgdOklJCdUh0naw3d
         Aax88qBWlZ/2EANGQYCPdyRiGq3fxlwbpglRMekedqmudfbtvwPSc0S+QJgRZeflJEx3
         IAYQdpXVvRKxjD0eH0pZ6x4YU92GQxH1UG+b2bkMu5mvI4nbAA8ioPUCuud9xXJR6daU
         e8XA==
X-Gm-Message-State: APjAAAWwL++Za8Irxz8eqf4imgmNTQPr9bRJHvH2u4MCiOhcS1vjk0ZJ
        ZNHhXr/bTNuq1BgRxgmv5hQ=
X-Google-Smtp-Source: APXvYqw6WY4ASEZeRLh5Zs+NH+rDkbJuuQQrgBnR9WluSw/9FPt+ettTxAVTCLruz2roW8ZfsPuIRQ==
X-Received: by 2002:a2e:8197:: with SMTP id e23mr950207ljg.250.1580969665476;
        Wed, 05 Feb 2020 22:14:25 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id n11sm741245ljg.15.2020.02.05.22.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 22:14:24 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v5 1/1] usb: gadget: add raw-gadget interface
In-Reply-To: <20200205211812.GD1399643@kroah.com>
References: <cover.1579007786.git.andreyknvl@google.com> <461a787e63a9a01d83edc563575b8585bc138e8d.1579007786.git.andreyknvl@google.com> <87ftfv7nf0.fsf@kernel.org> <CAAeHK+wwmis4z9ifPAnkM36AnfG2oESSLAkKvDkuAa0QUM2wRg@mail.gmail.com> <87a7637ise.fsf@kernel.org> <CAAeHK+zNuqwmHG4NJwZNtQHizdaOpriHxoQffZHMffeke_hsGQ@mail.gmail.com> <87tv4556ke.fsf@kernel.org> <20200205211812.GD1399643@kroah.com>
Date:   Thu, 06 Feb 2020 08:14:03 +0200
Message-ID: <87r1z85jkk.fsf@kernel.org>
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

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Wed, Feb 05, 2020 at 06:42:41PM +0200, Felipe Balbi wrote:
>> > Overall, supporting O_NONBLOCK might be a useful feature for people
>> > who are doing something else other than fuzzing, We can account for
>> > potential future extensions that'll support it, so detecting
>> > O_NONBLOCK and returning an error for now makes sense.
>> >
>> > WDYT?
>>=20
>> If that's the way you want to go, that's okay. But let's, then, prepare
>> the code for extension later on. For example, let's add an IOCTL which
>> returns the "version" of the ABI. Based on that, userspace can detect
>> features and so on.
>
> Ick, no, no version mess.  If you have a new api, just add a new ioctl
> and away you go, userspace can easily test for that.  Don't go down the
> path of trying to version your api, that way never works.
>
> Trust me, been there, got the t-shirt, lived to regret it.

fair enough. Here I was, thinking I was going to rock a new t-shirt
soon.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl47rq0ACgkQzL64meEa
mQbE9BAAm+lqFVf54KzTHS5MGpxLYUDrqLhJsEP2ffe3y8srzNLYUegMsO9PBkEO
J34xYUi2EHA+TnLZY/HfdNLtedpGuBPh81S8Vt3/4VA8BtOc9U8js1wemDG+rrHW
7cRnUlKTAWDhgESvptAbtEOgkwTtlhPDWPhnNoaQfPCZAb00IS7jv8kwldaAwrFR
zbEyf4gL+fd/iZGVgHJPyXFXET0lUlF6eronlok+V0/9VXoWUMHmG78WWps3SlTx
dVJ3RKiwDBqLyWrP4poXhlJoaq0yZr/cRRAexklj9P33gL6GjrpJ/cJN2GIiwv3X
cW/Q2AKI26Wf3kp4mAzRFkTjyPuLwJ0QShYV4CJ7i55Ec89ZS7AnRUfZw8pp7Doa
YR3AZU5sH4F4bCpOvPcjk+ttXcnG9xHCWGTyLXzikXGRK9EeUB5G1IxS329+mSDK
BlidzWXsIugzAzXik4yb5I57E0EypSHSJ/swI7mpmT7TP/OYjPCocUCbPRv9WR/j
aS7tRBCB0jhgwIrVl3q+nUEhy83W5cC7HFW9NHp9VGZfmkR61G8MWb9VvFlRiSou
O2Sqj4tUASzInargF/MZcsWtdx9YrJPu1z1eckxEziiS6esHIKP9DH1bRF7qqz8R
JpDXJ9Rl5LuWQUmYX/t5pN21qknoKk55GFJ2+v62GHEIt30aOR4=
=JotK
-----END PGP SIGNATURE-----
--=-=-=--
