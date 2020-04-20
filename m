Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33C8C38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A3C20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587403919;
	bh=IxBnmwUHGsYcZNKOwd+tpw9k4iNjw6R+P1uEmMntPhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JSCavu6ilNWFFcz3qXqGBhuNwrI1EbpCeXdNFq3cUKPySLi6InqaTcLhqrq/KYBDH
	 xsYv0FG4Vqy0LSD82EWGhbsVcRaRLl+Ue06FgNAHtDbPqY+qpC5Nhyoc5GlEXjzXOx
	 AR192erskBkQoHF13zwlsT9IFJ3ooUHXHpeJ0Mhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgDTRb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgDTRb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:31:58 -0400
Received: from localhost.localdomain (unknown [157.46.94.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A25C20BED;
        Mon, 20 Apr 2020 17:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587403918;
        bh=IxBnmwUHGsYcZNKOwd+tpw9k4iNjw6R+P1uEmMntPhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9gZNuXFuUPE3n9PEIE1vJsmd3NNUJAPYD9et/4FmW2wutu+mPPNNGLOzV2YaaE05
         UwFaBV+D37zRNAUgbpn3kYO0GyU7UEXwMIdVinvd0Nl48MJ5ay27zwvxqUahi8cEUF
         Z/fK5DwAnfhDGWyGWupXgO3cCHt+Sb4euEMByjRg=
From:   mani@kernel.org
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 3/6] dt-bindings: arm: stm32: Document Stinger96 compatible
Date:   Mon, 20 Apr 2020 23:01:21 +0530
Message-Id: <20200420173124.27416-4-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420173124.27416-1-mani@kernel.org>
References: <20200420173124.27416-1-mani@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Document devicetree compatible of Shiratech Stinger96 board.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 71ea3f04ab9c..3849f1d0e03e 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -39,6 +39,7 @@ properties:
           - enum:
               - arrow,stm32mp157a-avenger96 # Avenger96
               - lxa,stm32mp157c-mc1
+              - shiratech,stm32mp157a-stinger96 # Stinger96
               - st,stm32mp157c-ed1
               - st,stm32mp157a-dk1
               - st,stm32mp157c-dk2
-- 
2.17.1

