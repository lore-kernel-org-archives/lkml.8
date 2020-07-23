Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1170BC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE03207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595510067;
	bh=3Ek23uqFHJxEEeEwue+hrOY5RICC7zNWW630xY1/rb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=cjNTARd3Y9PvkSg0F3VzAe+JF8NCb/peWOAASfir7jShlXHJO9tJ7lJSWXYSSGE0h
	 thp3IQq9iwummOPgtyPHAjXKWJI51kgQ5g49mvgDQSi4hKPz9k2p5X/nBVT85/uo4Q
	 oE2rFXqT6BE4ijBQC7XeNG1DVwtqzpBLdPW7VQz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgGWNO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWNO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:14:26 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9152C0619DC;
        Thu, 23 Jul 2020 06:14:25 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 140so3244359lfi.5;
        Thu, 23 Jul 2020 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=3Ek23uqFHJxEEeEwue+hrOY5RICC7zNWW630xY1/rb4=;
        b=V7bQtxEvBfDa1epPg8MKSyuSb8htz+XWa/LX6g3d/Un/JL8tTyiOFxIkG7PGRto5xB
         ClZaSCb/hVxwFgIVzPwosS5OGKeAzVWoeVsS2PAQM4KK3AbWNmeXWnKmOXHQnzlG3J1S
         WvanNEGPTL+8UYKG4GrOCNh6oLT4HDp+g23SGGUvFaJAfRRRF3bPobup7KB7iK2ZSbcT
         24Je8NAP+Ywmzl+AAOqnrIY+lcjJr7r1+tkGRj9Ij8dFZlV9wxmKbAltli3rSiTHKwY3
         cFnYZ3LbMpbZmUMlXY4j8Lg0t6nkw97707IjotndM5OhaJtZIqQF+bAIABXRVfxoymNN
         muaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=3Ek23uqFHJxEEeEwue+hrOY5RICC7zNWW630xY1/rb4=;
        b=aj3xgX7RzorTN3HaPcVA2nbqT1yRSDaukXvq2ELMpOKic3XmiA2bAppGjkcdaJ6nhK
         7jqznOHYDn1lEKIRAAN73ckgOhpLEG79llRDxpyWxq7ndEwtOeOvIfzTtMsozzD2xG9c
         DkbH0Xx0JZB6h2VPxtqfnrXg5huk3EkFqVQn50+qdVG7ko1vj2Yk/s0E57vtUTDOd2fD
         CCKdYAWRr1gNJhG2I66HA/KodwVnjvQrSTN53KWLc8OISHJW3tNVyHEWeHuS7DwDvzNp
         ngw3uheggwjcJf1uAZrFe/t30gKN4plxm5hhMYQ1a17koFWM2bxPqz0uYfDa+Kc+lV6K
         r/AA==
X-Gm-Message-State: AOAM530cypMYGkSlKMucBdO1dn566XI3UsiKSdUFL3c8NCTz6seHbTlD
        TcfLhD/JP8qOQ1d6eOGZeYcYV66I7UASrA==
X-Google-Smtp-Source: ABdhPJzBPdux8+PQZy/lEPbmV5N4w1mTUpDRV1tsFSy51kdPYqJiPU7Sszpu04kX7FE4NkzVgZppJQ==
X-Received: by 2002:a05:6512:2010:: with SMTP id a16mr2205650lfb.196.1595510064107;
        Thu, 23 Jul 2020 06:14:24 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id h27sm2757613ljl.71.2020.07.23.06.14.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jul 2020 06:14:23 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: epautoconf: claim smallest endpoints first
In-Reply-To: <20200629200551.27040-1-ruslan.bilovol@gmail.com>
References: <20200629200551.27040-1-ruslan.bilovol@gmail.com>
Date:   Thu, 23 Jul 2020 16:14:18 +0300
Message-ID: <87blk6nzkl.fsf@kernel.org>
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

Ruslan Bilovol <ruslan.bilovol@gmail.com> writes:

> UDC hardware may have endpoints with different maxpacket
> size. Current endpoint matching code takes first matching
> endpoint from the list.
>
> It's always possible that gadget allocates endpoints for
> small transfers (maxpacket size) first, then larger ones.
> That works fine if all matching UDC endpoints have same
> maxpacket size or are big enough to serve that allocation.
>
> However, some UDCs have first endpoints in the list with
> bigger maxpacket size, whereas last endpoints are much
> smaller. In this case endpoint allocation will fail for
> the gadget (which allocates smaller endpoints first) on
> final endpoint allocations.
>
> To make endpoint allocation fair, pick up smallest
> matching endpoints first, leaving bigger ones for
> heavier applications.
>
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

checking file drivers/usb/gadget/epautoconf.c
Hunk #1 succeeded at 151 with fuzz 1 (offset 85 lines).
Hunk #2 FAILED at 77.
1 out of 2 hunks FAILED
=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8ZjSoACgkQzL64meEa
mQadJhAAqrhVSDptr4TCjjlcBNkGVzrkHDybXlvZSailDiKW/q70ZrxmNxTi6ens
0XphNLAeqG/Hsftc2dczeTzFNZ1tDhGoQ6tUZYnWpkVNT2I4WxSqE0WQlpKL1VmO
b58aBkOpF01ssMNJUk2w+jWN71PggQSqTtRJ9bybtoJK67b0H3eUZZb+oGhpcL+M
ggs6rzqN1/j+VFR9wdosFN1U4xYOkyyMCaY6y34nVoSuy730U7IPaYzifgXRmcVz
Cewi+N0nQOSNfDh2UBsrdIkrRteh6w+0KpOIiJro+2h+V/St7rDmgrDFv6E1lv4c
+9fZ223Lcm/pzkKidOvxxtt4Lnfzx2DFjH0eY+Pg5OaJQtTkEnir/MF6WG9YUn3w
LxcpVb967HCmj69PGG71uh7jtrohJThUZznBldJAjArLtVsQ7S7cN52UAIpRkFxU
8dc71HWo41Zyk8sIsQ7B7i4Nf8MXqSYDsSLzng3rdYecsjzI//aVx4qiTgh65yL5
FqQQQlCtb6+5CP7VGq/LbYCYIzidM+G3+dI/uHyzvkz9C9ZzIyKJcCj6pdPyCAlV
b5Ii/8qfQK2cNobQF5Uuvkj0TYsb9MlTXKtEc97WdtuW6JMIYWJNumQXO0TcU3PL
OvpwviQus8HsX1J86uCpyZvMu2EUqbxBUYSoPWrBVM1/0Z+Zjd8=
=2tO6
-----END PGP SIGNATURE-----
--=-=-=--
