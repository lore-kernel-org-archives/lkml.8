Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12CCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C9520776
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ciW8v2d9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgF2XOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:14:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55864 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgF2XOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:14:12 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05TCqx0C108046;
        Mon, 29 Jun 2020 07:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593435179;
        bh=LxZK6XItt8eRN8M36E8UH3WGeBppveLJV6p+zmugmTI=;
        h=From:To:CC:Subject:Date;
        b=ciW8v2d9+KONMCI11Nvt2pemy2FVyX1TioT/topmoboAD+JEFreQeaSFDFiJHH00V
         Gw43BL5TtfflHc7I9JwE5SV4Y6UKpFl6RWI4v/askkCrF2Pbij/LMoQf/35+YGVDeE
         rWLwKvUrKyVJQB4qps0HHlmopiab4pCq+1aoCSfg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05TCqxJl014789
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Jun 2020 07:52:59 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 29
 Jun 2020 07:52:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 29 Jun 2020 07:52:58 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05TCqugv015456;
        Mon, 29 Jun 2020 07:52:56 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <robh@kernel.org>, <kishon@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 0/6] arm64: ti: k3-j721e: Add SERDES PHY and USB3.0 support
Date:   Mon, 29 Jun 2020 15:52:48 +0300
Message-ID: <20200629125254.28754-1-rogerq@ti.com>
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

Please queue this for -next. Thanks.

cheers,
-roger

Changelog:
v4:
- Removed redundant patch
- used compaible string for yaml filename
- typo fix s/mdf/mfd in patch subject
- added simple-mfd, address-cells, size-cells and ranges

v3:
- Add new DT schema for J721E System controller.
- Re-order system controller's compatible string i.e. most compatible to least.

v2:
- Addressed Rob's comments.
- Changed type-C debounce delay from 300ms to 700ms as 300ms is not
sufficient on EVM.


Kishon Vijay Abraham I (2):
  arm64: dts: ti: k3-j721e-main: Add WIZ and SERDES PHY nodes
  arm64: dts: ti: k3-j721e-main: Add system controller node and SERDES
    lane mux

Roger Quadros (4):
  dt-bindings: mfd: ti,j721e-system-controller.yaml: Add J721e system
    controller
  arm64: dts: ti: k3-j721e-main.dtsi: Add USB to SERDES MUX
  arm64: dts: ti: k3-j721e: Enable Super-Speed support for USB0
  arm64: dts: k3-j721e-proc-board: Add wait time for sampling Type-C DIR
    line

 .../mfd/ti,j721e-system-controller.yaml       |  74 +++++
 .../dts/ti/k3-j721e-common-proc-board.dts     |  33 ++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 275 ++++++++++++++++++
 include/dt-bindings/mux/mux-j721e-wiz.h       |  53 ++++
 4 files changed, 433 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
 create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

