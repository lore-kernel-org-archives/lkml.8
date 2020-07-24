Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA60C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CAF20768
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bscCABDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGXF4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:56:11 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50006 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgGXF4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 01:56:11 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06O5u7Iq087970;
        Fri, 24 Jul 2020 00:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595570167;
        bh=qEHLl+oKKILik5zFthl7K1N5nwqibOWaX+6gSuWNfnc=;
        h=From:To:CC:Subject:Date;
        b=bscCABDaOtYw77E9HQMAbCzolfpnR81qwfCKoepYwllfs1HSkBMYc1M1DQ5zOL36v
         AnqCPxE6uuH5CDmOLphgb3dh81rqtb2lzQhIpWZ8Zd6R9FNYNeBn5hsXCiJtIRuy/d
         dmUf7gPqfGsC+PRPxw1qB7odUBN7J3iw/cOjP4cY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06O5u72M001051
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jul 2020 00:56:07 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Jul 2020 00:56:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Jul 2020 00:56:07 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06O5u435005411;
        Fri, 24 Jul 2020 00:56:05 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kishon@ti.com>
Subject: [PATCH 0/2] Add DT to get PCIe working in J721E SoC
Date:   Fri, 24 Jul 2020 11:26:02 +0530
Message-ID: <20200724055604.31498-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series adds device tree of I2C and PCIe DT nodes to get PCIe working
in both RC mode and EP mode in J721E.

The PCIe support patch series is queued in Lorenzo's branch [1]

This patch series is rebased to Tero's ti-k3-next branch [2]

[1] -> https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/log/?h=pci/cadence
[2] -> https://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux.git/log/?h=ti-k3-next

Kishon Vijay Abraham I (2):
  arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes
  arm64: dts: ti: k3-j721e-common-proc-board: Configure the PCIe
    instances

 .../dts/ti/k3-j721e-common-proc-board.dts     |  80 +++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 218 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   5 +-
 3 files changed, 302 insertions(+), 1 deletion(-)

-- 
2.17.1

