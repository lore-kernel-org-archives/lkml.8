Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6665C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 17:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C0A2081E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 17:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581270863;
	bh=WStKxZwxlj9xH6ezReAx8PejtEth1f4CDJRQ+8Gwyvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=PN2MADHT99vqn4O3zs/kGv2zzhcdzINfDCxGg0lgRBgw+VRVUDsYfVVmraBeATQWV
	 kgzmFEorhW9YMD1pkZ+QZdMOtKtPVI2kK4mMMBTJkVD36Dz52Iy+1b2Yzi8rj//Xa0
	 Utj/+fs8N3DeJiY+nXCUEXlnUWgNvmb+zoR/Ma2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBIRyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 12:54:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33841 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgBIRyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 12:54:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so4553074ljc.1;
        Sun, 09 Feb 2020 09:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=yToOlkZkYj/FbYOyMzXTxghkKi256mVsYV3YgS6NprE=;
        b=ijqw+WcIVuTiOWt3tpA2WyIhu0PxKSAV85NLz26ZxYTy4zGEasvgkOT3tuXnPMDDaU
         PQmCF3vKbilx9KJUlVgz7eX/hkEkGbDs06yFqUmO47ClNs4YIEZw8Cv6QjrTnr2y/+hj
         NUHnz3Qo020Zp7/jFPGWtQ0rmAelxJ8tCBYK9ZORNEtq1oIh/U4KtI32CsIxIPwq2Lpm
         kMyB1YUNZdXp7zf6dnaxpON9G5+WPRHKNyK8Pcd+9J7RxVL3M1Mo7AOBbGMtJHg1AFop
         ydyGoI++DKBkDsg2HxgijNXJ0r1Z3ZL0hZGCII+CMXa4TiyMA7VjNunOjOJb1S2riwVi
         KyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=yToOlkZkYj/FbYOyMzXTxghkKi256mVsYV3YgS6NprE=;
        b=Yd4O3htEQQSvsKxhA24YeKga19jLosCpJZ0JWz22gJgW7BTeyLs+EtmJJf4YyPR6y3
         +VlelDkVu+oyZdMoBTb+x2yOBvyZsS8ovKtbEbqaxm52WOlD3Lo5kF7/xM8xLP0UPNVz
         clDq+VLnhGHMfk9tfzvLTIAi31n0g0ZOJswezac8WWL9SBcPuwIOA/X7dMnJRbR427nQ
         MUcXqDj8+F9+OducezMgK8eS9Xz9YgkcOHBqduLR5Gs8LAuvyhlMa1fFUnJq7qOfUhqx
         OY3x5Y/f0+66FiLVbkOnSq1GFUUZ2SxcwmL+M2hR13k9nlJ8sN5BDX0AqENsJPZ/6AXq
         koZA==
X-Gm-Message-State: APjAAAV64I5WbtNIs+JkdFK4t9iHhYvykUsx1VQjN79XGlL7E00emHzQ
        Dq23yGOblNBlc8RJIGpzTeLl61Ch
X-Google-Smtp-Source: APXvYqw5NI+FMkHyKc4kTF5PcdKAPLhphct1UVPB2w4jvPmzySeoYkZU6s7XS6VWh/DrVgpTd5KxfQ==
X-Received: by 2002:a2e:7609:: with SMTP id r9mr5674576ljc.238.1581270858904;
        Sun, 09 Feb 2020 09:54:18 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id r23sm5003241ljk.35.2020.02.09.09.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Feb 2020 09:54:17 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: debug: remove redundant call to strlen
In-Reply-To: <20200208162508.29336-1-colin.king@canonical.com>
References: <20200208162508.29336-1-colin.king@canonical.com>
Date:   Sun, 09 Feb 2020 19:54:03 +0200
Message-ID: <87pnen3av8.fsf@kernel.org>
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

Colin King <colin.king@canonical.com> writes:

> From: Colin Ian King <colin.king@canonical.com>
>
> The call to strlen is redundant since the return value is assigned
> to variable len but not subsequently used. Remove the redundant
> call.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/dwc3/debug.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
> index e56beb9d1e36..ee964352c8e2 100644
> --- a/drivers/usb/dwc3/debug.h
> +++ b/drivers/usb/dwc3/debug.h
> @@ -296,8 +296,6 @@ static inline const char *dwc3_ep_event_string(char *=
str, size_t size,
>  				status & DEPEVT_STATUS_TRANSFER_ACTIVE ?
>  				" (Active)" : " (Not Active)");
>=20=20
> -		len =3D strlen(str);
> -

looking at the code here. The problem is elsewhere:

| case DWC3_DEPEVT_XFERNOTREADY:
| 	len =3D strlen(str);
| 	snprintf(str + len, size - len, "Transfer Not Ready [%d]%s",
| 			event->parameters,
| 			status & DEPEVT_STATUS_TRANSFER_ACTIVE ?
| 			" (Active)" : " (Not Active)");
|
| 	len =3D strlen(str);
|
| 	/* Control Endpoints */
| 	if (epnum <=3D 1) {
| 		int phase =3D DEPEVT_STATUS_CONTROL_PHASE(event->status);
| 		switch (phase) {
| 		case DEPEVT_STATUS_CONTROL_DATA:
| 			snprintf(str + ret, size - ret,
| 					" [Data Phase]");
| 			break;
| 		case DEPEVT_STATUS_CONTROL_STATUS:
| 			snprintf(str + ret, size - ret,
| 					" [Status Phase]");

these two should use str + len and size - len. However, a better fix
would be drop the usage of strlen() and just use the return value from
snprintf().

Do you want to produce that patch, instead? It could be two patches:

	1. replace ret with len in these two cases (a bug fix, possibly
	        Cc stable)
        2. drop usage of strlen() in the entire function (a new feature,
	        for v5.7

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl5ARz0ACgkQzL64meEa
mQYgmw/9EE5pVmtUrQ8lNzsRD1D74sigwdOsgAiv2KzGlsAo6V//uG7pj7HDevKs
PbGaHd1Z4wChEWK4SeNiGpt/Ti6i0jWJjm444SfOAzTaf9l+PChxW779Sevtpamh
kmapC8Kcu6+hDdudSXAahPvDy7cImv9ZRZwUvZCspIQgVz21+5MqZSGFv1Uzkp5M
0T/mGQcFRtdBDJzZvZxV/7Fk/pwAEtFGga324kvqJVu/156U9vgQOF4mhdxFFXrD
wcwIRQRr8oEHf+h/e/m1XI6GLlXsiCGWtPwd1C93GyS5GkTi7pcovxwXmhIbwwap
TzpsRWt+iFldtzrBgpEGrBtnLf+4T8jLGa3x6CWWmLe7f5jIdznd0DUkPn3ykSjR
LKVJ0vw1iASh16E4ayD7mtwk6ocxSSkq4mxmSebJH5xDzKlfPC0Igtd/gfmKDyku
/PRzMXi4HkkVO6Q6P8B1f7dKX2Oj2r6z7+Rgb5smb/Hh6E5TSFnf20SgdEYCdz22
VYzM6hR6Z39MQW+Vi2Ag72PYN0azhgXvqahRvf72Rov1cbtlT5fsUYJPN3W+S1MJ
CUA7/Y2vPulVTCYSUsq4MG+mK2d9fEgQ1U66Ysk6Q3FSJoRgAHSoSmaVp5V4GuX+
IRhwRji+3TaLqQo65jdhuvCxMXTjQ/sldiEws5trBCGwHC2I92U=
=AtVg
-----END PGP SIGNATURE-----
--=-=-=--
