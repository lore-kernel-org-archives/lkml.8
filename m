Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE6C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5896B20825
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595951126;
	bh=S7cdXSF/HmmzofXdj18m6G6gj8O49SL+F1PwSdtySqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D/AsS+ZsFWBl5CCqi6T/A3Yo2cZ53S8ROUNhTrKJVSPVumW4HClHOhSsV4BnxpKZR
	 W94IGPxB6aJvy2zGZEV6FqV84A7iaifnBtrd39vYd51fInkv/hFFCHfZv72lg06VDI
	 yuk+msjNaPpMo42Rx/Mg/Urm0gApZavGLiMpGNPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbgG1PpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730949AbgG1PpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:45:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12122065E;
        Tue, 28 Jul 2020 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595951124;
        bh=S7cdXSF/HmmzofXdj18m6G6gj8O49SL+F1PwSdtySqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UyaZbqQvEVUln/Hp4xGo59mb6FQCUFCQrAoAoCDIF6gTuLBBqnS9XxQr2wUvt74Xj
         pyJLH3Nl02fb+wRIEhZXGRNKM8EN9DjvzpwKJnYN9N2VQv76ffYqs0WPj7f+OhFgZc
         merm7S7rNIk5aevSI/+VaUQHO6Dj8C7a06EoBMCI=
Date:   Tue, 28 Jul 2020 16:45:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: regulator: Convert mp886x to json-schema
Message-ID: <20200728154505.GB24701@sirena.org.uk>
References: <20200728232327.71ab3729@xhacker>
 <20200728232417.5272843b@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20200728232417.5272843b@xhacker>
X-Cookie: You will be misunderstood by everyone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 11:24:17PM +0800, Jisheng Zhang wrote:
> From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>=20
> Convert the mp886x binding to DT schema format using json-schema.

Please put any schema conversions at the end of the series if they're in
one - there's often a backlog on review of them so it means they don't
hold up any other work.

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8gSAEACgkQJNaLcl1U
h9DcZAf+JiDWWPjf8n1mEkguii5q1B9q862vN2R7bA7dJ6sUs9eWiJFyWIe8ZTfL
6aT0IhiGRDCsDnV8aYTVC4+I3ojuegoS1sySs5iNGSx2yIf2PhV+Q8JWoF+/D9zh
IEOE7P2U69+UQFuIN1yE6HxEHq6OXmlEBNYBRMlUBWz0Fv4zntEe44MHKJKKz5xf
k8ZcY4rW0v2V6Y+ipO5AQMsxNxHUbrO1H0GgguirSH35dqW2gScYW8zKPJrlZDl4
US6+i+WbrE74NqZ1erukAHcqK8HbPW3T6QfMUgE2+PJpOJW81FaAKGkGwudKlHZ2
LnjUKvAi7CBhGbTcZLuCbBaKuX9hXQ==
=GVkK
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
