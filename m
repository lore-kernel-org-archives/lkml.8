Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEAFC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5521720735
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjMvmxbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgDUWQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUWQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:16:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D4DC0610D5;
        Tue, 21 Apr 2020 15:16:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h2so40839wmb.4;
        Tue, 21 Apr 2020 15:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F4WRDj2X5QQrEYRw/a+K7isgsB0ZBr1VCngrYHGVPQE=;
        b=YjMvmxbtzIxiPSpvyeDzhVN91hOfvfe4NO24ZIxnhdSC7Jh5pFBZ/jz4nFLci2o0o3
         Kn+EBqdDQ0wE2qxdQhSZ+NvTyq8dgquooLDf346frDFSsdNW5SvHy5+DGHN1h7w8BTMw
         y1SKsjDOMJoQAahKMMwxSSQnrP4AdWqF4eMbVvYnv5YZlUhUumMfycF7xt8XT2MmFaPT
         canRWukk1Qut6nFlXtGSTmDt45P7NBP+e03j5Xz4/JCaqc8Qu1bLbIQPNd+AWI4JCDwG
         +cf9hYy0vCUZzNYUKQAZtHMn/pAgybGJHDdYQeyhKuXh8fmIBGtG6fVd6+LZXNBDt5/G
         FAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F4WRDj2X5QQrEYRw/a+K7isgsB0ZBr1VCngrYHGVPQE=;
        b=qN0H4ORisUlCVHjO1SF7UidfX5XKQgQPhI19b2Vesh23fsq7hmDm4OMpSLjaJPkbWO
         osBk9cRu1p9un9SqQB90btsL9bkfO2W8XZHgVkVOI1DvOizIT61iCyMmBxflobGHmhov
         BTmh5LGgJFBP6jrFkSdHIoWslE5HH7udIg7uSytWfDisvc9B789T7VDM87dDDmv7DbCs
         EK0dk6QiKYukpQnZwwUw79qdoKkZpOH3jWPp12jspAAvjPC82leSZkvcWfWqYsfxCaE0
         qTii83j+j4ngAhk/bGJjEbfQ7vrnn4yXaVu6KCUrsxAYa5ptVfn3v59IYdvjmmLcJAms
         0O2w==
X-Gm-Message-State: AGi0PuYaNF38Hp1wjadJB4ZTLwgRpBudp5DxAsV7ysOVzfmGz2titn20
        9Iby9yxRZbREOP2V8jF/iyVRKeo9
X-Google-Smtp-Source: APiQypIeKmocXt3cSj07h7nJzOQe05tAv/aewV8blJWeulywv0MPc0r6Smu8Vzw4HKmaerppZcr8gQ==
X-Received: by 2002:a1c:3c87:: with SMTP id j129mr6800228wma.157.1587507368068;
        Tue, 21 Apr 2020 15:16:08 -0700 (PDT)
Received: from localhost (p2E5BEDBA.dip0.t-ipconnect.de. [46.91.237.186])
        by smtp.gmail.com with ESMTPSA id s17sm5389229wmc.48.2020.04.21.15.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 15:16:06 -0700 (PDT)
Date:   Wed, 22 Apr 2020 00:16:06 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: fuse: Update the SoC revision attribute to
 display a name
Message-ID: <20200421221606.GD3445172@ulmo>
References: <20200417124046.26400-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline
In-Reply-To: <20200417124046.26400-1-jonathanh@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2020 at 01:40:46PM +0100, Jon Hunter wrote:
> Currently the SoC revision attribute for Tegra devices displays the
> value of the enum associated with a particular revision. This is not
> very useful because to obtain the actual revision you need to
> use the tegra_revision enumeration to translate the value.
>=20
> It is more meaningful to display a name for the revision, such as
> 'A01', than the enumarated value and therefore, update the revision
> attribute to display a name. This change does alter the ABI, which
> is unfortunate, but this is more meaningful and maintable.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/fuse/fuse-tegra.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6fcKYACgkQ3SOs138+
s6G0mg/+P+8Rot7VDNd1EWJMIktuk2Nb3qJ9o0Cu31aSzy7qjODcc7qKB2duHkh4
D96kUWvGLMYVn2c13uaU97TnmSPbruadM8+oxBqFkKnUcfO6G80ExLHE6pebhhUV
7Ot7T9EESV1dh0wtrcEGH2wuOUyvOpzZDV09cKb7FdezEyiGDQ5hKHBarHdeTWXd
eYDEMeTJ54edTMSrdbCxD3GJ0Lw26gIkWbEPZTwE1oZ8iwDhSvaqvm9MbwSl8cns
y3ReXdrlnlchWMY8+QvQsrQLz80+T2U4wt1VGelr/xwttS3buQLsB0erSLJuRTTE
OgrcZrN8HH2db/pO2s8nr1hgao7N6GAe7OWaDpHQCM7DVFcgOfwIJeffRfod51Nt
ue/2Au0eVoXDEcZrlesENgtoCazK3ePaHVOuORjmndZi4afmruVwiI3Qc0LFRzOR
v9U1cMOTcIzoT7wcMlJ5maXPHsovK58mWLZ5KkIEgmaBps6By9+4vdI9liSQ+3FS
PnQ/tBrQx1ESKYV/j9UqnIvbn9qrXq9EmuGxCyPjXUZ22seYiMsW0MhFPbuuddFm
E6fxlK9N5+udDepUBCJr0vfdr1mKxyR+qpKa9uBrwc1cJZbMB+nmhFzomvB8xsdI
EUIdY5Ylqa7SzqrO2a+/Mwz2+Vxaop2G0k49K62e0MLy/vmseKg=
=Ibkn
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
