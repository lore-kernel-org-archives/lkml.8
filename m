Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2B0C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D652082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="azxFqOis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgAaSiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:38:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45646 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgAaSiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:38:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00VIbrEm054222;
        Fri, 31 Jan 2020 12:37:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580495873;
        bh=wFJrhXaox/xED3U0hn0P1PzvdyfG0/rLsIlSJEsK7YY=;
        h=From:To:CC:Subject:Date;
        b=azxFqOisBBxS1D1M0wD2FMv+tEcKPek3XETbiM98QTDFMjhBVaLhqvCta/1G+U5Ih
         JOhYReOA6zvSMvSDAG9jIGWWXlNIikoNjFnqbJPNpdPGGY55bwabPhpZZVe7WNlKgd
         fk+bFhx9MnsROkOr6hmTjmhVOWe2K/8R3LsNn65k=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00VIbrmE101501
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jan 2020 12:37:53 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 31
 Jan 2020 12:37:53 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 31 Jan 2020 12:37:53 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00VIbqMS092727;
        Fri, 31 Jan 2020 12:37:52 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <linux-kernel@vger.kernel.org>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <wg@grandegger.com>,
        <sriram.dash@samsung.com>
CC:     <davem@davemloft.net>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH linux-master 0/3] MCAN updates for clock discovery
Date:   Fri, 31 Jan 2020 12:34:30 -0600
Message-ID: <20200131183433.11041-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

These are the initial fixes for issues found in and requested in
https://lore.kernel.org/patchwork/patch/1165091/

For the clock discovery and initialization.

Dan

Dan Murphy (3):
  can: tcan4x5x: Move clock init to TCAN driver
  can: m_can_platform: Move clock discovery and init to platform
  can: m_can: Remove unused clock function from the framework

 drivers/net/can/m_can/m_can.c          | 16 ------
 drivers/net/can/m_can/m_can.h          |  3 -
 drivers/net/can/m_can/m_can_platform.c | 37 +++++++++---
 drivers/net/can/m_can/tcan4x5x.c       | 78 +++++++++++++++++++-------
 4 files changed, 89 insertions(+), 45 deletions(-)

-- 
2.25.0

