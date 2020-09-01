Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B714C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBD52078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LMj5tof/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbgIAQBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:01:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54170 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgIAQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:01:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 081E6hQE059157;
        Tue, 1 Sep 2020 09:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598969203;
        bh=62zSyAiSYxrZr6Sq8MDkMbOm+Vi5s5UC4OzsZp7L170=;
        h=From:To:CC:Subject:Date;
        b=LMj5tof/ylHOp7gwI4tJ2XVui8K3HdCUDDkLCUWZqzm6zeJfOoGMkl/2ZyZJd5HXq
         JeYrbJsGXA24i0rM7i7VbxLqCk69esuuR1uidVLCbEAxgKla+kb1dzUbeJQKYbzdxr
         yBE/Sy+jkttyhHy92ZEStpEZs+vmsa0/AZeHLdcw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 081E6hhZ017677
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 09:06:43 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 09:06:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 09:06:42 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 081E6Zlf034944;
        Tue, 1 Sep 2020 09:06:36 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RESEND PATCH 0/2] Add DT to get PCIe working in J721E SoC
Date:   Tue, 1 Sep 2020 19:36:26 +0530
Message-ID: <20200901140628.8800-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that J721E PCIe support is merged (including the YAML bindings),
add PCIe device tree nodes to get PCIe working in J721E SoC both in
RC mode and EP mode.

Series has been rebased to:
git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux ti-k3-dts-next 

No changes from the previous version sent to
http://lore.kernel.org/r/20200724055604.31498-1-kishon@ti.com

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

