Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFA7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5680020771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595324646;
	bh=dRBqRpPHLqQ+YiVHyYwy7/iduBS4RS42lBSIgjREvkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=ZpLeuPf7x/SJlJzvDe8Wjy5oDmrvMBeEmYwVWKRbDd+4MV6JI3f2ee55i1LE76byB
	 MCNnbZNHQqXbZw10TdqKQHy2NYcsSwV1mEJp306rWlH8vZ3EmQGEM6xAkvmUm0vv/l
	 wJlIAdHja8QaA7r9AbbrZ7i3GiNlWw8cXXg2zK5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgGUJoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUJoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:44:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661B6C061794;
        Tue, 21 Jul 2020 02:44:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q6so2346748ljp.4;
        Tue, 21 Jul 2020 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=4B4uTKaYVVIs2NUU7WSS3PrxtkG5yE1ho1vSzkWNNJY=;
        b=pdJRleq1eaXiymciRCaJyMpEjyPf0ED+Y0ls4trEfLYY1pCXRP0dEAYl7GKpTZrGN5
         4GCC1/QU/PadIe17M5/f5otVVm34IdsMKlFm0E53OJ7M/CMFib65tcxSgVcwPbY669Tq
         8ffyI9mQksGVgB9Mh2FJGtMdH0DRHXCI6GQGp3JL3k+bOa5AKg+Ww3F7MPO4prHB+Jl2
         Gy/ZBuJKzVJ2p6EVq/HKKEKesmnzGdFI5P4H7gfxBOMgydhnzEFXTglpA5n/nhtz+V81
         cZSZl1i31a2GiehcPueTGiGw+nYK7dUYaXhwXVWH83GmBnPWKRNoxtayXR2kQrU60a0w
         vXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=4B4uTKaYVVIs2NUU7WSS3PrxtkG5yE1ho1vSzkWNNJY=;
        b=uZFeVN/WTEr6f7t7z0YJvXzvANQFZgIS0hwc9F0EPF1oat082YUBowKF7JjTPMK9zU
         smcMC/tsG4HQ8ju06Yuc1VXRSgsEkdp2pLlCFnznN/q43Fb0WIhuaeOt6zDGcwCmBMEm
         tt0Wobv3v/QOpgzzMcUKJ2UR/93oo0Hw9bjS5XuFY0Vq6Ah2e3ONEFif681AHhXIU/8V
         IP0NpeafpFG9NULQvCQpU0X+ijlA2VZtbdaC7hv3jfNKlJOle1b1r4FnvMBGPlob3AMR
         TLo3TXp9Hu099Ea8hRgNA71JeDCeksFUKBc3MzbwTqNRmfZVmajsxvbdDZ1+Lm9mVgfu
         xE0A==
X-Gm-Message-State: AOAM5306UMv/DUUBnf54K896/tFmtiNGDhKJHxfRE4S75FTGyMAYPoV2
        4pHcD3c8WMgDWKv1qeFCzaHCfj4aqMTgLA==
X-Google-Smtp-Source: ABdhPJzhA3jW9y1U/VHRqB2+TAhq8vBgv7fDywrgkTgJmnvYz3ND+eXb6bTGt9vwJhd+hEJYMucSKQ==
X-Received: by 2002:a2e:8597:: with SMTP id b23mr11438006lji.338.1595324642702;
        Tue, 21 Jul 2020 02:44:02 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id r22sm4192790ljc.25.2020.07.21.02.44.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jul 2020 02:44:02 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Lee Jones <lee.jones@linaro.org>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCH v2 1/8] usb: dwc2: gadget: Make use of GINTMSK2
In-Reply-To: <566f2d65-1b5a-ed2a-f33f-516b66be2624@synopsys.com>
References: <20200715093209.3165641-1-lee.jones@linaro.org> <20200715093209.3165641-2-lee.jones@linaro.org> <566f2d65-1b5a-ed2a-f33f-516b66be2624@synopsys.com>
Date:   Tue, 21 Jul 2020 12:43:57 +0300
Message-ID: <87blk9p5ia.fsf@kernel.org>
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

> On 7/15/2020 1:32 PM, Lee Jones wrote:
>> The value obtained from GINTSTS2 should be masked with the GINTMSK2
>> value.  Looks like this has been broken since
>> dwc2_gadget_wkup_alert_handler() was added back in 2018.
>>=20
>> Also fixes the following W=3D1 warning:
>>=20
>>   drivers/usb/dwc2/gadget.c: In function =E2=80=98dwc2_gadget_wkup_alert=
_handler=E2=80=99:
>>   drivers/usb/dwc2/gadget.c:259:6: warning: variable =E2=80=98gintmsk2=
=E2=80=99 set but not used [-Wunused-but-set-variable]
>>   259 | u32 gintmsk2;
>>   | ^~~~~~~~
>>=20
>> Cc: Minas Harutyunyan <hminas@synopsys.com>
>> Cc: Ben Dooks <ben@simtec.co.uk>
>> Fixes: 187c5298a1229 ("usb: dwc2: gadget: Add handler for WkupAlert inte=
rrupt")
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> Acked-by: Minas Harutyunyan <hminas@synopsys.com>

Should I apply the entire series or only 1/8?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8WuN0ACgkQzL64meEa
mQacAQ//a/P5SYnBnlVVnSmY6/+H5xaTyA0frND1g+cvwxNLc8oWt8WK97bow8mn
gHNkRsPUfur72sCbsHhbOczv7Kc2ea3d+0KJNTv0idAgr8zUG0we/lYewX7+YCDc
x911DeDk19uqC84Xbt9LmC9iBJbqPA+IlzckS2CwunqNws57n01+/p+txsNOEwXc
EfCJBfEljT+W8u+yoeAu2FDdL3etFHZuIEE/aSLYC5qTqtM8dnUcoci0NDb3J+If
uhJ0U0E8S9u3D8vGaL78cZHvMCvY6C4NLj+CdwkTFIGh3wx0uYSyOGnvrd2mlupS
UV0oUqJj6vqDZ0MjpUYpAYd9tqSiucigXy13vId9QOSgTGsVKYNHevUlUOLq8lYC
q29fZ4qNprDyKdc/JRuzkqanRqVfP7+HArMOXajAbCb1Qbk+qoYp12LuDs4yFWBW
cBe1/yy9ItxJAjp7oMBiuMsjWdn/Di7mf3HMt5fTti0jNptDq1BPGsksUudJ656I
OewK0YelUC6ptvxRfE4YwI7MUoG5EciU9tonBpFGkU2euzs6VrIpIF9haDIKEuC8
8eafrA9+yamuhElBP0xix/Bbif/Lk6oxK6yXVIwdB5qCNEgHRPjLzDEQykO1QBwp
BMykpU5UXXpdqYD9kuT3k/hHTLq8GeO2o3bHVWoWZTvw7ZumzMk=
=1ehQ
-----END PGP SIGNATURE-----
--=-=-=--
