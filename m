Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7BFC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5FE2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599596022;
	bh=Ui8320bbgUjCC9ruXzFfhMB/rl1YdIK89+YTJtN2Kp4=;
	h=From:To:Subject:Date:List-ID:From;
	b=oxFRYPPc2iJkKtbYPNkTVrzqx0nZ5zaPJdXM21IknkEqA9IwEVjXglautyvWpzY0e
	 nlA2MrZ6c5d4fPbawdAOg36xCGFP91671HQxrxlvTW8YN6A86p4hsre0h9/9CvlTD0
	 rWy7pYTnlCcyRBBAzwgRby5uvl+Dmpt+8v2paK4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbgIHUNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731117AbgIHUNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:13:25 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 127EB208FE;
        Tue,  8 Sep 2020 20:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599596005;
        bh=Ui8320bbgUjCC9ruXzFfhMB/rl1YdIK89+YTJtN2Kp4=;
        h=From:To:Subject:Date:From;
        b=x2UVWU6fb2LVLh4tf7Xy3TSdCJWdWYMBPhljVetb11WwJJro1X/Hm6LUiGC8u92Ic
         bV6QGDN1ItenUP0skZ+XqCzrWwed/Lf4l7fEmusgQmJ0G5hnRwrD1TOm91dcIjSkBw
         4gOeiXQk0DgoM0saKyByNGik3LJArSMvapuzRud8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: power: bq27xxx: add bq34z100
Date:   Tue,  8 Sep 2020 22:13:13 +0200
Message-Id: <20200908201319.3567-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for bq34z100 charger.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index 82f682705f44..45beefccf31a 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -51,6 +51,7 @@ properties:
       - ti,bq27621
       - ti,bq27z561
       - ti,bq28z610
+      - ti,bq34z100
 
   reg:
     maxItems: 1
-- 
2.17.1

