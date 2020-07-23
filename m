Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAA1C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A2620792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R8OYczo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgGWM1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:27:02 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36626 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgGWM06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:26:58 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06NCQr8T077153;
        Thu, 23 Jul 2020 07:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595507213;
        bh=qEHLl+oKKILik5zFthl7K1N5nwqibOWaX+6gSuWNfnc=;
        h=From:To:CC:Subject:Date;
        b=R8OYczo9VzXsa0mue0YtwLX3AJ1CAKeO9BUM1irnWx3Fsb89WruMX0deD0RF+Bvk6
         TgjJh3Oc5jFGrVta3b0EctU0p/7f452hMJKMyxRZERg43XvXU0QeREZuDU2pAf083N
         MxMadroHDJhLBBl8RVJPc+j0da5o0NqOqAPXr20s=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06NCQr8H022951
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jul 2020 07:26:53 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Jul 2020 07:26:53 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Jul 2020 07:26:53 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06NCQooV024814;
        Thu, 23 Jul 2020 07:26:51 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add DT to get PCIe working in J721E SoC
Date:   Thu, 23 Jul 2020 17:56:47 +0530
Message-ID: <20200723122649.24676-1-kishon@ti.com>
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

