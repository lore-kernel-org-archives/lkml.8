Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849D3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5719220717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595009722;
	bh=etga1kcOMHqFWeb1YND8jg93xKqiY1c6UgFtugk/erk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jc498QrJewAhSa/9VTUNGpC6H5DuTsouUHaedqIeh0NyQQ9ZAo4ixC2h1c7V9OczD
	 hl9WO3RUz1hEV8F3JHQLmw/BXb+f48WQNiopQ/ftf9i4V7N2pFvIaZvXB3Zb1SlBY+
	 xUqb/50cIfAh4JCCEKJrvQDdSMHnIgd6gaYeu/n8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGQSPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgGQSPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:15:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74ACD206F4;
        Fri, 17 Jul 2020 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595009720;
        bh=etga1kcOMHqFWeb1YND8jg93xKqiY1c6UgFtugk/erk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPjYGdX8Z4a7PZCJCmkomJzf/XKQRpNDKdvpL29AS7RZzq9AHaGPzzaLpnag5BZmR
         Y3ygkRyFpVZTapNTSGJlan5b+jja5qt3wBTcuCwNl5OFt2ID4Lwdyg95HlyuZ06cwG
         gE4BIBgEPMzFQ5atcg0lfGNKqJAPsnuuLcUkkDXI=
Date:   Fri, 17 Jul 2020 19:15:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v2 1/3] regmap: add Intel SPI Slave to AVMM Bus Bridge
 support
Message-ID: <20200717181508.GA905@sirena.org.uk>
References: <1594896174-18826-1-git-send-email-yilun.xu@intel.com>
 <1594896174-18826-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <1594896174-18826-2-git-send-email-yilun.xu@intel.com>
X-Cookie: Haste makes waste.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 06:42:52PM +0800, Xu Yilun wrote:

> This patch add support for regmap API that is intended to be used by
> the drivers of some SPI slave chips which integrate the "SPI slave to
> Avalon Master Bridge" (spi-avmm) IP.

At a very high level this looks far too complicated.  Some of that is
due to the protocol it's implementing which looks awfully like you've
got a microcontroller in there trying to proxy a bus of some kind but
there looks to be a lot of abstraction layers simply within the software
here which make things hard to follow.  At the very least there doesn't
seem to be any interaction with this other than proxying stuff.  As
things stand this would be the largest regmap bus implementation by an
order of magnitude.

It is not clear to me that this is really a generic thing that will have
multiple users and that it shouldn't be implemented as reg_read() and
reg_write() operations in the driver that uses it.

> +config REGMAP_SPI_AVMM
> +	tristate
> +	depends on SPI

Note that for selected symbols dependencies don't take effect.

> @@ -0,0 +1,932 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Intel SPI Slave to AVMM Bus Bridge

Please make the entire comment a C++ one so things look omre
intentional.

> + * Reference Documents could be found at:
> + * https://www.intel.com/content/www/us/en/programmable/documentation/
> + * sfo1400787952932.html

Please don't corrupt links like this, that makes them harder to use.

> + * The main function of the physical layer is the use of PHY_IDLE (4a). =
Host
> + * issues SCLK to query data from slave, but if slave is not ready to su=
bmit
> + * data yet, it will repeat PHY_IDLE until data is prepared.
> + * Because of this special char, it also needs an ESCAPE char (4d), to h=
elp
> + * represent data "4a". The escape rule is "4d first, following 4a ^ 20".
> + * So "4d, 6a" for data "4a", and "4d, 6d" for data "4d".

> + * The packet layer defines the boundary of a whole packet. It defines t=
he
> + * Start Of Packet (SOP, 7a) char and End Of Packet (EOP, 7b) char. Plea=
se
> + * note that the non-special byte after EOP is the last byte of the pack=
et.
> + * The packet layer also defines a Channel char (7c) + Channel number for
> + * multiple channel transfer. This not currently supported by this drive=
r. So
> + * host will always send "7c, 00" when needed, and will drop the packet =
if
> + * "7c, non-zero" is received.
> + * Finally, a packet layer ESCAPE char (7d) is also needed to represent a
> + * data value that is the same as the special chars. The escape rule is =
the
> + * same. The escape rule should be used if the last byte requires it. So=
 if a
> + * packet ends up with data 7a, the last bytes should be "7b, 7d, 5a".

This comment is not particularly intelligable.  I assume all these
number/letter combinations are references to something - it'd be good to
say what.

> +/* slave's register addr is 32 bits */
> +#define REG_SIZE		4UL
> +/* slave's register value is 32 bits */
> +#define VAL_SIZE		4UL

These and many of the other constants are liable to conflict with
something, namespacing would be good.

> +struct trans_header {
> +	u8 trans_code;
> +	u8 rsvd;
> +	__be16 size;
> +	__be32 addr;
> +};
> +
> +struct trans_response {
> +	u8 r_trans_code;
> +	u8 rsvd;
> +	__be16 size;
> +};

Do these need to be packed?

> +/* No additional chars are in transaction layer RX, just read out data */
> +#define TRANS_RX_MAX		(VAL_SIZE * MAX_RX_CNT)
> +/*

Blank line before the comment.

> +#define TRANS_BUF_SIZE		((TRANS_TX_MAX > TRANS_RX_MAX) ?	\
> +				 TRANS_TX_MAX : TRANS_RX_MAX)

This could be more simply written using max() couldn't it (which IIRC
can also be evaluated at compile time)?

> +/* Format a transaction layer byte stream for tx_buf */
> +static void trans_tx_prepare(bool is_read, u32 reg, u16 count, u32 *wr_v=
al,
> +			     char *tx_buf, unsigned int *tx_len)
> +{
> +	struct trans_header *header;
> +	u8 trans_code;
> +	__le32 *data;
> +	int i;
> +
> +	trans_code =3D is_read ?
> +			(count =3D=3D 1 ? TRANS_CODE_READ : TRANS_CODE_SEQ_READ) :
> +			(count =3D=3D 1 ? TRANS_CODE_WRITE : TRANS_CODE_SEQ_WRITE);

Please write this using normal conditional statements for legibility.

> +	header =3D (struct trans_header *)tx_buf;

No need to cast away from char *.

> +/*
> + * The input is a transaction layer byte stream in rx_buf, the output is=
 read
> + * out data.
> + */
> +static int trans_rx_parse(bool is_read, char *rx_buf, unsigned int rx_le=
n,
> +			  u16 expected_count, u32 *rd_val)
> +{
> +	unsigned int expected_len =3D expected_count * VAL_SIZE;
> +
> +	if (is_read) {
> +		if (expected_len !=3D rx_len)
> +			return -EINVAL;
> +
> +		return rd_trans_rx_parse(rx_buf, rx_len, rd_val);
> +	}
> +
> +	return wr_trans_rx_parse(rx_buf, rx_len, expected_len);
> +}

Please write the is_read check as an if/else, it'd be clearer.

> +/* Packet Layer & Physical Layer */
> +/* The input is a trans stream in trans_buf, format a phy stream in phy_=
buf. */
> +static void pkt_phy_tx_prepare(char *trans_buf, unsigned int trans_len,
> +			       char *phy_buf, unsigned int *phy_len)
> +{
> +	unsigned int i;
> +	char *b, *p;
> +
> +	b =3D trans_buf;
> +	p =3D phy_buf;

I'm not seeing any bounds checking on the size of an operation in this
function and I think I'd expect some, similarly for a lot of the other
I/O operations.

> +	poll_timeout =3D jiffies + SPI_AVMM_XFER_TIMEOUT;
> +	for (;;) {

Please rewrite this loop so it's clear that it terminates, usually
that'd mean a do { } while (!timeout) type construction.  The extra
effort involved in doing one more check after timeout could just as well
be a slightly longer timeout and it'd be clearer.

> +		/*
> +		 * We timeout when rx is invalid for some time. But
> +		 * it is possible we are scheduled out for long time
> +		 * after a spi_read. So when we are scheduled in, a SW
> +		 * timeout happens. But actually HW may have worked fine and
> +		 * has been ready long time ago. So we need to do an extra
> +		 * read, if we get a valid word we return a valid rx word,
> +		 * otherwise real a HW issue happens.
> +		 */
> +		if (time_after(jiffies, poll_timeout))
> +			last_try =3D true;

If the system is that heavily loaded I fear there's bigger problems, you
could also express the timeout in terms of number of times you poll with
a delay (at the minute this will busy wait which doesn't seem ideal
either).

> +static void br_tx_prepare(struct spi_avmm_bridge *br, bool is_read, u32 =
reg,
> +			  u16 count, u32 *wr_val)
> +{
> +	unsigned int tx_len;
> +
> +	trans_tx_prepare(is_read, reg, count, wr_val,
> +			 br->trans_buf, &tx_len);
> +	pkt_phy_tx_prepare(br->trans_buf, tx_len,
> +			   br->phy_buf, &tx_len);
> +	phy_tx_pad(br->word_len, br->phy_buf, tx_len, &tx_len);
> +
> +	br->phy_len =3D tx_len;
> +}

This is the sort of thing I'm looking at when I say this code has too
many abstraction layers, this function and all of the functions it calls
have exactly one caller spread out all over the code and I can't help
but think that some of them could be usefully inlined.  As things stand
it's really hard to tell what any individual bit of code is supposed to
be doing or if it's doing it correctly.

> +	ret =3D ret ? : (eop ? 0 : -EINVAL);
> +	if (ret) {
> +		dev_err(&br->spi->dev, "%s br txrx err %d\n", __func__, ret);
> +		print_hex_dump(KERN_DEBUG, "phy rx:", DUMP_PREFIX_OFFSET,
> +			       16, 1, br->phy_buf, rx_len, true);
> +	}

Please write normal conditional statements for legibility.

> +
> +#define do_reg_read(_ctx, _reg, _value, _count) \
> +	do_reg_access(_ctx, true, _reg, _value, _count)
> +#define do_reg_write(_ctx, _reg, _value, _count) \
> +	do_reg_access(_ctx, false, _reg, _value, _count)

Please write these as proper functions so that the compiler can check
things more thoroughly.

> +static int regmap_spi_avmm_gather_write(void *context,
> +					const void *reg_buf, size_t reg_len,
> +					const void *val_buf, size_t val_len)
> +{
> +	if (reg_len !=3D REG_SIZE)
> +		return -EINVAL;
> +
> +	return do_reg_write(context, *(u32 *)reg_buf, (u32 *)val_buf,
> +			    (u16)(val_len / VAL_SIZE));
> +}

The cast on the length looks worrying... =20

> +	/* Only support BPW =3D=3D 8 or 32 now */
> +	if (spi->bits_per_word !=3D 8 && spi->bits_per_word !=3D 32)
> +		return ERR_PTR(-EINVAL);

Most controllers support configurable bits per word (and modes) - you
shouldn't be rejecting things based on whatever the default happens to
be.

> +static const struct regmap_bus regmap_spi_avmm_bus =3D {
> +	.write =3D regmap_spi_avmm_write,
> +	.gather_write =3D regmap_spi_avmm_gather_write,
> +	.read =3D regmap_spi_avmm_read,
> +	.reg_format_endian_default =3D REGMAP_ENDIAN_NATIVE,
> +	.val_format_endian_default =3D REGMAP_ENDIAN_NATIVE,
> +	.max_raw_read =3D VAL_SIZE * MAX_RX_CNT,
> +	.max_raw_write =3D VAL_SIZE * MAX_TX_CNT,
> +
> +	.reg_write =3D regmap_spi_avmm_reg_write,
> +	.reg_read =3D regmap_spi_avmm_reg_read,
> +
> +	.free_context =3D spi_avmm_bridge_ctx_free,
> +};

This seems confused, you shouldn't have both unformatted I/O operations
and register I/O operations.  Either the hardware implements a byte
stream and the core will handle formatting register operations into that
byte stream or the hardware understands registers and values in which
case there shouldn't be unformatted operations.  A combination of the
two is not going to work well.

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8R6qsACgkQJNaLcl1U
h9D9qAf/Taay5FL2xygBVg2GO3GH8nROBYczOgibH5Ii+UeF/oZbS42oSFEw8sBY
n+hEopF4GDn9iPt66Qe4xteY1rnsb8jQ+74wDrlnjpDkaC/jdWGiZSiabezDNIMv
Kky8tSh50eLLLUEEgLPPBzuJMalkPNIbqSbe2u6BQRGTnr2ptngVOKQJvXEywwng
chTnXc2FVp8BxcPbHsG/k5OfKCG3CU4IVMMKPDaQVbdPO9jRWK7DUyB/bRD+AFEV
EW/gCtypoZsfe/3QO6nG0tJeXDnq/ruAiFygR2MfIeHoswIeS+1A7+zecPTJPGmJ
WASrPCzQB8FXXWHhBGQzBdDoZvPAug==
=jC7H
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
