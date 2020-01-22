Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0767BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF6324688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699288;
	bh=jBO8c3HZQlw8vC1oXpZ3tYukt12CxJcPFqFl1KXNQiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tP5IfEPLW424K+nqIEMregmxiUdfquk2twbs82oqwFUfX0tP3BmYH+57dgEyotxTA
	 cI/iphxFSOkDYt1BxkgAy7faGvmvVCJc0Tqe+yKPrPTO8N79V83CxGjiKC4db9IzXc
	 FjJDMaP7ip3KhIwoYe4jGox5bDyMrcN1CdLvwltA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgAVNV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:21:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730256AbgAVNVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:21:25 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B126205F4;
        Wed, 22 Jan 2020 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699284;
        bh=jBO8c3HZQlw8vC1oXpZ3tYukt12CxJcPFqFl1KXNQiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gNbhVs8rzAwRlJwRRfLxZ+Ibs/qs7sOTR3zQEGf3aube4qWKPo4knc92TB/NYyVOz
         +GpkeXDo3XqU4h24z31bkHT2uAwDL2R3oRWBS4YZFep/CRTm84v2BD0fIW8HQt5KF5
         SH3pFABWgl4Isb/7X0pfXXsVWrXIPRk08EdgLmUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 097/222] ARM: dts: imx6q-icore-mipi: Use 1.5 version of i.Core MX6DL
Date:   Wed, 22 Jan 2020 10:28:03 +0100
Message-Id: <20200122092840.687283808@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagan Teki <jagan@amarulasolutions.com>

commit 4a132f60808ae3a751e107a373f8572012352d3c upstream.

The EDIMM STARTER KIT i.Core 1.5 MIPI Evaluation is based on
the 1.5 version of the i.Core MX6 cpu module. The 1.5 version
differs from the original one for a few details, including the
ethernet PHY interface clock provider.

With this commit, the ethernet interface works properly:
SMSC LAN8710/LAN8720 2188000.ethernet-1:00: attached PHY driver

While before using the 1.5 version, ethernet failed to startup
do to un-clocked PHY interface:
fec 2188000.ethernet eth0: could not attach to PHY

Similar fix has merged for i.Core MX6Q but missed to update for DL.

Fixes: a8039f2dd089 ("ARM: dts: imx6dl: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit support")
Cc: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6dl-icore-mipi.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/imx6dl-icore-mipi.dts
+++ b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
@@ -8,7 +8,7 @@
 /dts-v1/;
 
 #include "imx6dl.dtsi"
-#include "imx6qdl-icore.dtsi"
+#include "imx6qdl-icore-1.5.dtsi"
 
 / {
 	model = "Engicam i.CoreM6 DualLite/Solo MIPI Starter Kit";


