Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA5BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44CB207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbgE0NnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:43:04 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53793 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387682AbgE0NnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:43:03 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N3bjH-1ivhXw2f9X-010grN; Wed, 27 May 2020 15:42:55 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nouveau: add fbdev dependency
Date:   Wed, 27 May 2020 15:42:23 +0200
Message-Id: <20200527134254.854672-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UwRS52SKomS1dGxg/Cr8izduWX8ZD4LmV2z+vHIfJD0wpmnsWtB
 QsS+qAKdfR75PBtRiCiim1nlfytCKTLhu6JCbh4PrnV+FnERUpJOUQRYyQq4RJp3C9DiNIG
 0xVNyeytj45f/FlCXkUhpuZF3JKkcmVsifwuOG52sLtCSYd5ofSlkPSaA8yVL02/yhRHvp5
 BNBjDEjhB8nkcGG87ChpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sZgzWgmPFv0=:z9Y1bGS9xTuXxA3csoNcb1
 UZYKzg8vEU0M/l7zTe/VPttt95Av/k+Yn3Q41pSeJcoDFb4gSzkWi9fOLhOZjjGHkOngTp2fQ
 NUt+G+8tVnTxUc7wH5ZxMhEciPR3RYCdNj9JAYH3Lo029bfAxiP5M1XMbPB8hecIiFDE5qh1x
 qX4A/NCKQ62qjL8GSFCtI4jaeFzxkD4Mt+WgS5TG8RW7qRmdUZq7+apRDedRVIxUr58XA3L0y
 8YZEzAR2nRfFGEgEGdVVaYEyjE+mdbPfeVQ0Hdzy/OvS6XXiy/wI9+SVnL6T76Qf6RUmM5wU2
 Vsycwf9eT9Yud5Qs0UL4MMs0cku4A88vyFFDoh5UG/D7rxBiYRapgml5ng77WQ1QERcmZUx+s
 KpS7DtQaVaq8ZffeajcOz2xzFgdbiCa2RYEzZs0bKoH6CB1yOjjNWg9DfESeZ8XgsL9razQEx
 h90Bo5yR/JzCwf4bRtQFKQ1ejV4vw8GMycx1xX9ehMX7W1hqa4HWCSo4P/iLEWMPlGU9EITcD
 HNIjyH5VHvidwy83N9lxY4PUmvlPYXUXcSy3N1zgzpO/pTZzJ+y6IxMpxCpcwNvjlnF//qEvr
 747xwiisizEF+y+hTyBY10KDkxab0p7xor48HZ+5yZHP/sXer85v75hEVgZH3Rom6ykdGDeZ+
 EdXThkeQRUyiKh2u+IJIIRibInnf1NMjhBuZgTioJXngiNdzomYSmmvaIcXC2PqqO8jKopUfU
 KZKDByehOUjtvpO6Ev5i0Hg9ZV7G90Au1WN00d+bbW+HZc9Sy9rHhbSlo5hojoyiUe/Rf9N+Q
 J8N30rKh6plh6ZN/IZ+e+3SdoyfSH1XWuriqB1MdUfNDLSw2VI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling directly into the fbdev stack only works when the
fbdev layer is built into the kernel as well, or both are
loadable modules:

drivers/gpu/drm/nouveau/nouveau_drm.o: in function `nouveau_drm_probe':
nouveau_drm.c:(.text+0x1f90): undefined reference to `remove_conflicting_pci_framebuffers'

The change seems to have been intentional, so add an explicit
dependency here but allow it to still be compiled if FBDEV
is completely disabled.

Fixes: 2dd4d163cd9c ("drm/nouveau: remove open-coded version of remove_conflicting_pci_framebuffers()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/nouveau/Kconfig       | 1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 980ed09bd7f6..8c640f003358 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -18,6 +18,7 @@ config DRM_NOUVEAU
 	select THERMAL if ACPI && X86
 	select ACPI_VIDEO if ACPI && X86
 	select SND_HDA_COMPONENT if SND_HDA_CORE
+	depends on FBDEV || !FBDEV
 	help
 	  Choose this option for open-source NVIDIA support.
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index eb10c80ed853..e8560444ab57 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -697,7 +697,8 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
 	nvkm_device_del(&device);
 
 	/* Remove conflicting drivers (vesafb, efifb etc). */
-	ret = remove_conflicting_pci_framebuffers(pdev, "nouveaufb");
+	if (IS_ENABLED(CONFIG_FBDEV))
+		ret = remove_conflicting_pci_framebuffers(pdev, "nouveaufb");
 	if (ret)
 		return ret;
 
-- 
2.26.2

