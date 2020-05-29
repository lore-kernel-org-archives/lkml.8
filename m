Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85794C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616A72074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bc/TCs0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgE2QcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:32:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33724 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2QcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:32:16 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200529163214euoutp02645c48ad4cb9edb410ef9aa3521a2c82~TjNOwYjn21680116801euoutp02G
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:32:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200529163214euoutp02645c48ad4cb9edb410ef9aa3521a2c82~TjNOwYjn21680116801euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590769934;
        bh=YyI0aJs2AZdI75R6HWboaN2GUTmcD7CBWGH8ghELHas=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bc/TCs0zAPZbRoZkupJAenH6UOQwigTqDM7QEWBOk9/r6K0+e78znEc/MtW78m26M
         hLwHy9efr5Ae6gVA2+qbL+9ynXtik2RaLJJZ+4ijMV3QxVAKC75fNKUUofsdPczhUX
         eRP4yOvD1PDeycz7OrqIn7bie8HpwfbrMNPM5un8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200529163213eucas1p1b8c6693a4bb092751d1e6fb77f194bd1~TjNOa8_ZL2234422344eucas1p10;
        Fri, 29 May 2020 16:32:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F4.5D.61286.D0931DE5; Fri, 29
        May 2020 17:32:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200529163213eucas1p1ac148f9238214ac84f3d0cc199c4398b~TjNN7Y92e2234422344eucas1p1z;
        Fri, 29 May 2020 16:32:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200529163213eusmtrp10505a206e392450cf0ba7d1479952ac5~TjNN4_PvY2579525795eusmtrp1G;
        Fri, 29 May 2020 16:32:13 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-40-5ed1390d9e0e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2F.15.07950.D0931DE5; Fri, 29
        May 2020 17:32:13 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200529163212eusmtip198897ccc0e621058c177a4cac704732e~TjNNGw9Ub1044210442eusmtip1-;
        Fri, 29 May 2020 16:32:12 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v5 0/6] Exynos: Simple QoS for exynos-bus using
 interconnect
Date:   Fri, 29 May 2020 18:31:54 +0200
Message-Id: <20200529163200.18031-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zk7Oy6nx6Pii0rJsB8JeSl/nNAiL9SQfkTgoEBr6WGaOmVH
        TaPSmKl5v/zQXInoIrWLtpyUeYmlTvOet0JrQlYYXqhpYUHmPFb+e97neZ+P53n5SIzuFbqS
        sapkVq1SxEsJMd7auz5yQHJ4LNK3tPggY66+gZjHlU1CZnr1s5CZWFshmIoOPcGUmUtwZmSk
        WcToP0wJmfG22wRTOdIpYB52vxMxM9frCeblYo6QqSxfII7ZyfSNNwnZ7FQ7ITPnmwSyJ7oM
        WVFLI5JZ9HtOEWfFgdFsfGwqq/Y5el4cY7TMYUkaz7SxwWkiEy255yEbEih/MJmHBXlITNJU
        PYKu8pXtYRWBpniD4AcLgspHCygPkVsWncXJ6qapewi0DbH/DGWT+cgqEJQfFPYUbWEnKhSy
        P1bj1iWMahdAp3YZtwqO1GnoKcoRWDFO7YPBwvUtXkIFQHdfD87n2wv3m19gPO8A/bfmt3hs
        k9cYtJj1UaBeieCu7o6QN4TC27UH29gRvphaRDx2h4HyApw3aBAUPJ8R8UMJArOpBvFbATA7
        /JOw9sSo/dDU5sPTQdA1YxTx9e3gzZIDH8IOylorMJ6WQG42zW97wq/GCgGPXSF/fmO7iwy+
        lw4L+MtFwNCURVSCPKp2VKvaUa3qf4YahDUiFzaFS1CynJ+KveTNKRK4FJXSOyoxQY82f9fA
        b9O3p2jt9QUjokgktZWkeY1F0kJFKpeeYERAYlInSfDQQCQtiVakX2bViefUKfEsZ0RuJC51
        kRyqXYigKaUimY1j2SRW/VcVkDaumchj3EmZ7JHOgYN8QL4QN+1gn5E5GVIbsDj3Psw5JDDY
        f9lW3kS3kCp6LaohfOVIVtZGb6kwK8q+oDUxOGduNOiMnfjENXV1RF1HbVFxXSomDwWD9lmO
        Upn+NTV31+4sl+VRZ8NK2HHDvOHTyavaIFtRv07+46LmyoSvuC/cTYpzMQo/L0zNKf4AoSzS
        jlkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xu7q8lhfjDKav5ra4P6+V0WLjjPWs
        Fte/PGe1uPL1PZvF9L2b2Cwm3Z/AYnH+/AZ2i02Pr7FaXN41h81ixvl9TBZrj9xlt7jduILN
        4vCbdlaLGZNfsjnweWxa1cnmcefaHjaP+93HmTw2L6n36NuyitHj8ya5ALYoPZui/NKSVIWM
        /OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxDnx8wFzSrVFw8c52t
        gfGtTBcjB4eEgInEks8iXYxcHEICSxklDp0/zQgRl5KY36LUxcgJZApL/LnWxQZR84lRYte5
        NawgCTYBQ4neo32MILaIgIfEqda1rCBFzAInmCSe9G5kA0kICwRILGj6wgRiswioSpzp/ckC
        YvMKWEscOXGUBWKDvMTqDQeYIeKCEidnPmEBOYJZQF1i/TwhkDAzUEnz1tnMExj5ZyGpmoVQ
        NQtJ1QJG5lWMIqmlxbnpucVGesWJucWleel6yfm5mxiB0bXt2M8tOxi73gUfYhTgYFTi4b2g
        czFOiDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYTYFemMgsJZqcD4z8vJJ4
        Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjNMZp81vOtNY/fzHyVfb
        Oysux6jtuCwzb35IuqOGpcmqtUH2IQJrPM3KvqXncq3cNO2jOdeuHe5+D/tbbes1Dn53u1+5
        n219t42mctvV7azJDfIKB7qdZ2Quf5380G6eTKr9pqLV6rYeP/4EZf3YlXn/8vz4Lyu2bZ7z
        +0/ihV1C2RsePjVL7VViKc5INNRiLipOBAAiaeStxAIAAA==
X-CMS-MailID: 20200529163213eucas1p1ac148f9238214ac84f3d0cc199c4398b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529163213eucas1p1ac148f9238214ac84f3d0cc199c4398b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529163213eucas1p1ac148f9238214ac84f3d0cc199c4398b
References: <CGME20200529163213eucas1p1ac148f9238214ac84f3d0cc199c4398b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds interconnect API support for the Exynos SoC "samsung,
exynos-bus" compatible devices, which already have their corresponding 
exynos-bus driver in the devfreq subsystem.  Complementing the devfreq driver 
with an interconnect functionality allows to ensure the QoS requirements 
of devices accessing the system memory (e.g. video processing devices) 
are fulfilled and to avoid issues like the one discussed in thread [1].

This patch series depends on 3 patches from Artur for the interconnect API 
[2], which introduce following changes:

 - exporting of_icc_get_from_provider() to avoid hard coding every graph 
   edge in the DT or driver source,
 - relaxing the requirement on #interconnect-cells, so there is no need 
   to provide dummy node IDs in the DT, 
 - adding new field in struct icc_provider to explicitly allow configuring 
   node pairs from two different providers.

This series adds implementation of interconnect provider per each "samsung,
exynos-bus" compatible DT node, with one interconnect node per provider.
The interconnect code which was previously added as a part of the devfreq
driver has been converted to a separate platform driver.  In the devfreq 
a corresponding virtual child platform device is registered.  Integration 
of devfreq and interconnect frameworks is achieved through the PM QoS API.

A sample interconnect consumer for exynos-mixer is added in patches 5/6, 
6/6, it is currently added only for exynos4412 and allows to address the 
mixer DMA underrun error issues [1].

The series has been tested on Odroid U3 board. It is based on icc-next 
branch with devfreq-next branch merged and patches [2] applied.

--
Regards,
Sylwester

--
Changes since v3 [3] (v4 skipped to align with patchset [1]), detailed 
changes are listed at each patch:
 - conversion to a separate interconnect (platform) driver,
 - an update of the DT binding documenting new optional properties:
   #interconnect-cells, samsung,interconnect-parent in "samsung,exynos-bus"
   nodes,
 - new DT properties added to the SoC, rather than to the board specific 
   files.

Changes since v2 [5]:
 - Use icc_std_aggregate().
 - Implement a different modification of apply_constraints() in
   drivers/interconnect/core.c (patch 03).
 - Use 'exynos,interconnect-parent-node' in the DT instead of
   'devfreq'/'parent', depending on the bus.
 - Rebase on DT patches that deprecate the 'devfreq' DT property.
 - Improve error handling, including freeing generated IDs on failure.
 - Remove exynos_bus_icc_connect() and add exynos_bus_icc_get_parent().

Changes since v1 [4]:
 - Rebase on coupled regulators patches.
 - Use dev_pm_qos_*() API instead of overriding frequency in
   exynos_bus_target().
 - Use IDR for node ID allocation.
 - Reverse order of multiplication and division in
   mixer_set_memory_bandwidth() (patch 07) to avoid integer overflow.


References:
[1] https://patchwork.kernel.org/patch/10861757/ (original issue)
[2] https://www.spinics.net/lists/linux-samsung-soc/msg70014.html
[3] https://lore.kernel.org/linux-pm/20191220115653.6487-1-a.swigon@samsung.com
[4] https://patchwork.kernel.org/cover/11054417/ (v1 of this RFC)
[5] https://patchwork.kernel.org/cover/11152595/ (v2 of this RFC)


Artur Świgoń (1):
  ARM: dts: exynos: Add interconnects to Exynos4412 mixer

Marek Szyprowski (1):
  drm: exynos: mixer: Add interconnect support

Sylwester Nawrocki (4):
  dt-bindings: exynos-bus: Add documentation for interconnect properties
  interconnect: Add generic interconnect driver for Exynos SoCs
  PM / devfreq: exynos-bus: Add registration of interconnect child
    device
  ARM: dts: exynos: Add interconnect properties to Exynos4412 bus nodes

 .../devicetree/bindings/devfreq/exynos-bus.txt     |  15 +-
 arch/arm/boot/dts/exynos4412.dtsi                  |   6 +
 drivers/devfreq/exynos-bus.c                       |  17 ++
 drivers/gpu/drm/exynos/exynos_mixer.c              |  73 +++++++-
 drivers/interconnect/Kconfig                       |   1 +
 drivers/interconnect/Makefile                      |   1 +
 drivers/interconnect/exynos/Kconfig                |   6 +
 drivers/interconnect/exynos/Makefile               |   4 +
 drivers/interconnect/exynos/exynos.c               | 185 +++++++++++++++++++++
 9 files changed, 301 insertions(+), 7 deletions(-)
 create mode 100644 drivers/interconnect/exynos/Kconfig
 create mode 100644 drivers/interconnect/exynos/Makefile
 create mode 100644 drivers/interconnect/exynos/exynos.c

-- 
2.7.4

