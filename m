Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B708BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BDA20760
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uynyKw0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgF3Cts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:49:48 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54410 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgF3Cti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:49:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05U2nPWg105154;
        Mon, 29 Jun 2020 21:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593485365;
        bh=l3dJNMTnCJS2Tr9Fc2NBXAUcVx30a2Jtr1XirbH4bSQ=;
        h=From:To:CC:Subject:Date;
        b=uynyKw0k0VUCxZ8VoF8w9a5ttM0x+3lkNoX3+8nbl9b8VCUX/xl2sx3fFFxrhO5Zl
         ooL9/3dSSZVmBSa790/YlF0ul2FU6N1qBrhgRJrAZNROK25XX0sYRSmoVkGMJaElE8
         W3RaSDFOgI14SBY+2YuEZuohJnFxAyxZEXSYG9jE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05U2nPS5048597
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Jun 2020 21:49:25 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 29
 Jun 2020 21:49:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 29 Jun 2020 21:49:25 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05U2nPFt075189;
        Mon, 29 Jun 2020 21:49:25 -0500
Received: from localhost ([10.250.48.148])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 05U2nPFT029139;
        Mon, 29 Jun 2020 21:49:25 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 0/4] TI K3 R5F remoteproc support
Date:   Mon, 29 Jun 2020 21:49:18 -0500
Message-ID: <20200630024922.32491-1-s-anna@ti.com>
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

The following is v2 of the TI K3 R5F remoteproc driver series supporting all
the R5F processor clusters/subsystems on TI AM65x and J721E SoCs. Please
see the v1 cover-letter [1] for the features supported on these R5F
processors.

The patches are based off 5.8-rc1 and now sit on top of the v3 K3 DSP C66x
and C71x remoteproc driver series [2][3] (v1 had R5F followed by DSPs).

The v2 version now only has 4 patches instead of the 7 patches in v1. The
first 2 patches from v1 are already part of 5.8-rc1 and the third patch is
moved to the K3 DSP C66x series [4].

The following is the summary of the main changes in v2:
 - Reworked bindings patch (patch #1) to leverage a new common ti-sci-proc
   yaml bindings file introduced in the K3 DSP C66x series.
 - K3 R5F remoteproc driver revised to leverage more devm_ API and
   address all Mathieu's comments. 

Please see the individual patches for detailed delta differences.

regards
Suman

[1] R5F v1: https://patchwork.kernel.org/cover/11456367/
[2] C66x v3: https://patchwork.kernel.org/cover/11602331/
[3] C71x v3: https://patchwork.kernel.org/cover/11602345/
[4] https://patchwork.kernel.org/patch/11602329/

Suman Anna (4):
  dt-bindings: remoteproc: Add bindings for R5F subsystem on TI K3 SoCs
  remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem
  remoteproc: k3-r5: Initialize TCM memories for ECC
  remoteproc: k3-r5: Add loading support for on-chip SRAM regions

 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  |  278 ++++
 drivers/remoteproc/Kconfig                    |   13 +
 drivers/remoteproc/Makefile                   |    1 +
 drivers/remoteproc/ti_k3_r5_remoteproc.c      | 1396 +++++++++++++++++
 4 files changed, 1688 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
 create mode 100644 drivers/remoteproc/ti_k3_r5_remoteproc.c

-- 
2.26.0

