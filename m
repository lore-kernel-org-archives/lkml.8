Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0324AC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF80520740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gJdxXPXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgCYUS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:18:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38440 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbgCYUS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:18:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02PKIiVR085834;
        Wed, 25 Mar 2020 15:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585167524;
        bh=CxukkovBJFpII0uJw7j2rQdNqCAT4Ya7y+OIAbYeZf4=;
        h=From:To:CC:Subject:Date;
        b=gJdxXPXFwXAp0L2ctK6D43oGj9tX0xL5s2QfU0OqcRaWno9SD9iQ3H9B8D0zg530/
         TWp4uzQOnKNMetj1WTeaugk4suty839vKyYipV9DL1pXkKCNE/DD2icfYgOzEsAJTo
         mM/W6bBSRpx4d5deIoEkb91ol9QtUz0ACaVuRAeI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02PKIi8a025540
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Mar 2020 15:18:44 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 25
 Mar 2020 15:18:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 25 Mar 2020 15:18:43 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02PKIhmC064313;
        Wed, 25 Mar 2020 15:18:43 -0500
Received: from localhost ([10.250.35.147])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 02PKIhhq090851;
        Wed, 25 Mar 2020 15:18:43 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/3] TI K3 DSP remoteproc driver for C66x DSPs
Date:   Wed, 25 Mar 2020 15:18:36 -0500
Message-ID: <20200325201839.15896-1-s-anna@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The following series adds a new K3 DSP remoteproc driver supporting the
C66x DSPs on the TI K3 J721E SoCs. The current series mainly adds the support
for booting the DSPs from the Linux kernel. This series forms the foundation
for adding support for a new 64-bit DSP (C71x DSP) to be posted in a separate
series. Support for attaching to pre-booted DSPs (from bootloader) will be
done in a future series.

The C66x DSPs can boot either using firmware segments loaded into either DDR
and/or internal DSP RAMs. IPC is through the virtio-rpmsg transport. There is 
no Error Recovery or Power Management support at present. The driver also does
not support loading into on-chip SRAMs at present.

The patches are based on the current rproc-next branch, and does use couple
of patches posted earlier from the OMAP remoteproc series [1] and TI K3 R5F
series [2]. It also leverages the fixed memory carveout fixes series [3].

Following is the patch summary:
 - Patch 1 adds the bindings in the YAML format.
 - Patch 2 adds the basic remoteproc driver for the C66x DSPs
 - Patch 3 is an enhancement to support loading into the DSP's internal
   RAMs directly.

regards
Suman

[1] https://patchwork.kernel.org/patch/11455135/
[2] https://patchwork.kernel.org/patch/11456383/ 
[3] https://patchwork.kernel.org/cover/11447649/

Suman Anna (3):
  dt-bindings: remoteproc: Add bindings for C66x DSPs on TI K3 SoCs
  remoteproc/k3-dsp: Add a remoteproc driver of K3 C66x DSPs
  remoteproc/k3-dsp: Add support for L2RAM loading on C66x DSPs

 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 180 ++++
 drivers/remoteproc/Kconfig                    |  16 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 818 ++++++++++++++++++
 4 files changed, 1015 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
 create mode 100644 drivers/remoteproc/ti_k3_dsp_remoteproc.c

-- 
2.23.0

