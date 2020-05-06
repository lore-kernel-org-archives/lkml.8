Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A785DC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882F12075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Hbyib1Ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgEFSOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:14:25 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40632 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgEFSOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:14:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 046IEArB011357;
        Wed, 6 May 2020 13:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588788850;
        bh=i7DjKQcoyf7U+urYm+53KnmXgF7F3NKsTjU/TUs3Ap4=;
        h=From:To:CC:Subject:Date;
        b=Hbyib1JuMEfN/K7GtiOT/POTCc+fGJl0VEjbG2JF5TSq+sk7jXeUcUdXE4ogchrSX
         sqgEoS+yLARGLRQ6qNmL8OWWZKHxW+Y3+oi4w65lbBqNxuZ6LL5fL6+mnstaCAeMlQ
         /uGuo1YN3o8AyJzMZ9FGcflaTByVgDUEhgESOn8s=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 046IEAVl093986
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 May 2020 13:14:10 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 6 May
 2020 13:14:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 6 May 2020 13:14:09 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 046IE8Qu064547;
        Wed, 6 May 2020 13:14:09 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 0/3] net: ethernet: ti: am65x-cpts: follow up dt bindings update
Date:   Wed, 6 May 2020 21:13:58 +0300
Message-ID: <20200506181401.28699-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, David,

This series is follow update for  TI A65x/J721E Common platform time sync (CPTS)
driver [1] to implement  DT bindings review comments from
Rob Herring <robh@kernel.org> [2].
 - "reg" and "compatible" properties are made required for CPTS DT nodes which
   also required to change K3 CPSW driver to use of_platform_device_create()
   instead of of_platform_populate() for proper CPTS and MDIO initialization
 - minor DT bindings format changes
 - K3 CPTS example added to K3 MCU CPSW bindings

[1] https://lwn.net/Articles/819313/
[2] https://lwn.net/ml/linux-kernel/20200505040419.GA8509@bogus/
Grygorii Strashko (3):
  net: ethernet: ti: am65-cpsw-nuss: use of_platform_device_create() for
    mdio
  dt-binding: net: ti: am65x-cpts: make reg and compatible required
  arm64: dts: ti: k3-am65/j721e-mcu: update cpts node

 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   | 15 ++++++++++-
 .../bindings/net/ti,k3-am654-cpts.yaml        | 25 +++++++------------
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  4 ++-
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  4 ++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      | 24 +++++++++++++-----
 drivers/net/ethernet/ti/am65-cpsw-nuss.h      |  2 ++
 6 files changed, 49 insertions(+), 25 deletions(-)

-- 
2.17.1

