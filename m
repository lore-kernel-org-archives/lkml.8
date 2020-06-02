Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D546BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CD52074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591097059;
	bh=cT9jBHVPrWMrMhELAyl4RpjRekYb1zN8PMcuA/XN8LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0jcafYYaGkyw2Y5L0eJ4MGpEfdDNTHdiUmu87wrPqNqJuDdzLnuXrkcnaZ8HnYrga
	 Axg0cFlVPw6nQaZo9EEPoKDcYiKFlzBT4/qR3TgnVnN40oSBL+Vagj4uvFSCNnJ+LM
	 k9xC+iMIzr8NlqfB7WWVZLReiD0I8ulI2oADFOdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgFBLYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:24:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgFBLYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:24:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC1E420679;
        Tue,  2 Jun 2020 11:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591097057;
        bh=cT9jBHVPrWMrMhELAyl4RpjRekYb1zN8PMcuA/XN8LQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BVC09q5hW7vcrzboHRjSO9Gf/RhExlMs5DpXWTf317PpNiP7CE1z0YKs3Cz1bie8w
         G+brqj8LBKrIczOjg9mFXIT+EACM4g0skbUsyb3q+qQZudIYlCjXDLrJKg1S6KR/db
         rtgiw1i7RRzpRro5d88QhJvKZJPSv6lFx0fAqGjA=
Date:   Tue, 2 Jun 2020 12:24:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, nishakumari@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org,
        rnayak@codeaurora.org
Subject: Re: [PATCH v4 1/5] regulator: Allow regulators to verify enabled
 during enable()
Message-ID: <20200602112415.GD5684@sirena.org.uk>
References: <20200602100924.26256-1-sumit.semwal@linaro.org>
 <20200602100924.26256-2-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <20200602100924.26256-2-sumit.semwal@linaro.org>
X-Cookie: We are not a clone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2020 at 03:39:20PM +0530, Sumit Semwal wrote:

> +
> +		if (time_remaining <= 0) {
> +			rdev_err(rdev, "Enabled check failed.\n");
> +			return -ETIMEDOUT;

s/failed/timed out/

> + * @poll_enabled_time: Maximum time (in uS) to poll if the regulator is
> + *                          actually enabled, after enable() call
> + *

This comment needs updating to reflect the new implementation.

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7WNt4ACgkQJNaLcl1U
h9DiUQf/U/9+5zRl543DKtlEGwWv5y2SJPMULJc6Fx4l4UJyMi2WV76AIJ3kpvhV
3BK+XKeRUSM/EoHHrf7VTxN4pDu5GRqtKCXVmzN5jfl1LVgKNBNSapHtXt4rETbY
sBqecGsBHjZIcMFvIMJG1I+ljMFCVBdSZus3/gJO6qnCW4y88HPQU9TEsu5HoO/X
5PLcUd20oc1xFKeb/NDy3XZyx0KuBmV+8Ws66OspiXl24FaFaQAI+iFcsk+OTcir
Fgi94kGsHJKCA48iMqy5ffkD3wIpQdPYqlQACMeeKU3G+T0g5KjHiYSBKucWoRum
WVjSTeqiQwfaw0BGXWsykdtnnxHwEA==
=sPJI
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
