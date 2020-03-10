Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BD6C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089D8205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCJLSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:18:36 -0400
Received: from sauhun.de ([88.99.104.3]:47554 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgCJLSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:18:36 -0400
Received: from localhost (p54B33196.dip0.t-ipconnect.de [84.179.49.150])
        by pokefinder.org (Postfix) with ESMTPSA id B82582C1EB6;
        Tue, 10 Mar 2020 12:18:34 +0100 (CET)
Date:   Tue, 10 Mar 2020 12:18:34 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Alain Volmat <alain.volmat@st.com>
Cc:     pierre-yves.mordret@st.com, alexandre.torgue@st.com,
        linux-i2c@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fabrice.gasnier@st.com
Subject: Re: [PATCH] i2c: stm32f7: do not backup read-only PECR register
Message-ID: <20200310111834.GR1987@ninjato>
References: <1583413141-1268-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TDVcAd+kFgbLxwBe"
Content-Disposition: inline
In-Reply-To: <1583413141-1268-1-git-send-email-alain.volmat@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TDVcAd+kFgbLxwBe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 01:59:01PM +0100, Alain Volmat wrote:
> The PECR register provides received packet computed PEC value.=C2=A0
> It makes no sense restoring its value after a reset, and anyway,
> as read-only register it cannot be restored.
>=20
> Fixes: ea6dd25deeb5 ("i2c: stm32f7: add PM_SLEEP suspend/resume support")
> Signed-off-by: Alain Volmat <alain.volmat@st.com>

Looks good, but I can't apply. Please rebase on top of your other
patches.


--TDVcAd+kFgbLxwBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5nd4oACgkQFA3kzBSg
KbZHZg//eBBQyGXSgFi5dgT7rnfeukqPIx67/g3xi+EVigN2zR1MqSNIRgS6gdI2
hou5993KGHyxg55JYVEGPjPriPPyXkBkmaXvsH5luYF1cEObodZ7CuBalIFldW47
y/bcLA/e9Z+hyCx+W97X+AXDv6/Bncpht8hIzg5Axia8T/yLHixPKgaz3yMHdC9V
ltIOxkEU2QEMLarGbqTeRNEa4/wzVlJuRuwzAR3htjSX0lg7N3/crNnCNZdLT30i
zlBp3FhIJ9mHrUmDleg0rZtQimLiQK/BY0iO3aaCzfUFt3IQSyqQc5uxaqo/Tkn/
hc8/NZ6090W2hRtydtEfJp6mE6R1RaW4w00qLf60uhiK5imsNIPXvNYHKdkG84RJ
CwfcTWzq6JNPIJ+M1VtcZbE7u0rFsNaYVneGThOUes64T8kymMwVAn07wzaK6w7j
+3+tuJNpTWjEi8wvtpEyXRpJtJZTQstFBJPpe7BdjtHL00YViE80h7gFuc6AqoZy
qriyt497GVbwDQPN7qO0w++2dTY/l8awDq0UAodAGcTXl92IOn8jRNvD1UpA9YNI
TwJktN5qx9EHR4qgP1YgInk7kgL2zVT3FXR9XEz//U7ilLjT8mtZGVW1UOzhRUlb
Yomy7tf5FP9VE86KmflMVGg/EQe8+wTIboXbdoWLktq/AS+BQoI=
=Qlcu
-----END PGP SIGNATURE-----

--TDVcAd+kFgbLxwBe--
