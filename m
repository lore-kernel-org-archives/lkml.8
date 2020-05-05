Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B725EC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95BFD2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HR1/DoOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgEETe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:34:26 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42958 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgEETeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:34:25 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 045JYJlH030554;
        Tue, 5 May 2020 14:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588707259;
        bh=jzWhvutcEwidozLihf++L4max15eM6nrX1kIh+xmuNY=;
        h=From:To:CC:Subject:Date;
        b=HR1/DoOgtMRclap0p8EZT4t3wEJGraiI3e+TnTKpvksSMtKf5P7XIt7tIf3fSB/A0
         TZOMH/o7LSdfKBDRjHDWGj0XRVxvhEKM9ZV0jVV/TFGX/1Dob3GBYYggzkfo4qZ9nR
         atvU3qiaHAPP0uGoVF5nn1NC0DGnfnSKbbqu3T/I=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 045JYJvF038853
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 May 2020 14:34:19 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 5 May
 2020 14:34:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 5 May 2020 14:34:19 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 045JYHxq126746;
        Tue, 5 May 2020 14:34:18 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, <devicetree@vger.kernel.org>
CC:     Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 0/2] soc: ti: add k3 platforms chipid module driver
Date:   Tue, 5 May 2020 22:34:15 +0300
Message-ID: <20200505193417.2112-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series introduces TI K3 Multicore SoC platforms chipid module driver
which provides identification support of the TI K3 SoCs (family, revision)
and register this information with the SoC bus. It is available under
/sys/devices/soc0/ for user space, and can be checked, where needed,
in Kernel using soc_device_match().
It is also required for introducing support for new revisions of
K3 AM65x/J721E SoCs.

Example J721E:
  # cat /sys/devices/soc0/{machine,family,revision}
  Texas Instruments K3 J721E SoC
  J721E
  SR1.0

Example AM65x:
  # cat /sys/devices/soc0/{machine,family,revision}
  Texas Instruments AM654 Base Board
  AM65X
  SR1.0

Changes in v2:
 - pr_debug() replaced with pr_info() to show SoC info on init
 - minor format change
 - split series on driver and platform changes
 - add Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

v1: https://lwn.net/Articles/818577/

Grygorii Strashko (2):
  dt-bindings: soc: ti: add binding for k3 platforms chipid module
  soc: ti: add k3 platforms chipid module driver

 .../bindings/soc/ti/k3-socinfo.yaml           |  40 ++++++
 drivers/soc/ti/Kconfig                        |  10 ++
 drivers/soc/ti/Makefile                       |   1 +
 drivers/soc/ti/k3-socinfo.c                   | 135 ++++++++++++++++++
 4 files changed, 186 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
 create mode 100644 drivers/soc/ti/k3-socinfo.c

-- 
2.17.1

