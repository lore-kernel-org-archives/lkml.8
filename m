Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C764C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 06:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FDC2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 06:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595657801;
	bh=V3vTRFEUEoZaKR7jDFcqDT2SAFuHU76oT03wlCmId5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=qgsVrSxnummkuVjmHHlRn6DplzTdbW7hBUEF7imMeIP45ryUNAU8d9JKermtnJHwW
	 ZJVxX6b5XLlodYjx197YCSXKsRNViEWYmMAVbpZKskfQw5gy+ZioFB6PnX+6JJfAll
	 Vc4/4Vsb0YRJCHtn3XR+sNrDM8d/8DvvRBNSGGps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgGYGQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 02:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGYGQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 02:16:39 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A45C0619D3;
        Fri, 24 Jul 2020 23:16:39 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h22so12084952lji.9;
        Fri, 24 Jul 2020 23:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=V3vTRFEUEoZaKR7jDFcqDT2SAFuHU76oT03wlCmId5g=;
        b=Iu2Yvkg2dkJA47Du223ubB4YBbK6Rgnt0ZjsrWXet5RjrSTqjbTOJ1sictAYLWaq2k
         4Q4kACJwbM7ip0Np7SwfzKURRD7bSAY+HG3X28m0hc0M1RmmjbbQTUAv2+zFmkyVAM77
         PDHaH9i5anv03RB+o9riyFg406CdtY/JhyOn/41xAVx+i9BfA1lYXjla9vVt40cnkjMI
         6Vy9lrotkOpXer8mPbfW8v5zpcIy+ksM4vrZzu4sASnkfxe2JBllRv6I52dEPz8aUk7r
         B6l2kryOmehejCpV63u16x9fU77SgZOdV5JuwbdNERDaEGezVuAG2o2pjRwcAA3Le2rC
         lKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=V3vTRFEUEoZaKR7jDFcqDT2SAFuHU76oT03wlCmId5g=;
        b=jVGF87ldiPkgeL0b+VuHIR1y8JAXlTLX4qltJ5v8usc52oJfRDFBTZvt99SSYSlxfz
         USw60DcYSaB4b9eVGykb89KpgW39Za26Jfwje7+OYeK2Kq4XdzbehsiayZ77XzsX79AP
         Ra52UDsncG8yrJ1QfL434Hz9VlEg1cWqGgQghLpM3I+2pxHYex3zG0Fi1NlyzgUU323Y
         ag73dMQutPiD/7YRPYyAl/P/jftP/2qE2cpGqK3wVyaqZHMZbRlfwoTZFk36Pw+yNTjn
         3WdKxo2xyAb/0st6kv8KfL86cVyQ1/Nrap8C6dU9017N+1Fj7QMN+jK9giqgzswIioaz
         DEKQ==
X-Gm-Message-State: AOAM5306AYYuFBE2aDAFLt0fQ08xdvI/+M+uvzeiPqH5K1CmY3+qAxEl
        JoRLYXGBMpKjNwF+ohsk1bs=
X-Google-Smtp-Source: ABdhPJxdI0iiW7gu6mAaLaPT4Rz8TBcNkmSzrmTrsBFK5xAbAcnE5IKqLnX7DGdJS8bkUZY7ri8GBQ==
X-Received: by 2002:a2e:8855:: with SMTP id z21mr6033981ljj.325.1595657797843;
        Fri, 24 Jul 2020 23:16:37 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id 5sm974236lfz.35.2020.07.24.23.16.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 23:16:37 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, kishon@ti.com, vkoul@kernel.org,
        gor@linux.ibm.com, hca@linux.ibm.com,
        christophe.jaillet@wanadoo.fr, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: Re: [PATCH v6 3/5] USB: PHY: JZ4770: Add support for new Ingenic SoCs.
In-Reply-To: <20200725035159.31231-4-zhouyanjie@wanyeetech.com>
References: <20200725035159.31231-1-zhouyanjie@wanyeetech.com> <20200725035159.31231-4-zhouyanjie@wanyeetech.com>
Date:   Sat, 25 Jul 2020 09:16:32 +0300
Message-ID: <87r1t0nmpr.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

=E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeetech.com> write=
s:
> Add support for probing the phy-jz4770 driver on the JZ4780 SoC,
> the X1000 SoC and the X1830 SoC from Ingenic.
>
> Tested-by: =E5=91=A8=E6=AD=A3 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Co-developed-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@ing=
enic.com>
> Signed-off-by: =E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@ingen=
ic.com>
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>

It would be better to move this driver to drivers/phy before adding
support for new SoCs. We want to remove drivers/usb/phy/ in the near
future, any help is welcome.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8bzkAACgkQzL64meEa
mQYA1A/9ElIcBD92xlRYIUAJUg81tbMNB9xKPczktaV0wQYobcZsgqevWDLlYeXO
A1iurvM9vUh3SUnPL7+oOxbXhO1zZ2OHPICx6IRNG3ObWTLE/E6jmtKE0B3AjH85
g9/Mu0ZSt1oKYOUmJzDqTmerh2V2vaeNmoi+fP+FuiVfceeFCdVTPThQTAtup1eC
WL+eDPwWKi413esTn71924ArCu6LbKr+LbVDlGp6mYxNGlqVQE/kBiWiN8xah0ji
oTHvsOryW+9lA+ZUnRpCIpJ+sAUfJwsCOI9418dbUk77MaDi62w+JSa8A/1258n4
3JfYepOWxeUIiMU2E4kZAUiBQ1xpaZC8lzT8RIc5xrsD2euvmjZFoG3DmtGAgUIc
PO/gRgwn+eeXtEPL+wic2zAVzKGitJr6p2OG2VS+64vu0C1qPlDqgkYD1fVAWw76
HGMOPUVIKRapAvupKpRoT3cFRobE9bVLRIZI11LH5sgSoKqTohd56lMvH120GrRL
wRqiJ29erqbgvSs1VjiYH1QbOkzRSTyvGZJGC755+sRTISs/Z9AwKBNGxkd9q9nN
j2+OZlwwBD0lu9ZwlEaYaCcYXroCZ3C8yDS9K8KfUstw8WGdy8aEd3wOXYRkbDcO
71tiA1VqAMj1ihgwkDfCiB/w15ja8M6l/aimur4QH6aBF+J6cyg=
=AD6h
-----END PGP SIGNATURE-----
--=-=-=--
