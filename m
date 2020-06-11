Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBE9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852CA206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="f9W6Rspa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgFKWml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgFKWmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:42:40 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F25C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:42:39 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2F753806B7;
        Fri, 12 Jun 2020 10:42:38 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1591915358;
        bh=Eti+CYkcoKdG2j/gQPveQKce+SbFEvRu2kn2MA2fYbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=f9W6RspaOmK8rY7FQ6elm6iqzJo/dffDoq1rMHudpgOlJbIAWbYE0kJAJC7qEY79+
         lI7AdziW/BviUmCH9i+Wl51umGfqgnNOseiIIkIXw3gjkgeaFJmCJIpoTUtrxb5Yu4
         MN+DbplfLl7rDBjQa9VHLFShoarh2TpSsp3zEW49y6k8U4ct6kzcDvI6vXMqIJDKx7
         oemddG54dIw01YPZWOju/xalLttder5csl5Xl1p737k5obnRH0J3cOLid/oeYmOwkd
         pF8CiIMyD+pf0RatQxaDaeMMlaAOOI63HSvHoXsNyfgk8WejCb0I/6LNOiATd5MTBA
         Xa5PMeZth8OTA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ee2b35e0000>; Fri, 12 Jun 2020 10:42:38 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 3433B13ED45;
        Fri, 12 Jun 2020 10:42:37 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C9E44280083; Fri, 12 Jun 2020 10:42:37 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 2/2] powerpc: configs: remove CMDLINE_BOOL
Date:   Fri, 12 Jun 2020 10:42:20 +1200
Message-Id: <20200611224220.25066-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200611224220.25066-1-chris.packham@alliedtelesis.co.nz>
References: <20200611224220.25066-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regenerate defconfigs to remove CONFIG_CMDLINE_BOOL and the default
CONFIG_CMDLINE where applicable.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v3:
- new

 arch/powerpc/configs/44x/akebono_defconfig     | 2 --
 arch/powerpc/configs/44x/arches_defconfig      | 2 --
 arch/powerpc/configs/44x/bamboo_defconfig      | 2 --
 arch/powerpc/configs/44x/bluestone_defconfig   | 2 --
 arch/powerpc/configs/44x/canyonlands_defconfig | 2 --
 arch/powerpc/configs/44x/currituck_defconfig   | 2 --
 arch/powerpc/configs/44x/eiger_defconfig       | 2 --
 arch/powerpc/configs/44x/fsp2_defconfig        | 1 -
 arch/powerpc/configs/44x/icon_defconfig        | 2 --
 arch/powerpc/configs/44x/iss476-smp_defconfig  | 1 -
 arch/powerpc/configs/44x/katmai_defconfig      | 2 --
 arch/powerpc/configs/44x/rainier_defconfig     | 2 --
 arch/powerpc/configs/44x/redwood_defconfig     | 2 --
 arch/powerpc/configs/44x/sam440ep_defconfig    | 2 --
 arch/powerpc/configs/44x/sequoia_defconfig     | 2 --
 arch/powerpc/configs/44x/taishan_defconfig     | 2 --
 arch/powerpc/configs/44x/warp_defconfig        | 1 -
 arch/powerpc/configs/holly_defconfig           | 1 -
 arch/powerpc/configs/mvme5100_defconfig        | 3 +--
 arch/powerpc/configs/ps3_defconfig             | 2 --
 arch/powerpc/configs/skiroot_defconfig         | 1 -
 arch/powerpc/configs/storcenter_defconfig      | 1 -
 22 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/powerpc/configs/44x/akebono_defconfig b/arch/powerpc/co=
nfigs/44x/akebono_defconfig
index 7705a5c3f4ea..60d5fa2c3b93 100644
--- a/arch/powerpc/configs/44x/akebono_defconfig
+++ b/arch/powerpc/configs/44x/akebono_defconfig
@@ -19,8 +19,6 @@ CONFIG_HIGHMEM=3Dy
 CONFIG_HZ_100=3Dy
 CONFIG_IRQ_ALL_CPUS=3Dy
 # CONFIG_COMPACTION is not set
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 # CONFIG_SUSPEND is not set
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
diff --git a/arch/powerpc/configs/44x/arches_defconfig b/arch/powerpc/con=
figs/44x/arches_defconfig
index 82c6f49b8dcb..41d04e70d4fb 100644
--- a/arch/powerpc/configs/44x/arches_defconfig
+++ b/arch/powerpc/configs/44x/arches_defconfig
@@ -11,8 +11,6 @@ CONFIG_MODULE_UNLOAD=3Dy
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_EBONY is not set
 CONFIG_ARCHES=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_UNIX=3Dy
diff --git a/arch/powerpc/configs/44x/bamboo_defconfig b/arch/powerpc/con=
figs/44x/bamboo_defconfig
index 679213214a75..acbce718eaa8 100644
--- a/arch/powerpc/configs/44x/bamboo_defconfig
+++ b/arch/powerpc/configs/44x/bamboo_defconfig
@@ -9,8 +9,6 @@ CONFIG_MODULE_UNLOAD=3Dy
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_BAMBOO=3Dy
 # CONFIG_EBONY is not set
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_UNIX=3Dy
diff --git a/arch/powerpc/configs/44x/bluestone_defconfig b/arch/powerpc/=
configs/44x/bluestone_defconfig
index 8006a5728afd..37088f250c9e 100644
--- a/arch/powerpc/configs/44x/bluestone_defconfig
+++ b/arch/powerpc/configs/44x/bluestone_defconfig
@@ -11,8 +11,6 @@ CONFIG_EXPERT=3Dy
 # CONFIG_COMPAT_BRK is not set
 CONFIG_BLUESTONE=3Dy
 # CONFIG_EBONY is not set
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_UNIX=3Dy
diff --git a/arch/powerpc/configs/44x/canyonlands_defconfig b/arch/powerp=
c/configs/44x/canyonlands_defconfig
index ccc14eb7a2f1..61776ade572b 100644
--- a/arch/powerpc/configs/44x/canyonlands_defconfig
+++ b/arch/powerpc/configs/44x/canyonlands_defconfig
@@ -11,8 +11,6 @@ CONFIG_MODULE_UNLOAD=3Dy
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_EBONY is not set
 CONFIG_CANYONLANDS=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_UNIX=3Dy
diff --git a/arch/powerpc/configs/44x/currituck_defconfig b/arch/powerpc/=
configs/44x/currituck_defconfig
index be76e066df01..34c86b3abecb 100644
--- a/arch/powerpc/configs/44x/currituck_defconfig
+++ b/arch/powerpc/configs/44x/currituck_defconfig
@@ -17,8 +17,6 @@ CONFIG_HIGHMEM=3Dy
 CONFIG_HZ_100=3Dy
 CONFIG_MATH_EMULATION=3Dy
 CONFIG_IRQ_ALL_CPUS=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 # CONFIG_SUSPEND is not set
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
diff --git a/arch/powerpc/configs/44x/eiger_defconfig b/arch/powerpc/conf=
igs/44x/eiger_defconfig
index 1abaa63e067f..509300f400e2 100644
--- a/arch/powerpc/configs/44x/eiger_defconfig
+++ b/arch/powerpc/configs/44x/eiger_defconfig
@@ -10,8 +10,6 @@ CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
 # CONFIG_EBONY is not set
 CONFIG_EIGER=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 CONFIG_PCIEPORTBUS=3Dy
 # CONFIG_PCIEASPM is not set
 CONFIG_NET=3Dy
diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/confi=
gs/44x/fsp2_defconfig
index e67fc041ca3e..30845ce0885a 100644
--- a/arch/powerpc/configs/44x/fsp2_defconfig
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -28,7 +28,6 @@ CONFIG_476FPE_ERR46=3Dy
 CONFIG_SWIOTLB=3Dy
 CONFIG_KEXEC=3Dy
 CONFIG_CRASH_DUMP=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
 CONFIG_CMDLINE=3D"ip=3Don rw"
 # CONFIG_SUSPEND is not set
 # CONFIG_PCI is not set
diff --git a/arch/powerpc/configs/44x/icon_defconfig b/arch/powerpc/confi=
gs/44x/icon_defconfig
index 7d7ff84c8200..930948a1da76 100644
--- a/arch/powerpc/configs/44x/icon_defconfig
+++ b/arch/powerpc/configs/44x/icon_defconfig
@@ -9,8 +9,6 @@ CONFIG_MODULE_UNLOAD=3Dy
 # CONFIG_EBONY is not set
 CONFIG_ICON=3Dy
 CONFIG_HIGHMEM=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 CONFIG_PCIEPORTBUS=3Dy
 # CONFIG_PCIEASPM is not set
 CONFIG_NET=3Dy
diff --git a/arch/powerpc/configs/44x/iss476-smp_defconfig b/arch/powerpc=
/configs/44x/iss476-smp_defconfig
index fb5c73a29bf4..2c3834eebca3 100644
--- a/arch/powerpc/configs/44x/iss476-smp_defconfig
+++ b/arch/powerpc/configs/44x/iss476-smp_defconfig
@@ -17,7 +17,6 @@ CONFIG_ISS4xx=3Dy
 CONFIG_HZ_100=3Dy
 CONFIG_MATH_EMULATION=3Dy
 CONFIG_IRQ_ALL_CPUS=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
 CONFIG_CMDLINE=3D"root=3D/dev/issblk0"
 # CONFIG_PCI is not set
 CONFIG_ADVANCED_OPTIONS=3Dy
diff --git a/arch/powerpc/configs/44x/katmai_defconfig b/arch/powerpc/con=
figs/44x/katmai_defconfig
index c6dc1445fc04..1a0f1c3e0ee9 100644
--- a/arch/powerpc/configs/44x/katmai_defconfig
+++ b/arch/powerpc/configs/44x/katmai_defconfig
@@ -9,8 +9,6 @@ CONFIG_MODULE_UNLOAD=3Dy
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_EBONY is not set
 CONFIG_KATMAI=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_UNIX=3Dy
diff --git a/arch/powerpc/configs/44x/rainier_defconfig b/arch/powerpc/co=
nfigs/44x/rainier_defconfig
index c83ad03182df..6dd67de06a0b 100644
--- a/arch/powerpc/configs/44x/rainier_defconfig
+++ b/arch/powerpc/configs/44x/rainier_defconfig
@@ -10,8 +10,6 @@ CONFIG_MODULE_UNLOAD=3Dy
 # CONFIG_EBONY is not set
 CONFIG_RAINIER=3Dy
 CONFIG_MATH_EMULATION=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_UNIX=3Dy
diff --git a/arch/powerpc/configs/44x/redwood_defconfig b/arch/powerpc/co=
nfigs/44x/redwood_defconfig
index 640fe1d5af28..e28d76416537 100644
--- a/arch/powerpc/configs/44x/redwood_defconfig
+++ b/arch/powerpc/configs/44x/redwood_defconfig
@@ -10,8 +10,6 @@ CONFIG_MODULES=3Dy
 CONFIG_MODULE_UNLOAD=3Dy
 # CONFIG_EBONY is not set
 CONFIG_REDWOOD=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 CONFIG_PCIEPORTBUS=3Dy
 # CONFIG_PCIEASPM is not set
 CONFIG_NET=3Dy
diff --git a/arch/powerpc/configs/44x/sam440ep_defconfig b/arch/powerpc/c=
onfigs/44x/sam440ep_defconfig
index 22dc0dadf576..ef09786d49b9 100644
--- a/arch/powerpc/configs/44x/sam440ep_defconfig
+++ b/arch/powerpc/configs/44x/sam440ep_defconfig
@@ -12,8 +12,6 @@ CONFIG_PARTITION_ADVANCED=3Dy
 CONFIG_AMIGA_PARTITION=3Dy
 # CONFIG_EBONY is not set
 CONFIG_SAM440EP=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_UNIX=3Dy
diff --git a/arch/powerpc/configs/44x/sequoia_defconfig b/arch/powerpc/co=
nfigs/44x/sequoia_defconfig
index 2c0973db8837..b4984eab43eb 100644
--- a/arch/powerpc/configs/44x/sequoia_defconfig
+++ b/arch/powerpc/configs/44x/sequoia_defconfig
@@ -11,8 +11,6 @@ CONFIG_MODULE_UNLOAD=3Dy
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_EBONY is not set
 CONFIG_SEQUOIA=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_UNIX=3Dy
diff --git a/arch/powerpc/configs/44x/taishan_defconfig b/arch/powerpc/co=
nfigs/44x/taishan_defconfig
index a2d355ca62b2..3ea5932ab852 100644
--- a/arch/powerpc/configs/44x/taishan_defconfig
+++ b/arch/powerpc/configs/44x/taishan_defconfig
@@ -9,8 +9,6 @@ CONFIG_MODULE_UNLOAD=3Dy
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_EBONY is not set
 CONFIG_TAISHAN=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_UNIX=3Dy
diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/confi=
gs/44x/warp_defconfig
index af66c69c49fe..47252c2d7669 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -14,7 +14,6 @@ CONFIG_MODULE_UNLOAD=3Dy
 CONFIG_WARP=3Dy
 CONFIG_PPC4xx_GPIO=3Dy
 CONFIG_HZ_1000=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
 CONFIG_CMDLINE=3D"ip=3Don"
 # CONFIG_PCI is not set
 CONFIG_NET=3Dy
diff --git a/arch/powerpc/configs/holly_defconfig b/arch/powerpc/configs/=
holly_defconfig
index 067f433c8f5e..271daff47d1d 100644
--- a/arch/powerpc/configs/holly_defconfig
+++ b/arch/powerpc/configs/holly_defconfig
@@ -13,7 +13,6 @@ CONFIG_EMBEDDED6xx=3Dy
 CONFIG_PPC_HOLLY=3Dy
 CONFIG_GEN_RTC=3Dy
 CONFIG_BINFMT_MISC=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
 CONFIG_CMDLINE=3D"console=3DttyS0,115200"
 # CONFIG_SECCOMP is not set
 CONFIG_NET=3Dy
diff --git a/arch/powerpc/configs/mvme5100_defconfig b/arch/powerpc/confi=
gs/mvme5100_defconfig
index 0a0d046fc445..3d53d69ed36c 100644
--- a/arch/powerpc/configs/mvme5100_defconfig
+++ b/arch/powerpc/configs/mvme5100_defconfig
@@ -20,10 +20,9 @@ CONFIG_EMBEDDED6xx=3Dy
 CONFIG_MVME5100=3Dy
 CONFIG_KVM_GUEST=3Dy
 CONFIG_HZ_100=3Dy
+CONFIG_CMDLINE=3D"console=3DttyS0,9600 ip=3Ddhcp root=3D/dev/nfs"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_COMPACTION is not set
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D"console=3DttyS0,9600 ip=3Ddhcp root=3D/dev/nfs"
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_UNIX=3Dy
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps=
3_defconfig
index 81b55c880fc3..142f1321fa58 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -34,8 +34,6 @@ CONFIG_KEXEC=3Dy
 # CONFIG_SPARSEMEM_VMEMMAP is not set
 # CONFIG_COMPACTION is not set
 CONFIG_SCHED_SMT=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D""
 CONFIG_PM=3Dy
 CONFIG_PM_DEBUG=3Dy
 # CONFIG_SECCOMP is not set
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/config=
s/skiroot_defconfig
index ad6739ac63dc..b806a5d3a695 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -45,7 +45,6 @@ CONFIG_IRQ_ALL_CPUS=3Dy
 CONFIG_NUMA=3Dy
 CONFIG_PPC_64K_PAGES=3Dy
 CONFIG_SCHED_SMT=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
 CONFIG_CMDLINE=3D"console=3Dtty0 console=3Dhvc0 ipr.fast_reboot=3D1 quie=
t"
 # CONFIG_SECCOMP is not set
 # CONFIG_PPC_MEM_KEYS is not set
diff --git a/arch/powerpc/configs/storcenter_defconfig b/arch/powerpc/con=
figs/storcenter_defconfig
index b964084e4056..47dcfaddc1ac 100644
--- a/arch/powerpc/configs/storcenter_defconfig
+++ b/arch/powerpc/configs/storcenter_defconfig
@@ -12,7 +12,6 @@ CONFIG_EMBEDDED6xx=3Dy
 CONFIG_STORCENTER=3Dy
 CONFIG_HZ_100=3Dy
 CONFIG_BINFMT_MISC=3Dy
-CONFIG_CMDLINE_BOOL=3Dy
 CONFIG_CMDLINE=3D"console=3DttyS0,115200"
 # CONFIG_SECCOMP is not set
 CONFIG_NET=3Dy
--=20
2.27.0

