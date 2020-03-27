Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85959C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B172082E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585315635;
	bh=psper8VrHdCV5HS9lHJgsiiF7t3x+38IYIHkZSHTF2M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NCtIIhOH+a68busprN25UPoMdc3m97YCDwW4Kdf5SbTE2gX5shV6d2ibIc3yUVjQe
	 tuC3X7M8lhQstCXs0DKy6lJWafN91EIHZuzuFCPAWNLng9eBukpkU96ro6sJonxlmT
	 mnnqjIM9nv+ytVH6MtiW9wqs+aJme0Lt6dwDgx0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgC0N1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:27:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgC0N1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:27:14 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B01B32082D;
        Fri, 27 Mar 2020 13:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585315633;
        bh=psper8VrHdCV5HS9lHJgsiiF7t3x+38IYIHkZSHTF2M=;
        h=From:To:Cc:Subject:Date:From;
        b=tWpc8j/ddZhHm/TZbBG2ZYCyusJh/SvmRjlLv1scAy7u4YDtLztrlURvoUCIKyVZi
         lCL9J5rPqok/G25W79cpCTpSVhyn81AoZUKwxAuS4d9HAbhn01TXpmyqJiwq1RQ9AQ
         WHlQ1R5vylA7KWbpjduGA/9WlXWOGLdL0+9YdtUg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jHp0x-0049dW-4D; Fri, 27 Mar 2020 14:27:11 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] MAINTAINERS: dt: fix pointers for ARM Integrator, Versatile and RealView
Date:   Fri, 27 Mar 2020 14:27:10 +0100
Message-Id: <13cb650158b3fa2c09d3cefc5694e0868ae7f88f.1585315608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a conversion from a plain text binding file into 4 yaml ones.
The old file got removed, causing this new warning:

	Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/arm/arm-boards

Address it by replacing the old reference by the new ones

Fixes: 2d483550b6d2 ("dt-bindings: arm: Drop the non-YAML bindings")
Fixes: 33fbfb3eaf4e ("dt-bindings: arm: Add Integrator YAML schema")
Fixes: 4b900070d50d ("dt-bindings: arm: Add Versatile YAML schema")
Fixes: 7db625b9fa75 ("dt-bindings: arm: Add RealView YAML schema")
Fixes: 4fb00d9066c1 ("dt-bindings: arm: Add Versatile Express and Juno YAML schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d3f00c70555..f9264b14ac30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1295,7 +1295,10 @@ ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/arm/arm-boards
+F:	Documentation/devicetree/bindings/arm/arm,integrator.yaml
+F:	Documentation/devicetree/bindings/arm/arm,realview.yaml
+F:	Documentation/devicetree/bindings/arm/arm,versatile.yaml
+F:	Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
 F:	Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
 F:	Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-versatile.txt
-- 
2.25.1


