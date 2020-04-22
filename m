Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEAEC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C631D2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587563793;
	bh=sVM9uYAsJEFQRRF4MR/h5PGj4S/CY4CR+l7xE0S4gDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=glkQF351ZS7OIHC1RZk3PRQAjOmJHoPM6g6rHpytsEDZL9S83qMrwUpXJa3Dnsh/n
	 xInMAwUVqNIWTKjju1KYdsiAGqgUM7cbo8/+NdL5A1x2EUB2Gp63qBxDGjvI5E4MA2
	 cVYHWeMcZpoWX5o/1HnadkgHBS2ks7I+xR0J2FA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgDVN4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:32818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgDVN4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:56:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25B9E20787;
        Wed, 22 Apr 2020 13:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587563791;
        bh=sVM9uYAsJEFQRRF4MR/h5PGj4S/CY4CR+l7xE0S4gDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z1HV3HJJoW47uF7/DCe0Oz8nq3izozwQVz7G3NZzahemijDYOwSCHWcKMB1hhnMab
         24EPkxAMcYB8fCryB+fLI4tB0fKw4ySbiPmelgZhoIx9zKTfPknaQppFaiInxB3XM+
         +fbqa9V+BgeMQ88muFajktWaO5GclH38nGexXQBM=
Date:   Wed, 22 Apr 2020 14:56:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 11/23] sched,spi: Convert to sched_set_fifo*()
Message-ID: <20200422135628.GH4898@sirena.org.uk>
References: <20200422112719.826676174@infradead.org>
 <20200422112831.870192415@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dx9iWuMxHO1cCoFc"
Content-Disposition: inline
In-Reply-To: <20200422112831.870192415@infradead.org>
X-Cookie: A stitch in time saves nine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dx9iWuMxHO1cCoFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 01:27:30PM +0200, Peter Zijlstra wrote:
> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
>=20
> No effective change.

Copying Doug who did this change and Guenter who reviewed it.  This
looks fine to me but I've no particular involvement with the code or
platforms that are affected here.

> Cc: broonie@kernel.org
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/platform/chrome/cros_ec_spi.c |    6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -709,9 +709,6 @@ static void cros_ec_spi_high_pri_release
>  static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
>  					   struct cros_ec_spi *ec_spi)
>  {
> -	struct sched_param sched_priority =3D {
> -		.sched_priority =3D MAX_RT_PRIO / 2,
> -	};
>  	int err;
> =20
>  	ec_spi->high_pri_worker =3D
> @@ -728,8 +725,7 @@ static int cros_ec_spi_devm_high_pri_all
>  	if (err)
>  		return err;
> =20
> -	err =3D sched_setscheduler_nocheck(ec_spi->high_pri_worker->task,
> -					 SCHED_FIFO, &sched_priority);
> +	err =3D sched_set_fifo(ec_spi->high_pri_worker->task);
>  	if (err)
>  		dev_err(dev, "Can't set cros_ec high pri priority: %d\n", err);
>  	return err;
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1589,11 +1589,9 @@ EXPORT_SYMBOL_GPL(spi_take_timestamp_pos
>   */
>  static void spi_set_thread_rt(struct spi_controller *ctlr)
>  {
> -	struct sched_param param =3D { .sched_priority =3D MAX_RT_PRIO / 2 };
> -
>  	dev_info(&ctlr->dev,
>  		"will run message pump with realtime priority\n");
> -	sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
> +	sched_set_fifo(ctlr->kworker_task);
>  }
> =20
>  static int spi_init_queue(struct spi_controller *ctlr)
>=20
>=20

--Dx9iWuMxHO1cCoFc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6gTQwACgkQJNaLcl1U
h9DaXwf9FBhG1G0JAk62V1nu2JHA2kO4LvughfIdOhEbl+iAXihhFUI2g91OtWLM
vSi8yOfz05Ii/iJA/rFV4bOP0Fk8YsCwm7CgVI9/Ihjv/87BrYnysUBsla2wZcqz
taHnjad7MrkedyziSbpOMqXwkdY+MOTWXwjEMXKrcPr2Y73Pps0BTU7Hgha+DKHZ
t4mkvfq2zKDVr5rlI22A1WgNlRVXtDGHpop6SQ+JKaljbIFVE3mozTIQhuLnFxZk
KleE0cUIuk6rUxLZIjjuaJ82JVLFLtqQU2UBsj582HlrNwUaxZSnTIBxnV81ckys
foqHcvo+gf0hD5n7Qa4s5IvPMLbImw==
=V8uV
-----END PGP SIGNATURE-----

--Dx9iWuMxHO1cCoFc--
