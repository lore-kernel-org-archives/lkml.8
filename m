Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B608C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D212064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTHs6PzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgBQImK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:42:10 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:41483 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgBQImJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:42:09 -0500
Received: by mail-wr1-f50.google.com with SMTP id c9so18573751wrw.8;
        Mon, 17 Feb 2020 00:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XTVDtlDujS1FexCccIJjlqSnMh0JRNPhJT+VsfXONDc=;
        b=sTHs6PzD94xlIbp3EVV+xtr05qjRE4Sw20sk2G9/YIsN5t2TpPXC1FueyYwxZZP7kM
         sYJpQU2zChQtOmhNlAWabN8HDbFDSz9t5852gn1XxNjTSA9Pq50p8Os1oquNMCAeAupp
         hnVYRB8h3cZax5X7CvBk3gXW22nL89Pxr/raUFZEhOO7akEQH4BnKpCFs+paA8g9LdDz
         eay5WNYbQcK5pj1ncoj/F7A4SwMqe6RhSKeajg38/Rc6+B7kRxaO+tmT+XsAkBnrBgRo
         2KwIJWkxkpP+ZJCkxDKZd7tsdsw7d7ks5Wr/cA0/V9W2nM4knY6HTMC76YQCS4m6GG1v
         IiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XTVDtlDujS1FexCccIJjlqSnMh0JRNPhJT+VsfXONDc=;
        b=Yr4n9E8VhGHjRG1FWwaPDJoXO4ya2J6wmq7cyoXeMR04NegyN5ZKzm8MuNvVpf4K+H
         3QWr4qB5ds2tSshqcbP2NGMO2XAovwpMKM13CuFYjmQ5bt0K10HmxQuK7e4WjqS08un7
         hewAc9l0K4sRtUrJLN5KwlAsLf8c69v5MoyLG5ylN4A3tmJxQrU2jLJDHyc2IDph+Lec
         4CTU5pjOz7X/r3TAdLNNg2n5pt/noK/C/hvExDNRItuL71oUZNuTP+Sts9ydVykp0FAI
         v1VZBtclhY0dQEOb6ao/Wyf6uNZ8mz+L3MNcDK6CR+fN+JuicdZ8enwrzDUIQ1zkkh/k
         22hg==
X-Gm-Message-State: APjAAAWlc+di49kpR3bT8EYXR+D7JVW8PicARPQlYG8ZcEjWD83DOFKk
        HhqnpRHVdrcaJT/OUoSATXY=
X-Google-Smtp-Source: APXvYqzve2rIx2O5ybG8NSz8n8PvsLzpsq6vRL0tqM5ln98sZ1CnO5T5RP5nBuAteSbvdajZ8j21Yg==
X-Received: by 2002:a5d:6445:: with SMTP id d5mr20487035wrw.244.1581928926906;
        Mon, 17 Feb 2020 00:42:06 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id h205sm20110939wmf.25.2020.02.17.00.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:42:05 -0800 (PST)
Date:   Mon, 17 Feb 2020 09:42:04 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V5 12/21] usb: gadget: tegra-xudc: support multiple
 device modes
Message-ID: <20200217084204.GI1339021@ulmo>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
 <1581322307-11140-13-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4BlIp4fARb6QCoOq"
Content-Disposition: inline
In-Reply-To: <1581322307-11140-13-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4BlIp4fARb6QCoOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 01:41:38PM +0530, Nagarjuna Kristam wrote:
> This change supports limited multiple device modes by:
> - At most 4 ports contains OTG/Device capability.
> - One port run as device mode at a time.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V5:
>  - No changes.
> ---
> V4:
>  - Replaced current_phy_index usage with curr_*phy pointers.
>  - Used unsigned int instead of int wherever needed.
> ---
> V3:
>  - No changes in this version
> ---
> V2:
>  - Updated err variable on failure to get usbphy.
>  - Corrected identation after tegra_xudc_phy_get API call in tegra_xudc_p=
robe.
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 217 ++++++++++++++++++++++++++----=
------
>  1 file changed, 160 insertions(+), 57 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--4BlIp4fARb6QCoOq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KUdwACgkQ3SOs138+
s6FBTA/+OuSS68PjmW2Sn16CEA8GKImQt3M9/ZedBYhHI270QC4KXSO2Piz2+TMG
gX6/mSb8T492DXnHvpH7f4QV9BbSptNXWb6tNLfTf/AYWi++vG19RtswQQaZT1z+
OfWyHZJh/BwEolaYJ295QjD6ovpWRhXtg7di/fdyCIoYFrZN7lAw5ongGvFsa3bB
mC2kZ1NKMNHFJJ0/n3/M7OVQffMUJh/18fXC0gaGgwYBoL71VpCSY0ICH4OxQopx
D3J9uCiDc6/NOu/52TLWQh+tUPMW1784C2orAWqMn8fWT5DGOph2NPVm5H3rw+Rq
ub0gAyDRQGs+A4e2bieY5Pd36vtempIkZilZfeH3OmFFeB1ieOfrqxxy2eafxRhy
QdUro9WP9dhFxVZoxjNCtkWP8whnuGC5wx0FC7vTTBllxBYaxGDrrZyRTtM/H4uh
0V+KWu5hPjH1qsV2OAlqHMlIm0nPcUp794oq24ggLPvwg8YYOtnvd5VyHmmYzUpG
QzoByNWJgop9VdmTm7dXm6rpbEoHoeq70lxY1tVxbdUzwmqtKte2FiGNf2VkY4jQ
nUkSGU4C8yQGHdg+pumAz96wVJOALHPj/iCQBsSbWbnflwAzl0nAX59HLN/mbFg5
9PY+8EZs1cQL5JobE8GHUcesdF7tYUQ2dy8sJqJPqIDy/fTVh6Y=
=hIOY
-----END PGP SIGNATURE-----

--4BlIp4fARb6QCoOq--
