Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C355C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F084720774
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585552978;
	bh=YVaXtmHwgV76ZPlwLS1sQZAlggxgeAdo3+ZOGGbUvF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=ikKy4Tn9Xdv5x3cgMaq2bRpAj23ZNeCb5PTI7UQ8/hXWonBddIwhDzeim4/3I83nA
	 Fw0Hf9WJ4bAmYeCej54bQ1xEfHb6xl9uCLH6vB5zv0prCEzb64Ns0AdW3SkMJMXI0y
	 9ws1V5EjdnmjtiGmGXWMtST6hxY9Xw3uv21ogRxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgC3HW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:22:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43609 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgC3HW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:22:56 -0400
Received: by mail-lj1-f195.google.com with SMTP id g27so16852597ljn.10;
        Mon, 30 Mar 2020 00:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CFQXwJJrIXlSAMWy0ffSxEkaMxtOijfEu4eBTtwWKd8=;
        b=GAi4HKP0nBoaPwHyPeDijPw1rJ2dJfPawT18ZDBw9OvWx8tY1C/L+sg+QQ7OuAACyE
         Zrw7E+TveC0j5KG8kuTaHSKUrDF6DPCYSpuhFtlciYOcB6Pe9uPGmb/HuBaJj2RyvyiY
         MdOi48kS+nSsKdha+0uf/oI11cdSAgZNynrrzEFY2Q57jSqILNqb7DopZBgu0ujns+qv
         9yBDTWvP4hj3qp8ZWnmi7dlGWKS4pNUk459Zg4qy+7sFsCCcLwrQQhgXjOk+ES32l0YU
         ZZolQcn6X11Xc+lfPraaOwn3cZ841t7aHVfcXvBLIkc7F3fDWhi6Km18j1XSNz2/aQza
         4YAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=CFQXwJJrIXlSAMWy0ffSxEkaMxtOijfEu4eBTtwWKd8=;
        b=Rq5f0XB6WYBzdwb9aa+FX/dRGxqV7IRTrAPE7+Zk05qBP1YH9/0pvLvn0PIgEhBqrg
         sd4aWJeNN6skU15/XKTV3y8hBTZcghJbi8TiQ1LtdsogwNqua8F7Ssh/K9ycQGU8l5xt
         zPlRZ9pYLvcWqCZ6JXrFBJAJcc64uZ08jLnPVQzOXj/NTB3VGHiquBheftR7uwQbXPBQ
         d4gAJ2duBG7DroskZeCa1+9gZP+46fWdYeEoxEPC8/mhgS9SUchPCnn1+tEcLBrmBDjg
         huMBdiF3ErN6RYMJkFguOvNZE8QIiwM00QIUE74Kn/G2llNYVwpqHq9dgXpWw2eEVR6f
         zxYA==
X-Gm-Message-State: AGi0PubKLZoriFtkVmn1m5T6+rCfaIlfCKZomUI1OGy9qRKUNDtnm1mx
        s+jgVPmNHpewoqkf5Wpbvn8E7SktoZc=
X-Google-Smtp-Source: APiQypLuYNtpTNJHA0IOeHMEf1VRgthMQW1YtudxqKg0DroPVoU29gGhJIY/wxTqvcHG2I5mRCOSCQ==
X-Received: by 2002:a2e:9acd:: with SMTP id p13mr6006808ljj.131.1585552973499;
        Mon, 30 Mar 2020 00:22:53 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id k4sm3734167lfo.47.2020.03.30.00.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 00:22:52 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Ashwini Pahuja <ashwini.linux@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH RESEND] usb: gadget: udc: bdc: Remove unnecessary NULL checks in bdc_req_complete
In-Reply-To: <20200330060805.GA107017@kroah.com>
References: <87zhc0j2qi.fsf@kernel.org> <20200329011246.27599-1-natechancellor@gmail.com> <871rpb4nd1.fsf@kernel.org> <20200329144703.GA9720@ubuntu-m2-xlarge-x86> <87mu7zdsc7.fsf@kernel.org> <20200330060805.GA107017@kroah.com>
Date:   Mon, 30 Mar 2020 10:22:48 +0300
Message-ID: <87pncu2to7.fsf@kernel.org>
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
>> >> > When building with Clang + -Wtautological-pointer-compare:
>> >> >
>> >> > drivers/usb/gadget/udc/bdc/bdc_ep.c:543:28: warning: comparison of
>> >> > address of 'req->queue' equal to a null pointer is always false
>> >> > [-Wtautological-pointer-compare]
>> >> >         if (req =3D=3D NULL  || &req->queue =3D=3D NULL || &req->us=
b_req =3D=3D NULL)
>> >> >                              ~~~~~^~~~~    ~~~~
>> >> > drivers/usb/gadget/udc/bdc/bdc_ep.c:543:51: warning: comparison of
>> >> > address of 'req->usb_req' equal to a null pointer is always false
>> >> > [-Wtautological-pointer-compare]
>> >> >         if (req =3D=3D NULL  || &req->queue =3D=3D NULL || &req->us=
b_req =3D=3D NULL)
>> >> >                                                     ~~~~~^~~~~~~   =
 ~~~~
>> >> > 2 warnings generated.
>> >> >
>> >> > As it notes, these statements will always evaluate to false so remo=
ve
>> >> > them.
>> >> >
>> >> > Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for Broadcom USB3=
.0 device controller IP BDC")
>> >> > Link: https://github.com/ClangBuiltLinux/linux/issues/749
>> >> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> >>=20
>> >> It's now in my queue for v5.8. It doesn't really look like a bug fix,=
 so
>> >> it's not going in during v5.7-rc
>> >>=20
>> >> --=20
>> >> balbi
>> >
>> > Thank you for picking it up. It would be nice to see it in 5.7 since
>> > we're enabling this warning and this is one of two outstanding
>> > instances in -next and the other one's patch has been picked up plus t=
he
>> > patch itself is rather benign. Not to mention that I did send this pat=
ch
>> > back in October. However, when it is merged into Linus' tree is
>> > ultimately your call so I won't argue as long as it gets there
>> > eventually.
>>=20
>> If Greg's okay with this patch going in during v5.7-rc, I can send it as
>> a fix, no worries. Greg?
>
> Yes, clang build warnings fixes are valid fixes for the -rc period, and
> I take them into stable where needed as well.

Thanks for confirming, Greg. I'll move the commit to my testing/fixes

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6BnkgACgkQzL64meEa
mQZTfBAAsICVocPOV4FHNqbsoY4Tx3EZ+KwylNUGsG5xO7kz0niqiJxEPn02IDEw
jkdJarhk62P68V+U11jxFyAj7Y/O1jUzpbn+NfwOZNv9q1i6gzyQNcrwfOK/zsL7
eBFOeamGdMbERRKEizBWbwhS8aRtf9F2lElrcKwkiQRkWZSnwh4vpOzELOzjeSSG
IbSD9KlTuIZIUcb5TGNKpidb3KuK/3byH1OwJRB9S4JuEIDZRKrMOR738tSFrn+4
X7H26jDX+bhD6rxdx5PxRdMqLi7HxLLM4w2Ne3WHDGtCip8SdMzUn+E0RiPRpzAn
OuzOlitJN2qI/e/Zr2d97RAYhDiZxHR2RCj2ZmjCyFkGUCXjKLiFf3WaY3TLfFE6
/po0QSqQ7iZWVLw2nby6QSzQfxDTm4xvtkyRUfjHg2EzDwAFZ42SndPHW8wFsod2
p0sYAPGK5SWbfTW4uRGpOO5R12CrmI9RI2f7c8wAHY3yVzO3GyrzhXec/OxcHpua
QKhF0ems5MrRyMokZU5GT4Rxxd0wrHizphp0/XIjzYfEiKPQ1thzpLAVDfIsy4RV
XcuMuy/Jg0I2/e6TjvX4jd5Z/sJMOmekl5B5qJUo3/cd1NK75oBgmoT2SnKnq2TV
Uxbqg9hiubkOg1awIybALVoBbANeFV2+n5wphJzOtKHHc0aROuQ=
=Dde9
-----END PGP SIGNATURE-----
--=-=-=--
