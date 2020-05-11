Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE0EC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6123C206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbgEKURD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKURD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:17:03 -0400
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB29AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:17:02 -0700 (PDT)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 56683981F75; Mon, 11 May 2020 22:17:01 +0200 (CEST)
Date:   Mon, 11 May 2020 22:16:56 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: Failure to shutdown/reboot with intel_iommu=on
Message-ID: <20200511201656.GA2725@taurus.defre.kleine-koenig.org>
References: <20200506144558.GA4019@taurus.defre.kleine-koenig.org>
 <20200508150734.GP8135@suse.de>
 <bd9fb298-1ad3-fd4c-19f7-aae4c2b62daa@linux.intel.com>
 <11a3945a-f743-ac32-135c-1de026da66c9@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <11a3945a-f743-ac32-135c-1de026da66c9@kleine-koenig.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again,

On Mon, May 11, 2020 at 09:59:31PM +0200, Uwe Kleine-K=F6nig wrote:
> On 5/9/20 3:58 AM, Lu Baolu wrote:
> > Hi Uwe,
> >=20
> > Have you tried commenting out intel_disable_iommus() in
> > intel_iommu_shutdowan()?
> >=20
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 0182cff2c7ac..532e62600f95 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -4928,8 +4928,10 @@ void intel_iommu_shutdown(void)
> > =A0=A0=A0=A0=A0=A0=A0 for_each_iommu(iommu, drhd)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iommu_disable_protect_mem=
_regions(iommu);
> >=20
> > +#if 0
> > =A0=A0=A0=A0=A0=A0=A0 /* Make sure the IOMMUs are switched off */
> > =A0=A0=A0=A0=A0=A0=A0 intel_disable_iommus();
> > +#endif
> >=20
> > =A0=A0=A0=A0=A0=A0=A0 up_write(&dmar_global_lock);
> > =A0}
>=20
> I just tested that and it didn't help. The machine still hangs with the
> same symptoms as reported before.

I patched the file a bit differently:

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ef0a5246700e..b76acae6a6ac 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4922,16 +4922,24 @@ void intel_iommu_shutdown(void)
 	if (no_iommu || dmar_disabled)
 		return;
=20
+	pr_warn("%s:%d\n", __func__, __LINE__);
 	down_write(&dmar_global_lock);
=20
+	pr_warn("%s:%d\n", __func__, __LINE__);
 	/* Disable PMRs explicitly here. */
-	for_each_iommu(iommu, drhd)
+	for_each_iommu(iommu, drhd) {
+		pr_warn("%s:%d\n", __func__, __LINE__);
 		iommu_disable_protect_mem_regions(iommu);
+		pr_warn("%s:%d\n", __func__, __LINE__);
+	}
=20
+	pr_warn("%s:%d\n", __func__, __LINE__);
 	/* Make sure the IOMMUs are switched off */
 	intel_disable_iommus();
=20
+	pr_warn("%s:%d\n", __func__, __LINE__);
 	up_write(&dmar_global_lock);
+	pr_warn("%s:%d\n", __func__, __LINE__);
 }
=20
 static inline struct intel_iommu *dev_to_intel_iommu(struct device *dev)

and the output shows that the for_each_iommu loop runs twice and the
last pr_warn is reached, too. So the hang doesn't occur in
intel_iommu_shutdown() but later.

I don't know enough about x86 and iommus to judge what that means or
even if this was a useful test.

Best regards
Uwe

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl65srQACgkQwfwUeK3K
7AnJTgf+O5xIGA9I6hKnJ72zZZW7bZS07Yrt30PfSkzYcCNOeYU9gjF2/Dis/JX1
P/VPEE3+yENFD8fW8ZP1/Y2ml7eeCO1/zCdeLjuE/AVj282V+8fHgwjLfJUd/QR3
rypvOfsmBuJFyv+WuXqQloTYB6oSiSRn5xKtyfshRQH/B0IAqjC9kGWma7dkqDve
NakrmX5fkgZ4flsv+4zdVLFD9tYeLRq2AM/j+B9okgZyM521V5NniwubdMn53tfm
XVNjYn0sgUsq5lgQyOQaT7UW6MIuOOCFYFh5gWUL+KObY6YaleLBVtI6GLyL55A4
X8MBHcWYlv3iaen4++grZsZOci6PRQ==
=6lsu
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
