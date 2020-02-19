Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E163FC3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6F72064C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582104567;
	bh=G12iDI2LhUCZNRg2g/JXNpN3EjR4uftaK41vzUZkM68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=WAB1cC5h4La53JQ9ZCyWZC5zSLG09xIsqLXTo6JbHmo5qFg3JERfm0793bBCofQsg
	 Jh/Vi5VgShUAsOzxjGmj5GudtwHl4nRR9eAvMT95wGx9m35tlIUwsGOo9yelD56RmK
	 jh1Ue1jr7MkZwxSTRWHuEUo271k0wREjz5I5k0SQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBSJ30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:29:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41581 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgBSJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:29:26 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so26304589ljc.8;
        Wed, 19 Feb 2020 01:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=HZFrrRqHF9rat2GOnuiaCI6Iji/RxgKMPz38tWAa6x4=;
        b=Y5LeXKpp5r7fYYViO8AaYc3q30M5wQFpYBLiP1mpyGNAR8vZWsRiRKWB8u5py5MkHS
         OUJg33wFQJQjN1TgoaMEe7ZqHqtCyBk5j1HsoRBg0H1fdhd2KTX3PO9xYbxZmgbndKOq
         zX0UIt++ekY7t1Tf/g1JxRddJHba2BTEcAGBzHjPnIWoexQ/9VGGgsHVqYLOK8USLpdX
         a1QpcH4/rtiEsU59mUyX2nwg/w3aCMeoidSgelnmRJMi3LVO8cQY4wVNjMuB973nmlIS
         HhFjcgXv8mfcoSkC+1cIHa3vSFCMr2Kx7pIqOwoJ5Cl/7K3N5XR2nIQTd48CAVgIZwGf
         mOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=HZFrrRqHF9rat2GOnuiaCI6Iji/RxgKMPz38tWAa6x4=;
        b=HLvF7BZP5KQi0M3kV91pTayDco+1DY64/cF3448uyizV6/oaVeMGXyK4430juuk8wm
         QUa98m3PBocS/sqQ/v1njtfdbC05qWsXf/Badq+uFycASoOuIRaU0+I5CSmaRlI5QJD6
         L/WAj3gyBDFr5ai2r+3+eSnY6/wjuRwGSU3dFXuUPB6b/xEEBYyw7Iq31rWIfUtE64IR
         fIBe5xSgLOc+Smj0KBxSY7sg9Z39SMoFWr+auHIeCQuUz3ztkQo9lvpBnDQmXvEgU2tY
         KJMpClkTqTFrV/l7X9k6+f68u3WrtH7UPvbgGqyUHvg5TkipDvgB5nMq2csKTo1YuKLU
         /vZg==
X-Gm-Message-State: APjAAAVjc0bXZvh4/G41lFcdljq279WtswYAvcgAcgmT5+Mq9y0Xct1S
        NhbQUo7DcJzEOFBxCst8osDF/t4OGzWiLw==
X-Google-Smtp-Source: APXvYqxS0LzmXyXKA4GbjL476zZyOb9KE1NEr9/OuxW8DYtt5IsPCcs9B06k37RqEUSg4RdFzn9doQ==
X-Received: by 2002:a2e:9a01:: with SMTP id o1mr15728068lji.247.1582104564057;
        Wed, 19 Feb 2020 01:29:24 -0800 (PST)
Received: from saruman (n1mlnpstvlzwon2u5-3.v6.elisa-mobile.fi. [2001:999:20:4c34:8cff:c9ae:6619:761d])
        by smtp.gmail.com with ESMTPSA id w16sm907410lfc.1.2020.02.19.01.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 01:29:23 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>,
        Jack Pham <jackp@codeaurora.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Pratham Pratap <prathampratap@codeaurora.org>,
        Yang Fei <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Update chain bit correctly when using sg list
In-Reply-To: <CALAqxLUSU4j3G6zBsxeOanF2A4fi-Q+JKu6FVDXOwAzpnZvWNQ@mail.gmail.com>
References: <20200218235104.112323-1-john.stultz@linaro.org> <20200219000736.GA5511@jackp-linux.qualcomm.com> <CALAqxLUSU4j3G6zBsxeOanF2A4fi-Q+JKu6FVDXOwAzpnZvWNQ@mail.gmail.com>
Date:   Wed, 19 Feb 2020 11:29:08 +0200
Message-ID: <87wo8jexi3.fsf@kernel.org>
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

John Stultz <john.stultz@linaro.org> writes:
>>                 unsigned chain =3D (i < remaining - 1);
>>
>
> Personally, I think doing it via the conditional makes the logic a bit
> less taxing to read/skim. So I might keep that bit as is.

I agree, it's easier to follow the code. Compiler is, mostly, likely
optimizing that anyway.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl5M/+QACgkQzL64meEa
mQZZAw//YsGSlNz2yYAKVFlO9oc25EiJHkiq8is+Uj4foszgdSp6klWZ3u4+aGC2
7/QuuPR2Ah/+borQ5bqz0dnxzClgnJdhn10JYoEp7P9b0C6y31NH5GMHSH5bxaqG
mR3wgVIYqKW/LAzhxxAXdm0PB8mroa+lhS8oBqV5zfZbg611yKWbqlcFX4Emxt8k
wcD+XvBooE6JZA71ub4tnZoAmz02Iz5/d7oOM0ZAh0VVAc+rlnlhRhULrjg+jmpO
nzEXxBx0GU0lMz4TnJhgd9uL4J1NTGDNxHaL1DpYyhw0VCu3xmw8MNK18dagidn+
8M68rg83uDNcOSbX32aiA9aKVUS3M86FyWEY+CVccDR/FIGR3v5wbKOpjGkFE75Q
0xeeTQTfFt3dO8K1H6avLNwFXV7ui8vMMK0XWeJEfzpSX5hPUy4bKqlRkRJEp9M0
ivTKdmI/kicJ8BpyA5M4abaPGc2zx2uSO34cYvCPHUYKfmytq0UHc2lwZcx+5UPG
Zhq9sWCylk6CK4s1deu9Zm8WcGi77fY4jEKHMqF+aNfnRxZb8y1fXi4aN7Uh7F6a
UAmROWWXkfCNPgzPtlSLMURNmurD+Ylc7vC6HfvGRHnVKH0Ctc+Gdat2FcwEM/N2
LZoe/xUPVQxWIsvQJDyWQlXkm0uWyZr+yoY40zWxtxBfbRvRO/g=
=chJF
-----END PGP SIGNATURE-----
--=-=-=--
