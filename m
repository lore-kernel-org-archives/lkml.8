Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F0BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8CA5206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594222917;
	bh=qPbFVQa1Wx91Hp6x2uzH3y2LNvB6ddAdFBVb0dj/MTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=guzFIjv8N+7FgQILyPh9I6Gz4L+9IJK1+54X9/H7hrNZ4BxuwwuZRuVn8I1dNaSn2
	 rG6tUrnlraky8nw87xwmw6UtnVSQ1E2WBFxe2pj9KkU3ywmnvHdUSZuBhWJdnaPwJw
	 tnNYwoJ2dWucSxHzAl80U1gvHP5zg7lX1VjBw7+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgGHPl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730577AbgGHPlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:41:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F233A20720;
        Wed,  8 Jul 2020 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594222909;
        bh=qPbFVQa1Wx91Hp6x2uzH3y2LNvB6ddAdFBVb0dj/MTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6SwV/BQTIYL5r0N+fiknxk1MWzgzsNDDMectVViN80y5IjQY+/mLqU26KxH8VZtG
         2Rg5QEcvmmWOrErlHF1NOtmiy+Lx2iZYjeuiea3mT+Pfko+ZV02luh/9L5RHnwY33C
         4FK7oBkxQg8elMq+kjmSKfg3QrcIwCMcFTnaegAY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangmin Park <l4stpr0gr4m@gmail.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 11/16] dt-bindings: mailbox: zynqmp_ipi: fix unit address
Date:   Wed,  8 Jul 2020 11:41:30 -0400
Message-Id: <20200708154135.3199907-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708154135.3199907-1-sashal@kernel.org>
References: <20200708154135.3199907-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangmin Park <l4stpr0gr4m@gmail.com>

[ Upstream commit 35b9c0fdb9f666628ecda02b1fc44306933a2d97 ]

Fix unit address to match the first address specified in the reg
property of the node in example.

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
Link: https://lore.kernel.org/r/20200625135158.5861-1-l4stpr0gr4m@gmail.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
index 4438432bfe9b3..ad76edccf8816 100644
--- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
@@ -87,7 +87,7 @@ Example:
 		ranges;
 
 		/* APU<->RPU0 IPI mailbox controller */
-		ipi_mailbox_rpu0: mailbox@ff90400 {
+		ipi_mailbox_rpu0: mailbox@ff990400 {
 			reg = <0xff990400 0x20>,
 			      <0xff990420 0x20>,
 			      <0xff990080 0x20>,
-- 
2.25.1

