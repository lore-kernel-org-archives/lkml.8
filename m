Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2518C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CD420773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgGTKP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:15:26 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:33930 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgGTKP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:15:26 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BB5631C0BE5; Mon, 20 Jul 2020 12:15:23 +0200 (CEST)
Date:   Mon, 20 Jul 2020 12:15:22 +0200
From:   Pavel Machek <pavel@denx.de>
To:     stable@kernel.org, kernel list <linux-kernel@vger.kernel.org>,
        gregkh@duo.ucw.cz, erosca@de.adit-jv.com, roscaeugeniu@gmail.com,
        stern@rowland.harvard.edu, qais.yousef@arm.com,
        linux@prisktech.co.nz, mathias.nyman@intel.com, oneukum@suse.de,
        linux-usb@vger.kernel.org
Subject: hibernation reverts in 4.19.134: better alternative?
Message-ID: <20200720101522.GB13137@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This is queued for 4.19.134-stable, reverting 3 patches. But it seems
better alternative is available...

commit f3e697b7b6f5e2c570226f8f8692fb7db57215ec
Author: Sasha Levin <sashal@kernel.org>
Date:   Fri Jul 17 12:58:32 2020 -0400

    Revert "usb/ohci-platform: Fix a warning when hibernating"
   =20
    This reverts commit c83258a757687ffccce37ed73dba56cc6d4b8a1b.
   =20
    Eugeniu Rosca writes:

=2E..

    > - Backporting 987351e1ea7772 ("phy: core: Add consumer device
    >   link support") to v4.14.187 looks challenging enough, so probably n=
ot
    >   worth it. Anybody to contradict this?

Backporting 987351e1ea7772 to 4.4 may be "interesting", but backport
to 4.19 seems trivial, here, and it seems to work ok according to CIP
test suites:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/168487477

(You can simply apply 987351e1ea7772 ignoring one file that is not yet
present in 4.19.)

Eugeniu, can you verify this works for you?

Best regards,
								Pavel

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 35fd38c5a4a1..600a4e554d17 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -33,7 +33,7 @@ static void devm_phy_release(struct device *dev, void *re=
s)
 {
 	struct phy *phy =3D *(struct phy **)res;
=20
-	phy_put(phy);
+	phy_put(dev, phy);
 }
=20
 static void devm_phy_provider_release(struct device *dev, void *res)
@@ -490,12 +490,12 @@ struct phy *of_phy_get(struct device_node *np, const =
char *con_id)
 EXPORT_SYMBOL_GPL(of_phy_get);
=20
 /**
- * phy_put() - release the PHY
- * @phy: the phy returned by phy_get()
+ * of_phy_put() - release the PHY
+ * @phy: the phy returned by of_phy_get()
  *
- * Releases a refcount the caller received from phy_get().
+ * Releases a refcount the caller received from of_phy_get().
  */
-void phy_put(struct phy *phy)
+void of_phy_put(struct phy *phy)
 {
 	if (!phy || IS_ERR(phy))
 		return;
@@ -503,6 +503,20 @@ void phy_put(struct phy *phy)
 	module_put(phy->ops->owner);
 	put_device(&phy->dev);
 }
+EXPORT_SYMBOL_GPL(of_phy_put);
+
+/**
+ * phy_put() - release the PHY
+ * @dev: device that wants to release this phy
+ * @phy: the phy returned by phy_get()
+ *
+ * Releases a refcount the caller received from phy_get().
+ */
+void phy_put(struct device *dev, struct phy *phy)
+{
+	device_link_remove(dev, &phy->dev);
+	of_phy_put(phy);
+}
 EXPORT_SYMBOL_GPL(phy_put);
=20
 /**
@@ -570,6 +584,7 @@ struct phy *phy_get(struct device *dev, const char *str=
ing)
 {
 	int index =3D 0;
 	struct phy *phy;
+	struct device_link *link;
=20
 	if (string =3D=3D NULL) {
 		dev_WARN(dev, "missing string\n");
@@ -591,6 +606,13 @@ struct phy *phy_get(struct device *dev, const char *st=
ring)
=20
 	get_device(&phy->dev);
=20
+	link =3D device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
+	if (!link) {
+		dev_err(dev, "failed to create device link to %s\n",
+			dev_name(phy->dev.parent));
+		return ERR_PTR(-EINVAL);
+	}
+
 	return phy;
 }
 EXPORT_SYMBOL_GPL(phy_get);
@@ -684,6 +706,7 @@ struct phy *devm_of_phy_get(struct device *dev, struct =
device_node *np,
 			    const char *con_id)
 {
 	struct phy **ptr, *phy;
+	struct device_link *link;
=20
 	ptr =3D devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
@@ -695,6 +718,14 @@ struct phy *devm_of_phy_get(struct device *dev, struct=
 device_node *np,
 		devres_add(dev, ptr);
 	} else {
 		devres_free(ptr);
+		return phy;
+	}
+
+	link =3D device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
+	if (!link) {
+		dev_err(dev, "failed to create device link to %s\n",
+			dev_name(phy->dev.parent));
+		return ERR_PTR(-EINVAL);
 	}
=20
 	return phy;
@@ -717,6 +748,7 @@ struct phy *devm_of_phy_get_by_index(struct device *dev=
, struct device_node *np,
 				     int index)
 {
 	struct phy **ptr, *phy;
+	struct device_link *link;
=20
 	ptr =3D devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
@@ -738,6 +770,13 @@ struct phy *devm_of_phy_get_by_index(struct device *de=
v, struct device_node *np,
 	*ptr =3D phy;
 	devres_add(dev, ptr);
=20
+	link =3D device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
+	if (!link) {
+		dev_err(dev, "failed to create device link to %s\n",
+			dev_name(phy->dev.parent));
+		return ERR_PTR(-EINVAL);
+	}
+
 	return phy;
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_get_by_index);
diff --git a/drivers/usb/renesas_usbhs/rcar2.c b/drivers/usb/renesas_usbhs/=
rcar2.c
index 0027092b1118..c52d36c384e7 100644
--- a/drivers/usb/renesas_usbhs/rcar2.c
+++ b/drivers/usb/renesas_usbhs/rcar2.c
@@ -33,7 +33,7 @@ static int usbhs_rcar2_hardware_exit(struct platform_devi=
ce *pdev)
 	struct usbhs_priv *priv =3D usbhs_pdev_to_priv(pdev);
=20
 	if (priv->phy) {
-		phy_put(priv->phy);
+		phy_put(&pdev->dev, priv->phy);
 		priv->phy =3D NULL;
 	}
=20
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 9713aebdd348..e969b604cb54 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -185,7 +185,8 @@ struct phy *devm_of_phy_get(struct device *dev, struct =
device_node *np,
 			    const char *con_id);
 struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_nod=
e *np,
 				     int index);
-void phy_put(struct phy *phy);
+void of_phy_put(struct phy *phy);
+void phy_put(struct device *dev, struct phy *phy);
 void devm_phy_put(struct device *dev, struct phy *phy);
 struct phy *of_phy_get(struct device_node *np, const char *con_id);
 struct phy *of_phy_simple_xlate(struct device *dev,
@@ -348,7 +349,11 @@ static inline struct phy *devm_of_phy_get_by_index(str=
uct device *dev,
 	return ERR_PTR(-ENOSYS);
 }
=20
-static inline void phy_put(struct phy *phy)
+static inline void of_phy_put(struct phy *phy)
+{
+}
+
+static inline void phy_put(struct device *dev, struct phy *phy)
 {
 }
=20


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8VbroACgkQMOfwapXb+vIsdgCeN8e0SOmPQhjKnsYZaF90xKl4
lCEAoIOXJk+fLM5ZKytKp2EmossZ1aME
=DooB
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
