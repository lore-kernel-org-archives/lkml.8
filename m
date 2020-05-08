Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB84BC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F8C208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QS9p/Edf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgEHI3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:29:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49578 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgEHI3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:29:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0488TgCO023259;
        Fri, 8 May 2020 03:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588926582;
        bh=WVLyKexaTHThjRBNIWhIYQ1jHDIkHwKx9rD6q73WgVk=;
        h=From:To:CC:Subject:Date;
        b=QS9p/EdfPaPpTCMbj/RHIyREw+FGLCtXRlpht5fyX5QwC8q3YbwUDVIgdqnR7ltiF
         jEJO4zzHzDRwLz1hJzdfcTjRuRJszMhWxoDlX2WJhl4c8lXCJHvzIbi6bbcQ98z+6v
         pDAldR/ooW9tHtOkHtNxrfEIaje3H1DrBW7BfR/4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0488Tgox103003
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 May 2020 03:29:42 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 03:29:42 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 03:29:42 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0488Tdn9073953;
        Fri, 8 May 2020 03:29:40 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <robh@kernel.org>, <kishon@ti.com>, <nm@ti.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 0/7] arm64: ti: k3-j721e: Add SERDES PHY and USB3.0 support
Date:   Fri, 8 May 2020 11:29:30 +0300
Message-ID: <20200508082937.14171-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

This series adds SERDES PHY support and Type-C USB Super-Speed support
to the J721E EVM.

Please queue this for v5.8. Thanks.

cheers,
-roger

Changelog:
v3:
- Add new DT schema for J721E System controller.
- Re-order system controller's compatible string i.e. most compatible to least.

v2:
- Addressed Rob's comments.
- Changed type-C debounce delay from 300ms to 700ms as 300ms is not
sufficient on EVM.

Kishon Vijay Abraham I (3):
  dt-bindings: syscon: Add TI's J721E specific compatible string
  arm64: dts: ti: k3-j721e-main: Add WIZ and SERDES PHY nodes
  arm64: dts: ti: k3-j721e-main: Add system controller node and SERDES
    lane mux

Roger Quadros (4):
  dt-bindings: mdf: ti,j721e-syscon.yaml: Add J721e system controller
  arm64: dts: ti: k3-j721e-main.dtsi: Add USB to SERDES MUX
  arm64: dts: ti: k3-j721e: Enable Super-Speed support for USB0
  arm64: dts: k3-j721e-proc-board: Add wait time for sampling Type-C DIR
    line

 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../bindings/mfd/ti,j721e-syscon.yaml         |  69 +++++
 .../dts/ti/k3-j721e-common-proc-board.dts     |  33 ++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 275 ++++++++++++++++++
 include/dt-bindings/mux/mux-j721e-wiz.h       |  53 ++++
 5 files changed, 429 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,j721e-syscon.yaml
 create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

