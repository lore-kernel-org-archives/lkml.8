Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F298DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2232080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595331136;
	bh=wPDosbxIVdat8N0jUKxbUwItR0sOdNTyG9MjJP9QXVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=O1m1FaGFwcjep4xOeEZE8LZeygGex8TYi5HUBr+sttykSHKfMydPwnJDAWQlfK8GE
	 XluwYq/R8KmisAx2Rp6up2FmPv8qYZRTo0lehXgUOZZhiCyRCtwQtY42EsBLiI8+7V
	 tSEVTNxEOq6TYnOp1OLZSxSNH/AXhSgu7fyhCwbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgGULcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgGULcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:32:14 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D874C061794;
        Tue, 21 Jul 2020 04:32:14 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h22so23659958lji.9;
        Tue, 21 Jul 2020 04:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hvBHByfuN4VYEKY+y/yvJNCDmWONLf8OUqOSVrmh4Q4=;
        b=MGipDunY1c1w9J7bbp++6aGSvcXbN4qzm1hj5wdbM4Tvy9BDJrzitpV/pEaNkPI5HO
         p10+qclaXvCngz4o/38MfLlt76Ax7RgT63bL1H2BZAZp8pkZMQwoIFNidpQQ3p73hxlm
         N5nPQorpjmUbnUHTAalkXukqbQ6qCUjW/Tr7ZUi5iuLN2k4EzHNClREOekUYyTJO2VQc
         EA8E3RiwFi/h/5JRXm44re0gx8mt3OeAYscQ3PJIy7/GC4CEYmGufD5bHLEjPw5ta4/S
         pTu3DMsEdgevR/1RdrEXq302P+yrV+krAee4eVb2D0SEzcnUPnycLfi8Jv59zIV4TXPC
         IJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=hvBHByfuN4VYEKY+y/yvJNCDmWONLf8OUqOSVrmh4Q4=;
        b=IVlacHq1YDrOBPHy1tcOh7kXxgEzbiOmt+KcZk6/n8OmVMmDqN2goH4OPxrt477CLp
         sayWAfJdMBQhXUbKOwtvjjGUljoyKnW11/xcpjyjXGC+ppc+zlr0lYdM5QapFBRjW2MK
         9nIv+PQu20f3mTbZVvMraHpNaAZt7pp/YC0gmyc+2QKWBIZkRR9pyn6vSW71IzJ3Hrux
         NL6JI1QGU6N/IIGgJa55ZHG3N7BLZ1bTcgCOiVNyIRMF9lcvVDeW4rHsNJSAA04nRkmN
         DsnKCFYswJT+dcG7DB2+SXxRKAVemHY0jVthnqpZ5aeLky6af/RYwWEQuc2Lewcd4Ftk
         j1Fw==
X-Gm-Message-State: AOAM53305flbFvltkaQ25YGmzx55ssg7HKgXj2VFE8DZU9PCoO+uvxDe
        aYiAV98dzeCy10y8j8d4odM=
X-Google-Smtp-Source: ABdhPJyYSOylUhpvpY66H7g9H8of+i4dnEuzb6if/mlO0vzJWxnMDWB1Z1US6G3nS8tjTbkUTDZ5Cg==
X-Received: by 2002:a2e:9003:: with SMTP id h3mr12861735ljg.191.1595331132934;
        Tue, 21 Jul 2020 04:32:12 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id h21sm4321302ljk.31.2020.07.21.04.32.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jul 2020 04:32:11 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Lee Jones <lee.jones@linaro.org>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCH v2 1/8] usb: dwc2: gadget: Make use of GINTMSK2
In-Reply-To: <5862f649-8058-7e39-cb43-2a4b09303333@synopsys.com>
References: <20200715093209.3165641-1-lee.jones@linaro.org> <20200715093209.3165641-2-lee.jones@linaro.org> <566f2d65-1b5a-ed2a-f33f-516b66be2624@synopsys.com> <87blk9p5ia.fsf@kernel.org> <5862f649-8058-7e39-cb43-2a4b09303333@synopsys.com>
Date:   Tue, 21 Jul 2020 14:32:07 +0300
Message-ID: <875zahp0i0.fsf@kernel.org>
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

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com> writes:

> Hi Felipe,
>
> On 7/21/2020 1:43 PM, Felipe Balbi wrote:
>> Minas Harutyunyan <Minas.Harutyunyan@synopsys.com> writes:
>>=20
>>> On 7/15/2020 1:32 PM, Lee Jones wrote:
>>>> The value obtained from GINTSTS2 should be masked with the GINTMSK2
>>>> value.  Looks like this has been broken since
>>>> dwc2_gadget_wkup_alert_handler() was added back in 2018.
>>>>
>>>> Also fixes the following W=3D1 warning:
>>>>
>>>>    drivers/usb/dwc2/gadget.c: In function =E2=80=98dwc2_gadget_wkup_al=
ert_handler=E2=80=99:
>>>>    drivers/usb/dwc2/gadget.c:259:6: warning: variable =E2=80=98gintmsk=
2=E2=80=99 set but not used [-Wunused-but-set-variable]
>>>>    259 | u32 gintmsk2;
>>>>    | ^~~~~~~~
>>>>
>>>> Cc: Minas Harutyunyan <hminas@synopsys.com>
>>>> Cc: Ben Dooks <ben@simtec.co.uk>
>>>> Fixes: 187c5298a1229 ("usb: dwc2: gadget: Add handler for WkupAlert in=
terrupt")
>>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>>
>>> Acked-by: Minas Harutyunyan <hminas@synopsys.com>
>>=20
>> Should I apply the entire series or only 1/8?
>>=20
> In this series only 2 patches are related to dwc2, which I'm already Acke=
d:
>
> [PATCH v2 1/8] usb: dwc2: gadget: Make use of GINTMSK2
> [PATCH v2 2/8] usb: dwc2: gadget: Avoid pointless read of EP control=20
> register
>
> I can't acked other patches from this series, because they are not=20
> related to dwc2.

heh, I saw that after sending the email, sorry :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8W0jcACgkQzL64meEa
mQYkNA//SvFqXwJajGIbMxt0zxlYlwOUMXjMJAoVSgOROAwJX1x/7BU9NfjuPv1C
Ndy4KfZIOKX/QZVpFbVSAtK23AE5nS3dtPLuP1xhpX6ZDu6vKkwfRuXHPlotTx16
Na9Xq1u2sh9FGa1HeeCEwWVTad672OOsRuqA3ueS+K1bU3GjgbL/dyKcp435CQeP
oLw45QRIWWnOhmc+I1cs0dON4Xl6mCQwX+j7T3ztGUSLXjs8L+DOjBdo/ACBAdTp
yJuvTETyDU11uuckNRywwAxAIdw0AxypK2gLInoYGdyLhxrvE4STtMIF5MT4Ts8J
jnzD2ddDKLRS4mw2vpn1iKqKLt65loqJg7flcSAfV+wmcDIDpLOjWq5iYWl2Wto+
iTbAZO9PQnWVrPtIB7ghVfIG0d/QYxOphGHBnVhrNPq6g0F0ZmHG7KipWUMXBcbQ
v8pHE5cSh+R6SiWt8Exif0CeApworGdYb7bm8Cwe1pNSGWnjzzwphK1Dz4CSqjVI
PE30gykBihvQD+pR3I92HidcLDzDlMKKp8BHwYqzthdNg+TPQO3sWanucJJGCQno
FeGpLOiOX/8/TmMWZxILr+MEBsq8DI7ByxkQwqlqjXaRuVCFvQKQ5KBhSCpKlgOQ
ve/gQG2kHf2q35Kj3VhW0YYznwZv+zufDws7NJ2jvgLWSo9H7XM=
=Tbrc
-----END PGP SIGNATURE-----
--=-=-=--
