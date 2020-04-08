Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2184CC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51EF206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360931;
	bh=ooW89rST4GmeQXzLWvXim86Mk5Dn0bBASsKnbkuiJgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ORJsoL2+UfpUOkA4lPOLjPXoWTfBMz1R4gIkBlPqQKSrx6kgB8/Bf15SYXP+KmoR
	 XWdoEt56YOBS/4wqDoFGzEtTwOP84NAfGenY1y3d3V0pwHpm8HHv1HnwDqYhdoVfHE
	 2QM30IM9YHWUBPWmqf5e5du3DHQSEJy4cCEs1ERM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgDHPqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbgDHPqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:31 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFBF720730;
        Wed,  8 Apr 2020 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=ooW89rST4GmeQXzLWvXim86Mk5Dn0bBASsKnbkuiJgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l55rUwi6jEY2YGj9/088umhgixkoDyC8JHBIIxCim0CxdmtfSdy5TnjzxWsV2ya+Z
         pQxgmoO4b05mjJyPYugJuYuyMc9fdPOJnMLQYlMew5joUed7Qx+kGDcXzd4Prh8IgD
         NOOfxZp72IDNpxrRDe/vLF5ge8lp0O32A44Nkoto=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cAO-2O; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yuti Amonkar <yamonkar@cadence.com>, devicetree@vger.kernel.org
Subject: [PATCH 02/35] docs: dt: fix broken reference to phy-cadence-torrent.yaml
Date:   Wed,  8 Apr 2020 17:45:54 +0200
Message-Id: <e2b930ceda89bc29ad84a6c6edcf196930dc18a6.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file was removed, and another file was added instead of
it, on two separate commits.

Splitting a single logical change (doc conversion) on two
patches is a bad thing, as it makes harder to discover what
crap happened.

Anyway, this patch fixes the broken reference, making it
pointing to the new location of the file.

Fixes: 922003733d42 ("dt-bindings: phy: Remove Cadence MHDP PHY dt binding")
Fixes: c6d8eef38b7f ("dt-bindings: phy: Add Cadence MHDP PHY bindings in YAML format.")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index fd1982c56104..3f913d6d1c3d 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -146,7 +146,7 @@ patternProperties:
       bindings specified in
       Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
       Torrent SERDES should follow the bindings specified in
-      Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
+      Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
 
 required:
   - compatible
-- 
2.25.2

