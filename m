Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE1EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76D8206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C3Lu1WiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbgGUWg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:36:27 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36016 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgGUWg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 18:36:26 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06LMaLNG108088;
        Tue, 21 Jul 2020 17:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595370981;
        bh=3Sb6PrHGQGYKFrEVdSA8GaYuEwf+vL4h5BIJE8Zpo6k=;
        h=From:To:CC:Subject:Date;
        b=C3Lu1WiJ0sSay5h9zOT1yMJmfHMYoMNXmyoeU9WQcFiVBoJ55Fp8VLR56viwCNRtt
         JVtC0nvljbmVgTEA57WgoTWyfzXy18MRCILBh4HWFPux8f7RN70qzsqzq40SJ73Ur1
         AdNyCJ77Ot3zJaZyqCSU40lf8T9Tt7Ldd78WJr6c=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LMaL51023668;
        Tue, 21 Jul 2020 17:36:21 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 21
 Jul 2020 17:36:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 21 Jul 2020 17:36:21 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LMaLRo013887;
        Tue, 21 Jul 2020 17:36:21 -0500
Received: from localhost ([10.250.34.248])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 06LMaL2D080793;
        Tue, 21 Jul 2020 17:36:21 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v5 0/6] TI K3 DSP remoteproc driver for C66x DSPs
Date:   Tue, 21 Jul 2020 17:36:11 -0500
Message-ID: <20200721223617.20312-1-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The following is v5 of the K3 DSP remoteproc driver supporting the C66x DSPs
on the TI K3 J721E SoCs. The patches apply cleanly both on v5.8-rc1 as well
as on latest HEAD of rproc-next branch. The C71x v3 still applies cleanly on
top of this series.

The main changes are on the bindings. The previously added common 
ti,k3-sci-rproc.yaml remoteproc binding (v4 patch#3) is replaced by an
equivalent generic ti,k3-sci-common.yaml binding (patch #1) that can scale
to other TI SCI controller nodes. As such, I have relocated the file to 
Documentation/devicetree/bindings/arm/keystone folder instead of the
remoteproc folder. Driver patches are unchanged.

Please see the v4 cover-letter and individual patches for further delta
differences.

v4: https://patchwork.kernel.org/cover/11671459/
v3: https://patchwork.kernel.org/cover/11602331/
v2: https://patchwork.kernel.org/cover/11561787/
v1: https://patchwork.kernel.org/cover/11458573/

C71x v3: https://patchwork.kernel.org/cover/11602345/

regards
Suman

Suman Anna (6):
  dt-bindings: arm: keystone: Add common TI SCI bindings
  remoteproc: Introduce rproc_of_parse_firmware() helper
  remoteproc: k3: Add TI-SCI processor control helper functions
  dt-bindings: remoteproc: Add bindings for C66x DSPs on TI K3 SoCs
  remoteproc: k3-dsp: Add a remoteproc driver of K3 C66x DSPs
  remoteproc: k3-dsp: Add support for L2RAM loading on C66x DSPs

 .../arm/keystone/ti,k3-sci-common.yaml        |  44 +
 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 142 ++++
 MAINTAINERS                                   |   1 +
 drivers/remoteproc/Kconfig                    |  13 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/remoteproc_core.c          |  23 +
 drivers/remoteproc/remoteproc_internal.h      |   2 +
 drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 771 ++++++++++++++++++
 drivers/remoteproc/ti_sci_proc.h              | 104 +++
 9 files changed, 1101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
 create mode 100644 drivers/remoteproc/ti_k3_dsp_remoteproc.c
 create mode 100644 drivers/remoteproc/ti_sci_proc.h

-- 
2.26.0

