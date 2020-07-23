Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51D0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C462080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595489102;
	bh=4ypnH/dRrdyD3eMn9X4UbG4Wd3PT6+4KmqAFPPQePv8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NfVgU++lsvrtn2OLQsN/v4CkbHYP3GZe8NULcGuuseDSIGn3bGP1hS9Lv32q03d+w
	 kphbP4Qp3lq/rSramHT6S7L+Pnp6yhJwJKAoNDJlp03HX82BwCuxWgnXEmBjns6MjS
	 TLo6dRH3+3nXjzLX1p+3GN8yWNIxkpa8q5JuQxoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGWHZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgGWHZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:25:00 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 050D52080D;
        Thu, 23 Jul 2020 07:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595489100;
        bh=4ypnH/dRrdyD3eMn9X4UbG4Wd3PT6+4KmqAFPPQePv8=;
        h=Date:From:To:Cc:Subject:From;
        b=oiWquGaMc9YH7U8OJt0T55MMInqqNuqfetLTIwNCywj5CCK7l/o/G8DMELaM+Hflq
         eaYxx007GpV/BDFhe0cB+wJ1iCkjDixzoFrixnMibezt1unexVxZPhchDftuDxhhCD
         oKlv8jgV4bEhhdbWhpve7DG4pL8FhZgL3qIBFWtQ=
Date:   Thu, 23 Jul 2020 12:54:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] phy updates for 5.9-rc1
Message-ID: <20200723072455.GW12965@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Here are the updates for phy subsystem for 5.9. Please pull.

The following changes since commit 38b1927e5bf9bcad4a2e33189ef1c5569f9599ba:

  phy: sun4i-usb: fix dereference of pointer phy0 before it is null checked=
 (2020-06-25 18:25:37 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-5.9

for you to fetch changes up to 3d7b0ca5300bd01b176f2b4c10e173db802560d8:

  phy: qualcomm: fix setting of tx_deamp_3_5db when device property read fa=
ils (2020-07-21 23:11:48 +0530)

----------------------------------------------------------------
phy for 5.9

 - New PHY Drivers:
   - Samsung UFS
   - Qcom USB DWC for ipq806x
   - Xilinx ZynqMP Gigabit Transceiver
   - Qcom USB QMP for IPQ8074
   - BCM63xx USBH

 - Removed:
   - Qcom ufs qmp phy driver

 - Updates:
   - Support for Qcom SM8250 QMP V4 USB3 UNIPHY
   - qcom-snps runtime pm support
   - Cleanup of W=3D1 warns in the subsystem

----------------------------------------------------------------
Alim Akhtar (2):
      dt-bindings: phy: Document Samsung UFS PHY bindings
      phy: samsung-ufs: add UFS PHY driver for samsung SoC

Ansuel Smith (2):
      phy: qualcomm: add qcom ipq806x dwc usb phy driver
      devicetree: bindings: phy: Document ipq806x dwc3 qcom phy

Anurag Kumar Vulisha (2):
      dt-bindings: phy: Add DT bindings for Xilinx ZynqMP PSGTR PHY
      phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver

Colin Ian King (1):
      phy: qualcomm: fix setting of tx_deamp_3_5db when device property rea=
d fails

Gustavo A. R. Silva (1):
      phy: samsung-ufs: Fix IS_ERR argument

Jonathan Marek (3):
      phy: qcom-qmp: Allow different values for second lane
      phy: qcom-qmp: Add QMP V4 USB3 UNIPHY
      phy: qcom-qmp: Add QMP V4 USB3 PHY support for sm8250

Krzysztof Kozlowski (1):
      phy: exynos: Rename Exynos to lowercase

Kunihiko Hayashi (1):
      dt-bindings: phy: uniphier: Fix incorrect clocks and clock-names for =
PXs3 usb3-hsphy

Lad Prabhakar (2):
      dt-bindings: phy: renesas,usb2-phy: Add r8a774e1 support
      dt-bindings: phy: renesas,usb3-phy: Add r8a774e1 support

Laurent Pinchart (1):
      dt-bindings: phy: zynqmp-psgtr: Fix example's numbers of cells in reg

Marek Szyprowski (1):
      phy: exynos5-usbdrd: Calibrating makes sense only for USB2.0 PHY

Peter Chen (1):
      phy: cadence: salvo: fix wrong bit definition

Rikard Falkeborn (1):
      phy: allwinner: phy-sun6i-mipi-dphy: Constify structs

Russell King (2):
      dt: update Marvell Armada 38x COMPHY binding
      phy: armada-38x: fix NETA lockup when repeatedly switching speeds

Sivaprakash Murugesan (4):
      dt-bindings: phy: qcom,qmp: Add ipq8074 usb dt bindings
      dt-bindings: phy: qcom,qusb2: Add ipq8074 device compatible
      phy: qcom-qmp: Add USB QMP PHY support for IPQ8074
      phy: qcom-qusb2: Add ipq8074 device compatible

Tiezhu Yang (2):
      phy: Remove CONFIG_ARCH_* check for related subdir in Makefile
      phy: allwinner: Make PHY_SUN6I_MIPI_DPHY depend on COMMON_CLK

Tobias Klauser (1):
      phy: zynqmp: Fix unused-function compiler warning

Vinod Koul (13):
      phy: qcom: remove ufs qmp phy driver
      phy: core: fix code style in devm_of_phy_provider_unregister
      phy: core: Document function args
      phy: ti: dm816x: remove set but unused variable
      phy: ti-pipe3: remove set but unused variable
      phy-mvebu-a3700-utmi: correct typo in struct mvebu_a3700_utmi comments
      phy: mapphone-mdm6600: Add missing description for some structure fie=
lds
      phy: xgene: remove unsigned integer comparison with less than zero
      phy: rockchip-typec: use correct format for structure description
      phy: exynos5-usbdrd: use correct format for structure description
      phy: stm32: use NULL instead of zero
      phy: sun4i-usb: explicitly include gpio/consumer.h
      Merge branch 'fixes' into next

Wesley Cheng (2):
      phy: qcom-snps: Add runtime suspend and resume handlers
      phy: qcom-snps: Add a set mode callback

Yoshihiro Shimoda (2):
      phy: renesas: rcar-gen3-usb2: move irq registration to init
      phy: renesas: rcar-gen3-usb2: exit if request_irq() failed

=C1lvaro Fern=E1ndez Rojas (2):
      dt-bindings: phy: add bcm63xx-usbh bindings
      phy: bcm63xx-usbh: Add BCM63xx USBH driver

 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml        |  79 ++
 .../bindings/phy/phy-armada38x-comphy.txt          |  10 +-
 .../bindings/phy/qcom,ipq806x-usb-phy-hs.yaml      |  55 ++
 .../bindings/phy/qcom,ipq806x-usb-phy-ss.yaml      |  73 ++
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   2 +
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |   1 +
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml  |   1 +
 .../devicetree/bindings/phy/renesas,usb3-phy.yaml  |   1 +
 .../devicetree/bindings/phy/samsung,ufs-phy.yaml   |  75 ++
 .../phy/socionext,uniphier-usb3hs-phy.yaml         |   8 +-
 .../devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml | 105 +++
 MAINTAINERS                                        |   9 +
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |  17 +-
 drivers/phy/allwinner/Kconfig                      |   2 +-
 drivers/phy/allwinner/phy-sun4i-usb.c              |   3 +-
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c        |   4 +-
 drivers/phy/broadcom/Kconfig                       |   8 +
 drivers/phy/broadcom/Makefile                      |   1 +
 drivers/phy/broadcom/phy-bcm63xx-usbh.c            | 457 ++++++++++
 drivers/phy/cadence/phy-cadence-salvo.c            |   2 +-
 drivers/phy/marvell/phy-armada38x-comphy.c         |  45 +-
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c         |   2 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c        |   3 +-
 drivers/phy/phy-core.c                             |   5 +-
 drivers/phy/phy-xgene.c                            |   2 +-
 drivers/phy/qualcomm/Kconfig                       |  34 +-
 drivers/phy/qualcomm/Makefile                      |   4 +-
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c        | 571 ++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 510 ++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   7 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |   3 +
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      |  85 ++
 drivers/phy/qualcomm/phy-qcom-ufs-i.h              | 131 ---
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c       | 172 ----
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.h       | 168 ----
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c       | 226 -----
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.h       | 226 -----
 drivers/phy/qualcomm/phy-qcom-ufs.c                | 648 --------------
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |  63 +-
 drivers/phy/rockchip/phy-rockchip-typec.c          |   2 +-
 drivers/phy/samsung/Kconfig                        |  17 +-
 drivers/phy/samsung/Makefile                       |   1 +
 drivers/phy/samsung/phy-exynos-dp-video.c          |   4 +-
 drivers/phy/samsung/phy-exynos-mipi-video.c        |   4 +-
 drivers/phy/samsung/phy-exynos-pcie.c              |   2 +-
 drivers/phy/samsung/phy-exynos5-usbdrd.c           |  16 +-
 drivers/phy/samsung/phy-exynos7-ufs.h              |  81 ++
 drivers/phy/samsung/phy-samsung-ufs.c              | 366 ++++++++
 drivers/phy/samsung/phy-samsung-ufs.h              | 139 +++
 drivers/phy/samsung/phy-samsung-usb2.c             |   2 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |   4 +-
 drivers/phy/ti/phy-dm816x-usb.c                    |  11 +-
 drivers/phy/ti/phy-ti-pipe3.c                      |   5 +-
 drivers/phy/xilinx/Kconfig                         |  13 +
 drivers/phy/xilinx/Makefile                        |   3 +
 drivers/phy/xilinx/phy-zynqmp.c                    | 993 +++++++++++++++++=
++++
 include/dt-bindings/phy/phy.h                      |   1 +
 58 files changed, 3789 insertions(+), 1694 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh=
-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq806x-usb-=
phy-hs.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq806x-usb-=
phy-ss.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,ufs-phy.y=
aml
 create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr=
=2Eyaml
 create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-ufs-i.h
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.h
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.h
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-ufs.c
 create mode 100644 drivers/phy/samsung/phy-exynos7-ufs.h
 create mode 100644 drivers/phy/samsung/phy-samsung-ufs.c
 create mode 100644 drivers/phy/samsung/phy-samsung-ufs.h
 create mode 100644 drivers/phy/xilinx/Kconfig
 create mode 100644 drivers/phy/xilinx/Makefile
 create mode 100644 drivers/phy/xilinx/phy-zynqmp.c

Thanks
--=20
~Vinod

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl8ZO0cACgkQfBQHDyUj
g0dbgA//WxiVWLIF261YU4GkyGKN4nApDUxS6q/jeyp14aAvJAzY88QivJx474do
H+elAmHGoBHdnwfjWu+iD2M6dIP2lxjFZria5u+6SHIQcI3Py85ScWHr+WTohLAS
BkU0dEQ2shg+KaKwBBntxg/5RualaE9e94D7V5wwtu/lXOfjrbF85SmzptDLtmbQ
+fduchgvP1dZcjsQmPlUks4lns02aTKruyy+Ed1BUSlKfBOSbw6ibUbx0X9sJYZC
dtw/iaI5wr+4hYrObLda6mTL+3hB8d87Xj6n35G5xaJwTnuwIBO1OsHY8yTVkx1R
/gq+wtQ+z26/HH7B/J8uy2/nCz51ThPMABohrGgRKfKlhlSlzxUAZca/prWxDaYg
uG0qJS+N5fkXOQ7ogQMYbas1s0petM7nPKLiyv/ZLlaXsQT/YJxZxPwYw/ZK2EkH
Uk5kxcTnHpZkGdG5T5OH138NWlj8+IslKO0iVMfNP4yEOXOMA+sgb026pzbOTpAO
825bQ8++PF7L+HZS1ZkgoyaEofZCLOhpqbn7IO5+8AmlZz8EhuhD/e1Jj3yxDPWu
xa6pf09YniDg8L3Xw174DqTjgvKGdE8HFYROGYeJMb49vHRWeJbDZsG5q/ubG2XP
9Pg3DWDuaFaIlOr827Haf6OAEzzgRP0jjMz1fL4nHA5UHgsgBXw=
=skPy
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
