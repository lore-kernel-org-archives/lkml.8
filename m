Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3268DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F21E20727
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="To56uubN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbgGVX4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:56:04 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59950 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgGVX4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:56:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06MNtwsG014770;
        Wed, 22 Jul 2020 18:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595462158;
        bh=v0VRddPclOlei0BW7bJOnJe3NxEuTUvl0Xe3+dkijHY=;
        h=From:To:CC:Subject:Date;
        b=To56uubNhecdnY7N7N0RiBNcLyPPbzGnvQxQGGtM3w8dKRaktjFcajeuh86kI7+P1
         Dy0Ay3si+iZk1VFgRCZXPJGWskrVj0vOFEiY7bFYqTSgKZ1K6y8Z4SnlhDEswDhnwG
         jw8FzZzEt9LcTfgxZpQ3XGrkZuKixMK60gJxJZd4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06MNtwDc094112
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jul 2020 18:55:58 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 22
 Jul 2020 18:55:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 22 Jul 2020 18:55:58 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06MNtwMo109422;
        Wed, 22 Jul 2020 18:55:58 -0500
Received: from localhost ([10.250.34.248])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 06MNtwML072336;
        Wed, 22 Jul 2020 18:55:58 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 0/4] TI K3 R5F remoteproc support
Date:   Wed, 22 Jul 2020 18:55:50 -0500
Message-ID: <20200722235554.7511-1-s-anna@ti.com>
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

The following is v3 of the TI K3 R5F remoteproc driver series supporting all
the R5F processor clusters/subsystems on TI AM65x and J721E SoCs. Please
see the v1 cover-letter [1] for the features supported on these R5F processors.
This series is almost ready and awaiting the conclusion on the bindings
discussion from v2.

The patches are rebased and slightly revised versions of v2 to sit on top of
the v5 K3 DSP C66x [2] and v3 C71x remoteproc driver series [3].

Following are the main differences from v2:
 - The bindings patch (patch #1) is revised to move away from using the
   ti-sci-proc yaml bindings file to the generic refactored ti,k3-sci-common.yaml
   bindings patch introduced in the latest K3 DSP C66x series.
 - Minor updates to the R5F remoteproc driver (patch #2) fixing all the
   pending review comments from Mathieu

Please see the individual patches for detailed delta differences.

regards
Suman

[1] R5F v1: https://patchwork.kernel.org/cover/11456367/
[2] R5F v2: https://patchwork.kernel.org/cover/11632993/
[3] C66x v5: https://patchwork.kernel.org/cover/11676819/
[4] C71x v3: https://patchwork.kernel.org/cover/11602345/

Suman Anna (4):
  dt-bindings: remoteproc: Add bindings for R5F subsystem on TI K3 SoCs
  remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem
  remoteproc: k3-r5: Initialize TCM memories for ECC
  remoteproc: k3-r5: Add loading support for on-chip SRAM regions

 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  |  281 ++++
 drivers/remoteproc/Kconfig                    |   13 +
 drivers/remoteproc/Makefile                   |    1 +
 drivers/remoteproc/ti_k3_r5_remoteproc.c      | 1395 +++++++++++++++++
 4 files changed, 1690 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
 create mode 100644 drivers/remoteproc/ti_k3_r5_remoteproc.c

-- 
2.26.0

