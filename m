Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D57C47256
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB5C20757
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588520565;
	bh=IxBnmwUHGsYcZNKOwd+tpw9k4iNjw6R+P1uEmMntPhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s3ITQaFNHIpOeEnbgVuzh2K7xEocS6OkRwXOQYWgkcIxmiRWUOy2jM6Jiebuz2L2o
	 vIY10M08gw8aYZ9kXIekNSo2bzXdd4+GlLieFXAeXWZX7ztieaafnb/P0hKoerrkac
	 eHmVnxMqCYZiuEBuCOjPxR7EjLK4ewFkkq6HKHEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgECPmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 11:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbgECPmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:42:43 -0400
Received: from localhost.localdomain (unknown [157.51.190.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D968207DD;
        Sun,  3 May 2020 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588520562;
        bh=IxBnmwUHGsYcZNKOwd+tpw9k4iNjw6R+P1uEmMntPhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0EQAVSzQz9LsHQ5jzQ51KqfQFLaLxz6BtU3vYwdnXcGbAZ/6+L8b6EGaE0x2axszy
         E6tPW1Z7BGtyk046yYd3S8+bIg0LAsylhkROPOT4Me41PoRQ3AToo4nEvxR6lIcPx6
         Zx4x/xbOU8YrVdpVoGC8tuczfABweEi4rtKv7TOw=
From:   mani@kernel.org
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 3/6] dt-bindings: arm: stm32: Document Stinger96 compatible
Date:   Sun,  3 May 2020 21:12:12 +0530
Message-Id: <20200503154215.23654-4-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200503154215.23654-1-mani@kernel.org>
References: <20200503154215.23654-1-mani@kernel.org>
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

