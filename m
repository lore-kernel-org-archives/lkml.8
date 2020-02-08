Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11085C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 19:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE812253D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 19:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qubes-os.org header.i=frederic.pierret@qubes-os.org header.b="aho9vRRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgBHT6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 14:58:47 -0500
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21899 "EHLO
        sender4-of-o58.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbgBHT6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 14:58:47 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Feb 2020 14:58:46 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1581191015;
        s=s; d=qubes-os.org; i=frederic.pierret@qubes-os.org;
        h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type;
        bh=4UMIRX/WyO4WPJxy81RyadUUcsnUGWlHOmbQ6Au+Adw=;
        b=aho9vRRvhnk2FpRErf38+/MEObzvwxaTurt+edbLy96tJbcgb/3dPKq74mB3lI5j
        QEepVG9fLYkVEltOPuE6wxCNAGPMZXkXolO5Ysv3mQCxggkZTUoaZcxkXI3Elnc5tn3
        AtDFkEXGsEDgpMgK8PUbchHwTyVHWq9Q7HAa2drk=
Received: from [10.137.0.45] (82.102.18.6 [82.102.18.6]) by mx.zohomail.com
        with SMTPS id 1581191012557842.0701714079564; Sat, 8 Feb 2020 11:43:32 -0800 (PST)
From:   =?UTF-8?B?RnLDqWTDqXJpYyBQaWVycmV0?= 
        <frederic.pierret@qubes-os.org>
Subject: [PATCH] nv50_disp_chan_mthd: ensure mthd is not NULL
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <dac89843-5258-5bed-ee86-7038e94e56da@qubes-os.org>
Date:   Sat, 8 Feb 2020 20:43:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="B4yCyaNyqdN68C01OPt6rR5nIf1KF21jl"
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B4yCyaNyqdN68C01OPt6rR5nIf1KF21jl
Content-Type: multipart/mixed; boundary="TIhELMerY5yoVKYrPM88CXOKjlxsWwbcW"

--TIhELMerY5yoVKYrPM88CXOKjlxsWwbcW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Pointer to structure array is assumed not NULL by default. It has
the consequence to raise a kernel panic when it's not the case.

Basically, running at least a RTX2080TI on Xen makes a bad mmio error
which causes having 'mthd' pointer to be NULL in 'channv50.c'. From the
code, it's assumed to be not NULL by accessing directly 'mthd->data[0]'
which is the reason of the kernel panic. Simply check if the pointer
is not NULL before continuing.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D206299
Cc: stable@vger.kernel.org
Signed-off-by: Fr=C3=A9d=C3=A9ric Pierret (fepitre) <frederic.pierret@qub=
es-os.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c b/driver=
s/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
index bcf32d92ee5a..50e3539f33d2 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
@@ -74,6 +74,8 @@ nv50_disp_chan_mthd(struct nv50_disp_chan *chan, int de=
bug)
=20
 	if (debug > subdev->debug)
 		return;
+	if (!mthd)
+		return;
=20
 	for (i =3D 0; (list =3D mthd->data[i].mthd) !=3D NULL; i++) {
 		u32 base =3D chan->head * mthd->addr;
--=20
2.21.0



--TIhELMerY5yoVKYrPM88CXOKjlxsWwbcW--

--B4yCyaNyqdN68C01OPt6rR5nIf1KF21jl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn6ZLkvlecGvyjiymSEAQtc3FduIFAl4/D18ACgkQSEAQtc3F
duIJFhAAzN4V0d2b9UNZOSl5OOGjbUHnimbJA3Y51i+r3r+rEInrItxwl2c8asfm
mHaq3BdBfcGVrb0rkFssztpze7mtt+UBBvmDYSGGHrStyGEpeoZJ659PI0EmZr/U
PwRHspPkOwb5N2DSDZJ83j/O/lZE3x61YFOAum11JW6xOJOT7lTLlzO/NYosktnj
VNM/WAbUt5muS3ZZAlPCpaX8vMS3oFG7ssPCYtq56w9BaaOZuWiAA41vtCAc79Sm
pE6BjWEmcD22tBF19/V0wnbENXfv2AKgw2X1VIChjXDYW0+Rd7DVOMiNnRU+9brD
3pyyKppbrakHy6u9S7762NDCJvtLDL2dkYaN/VdtKw41jwTCRg0O/IG16jjRT/Z2
OZRPWBo1wibMsgXB6LfAvE6Y/GDS6N0imGsJgq/mZe6j7wexDTLwLu5GCLWUDFP3
RvBpHBx5w17KCMQ0pYnFkLdZTc7gkqhqdI5FeDK4QBbNTi8tKvmSNzs7/ZWLaUI9
vGqteuMnmrs8+mMZxrfIk7oijIFNKnv3JJIM2Hbovfx9e7haKuIZ7M5LqEC3fNuY
4d9BCj4xnF0S5UFM+VP0lGB5PoMXnTuwHzsIjBqDErpsFH3J69Inh/7+hVECbs2U
Yg3Ui9xyK9AEEFw83u9BXS90ZlvwIFWKJvgenDQs9zarslW0vQE=
=8SIN
-----END PGP SIGNATURE-----

--B4yCyaNyqdN68C01OPt6rR5nIf1KF21jl--
