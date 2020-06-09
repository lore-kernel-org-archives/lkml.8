Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEC7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5164207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591701724;
	bh=SoQg+I6Ac4ovBynb3sRtmLFS7Oy8Tl5nHbyAO/uFR8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=03Met8EZyc98HSzoeYnElVWSUJB/FWRK66wXvB0UbeXD7EEhjIezg8ob1Jfkzp8zZ
	 AKS+dlgWyrapab8zONQQH6lVoFDoOKNWaGYdaEbtu7YHy+/o8sWMyUXqjeN/Kyzrm/
	 nd3xOfWZtkwvYj2MCEFWum/1tbhPL/SB47kYPtIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgFILWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgFILWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:22:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 185B4207C3;
        Tue,  9 Jun 2020 11:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591701719;
        bh=SoQg+I6Ac4ovBynb3sRtmLFS7Oy8Tl5nHbyAO/uFR8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lg7ZucQdX2Hrazh+RjG9UFANqHbs5S3zeNsNmVwij58zKZyrG4MSDCwc74Mkl+ze6
         qMV8v5gIwwidDMjd0zyW9BOtYc5/gQ8KJnkhXPN6k8jruYm20Yj07S2t2XMcT38Ba2
         6QTbrIVYhS3izQIZ6nGlleUY5W889+eS8mcB7kaA=
Date:   Tue, 9 Jun 2020 12:21:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" 
        <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add DT binding for
 cros-ec-regulator
Message-ID: <20200609112157.GC4583@sirena.org.uk>
References: <20200609080001.121499-1-pihsun@chromium.org>
 <20200609080001.121499-2-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <20200609080001.121499-2-pihsun@chromium.org>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2020 at 03:59:54PM +0800, Pi-Hsun Shih wrote:

> +  google,remote-regulator:
> +    description: Identifier for the voltage regulator to ChromeOS EC.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

As I said in reviewing the patch this is a bit weird - it feels like it
should be a reg property on a bus rather than a property like this.  How
exactly to these devices get created - can the core device for the EC
enumerate the regulators that are present?

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fcNQACgkQJNaLcl1U
h9B0jQf/VOxi9AR4F/etZ8Hn6p9f/DR40OmYg+u+lZp9pMRacs4YffgmEhavi2EM
00B5na9NJy763PpMZvgQNy0Hp6DEZtoMRN0sq8k31//NKJU+r6p3zrAR2m3rH8Iv
2Lh0adLaONYppaX7T8x+nw63mzhIzLPnJETJJOxkQ+cY5Ib38k+ASwF/NBCPod8G
BEpI0/JT4KVGxp7+p1+mIQjW5qi4kDvjSFOwgFNZftlzfVs/uirqweRhJNYdReho
6Jkzi4XoCg55MGMjH0slYzSNyZruiMGsqYiyEtqJ+yiwtJFp8Zap0vOz8LNdPIre
2XEJbWkN4T8Sa+h+Wx3ePR5Ic6L6ZA==
=D+me
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
