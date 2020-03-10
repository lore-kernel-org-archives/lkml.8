Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA9EC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1EC24692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgCJLPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:15:09 -0400
Received: from sauhun.de ([88.99.104.3]:47520 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgCJLPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:15:07 -0400
Received: from localhost (p54B33196.dip0.t-ipconnect.de [84.179.49.150])
        by pokefinder.org (Postfix) with ESMTPSA id 33A132C1EB6;
        Tue, 10 Mar 2020 12:15:06 +0100 (CET)
Date:   Tue, 10 Mar 2020 12:15:05 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Alain Volmat <alain.volmat@st.com>
Cc:     pierre-yves.mordret@st.com, alexandre.torgue@st.com,
        linux-i2c@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
Subject: Re: [PATCHv2 3/5] i2c: i2c-stm32f7: add a new st,stm32mp15-i2c
 compatible
Message-ID: <20200310111505.GQ1987@ninjato>
References: <1583148796-24285-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V2tfspbppmK1TQo2"
Content-Disposition: inline
In-Reply-To: <1583148796-24285-1-git-send-email-alain.volmat@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V2tfspbppmK1TQo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2020 at 12:33:16PM +0100, Alain Volmat wrote:
> Add a new stm32mp15 specific compatible to handle FastMode+
> registers handling which is different on the stm32mp15 compared
> to the stm32f7 or stm32h7.
> Indeed, on the stm32mp15, the FastMode+ set and clear registers
> are separated while on the other platforms (F7 or H7) the control
> is done in a unique register.
>=20
> Signed-off-by: Alain Volmat <alain.volmat@st.com>
> Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ----
> v2: adapt struct stm32f7_i2c_dev fmp register variable naming (regmap_ ->=
 fmp_)
> ---

Please move the "v2" information after the "---" so our tools can cut
them off automatically. A custom "----" is not not detected.

Applied to for-next, thanks!


--V2tfspbppmK1TQo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5ndrkACgkQFA3kzBSg
KbarhxAAqcBaLCnzs4qnFRbgblz5ZqjqbO5416DrW/MoOQ+g+6VA+t/2evDb3Ww6
nz7e48UVYa0TEwRBkFLlb//9j/K8vov/uqKHmLbJHwqQRr6RUN73pVw7OF1z8CHg
GeyFW0Q1Dta3OuuDRKVCgcEcfPDH+jvkr3zUDZUi2SmwriuexWpqVAfXq8M90YiH
9iFHhrtOV9BUxlYclWllyMOZosuCFxsMTeQDabrPJgqMWovq+UZNtL9E8rv9+/Kh
KrsYUngBLRYvwLDhrCl0B4YX7dcRt+qSN+tedHPfP57pPlF/XhQctr1vzlppB+VS
GK5NqXjM1zBcMax5m0xk6IrPj50MhKlms52bVrSWNToF838iUBglxoEjM0tezPqi
1xxKvOWafWWBvMK7fiYoNDS5mwTFt2PkunVZ93xT/8nEEChLNHQCZS6uImwO8rCx
i0cKHBBSMxPAbs0TftAqz+LTvoSFKbVJ2BDonAbyjdyJqCdKwuyme5LTWcQy7FXT
K3FHDYfHJ/Kw2hbK1BVlXoXo9bqeBrW83NWsWYaxJmAcEu4TTh+/3HeoL83hdlcw
kpBmvEa2b9CQNaN/KFyI19XfR9sv4FdvlxZYQWdZ+rU6ZU9tSRPXrz3pXikly2pj
goj61CYymvTiBvTzZum4mQngiq7hmypLwQ5RxPHD4UkW633qqYc=
=q/s7
-----END PGP SIGNATURE-----

--V2tfspbppmK1TQo2--
