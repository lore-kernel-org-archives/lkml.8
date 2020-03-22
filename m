Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1785C54FCE
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2FC2072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgCVLG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:06:58 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34143 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgCVLG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:06:58 -0400
X-Originating-IP: 2.7.45.25
Received: from localhost.localdomain (lfbn-lyo-1-453-25.w2-7.abo.wanadoo.fr [2.7.45.25])
        (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 28A83FF803;
        Sun, 22 Mar 2020 11:06:53 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [RFC PATCH 6/7] dt-bindings: riscv: Remove "riscv,svXX" property from device-tree
Date:   Sun, 22 Mar 2020 07:00:27 -0400
Message-Id: <20200322110028.18279-7-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200322110028.18279-1-alex@ghiti.fr>
References: <20200322110028.18279-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property can not be used before virtual memory is set up
and then the  distinction between sv39 and sv48 is done at runtime
using SATP csr property: this property is now useless, so remove it.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 04819ad379c2..12baabbac213 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -39,19 +39,6 @@ properties:
       Identifies that the hart uses the RISC-V instruction set
       and identifies the type of the hart.
 
-  mmu-type:
-    allOf:
-      - $ref: "/schemas/types.yaml#/definitions/string"
-      - enum:
-          - riscv,sv32
-          - riscv,sv39
-          - riscv,sv48
-    description:
-      Identifies the MMU address translation mode used on this
-      hart.  These values originate from the RISC-V Privileged
-      Specification document, available from
-      https://riscv.org/specifications/
-
   riscv,isa:
     allOf:
       - $ref: "/schemas/types.yaml#/definitions/string"
-- 
2.20.1

