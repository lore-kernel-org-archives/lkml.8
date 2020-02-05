Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57160C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BE321741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580920592;
	bh=pK7nF5mUeUsAafBzOWCyuuzeSXznIS/sk5aHZ0dUNWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=do3sThz1YN2GDRwxBl1y9ZeAvTUz1MlMNWWNJk62rb13YlY4T9ejYRVEjY8bfjQdD
	 pdRCG9HutMWMze4c3/GfQw9fgqUEtiRxu05IOBLpxzLvRtDdk8n3wz5xKG3+enU2K4
	 hT7qu9PLO5kcMXeMtGiUbRjRennhAdyZzu71ylzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgBEQgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:36:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42030 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgBEQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:36:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id d10so2945329ljl.9;
        Wed, 05 Feb 2020 08:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=PIUzg03PZCq7NtLZuhzkmxB+obztP4qp7TMcQAm7UzU=;
        b=fZmMzKmusht1Fb/nkBDS8TQ16IocvAk77CKdTyDQsHf+wE4QXxfIhStovSkLZJXjuE
         yQPZjKv7Uxvdg+PVAthVV6ckeh1/HRFx8o25cTy8TnneT8OMW12WZ6JDteruhQVhokeq
         sLFx1Q6Cn3/wafTw62WxxTQGnAyfB3IYjMoowwR/swxC90IXrVFF62m16wYcPbzSmgI2
         dLyXqVsLs4zE1oLk/Yjqv1b2MRKGkocJRadqUbXh/IaSiwlcyevsu25LLmHVyTM6Vt5w
         A4lX2mPLkyHbfCjEVXawG6+eS8645tEi1Qehq3Cfcwt1idKSMDxossIUYznOplaOUx5I
         VfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=PIUzg03PZCq7NtLZuhzkmxB+obztP4qp7TMcQAm7UzU=;
        b=Lq0NrhMLgpm1wMFHEQBUABCkdALmmXhjrpYMAzS0v5prFWCdhMBBj3Jk8VO4XL9xgg
         Uznwxl1H5XuMTkx/ijvrOwda7uTj6vQ0g2cF3zyDaCRJicjXHeffCHX8ych0YP8xRzQa
         QrgZlZpF3AFfojharYzKIn7oMi0A/ia18rV0kkFjURnGqDY0Xdq/zlecvsYNNa+Muj1R
         6WBGUUEojiVore/nOe6BQ8rtPRLocR7wApbyLoYuLUg9LHFfp9zaccnBOYbIfPa8Sjm4
         CmObrKHYZ364Lo9vQP2SjAF1ESOrr0LzKH5mnarFyQ5wLM93NwhO+GgNhRXPSVLcKho+
         8Vww==
X-Gm-Message-State: APjAAAUaIsBuM/X1qshIiWD5mVqNgGyYhlYIpbywxxxU8O+1GdxqMfdE
        VuBYYmJ8srXJpi+zKN57bvRggbakMek=
X-Google-Smtp-Source: APXvYqywHCuTgg+E3j4jggENB28wu5Af4EmJX5B409SbpaDCqlimTwJgQKx3UIU1BIicQvnxs/OChw==
X-Received: by 2002:a05:651c:20f:: with SMTP id y15mr21710994ljn.7.1580920588582;
        Wed, 05 Feb 2020 08:36:28 -0800 (PST)
Received: from saruman ([2001:999:81:d599:3b1e:9c62:de71:2a9d])
        by smtp.gmail.com with ESMTPSA id h24sm13418336ljl.80.2020.02.05.08.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 08:36:27 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     John Keeping <john@metanate.com>,
        Minas Harutyunyan <hminas@synopsys.com>
Cc:     John Keeping <john@metanate.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list\:DESIGNWARE USB2 DRD IP DRIVER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Implement set_selfpowered()
In-Reply-To: <20200204152933.2216615-1-john@metanate.com>
References: <20200204152933.2216615-1-john@metanate.com>
Date:   Wed, 05 Feb 2020 18:36:21 +0200
Message-ID: <87wo9156uy.fsf@kernel.org>
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

John Keeping <john@metanate.com> writes:

> dwc2 always reports as self-powered in response to a device status
> request.  Implement the set_selfpowered() operations so that the gadget
> can report as bus-powered when appropriate.
>
> This is modelled on the dwc3 implementation.
>
> Signed-off-by: John Keeping <john@metanate.com>
> ---

what's the dependency here?

checking file drivers/usb/dwc2/gadget.c
Hunk #1 FAILED at 1646.
Hunk #2 succeeded at 4521 (offset -9 lines).
Hunk #3 succeeded at 4632 (offset -9 lines).
1 out of 3 hunks FAILED

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl467wUACgkQzL64meEa
mQYo2w//ZyxGZVbFWXyPTffhW2kVCvsTOu71akMCkQMJ8NFgPE6/uNB/7osrd5bN
cQZagrehU16jX+P4608iFEcLx5ogEJ2d3Y5Yi6qvi6ISWxhio5agXLUDpgA3BM5n
P/6BEp9UJ+0H4FEMNtlQpdLuvby9/hcnMj3b8ZOqtRJoztybdPEKjbfPC/2tZoZY
zGNazxE+EQIi3hD4LcfRs4YmLS4YC38mmGkuoSt+du1JNH6gtWyGDjgXX/4T+YvH
b2h/hQfU9Gy8bqs9n33DGI9LUouUXD1xYVPAabs21baAfRZolKyvi0Jq7m46tfT/
7gugqQO8bqtYivWSRgZr5+srxWUhyqJ1UyYOpSUsJORG4EbCKFkZMV0QSVbpwSwU
w4yGq10qDiWy69dIs4c5iyEoKGb8muR3lMVhDScznHyH7ozFLGjmDtJodpJbK5Ln
RQl3TQ0jf9c2wRzJED2VZKwUEJq3FHFL3kHjCFAx5aHmEuZ1N8EdtJywPUcGfNlk
csXaKT5rsBhmlX7U5IagOtgBmd7MBQ33lwwy58zIevyMAHaWrV3xvsfVg8/83zQO
/b1o5M+tSHQd28gT7moUJWBCAj60T4I61PJmEIYAea/fDrMqzaIqFRmtgJWI/wE2
AwRFMM3tRFLQyTGuMO7fKtNwEP0RWCtJrTFeny85G5ZfMG01Obo=
=V5OR
-----END PGP SIGNATURE-----
--=-=-=--
