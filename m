Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D4BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020CB207FD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khCBdBgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFSqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:46:36 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50912 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgCFSqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 13:46:36 -0500
Received: by mail-pj1-f67.google.com with SMTP id nm6so1431555pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 10:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qs7ImbJabDiO2c+nA0PLDjvn+ichuXUQrVBrfX1bZCI=;
        b=khCBdBgUrq3Iro4lw6N8B1QoPsldVk3UXCYnzdH2RAiDgk8c2S3c45df/hn2BZNJhN
         w6rlV1YFrXTosRLkr/OSdw0yE4ecr0+pisMvuHB8LRzUU6XNsBTL7VZx6ZG8yyuqcmnD
         aKJ0b7uj8VM28iYubhChlsntpMu88ekQOoTAR/afX1b8Rt3kNZAsIylW8rsSJL6WeU3g
         CUDNdMzxRro6nw+UpGjmeaI5rydk9TugiNJi1PftLlGAqwtPv/JdLZM22YZm9TQBtuBm
         TXXeh7umTTNUwjlNMM7Rf7ni3tKcBXiF9qQL9ExAwlxHJVoMJd+IGgdhYH9MCxeQ9nj9
         +5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qs7ImbJabDiO2c+nA0PLDjvn+ichuXUQrVBrfX1bZCI=;
        b=SMSIujpDyHujB4U0Q3bslXl8ty29EtlVpFWVJ/DH+NgdURGLcjtYerxSD/5kUr8S20
         Tq3VfusgNWUqGbq8VPujehuNIwVBevkA9b9wkzMwbvcWaaBg8WlYM6UAL9CaNda1qvpt
         8zaVq1fRbfQdGa1Pv0wvdNiuyChqgGBlp7Ze77G95o1vmnMdbREalR6E7ETAZuqopqSf
         nR4eNmwzTmkmaofjIcElMTqZZ3ZUjM9Lkcp4u6Eb2sO75lXD6690vqejKCq7GyPR7nDc
         l4NCjUmQfMx0TlXwXhgeVL+NByBaLOErItEId+leMPsY87MIfCu6A+iWFC4M3YfmteoL
         wquA==
X-Gm-Message-State: ANhLgQ0LFUriWKfRjCNnAPSohWXGCyKxYCbL7Vmowh8i4JqCWs0KZxl/
        YkbdjY0ALoik4WLYJSegns99Jw==
X-Google-Smtp-Source: ADFU+vu8caf6fm9vlyYJx/DSgFl0r1swaMsn+ExLitzqjBC76MvfeUhu9mc1gS3F3QNIMzxvIvv9sA==
X-Received: by 2002:a17:902:74c2:: with SMTP id f2mr4107359plt.318.1583520394996;
        Fri, 06 Mar 2020 10:46:34 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id 18sm37442928pfj.20.2020.03.06.10.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 10:46:34 -0800 (PST)
Date:   Fri, 6 Mar 2020 10:46:29 -0800
From:   Benson Leung <bleung@google.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        jflat@chromium.org, linux-kernel@vger.kernel.org,
        pmalani@chromium.org
Subject: Re: [PATCH] platform: chrome: Fix cros-usbpd-notify notifier
Message-ID: <20200306184629.GA253583@google.com>
References: <20200304232108.149553-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20200304232108.149553-1-gwendal@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gwendal,

On Wed, Mar 04, 2020 at 03:21:08PM -0800, Gwendal Grignou wrote:
> cros-usbpd-notify notifier was returning NOTIFY_BAD when no host event
> was available in the MKBP message.
> But MKBP messages are used to transmit other information, so return
> NOTIFY_DONE instead, to allow other notifier to be called.
>=20
> Fixes: ec2daf6e33f9f ("platform: chrome: Add cros-usbpd-notify driver")
>=20
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Queued for v5.7.

Thank you,
Benson

> ---
>  drivers/platform/chrome/cros_usbpd_notify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platfo=
rm/chrome/cros_usbpd_notify.c
> index 3851bbd6e9a39..ca2c0181a1dbf 100644
> --- a/drivers/platform/chrome/cros_usbpd_notify.c
> +++ b/drivers/platform/chrome/cros_usbpd_notify.c
> @@ -84,7 +84,7 @@ static int cros_usbpd_notify_plat(struct notifier_block=
 *nb,
>  	u32 host_event =3D cros_ec_get_host_event(ec_dev);
> =20
>  	if (!host_event)
> -		return NOTIFY_BAD;
> +		return NOTIFY_DONE;
> =20
>  	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
>  		blocking_notifier_call_chain(&cros_usbpd_notifier_list,
> --=20
> 2.25.0.265.gbab2e86ba0-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXmKahQAKCRBzbaomhzOw
whwQAP4jCnzsupC6BWVC0gEzvODtsZAj6A5R19O/esCpw3QAaQD8DydhtsM7aqLZ
9uhlqN32iPL4n82hdYy+CKfNN6XwEAI=
=9AS2
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
