Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC49C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0167A20E65
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599162831;
	bh=Fa3b1lnE22DhvntC+PGrdNGj85OZk2EbC6j9zvy+N3k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FEbgSvu3KXjDPmkF8/yV0McY4teWqq4JT5cxP1e12I0TgN34+kAdSC6ojobpKJ9QG
	 KImGz/rx+PM5T00KIsJ/XXpC9Z6bExpd6qPiI+5kQ3dKkVsfAUA4EMdyX08EmkrIjy
	 NHMK8tfu5vDCvRIVVM5aYINJSdXEsHSxTtM98n2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgICTxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbgICTxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:53:43 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112C020716;
        Thu,  3 Sep 2020 19:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599162822;
        bh=Fa3b1lnE22DhvntC+PGrdNGj85OZk2EbC6j9zvy+N3k=;
        h=From:To:Cc:Subject:Date:From;
        b=IBcSYB63LIhhSzrXhUJrbm2jBDhdmvZ57hAXN7Gq6dP4dW5o+ZfDjkdwxyQYq1gDh
         Wg6/aed9elRT57fdkmb/XfYWBL2Qx+G8TlIW7SBz59D6aPY3i1YgcJv+YlNfRYcjGZ
         J+5rSshxutyz7vhKTD3O4kU5ajjJIgSlPUR/8tLc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: mailbox: fsl,mu: Fix i.MX 8QXP compatible matching
Date:   Thu,  3 Sep 2020 21:53:23 +0200
Message-Id: <20200903195325.5394-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mailbox on i.MX 8QXP (fsl,imx8qxp-mu) can also be compatible with
fsl,imx8-mu-scu (for fast IPC) so adjust the compatibles to fix
dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: mailbox@5d1f0000:
    compatible: ['fsl,imx8-mu-scu', 'fsl,imx8qxp-mu', 'fsl,imx6sx-mu']
    is not valid under any of the given schemas (Possible causes of the failure):

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: mailbox@5d1f0000:
    compatible: ['fsl,imx8-mu-scu', 'fsl,imx8qxp-mu', 'fsl,imx6sx-mu'] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. None
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 8a3470b64d06..7ed096360be2 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -38,8 +38,9 @@ properties:
           - const: fsl,imx6sx-mu
       - description: To communicate with i.MX8 SCU with fast IPC
         items:
-          - const: fsl,imx8qxp-mu
           - const: fsl,imx8-mu-scu
+          - const: fsl,imx8qxp-mu
+          - const: fsl,imx6sx-mu
 
   reg:
     maxItems: 1
-- 
2.17.1

