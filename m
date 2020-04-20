Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58820C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3359020BED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587403931;
	bh=7aBAnRak5Bldx4cBNSXIUSnVBTzqbPpz13Ef8H6bw6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c1HXxgO8Q285s3nBtw2sm+YRDk8wsuY0oq+apIFbenKzjanBfdSlvRBru4eJpfSpY
	 Aw5MSGitMuzm+2ISNJ34YXBwbDGc1Xh2PyZR2SkmYLDL/no8Z882RrQ2Fmzm3wzmCl
	 Bn9XpEQ3NB5bllTuehc+Fer6/X94blahivji6O40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgDTRcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgDTRcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:32:08 -0400
Received: from localhost.localdomain (unknown [157.46.94.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AA2620BED;
        Mon, 20 Apr 2020 17:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587403928;
        bh=7aBAnRak5Bldx4cBNSXIUSnVBTzqbPpz13Ef8H6bw6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jRwFFMZ5PgGHnq4m9KPyYvozIDZo4gptcKMxqi+1sZar+3PKOHpM0m2VaNSD+2Xni
         rUXm/AqGtr8PpVIVz5nJPuBLoK/wkaIs9r7RpSxcc4Sa26VKsXFG4OqoPANudJc6Xc
         aDkRsQn8vt4WFpn2rLfjDC5+R+wQdyKsC7zWN12w=
From:   mani@kernel.org
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 5/6] dt-bindings: arm: stm32: Document IoT Box compatible
Date:   Mon, 20 Apr 2020 23:01:23 +0530
Message-Id: <20200420173124.27416-6-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420173124.27416-1-mani@kernel.org>
References: <20200420173124.27416-1-mani@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Document devicetree compatible of Shiratech IoT Box.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 3849f1d0e03e..790e6dd48e34 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -39,6 +39,7 @@ properties:
           - enum:
               - arrow,stm32mp157a-avenger96 # Avenger96
               - lxa,stm32mp157c-mc1
+              - shiratech,stm32mp157a-iot-box # IoT Box
               - shiratech,stm32mp157a-stinger96 # Stinger96
               - st,stm32mp157c-ed1
               - st,stm32mp157a-dk1
-- 
2.17.1

