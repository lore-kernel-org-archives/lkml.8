Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08BAC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 16:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7322074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 16:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j5rXsjk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgFMQoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 12:44:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59984 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgFMQoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 12:44:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05DGhswF111003;
        Sat, 13 Jun 2020 11:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592066634;
        bh=lIvsGsW24nMTEz/eeWE5udB3Am8ZqohzsFmx7ykBBfM=;
        h=From:To:CC:Subject:Date;
        b=j5rXsjk99QrwOQHbsXfuTArVNWlL4PG2gplFB1oi9M8bbr7GzQ6NZZJzHBZJb2Qvf
         c651v43dsZhZwndY+AcygOcXCt7MPKE2/S1gBoBki1P8WZxMykbL4JWt7w062uoDB6
         LINBwWU6h8BuPf58FvLVG4rj+GpS53Jf/Vif/Wl0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05DGhsxJ085854
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 Jun 2020 11:43:54 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 13
 Jun 2020 11:43:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 13 Jun 2020 11:43:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05DGhqWe096439;
        Sat, 13 Jun 2020 11:43:53 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/2] arm64: dts: ti: k3: add platforms chipid module nodes
Date:   Sat, 13 Jun 2020 19:43:44 +0300
Message-ID: <20200613164346.28852-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

Hence k3 platforms chipid module driver was merged, there is follow up series
to add corresponding DT chipid nodes. 

[1] https://lkml.org/lkml/2020/5/29/979

Grygorii Strashko (2):
  arm64: dts: ti: k3-am65-wakeup: add k3 platforms chipid module node
  arm64: dts: ti: k3-j721e-mcu-wakeup: add k3 platforms chipid module node

 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      | 5 +++++
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.17.1

