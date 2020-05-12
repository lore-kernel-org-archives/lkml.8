Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FFDC54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C800B206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbgELOsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:48:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:35662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730195AbgELOsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:48:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 93249ACCE;
        Tue, 12 May 2020 14:48:43 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     swarren@wwwdotorg.org, robh+dt@kernel.org, robin.murphy@arm.com
Cc:     devicetree@vger.kernel.org, talho@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, afaerber@suse.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH 2/4] dt-bindings: sram: add documentation for reserved-only flag
Date:   Tue, 12 May 2020 16:48:01 +0200
Message-Id: <20200512144803.24344-2-ykaukab@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200512144803.24344-1-ykaukab@suse.de>
References: <20200512144803.24344-1-ykaukab@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the new optional flag added for SRAM driver.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 Documentation/devicetree/bindings/sram/sram.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 19d116ff9ddc..4bcc309fa841 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -55,6 +55,12 @@ properties:
       as write combining. WC is used by default.
     type: boolean
 
+  reserved-only:
+    description:
+      The flag indicating, that only SRAM reserved regions have to be remapped.
+      remapping type is selected depending upon no-memory-wc as usual.
+    type: boolean
+
 patternProperties:
   "^([a-z]*-)?sram(-section)?@[a-f0-9]+$":
     type: object
-- 
2.25.0

