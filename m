Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22ABC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D902053B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589452849;
	bh=ADFIiIM1Fe26/cRjvae/xxSYwcERBybNKGMvOKxuFr4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=Iw/HOAcN+QtcGGH6TpSnxjpVPA/71J/Vo8/WwLwoJxnHlvjP/adebM9OHay8w5wPJ
	 RvqUPsBrYhTU3jiOv8p6CRT0hbs3Yiuztxu5Sx5mF1jog4HgH2EVN+PUTsUa08sF5O
	 c/YjKOkVSapmdxzUBQwiPFgonHYix6cHQVVVwcg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgENKkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgENKkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:40:45 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBF1C061A0C;
        Thu, 14 May 2020 03:40:44 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so2971295ljd.3;
        Thu, 14 May 2020 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ADFIiIM1Fe26/cRjvae/xxSYwcERBybNKGMvOKxuFr4=;
        b=bcftHwObq2STzO4ObxkD57BKbGME8uRmzC1DIuh1WNyRkLm+RpMqlj3oJPYjCecTdW
         qeixtywBTxIDWfCvWYfh6os9aQTjruOLHMxBvxna9zosjgHtlR1/HY7bSv6sut/GXHX/
         pvBhPQC5M7xC+15QOoDF3w/ZH6a+Q5ovj01Yfxu4WBSwXYK/8LH0K0nuDiZBTb1GM2Op
         kut8C6pqAxf65Gbn1I1gPekBSdzo6C9L843PuLCd0XUjd5VwwJ4mXYVJRxyMNgSNo2xE
         ft3y4XmwxVLHPMgkYWzu8iztz4kyeJKaUSLTK9qY4Wctvx+DlxXKnwfKcOQXZdBCBvpa
         3OlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=ADFIiIM1Fe26/cRjvae/xxSYwcERBybNKGMvOKxuFr4=;
        b=b5dEz1obOCW315NuUCYtA6851gEfcQ8HLoRH+VrhMUW/wk0llCMMROD5GusiKViyVR
         R8M15biqvnh7kj3tCg0QvVU2QGVObfoJmWfxWQi8xiGGgSCk09+dRjr2vzxO3Yrpa3d5
         W8M5dm7jUMOuu/34gJpX4QlL5OChEbG4gCQ9kWL9nzzw1BmqW8CLFtGSriL2fbCSJAkC
         Hqi1XvQDeK/A6k9S+wWQUead+kMdg0jx5iASy7UksYMK7SePFAAs5aHmcAmQnZpRoEG5
         MOgCF+NIaMHpRmJFfGcJg+gWBzYEM9uZUE8SZn0iamIGF1vRSPGN3YyOtRFQsbJuiX/w
         AR9Q==
X-Gm-Message-State: AOAM531uffqI4NmcQff2Uzv95UmZXF+AVQFS6zkgVj+XL8Go21PvhFlW
        cQ1xhs3ajHV9WoacLNnVv8dnZpuHvXPMgg==
X-Google-Smtp-Source: ABdhPJxSqTSWM74zlVsYXQn6jKwYtKuDk62yq+Z8ixknh/c2vPrcCXyau8zXak4ww5Ml8u8ZzxOlMA==
X-Received: by 2002:a2e:a417:: with SMTP id p23mr2491094ljn.19.1589452842932;
        Thu, 14 May 2020 03:40:42 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id f24sm1534475lfc.43.2020.05.14.03.40.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 May 2020 03:40:42 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        Roger Quadros <rogerq@ti.com>
Cc:     gregkh@linuxfoundation.org, sergei.shtylyov@cogentembedded.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: dwc3: support continuous runtime PM with dual role
In-Reply-To: <d1c38262-198c-c128-f2b7-3253bde37e5c@puri.sm>
References: <20200319100207.19957-1-martin.kepplinger@puri.sm> <cb2db077-0f37-2221-84f6-a7adfd6ed1f1@ti.com> <d1c38262-198c-c128-f2b7-3253bde37e5c@puri.sm>
Date:   Thu, 14 May 2020 13:40:37 +0300
Message-ID: <87lflu4x5m.fsf@kernel.org>
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

Martin Kepplinger <martin.kepplinger@puri.sm> writes:

> On 24.04.20 09:48, Roger Quadros wrote:
>>=20
>>=20
>> On 19/03/2020 12:02, Martin Kepplinger wrote:
>>> The DRD module calls dwc3_set_mode() on role switches, i.e. when a
>>> device is
>>> being plugged in. In order to support continuous runtime power
>>> management when
>>> plugging in / unplugging a cable, we need to call
>>> pm_runtime_get_sync() in
>>> this path.
>>>
>>> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
>>=20
>> Reviewed-by: Roger Quadros <rogerq@ti.com>
>>=20
>>=20
>
> thank you very much Roger. Anything else that is holding this back?

Merge window is holding it back :-) It has been in my tree for weeks:

https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/commit/?h=3Dt=
esting/next&id=3Dc2cd3452d5f8b66d49a73138fba5baadd5b489bd

Gotta wait for the next merge window for new features to be merged.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl69ICUACgkQzL64meEa
mQZ7VQ/+Mq0/5vRDJKOzvBdxMlyHYA9lUQr02QNKN8h1S0qAap4a0JZ01VhuIf3Y
XBALfQgHg0ljjY3THqZ6MjDNEjGPDm8ENsdXInXt6jrwlDucrJxBHTKG8ZBq/brC
WMS5hA/uL1LWywn0ybeNCtuvl8tn3vIV7iNKATt0YtijfZxBt/IP+fd+4rlkEyPk
tN41d1HZo4uh7RNBiUgFX3L36j1yrdadSdnLv383yRmUQoxpdsmsVs3Jp1PHYalb
bIPjNTlgJfyQ8vikb+1/OQSOe4ARIIXkViDeQG4MODjzU/cwiy4spipcwXk7HMQG
VeeBXFXyZyljxddSWGLMHOSmBKl0s5o20ClnjmPGBpDnAsgt96tPqwC6Tb+jb0R4
hpJDVn0MFRpcAk/4plccqKVE9behUXNWHLzyMGuwKkQ8Js/0oNOIw6KW0oUynMnw
3rFvADz3+fct78F7M/zr82adrCtSF7l0gw4WvfpCqImu+59PApGg6ivv+F+ALwkZ
7UDGevdubjw23+8tfZH7muURNJJDMleyl2E0ZDOwHtb/XB5FKVs8DxXSv9zUFEZq
kUx1qbMjze8hONtM3Mzuy4vnpU68K1/r2OdAOtbPmAGbSRZNw9Gf/TPjHi0TVubg
wbs8QRbxrd69glmDuH7pnb5uWphtUItieKQ5P9+Xsq0w99kNprM=
=CQVk
-----END PGP SIGNATURE-----
--=-=-=--
