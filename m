Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B576CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDFA214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EEdL3hEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgCCKR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:17:29 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36656 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgCCKR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:17:29 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 023AHR9V010777;
        Tue, 3 Mar 2020 04:17:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583230647;
        bh=obAxkwX8Z4EF6e6mbeHR2LT0eEAUVXPL0QL8g5fEm9E=;
        h=From:To:CC:Subject:Date;
        b=EEdL3hEqqdjll6q1LlBkqcp3BgCk80oLMSSx1C4EQ9f1+vQgbZU5egi8mo4HC9vtP
         OuUHu1JxZVAHu61DxW37/a4XWpm9vjd00ODWSu7x/epCSYkaQ1hrUmDrZMBX4fN22A
         4a0NycbROkGUGkQAlBgvnD+OtJMi0vTYLkJbYI5k=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 023AHRZm005453
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Mar 2020 04:17:27 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 3 Mar
 2020 04:17:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 3 Mar 2020 04:17:27 -0600
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 023AHONb004649;
        Tue, 3 Mar 2020 04:17:25 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <robh@kernel.org>, <kishon@ti.com>, <nm@ti.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 0/6] arm64: ti: k3-j721e: Add SERDES PHY and USB3.0 support
Date:   Tue, 3 Mar 2020 12:17:16 +0200
Message-ID: <20200303101722.26052-1-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

This series adds SERDES PHY support. The relevant PHY driver
and bindings are already in v5.6.

It also adds Super-Speed support to the Type-C port on the EVM.
The USB Type-C related driver support is in v5.6.

Please queue this for v5.7 if no objections. Thanks.

cheers,
-roger

Changelog:
v2:
- Addressed Rob's comments.
- Changed type-C debounce delay from 300ms to 700ms as 300ms is not
sufficient on EVM.


Kishon Vijay Abraham I (3):
  dt-bindings: syscon: Add TI's J721E specific compatible string
  arm64: dts: ti: k3-j721e-main: Add WIZ and SERDES PHY nodes
  arm64: dts: ti: k3-j721e-main: Add serdes_ln_ctrl node to select
    SERDES lane mux

Roger Quadros (3):
  arm64: dts: ti: k3-j721e-main.dtsi: Add USB to SERDES MUX
  arm64: dts: ti: k3-j721e: Enable Super-Speed support for USB0
  arm64: dts: k3-j721e-proc-board: Add wait time for sampling Type-C DIR
    line

 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 .../dts/ti/k3-j721e-common-proc-board.dts     |  33 ++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 275 ++++++++++++++++++
 include/dt-bindings/mux/mux-j721e-wiz.h       |  53 ++++
 4 files changed, 360 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

