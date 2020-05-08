Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6115EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4165220CC7
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgEHOl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:41:29 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:38571 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgEHOlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:41:13 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mr9OA-1ikEYX0EAI-00oG15; Fri, 08 May 2020 16:40:51 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ben Skeggs <bskeggs@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nouveau: fix dependencies for DEVICE_PRIVATE
Date:   Fri,  8 May 2020 16:40:09 +0200
Message-Id: <20200508144017.3501418-2-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200508144017.3501418-1-arnd@arndb.de>
References: <20200508144017.3501418-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JWVQOgOnHysetYBnSk3CKrV5svFn5O5bRyqndsTcxkwhAVFX33K
 8QbP8gDLWPxaMFNAgd7F0Cl5FkzbK7UMEJIFy0zMaVqeRYEiRnApjKD442XntX1liV7tU8u
 +v58YzETQ9SV2Hp+cHqKt2yBzRbfWwCIKA6DW0+yHZ5CaJ628eVpggV+QV31QJGmJnChH1i
 vbw4Va8hrFgS/CW9ROAkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VzDQJ1Yexdc=:rlZgpEK/dFkEh64B04UQUI
 g+x10OM+ECzQzdguOSFhigUHOMdlbZFiI08PVo16y3npp77DmEsUma/AvaHcceM2m5b3I2o7L
 TNCu82db3goJxFTWsXeuL1ZexwTp0gb5JWPrscj83fsTSOZ/18VLYpONC2FctsWw9C/ZTKzgS
 K0HbBohnOvCR3/SHRUv1n1sX17ZLm6sZ7onWo54A55647knTetrzKq+aimZ3A3fEN/f1JRi2q
 Fz7PefVUE5BFdLOZfKP5PVlfwCyFKD6ePO31sczeohRvfZrfip4z6j5azwY53UD8A2la9VDMl
 yQ+zJZVhiTIEPExvx2yHPt8Gb4vD9nklM6omlVYpu0t7d4EINmaSrURvpa8jZGeYVMzuniupd
 GCC0Ui4hsMVN4O+BGGp4mzzSTdHxZNuUpUfZalKuY98GENhMiAjkN8T1/WrzIzIlYLjdGtodz
 i4ar0/wiV5tIOczUPF0P9sKJGaDYgVsNGNmzm403LzNNJzt1oxw6UMUJE4iRQ1Akef7DSocGP
 TPO/xZ/dimwT8pDNNP6hqgqxRCEPgk43rCb1CWF2rYxdcoPcQLVLwDgWV1VH9AhMabNUbojSm
 G8HmBR+fcLs6jSPX8Ls6tidrpGP6nsyMSNMLDV8lfryssOazCoAdn2ZG4RZJ1/o5BEegZ8I9B
 80CzFDRI32YAgnT9uC1xB8szTuFOrz1fc+/kgtYCqSk3qr4O9buMmeCmRGHuM+5J8UOGznTD8
 0YZ3ZZkh/Y2ymPOhW2NNuVL+0rXAFSSaH49WsYDVcyPjUerW4YuaddC4lv6dBUSeTDyQY4nLK
 NV8OCikn7NeFF6Uk7/uPXIkQYE5CSkZ9+DUpSoA+hw2rOqe68k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEVICE_PRIVATE cannot be selected in configurations
without ZONE_DEVICE:

WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
  Depends on [n]: ZONE_DEVICE [=n]
  Selected by [y]:
  - DRM_NOUVEAU_SVM [=y] && HAS_IOMEM [=y] && DRM_NOUVEAU [=y] && MMU [=y] && STAGING [=y]
kernel/resource.c:1653:28: error: use of undeclared identifier 'PA_SECTION_SHIFT'
        size = ALIGN(size, 1UL << PA_SECTION_SHIFT);
                                  ^
kernel/resource.c:1654:48: error: use of undeclared identifier 'MAX_PHYSMEM_BITS'

Add a dependency for Nouveau to avoid broken randconfig builds.

Fixes: d2c63df2242e ("mm/hmm: make CONFIG_DEVICE_PRIVATE into a select")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/nouveau/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index af5793f3e7c2..996ec5475908 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -87,6 +87,7 @@ config DRM_NOUVEAU_BACKLIGHT
 config DRM_NOUVEAU_SVM
 	bool "(EXPERIMENTAL) Enable SVM (Shared Virtual Memory) support"
 	depends on DRM_NOUVEAU
+	depends on ZONE_DEVICE
 	depends on MMU
 	depends on STAGING
 	select DEVICE_PRIVATE
-- 
2.26.0

