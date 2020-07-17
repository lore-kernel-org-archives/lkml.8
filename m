Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F231C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFDE20737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595009782;
	bh=ih7YVj7qp5uD4MsT7vKxCXUTrq4W7Jboa44olVLsmVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RQtWGXnnNLYR2wCdkoiakkiU8+DzMKdeMV2PavisT0ihDQXARBkWPLzkfZfx383Hq
	 nwSknaK/EmOcRnFOJhrAFKhPwtCCd5vj4jqX9bSnztN7C0O8uDQXE58txhfLSaFOo+
	 UzvT60dVJDxyONoC7TISFJTqGbgEswIhiNa2B/wM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGQSQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgGQSQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:16:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A3A206F4;
        Fri, 17 Jul 2020 18:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595009780;
        bh=ih7YVj7qp5uD4MsT7vKxCXUTrq4W7Jboa44olVLsmVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNZxjx9JqY64qS8s/ahoE3TCh4oKQWCXjPFtH65xFbTP1KkndwXDfEsPxFy0atonv
         y1+YXEVh6u1LSGTH/UQFE2KmbtlgcroPEFnAZSGRYRNgUBBzJZ7KVH1ateC+NeiSx0
         DKD/KQLQVRPbBIPl0xstP4ULhwNpdcEUeHVRKipY=
Date:   Fri, 17 Jul 2020 19:16:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v2 3/3] mfd: intel-m10-bmc: add Max10 BMC chip support
 for Intel FPGA PAC
Message-ID: <20200717181609.GB905@sirena.org.uk>
References: <1594896174-18826-1-git-send-email-yilun.xu@intel.com>
 <1594896174-18826-4-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <1594896174-18826-4-git-send-email-yilun.xu@intel.com>
X-Cookie: Haste makes waste.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2020 at 06:42:54PM +0800, Xu Yilun wrote:

> +static const struct spi_device_id m10bmc_spi_id[] = {
> +	{ "m10-n3000", M10_N3000 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);

> +static struct spi_driver intel_m10bmc_spi_driver = {
> +	.driver = {
> +		.name = "intel-m10-bmc",
> +		.dev_groups = m10bmc_dev_groups,
> +	},
> +	.probe = intel_m10_bmc_spi_probe,
> +	.id_table = m10bmc_spi_id,
> +};

> +module_spi_driver(intel_m10bmc_spi_driver);

This device has no ACPI information - how will it be instantiated?

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8R6ugACgkQJNaLcl1U
h9BzDwf/XwIckYKy5qCbJu8ahnG9m6wbuq1lenJROybxusWsvQh8yn6HvtHH+tFE
5pjz0NpjEvBOHVoi+psC24keNT69SBa9hH2urwpxSIB+qflpBWf1awjkawN4qmJV
xzlxEGLBMbpvB3iJfGAHtesHFDZm2ulIaIg9appYmpwAEf8gcDWPtl1FOYQ1klg4
sltzKARgqD1PCoSBsEVI1azxrJwHFQj+2oGvRwRZzIrSKdA/q1yf2yWwytsApt/e
4AY8gsvXscQHheB9K2APqIlqm1Oc5TJ/v/dpBoPqCEB1flM1KehH26TZBFuYeU2e
qns7ZU46xwXYav4cK886nI2JiKW+pg==
=cziV
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
