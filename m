Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99069C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725802068E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598350418;
	bh=HqOI8feOI/47aGR0ob8Txo2AUeoAS4q7aUyZJ170ZZU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eKDlGqI0G9AowQ/QnZHC6PNlLI269Gb1K5wGPjAzIsmOQA3G4QVTEpy7q13u+fpMi
	 AnUmlaOnjnwc2WvW5TlbLq8eD2pI9eV0otby4eXqlIfls/G7BqtIWJEcLNlOQ2dY2t
	 6GhERSbGP0qT49K7H5RGdL+6kAAqibRl2Cfwj6VA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgHYKNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729778AbgHYKNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:13:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A292068E;
        Tue, 25 Aug 2020 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598350411;
        bh=HqOI8feOI/47aGR0ob8Txo2AUeoAS4q7aUyZJ170ZZU=;
        h=From:To:Cc:Subject:Date:From;
        b=R7WR/BXHmSfw44fsBfq+KMdbZuToY27d8rFZ4vOTlBSSac/kAOs1LAQ4Z4clqQy5p
         ClyYDeOL/kx08x6sgZCCPMNGjmuENSRtFsTy7zl/0vye2pHhrOJwOb+rA99CFmEEvz
         SrBKBZVI3rDG9D1+UnRIhvHmblX+geLrm3q2j+kc=
From:   Mark Brown <broonie@kernel.org>
To:     ChiYuan Huang <cy_huang@richtek.com>
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH] regulator: rt4801: Specify additionalProperties: false
Date:   Tue, 25 Aug 2020 11:12:50 +0100
Message-Id: <20200825101250.9485-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/regulator/richtek,rt4801-regulator.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
index fa075c6e67f9..235e593b3b2c 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
@@ -49,6 +49,8 @@ required:
   - compatible
   - reg
 
+additionalProperties: false
+
 examples:
   - |
     i2c {
-- 
2.20.1

