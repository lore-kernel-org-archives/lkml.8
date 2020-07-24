Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD320C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B1220674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595607403;
	bh=G3jgH9IJtnDPS4GzMfQzYedGbY2dUDD4L8Drje8NRlU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=uH/w3gVkW77dTKFV52d347+a6au4F2wWLrMxiMYEqeNZFkbK3z1/QATtTtYoL2nOG
	 p9EHZywq+8+aZL+Ekde0GUB73jNrXCJS+M9JABVhmX6tguwV2Ki/rKW0EiIZvsyJr+
	 xvbWEFdNkImtnY/gXEbmJ3TEdurkYQyNrORZ/Zy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgGXQQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgGXQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:16:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05514C0619D3;
        Fri, 24 Jul 2020 09:16:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d17so10546673ljl.3;
        Fri, 24 Jul 2020 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=G3jgH9IJtnDPS4GzMfQzYedGbY2dUDD4L8Drje8NRlU=;
        b=nrUSmfpaTpszweIRHhqWJLQQZtbutSiCM3PQrV1OkVvq6RfvffjRE1yf0vpuGKHaJH
         GwbC6/ZnQJoUwZ5oss1A3GDiGgrViVQydfS95yWJjFzW26+Z78e5ixZr2r45JXwe5Nue
         Qx7ULKX0G91/kYXx5WyUZXGgO8tBIUuq9vEKXvR9QvQUNhJIO43nxaEUtUmvwRrYtM0b
         zbADhSwV1bbaYEtEs5FfIHr+gnkzeYd5k9fgY5N7ob9S80HD8SQPWHgfcjukumtj+Cky
         OSp7+V1WEu9ga05UIEVmoCY52dhnmRxE27Q2NFqvlBLz34SML1A0oXul2I0Z6X1oF3i5
         sdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=G3jgH9IJtnDPS4GzMfQzYedGbY2dUDD4L8Drje8NRlU=;
        b=gpmtjPQA/UezREMhEnzIqGxv4jHWP7bsjeZShucx2AVOfpZIOuz1i5PK0ZXygAXZP5
         FBHjYTN2CMFyNseMK1ZyilCv97uZyyEC3j2nvxXaDjNjTehTF5j3j7p+OzZKx+Wz01lv
         wmZY5yIqU8l978UY3pwpJgXaCl2Wx7DIpGHnNXf+IQTx0uFDu/soYF89CoyeknO4fvZ8
         2qxPU+DMhwyfZRdYJW0k9fIsAFuDjIN4rf8sYoOrE1a4VR4NKHyQqmupyeVyh7KNdWC3
         +P1ftzZFyZkukgoyjQTQ/9CiwVDViixQ8k4+Qd9FwoqxwDv1Ult6P3W9EljAAJKVLyON
         yGYw==
X-Gm-Message-State: AOAM5301ahZRfu/y4Pr+wFU1wnI0epQsXxWxMWCjWK1ffrZJb6b/NtYK
        RNVSZAXwWXhFGH/MVC6IeII=
X-Google-Smtp-Source: ABdhPJzZZxJFgz/JhY1AQxrSNFLKjFlzqxRkySRQt6pWYKe77616ATr0A1ybIV2h7qX8Q8N/3qdvRw==
X-Received: by 2002:a2e:960a:: with SMTP id v10mr4860375ljh.223.1595607400472;
        Fri, 24 Jul 2020 09:16:40 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id r15sm335077ljd.130.2020.07.24.09.16.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 09:16:39 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Amelie DELAUNAY <amelie.delaunay@st.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Cc:     "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32\@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 0/3] Add USB role switch support to DWC2
In-Reply-To: <fcff5f96-8383-fd84-35f1-3eb291cd65df@st.com>
References: <20200724104711.5474-1-amelie.delaunay@st.com> <4c44f596-d2c3-6d2f-bf28-9e3964b6e6f1@st.com> <878sf9owcw.fsf@kernel.org> <fcff5f96-8383-fd84-35f1-3eb291cd65df@st.com>
Date:   Fri, 24 Jul 2020 19:16:29 +0300
Message-ID: <871rl0q46a.fsf@kernel.org>
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

Amelie DELAUNAY <amelie.delaunay@st.com> writes:

> Hi,
>
> On 7/24/20 3:50 PM, Felipe Balbi wrote:
>>=20
>> (no top-posting, please)
>>=20
>> Hi,
>>=20
>> Amelie DELAUNAY <amelie.delaunay@st.com> writes:
>>> Series dropped.
>>=20
>> what do you mean with this? Should I drop all patches related with this =
series?
>>=20
>
> As v1 patches were in your next branch, I've prepared a new patchset=20
> which contains fixes, on top of you next branch :
> https://lore.kernel.org/patchwork/project/lkml/list/?series=3D454959
>
>
> What do you prefer ? Drop all patches related to the v1 "Add USB role=20
> switch support to DWC2" series and I send a v4 in replacement or keep=20
> all patches and wait for new series review ?

I've dropped those because they caused the build breakage :-) I can take
a new series, let's take the opportunity to avoid the build regression.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8bCV8ACgkQzL64meEa
mQZc7w/7BbjxTemwrP+zsnhES1GyFOmMB+RtZe3AKqd2aNcuD7rhQAPH2At/2pfK
bVw4evguMHwzuyeHPw/3p6wy0udW/NGnxuqNR5TX+fQaydDlp4MFJj7qLK7zRpd1
b7cYxDKXgcXpI4rMORF6w/6rOdcweTGRlTZJ+Jk8/I/cee+JB7ZmQbqwvAr2pURP
AE6tu8v8jzcguyIm7IC0vdvTigkdQGTrNp+qmrECbf+gr5TMvvY8CYRIwmgz312O
8Xqc2GzEm02HLK2GxZDTl31ImnXO8sRjCkkZH33BOeMka6+Jw4PqrGVj7zIGG5zG
uxal+yZwCub2JfEPo+sVP/GbGg8iHzMeoXzBwDPHbGyvCizRqrRfUoRiSVav6Yy+
0dtrs3vcOwnvHIo2frrxei7PMV5U/AqTNmhBik8eRr0U8aFwf2i/2IeJAZt+te0p
z5t9wRGPop1RzMtai2jCcvxCA0e/tX8exBXB7+0UuuuPPjWBIFYSSbhqovYiyk1G
CRbk5L4Gw4Kh8OLJzmXv+O4Awpf5PsPt8VmoWy2SVyMxwPPBiCyklwtiVYt/TpAZ
Tsw+MnaT1USiMoluo3LLzpNLFp6p1uqgKaJGEVoLBeI5czoFP9mBdEAkUGx0Z/Zl
HUDcXMpUkSydzN840QymcMm15u0etdm9IPdA3cwW4LZxhwEGtjk=
=JWEE
-----END PGP SIGNATURE-----
--=-=-=--
