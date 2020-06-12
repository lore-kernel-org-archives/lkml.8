Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C036C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCD2206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lYywnfIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgFLWtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:49:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57694 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLWte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:49:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05CMnOqZ121046;
        Fri, 12 Jun 2020 17:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592002164;
        bh=r3KC4WGjMUHhMPU0T9d+Aev6nWaRVfp+MljfOUVI+nY=;
        h=From:To:CC:Subject:Date;
        b=lYywnfImUv/KyQ0kWp4EKnDSpBIQ6xu2IhWLIaIJCohmQL8hQ0tx0PpJTR7tGO/zX
         EbwP1oMbCsRLyOxSuYE4ucM3oxy8fBspQB8zcB5ACmUVbU+s78iIQKWxUVgIMszlzS
         8oDZyUtPnZZ4yH4m3vwiBuOs9riK4hUUOmX22bq8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05CMnO1S119570
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 17:49:24 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 17:49:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 17:49:24 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CMnOgK112149;
        Fri, 12 Jun 2020 17:49:24 -0500
Received: from localhost ([10.250.48.148])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 05CMnOTZ062157;
        Fri, 12 Jun 2020 17:49:24 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 0/6] TI K3 DSP remoteproc driver for C66x DSPs
Date:   Fri, 12 Jun 2020 17:49:08 -0500
Message-ID: <20200612224914.7634-1-s-anna@ti.com>
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

The following is v3 of the K3 DSP remoteproc driver supporting the C66x DSPs
on the TI K3 J721E SoCs. The patches are based on the latest commit on the
master branch 44ebe016df3a.

The main changes in v3 are mostly around the bindings to address various
comments from Rob. The bindings patch is the only patch without an Ack on
v2.

Main changes in v3:
 - Introduced a new common ti-sci-proc bindings yaml file (Patch #3)
   that can be used by both K3 DSP and R5F
 - Updated dt-bindings to address most comments (Patch #4)
 - Moved the common ti-sci-helper patch (Patch #2) between R5 and DSP drivers
   from the R5F series to this series, so that this series is standalone and
   can be merged by itself.

Please see the individual patches for further delta differences.

v2: https://patchwork.kernel.org/cover/11561787/
v1: https://patchwork.kernel.org/cover/11458573/

regards
Suman

Suman Anna (6):
  remoteproc: Introduce rproc_of_parse_firmware() helper
  remoteproc: k3: Add TI-SCI processor control helper functions
  dt-bindings: remoteproc: Add common TI SCI rproc bindings
  dt-bindings: remoteproc: Add bindings for C66x DSPs on TI K3 SoCs
  remoteproc: k3-dsp: Add a remoteproc driver of K3 C66x DSPs
  remoteproc: k3-dsp: Add support for L2RAM loading on C66x DSPs

 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 139 ++++
 .../bindings/remoteproc/ti,k3-sci-proc.yaml   |  51 ++
 drivers/remoteproc/Kconfig                    |  13 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/remoteproc_core.c          |  23 +
 drivers/remoteproc/remoteproc_internal.h      |   2 +
 drivers/remoteproc/ti_k3_dsp_remoteproc.c     | 774 ++++++++++++++++++
 drivers/remoteproc/ti_sci_proc.h              | 102 +++
 8 files changed, 1105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
 create mode 100644 drivers/remoteproc/ti_k3_dsp_remoteproc.c
 create mode 100644 drivers/remoteproc/ti_sci_proc.h

-- 
2.26.0

