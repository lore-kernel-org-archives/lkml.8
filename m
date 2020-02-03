Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2BCC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 05:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846AE207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 05:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580707513;
	bh=Aq0yEnBkPZ2i28u2kA+F5xCcoMjtJM3CWtJgcuQxAI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QCLfSI2GCMFdhZhyRo2VCKAGdHVqt0bpQ6bCnI/yzQrentbTymnNoPSkVrxOkPhm/
	 K8343f54hYmNpWuGrFhiovA/le0nPsfLKYiOhAmyhRayFQh40TwQlLY11HxzinKEDZ
	 H8tfXWVZqpGT/kqATEPgaBzpO392x627NR4pVz6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgBCFZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 00:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgBCFZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 00:25:09 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB762080D;
        Mon,  3 Feb 2020 05:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580707509;
        bh=Aq0yEnBkPZ2i28u2kA+F5xCcoMjtJM3CWtJgcuQxAI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/928VeEyoFEYXbIWkImpCUwlhO4t9K/TmNAhMzMvbabz08lIhif7Mcwem0U1nMdG
         NGiEk/fp9CgAS1qX0ixhQeyezgyRvifoGuavCo1BHNQ2UCkoDQL0fueNTL4TKF4sDZ
         1C9RJzKs4knv6M41nQEXx6DbITIwgHdNvWIv83Kg=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Wen He <wen.he_1@nxp.com>
Subject: [PATCH 2/2] dt/bindings: clk: fsl,plldig: Drop 'bindings' from schema id
Date:   Sun,  2 Feb 2020 21:25:07 -0800
Message-Id: <20200203052507.93215-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200203052507.93215-1-sboyd@kernel.org>
References: <20200203052507.93215-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having 'bindings' in here causes a warning when checking the schema.

 Documentation/devicetree/bindings/clock/fsl,plldig.yaml:
 $id: relative path/filename doesn't match actual path or filename
         expected: http://devicetree.org/schemas/clock/fsl,plldig.yaml#

Remove it.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Wen He <wen.he_1@nxp.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/devicetree/bindings/clock/fsl,plldig.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/fsl,plldig.yaml b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
index ad37d3273229..c8350030b374 100644
--- a/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
+++ b/Documentation/devicetree/bindings/clock/fsl,plldig.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/bindings/clock/fsl,plldig.yaml#
+$id: http://devicetree.org/schemas/clock/fsl,plldig.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NXP QorIQ Layerscape LS1028A Display PIXEL Clock Binding
-- 
Sent by a computer, using git, on the internet

