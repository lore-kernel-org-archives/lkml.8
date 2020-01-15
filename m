Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CD0C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D090F207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rUA4+c20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgAOKfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:35:24 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35352 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbgAOKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:35:24 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00FAZDPA015455;
        Wed, 15 Jan 2020 04:35:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579084513;
        bh=jHHq6tBvJANy25bIWbt9if2gvhapze0d8vL3P10H55E=;
        h=From:To:CC:Subject:Date;
        b=rUA4+c20fAlJXRl1t6mQbvbS7Ue5WT2ZjXSzmaLd/IWLxydnuzpHa9mX4pDzRa8tN
         +By3s0U8sXAUTMeu6HiO40wgZx93iOj9vLz/ohFMXuGS/pQMDPPM11MFTly/1ZydXt
         2cjKfrWRVK0x7Qvv1QSgY8ZdfVFi8OM3eze0fRTg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00FAZDEZ128815
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jan 2020 04:35:13 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 15
 Jan 2020 04:35:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 15 Jan 2020 04:35:11 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00FAZ8vm050211;
        Wed, 15 Jan 2020 04:35:08 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ssantosh@kernel.org>, <santosh.shilimkar@oracle.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <t-kristo@ti.com>, <grygorii.strashko@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <lokeshvutla@ti.com>,
        <tony@atomide.com>, <j-keerthy@ti.com>, <vigneshr@ti.com>,
        <nm@ti.com>, <nsekhar@ti.com>
Subject: [PATCH v9 0/2] soc: ti: k3: Introduce ringacc driver
Date:   Wed, 15 Jan 2020 12:35:43 +0200
Message-ID: <20200115103545.6363-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

as you have asked I have sending the ringacc driver as a separate series from
the DMA support for K3 platform.

I have picked the patches from v8 of the DMA support series.

The changelog regarding to ringacc:

Changes since v8:
- No change, picked from
 v8: https://lore.kernel.org/lkml/20191223110458.30766-1-peter.ujfalusi@ti.com/

Changes since v7:
- Added Tested-by from Keerthy
- Do not allow it to be built as a module for now as two exports are missing
  from kernel:
 - devm_ti_sci_get_of_resource()
 - of_msi_get_domain()

Changes since v6:
- No change

Changes since v5:
- No change

Changes since v4:
- clarify the meaning of ti,sci-dev-id in the binding document
- Remove 'default y' from Kconfig
- Fix struct comments
- Move try_module_get() earlier in k3_ringacc_request_ring()

Changes since v3:
- TODO_GS is removed from the header
- pm_runtime removed as NAVSS and it's components are always on
- Check validity of Message mode setup (element size > 8 bytes must use proxy)

Changes since v2:
- fixed up th commit message (SoB, TI-SCI)
- fixed ring reset
- CONFIG_TI_K3_RINGACC_DEBUG is removed along with the dbg_write/read functions
  and use dev_dbg()
- k3_ringacc_ring_dump() is moved to static
- step numbering removed from k3_ringacc_ring_reset_dma()
- Add clarification comment for shared ring usage in k3_ringacc_ring_cfg()
- Magic shift values in k3_ringacc_ring_cfg_proxy() got defined
- K3_RINGACC_RING_MODE_QM is removed as it is not supported

Changes since v1:
- Added Rob's Reviewed-by to ringacc DT binding document patch

Regards,
Peter
---
Grygorii Strashko (2):
  bindings: soc: ti: add documentation for k3 ringacc
  soc: ti: k3: add navss ringacc driver

 .../devicetree/bindings/soc/ti/k3-ringacc.txt |   59 +
 drivers/soc/ti/Kconfig                        |   11 +
 drivers/soc/ti/Makefile                       |    1 +
 drivers/soc/ti/k3-ringacc.c                   | 1157 +++++++++++++++++
 include/linux/soc/ti/k3-ringacc.h             |  244 ++++
 5 files changed, 1472 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
 create mode 100644 drivers/soc/ti/k3-ringacc.c
 create mode 100644 include/linux/soc/ti/k3-ringacc.h

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

