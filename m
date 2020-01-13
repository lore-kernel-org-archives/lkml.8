Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EDDC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7713214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lriEWlQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbgAMGAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:00:52 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18839 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgAMGAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:00:51 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1c077f0000>; Sun, 12 Jan 2020 22:00:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 12 Jan 2020 22:00:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 12 Jan 2020 22:00:50 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan
 2020 06:00:50 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 Jan 2020 06:00:50 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.118]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1c07900007>; Sun, 12 Jan 2020 22:00:50 -0800
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <felipe.balbi@linux.intel.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v1] dt-binding: usb: add "super-speed-plus"
Date:   Mon, 13 Jan 2020 14:00:46 +0800
Message-ID: <20200113060046.14448-1-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578895231; bh=RIrMJ3U8mxtLMCKPdAwhUjbmNPuOINjinnOtxdHqqwQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=lriEWlQsyplWRBZsxy1+WPHhQ43hi/hmfiF600yYu7oc0lSpqRhrDkR/7pejc/Ytt
         +7CKED2RtfKqDJE4Npvoz8vlp7RsqBxSflwmOmq2edEclZ2A00Ves0reabtZRA2TMa
         Ns7kmS4GdqqaJSuKZMu8Zil0oHLos43hFtFX8lDiZJ1WhCTXuz/xE7QhuhXbgkJGlk
         OABr8TjK6jGoOlDEBS4w68ZZpdgoHW/I8CZRCdJax5oS3Xqvpk+4Bm4lwqhG0fquEF
         giCpwAbGG1/X5KfGg3vyugmXlwnqj/pHWkzfmR0mldt//56bOZovvd92eBkSnvmeUY
         BphUzzI4+YyJQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds "super-speed-plus" to valid argument list of
"maximum-speed" property.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 Documentation/devicetree/bindings/usb/generic.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
index cf5a1ad456e6..e6790d2a4da9 100644
--- a/Documentation/devicetree/bindings/usb/generic.txt
+++ b/Documentation/devicetree/bindings/usb/generic.txt
@@ -2,10 +2,11 @@ Generic USB Properties
 
 Optional properties:
  - maximum-speed: tells USB controllers we want to work up to a certain
-			speed. Valid arguments are "super-speed", "high-speed",
-			"full-speed" and "low-speed". In case this isn't passed
-			via DT, USB controllers should default to their maximum
-			HW capability.
+			speed. Valid arguments are "super-speed-plus",
+			"super-speed", "high-speed", "full-speed" and
+			"low-speed". In case this isn't passed via DT, USB
+			controllers should default to their maximum HW
+			capability.
  - dr_mode: tells Dual-Role USB controllers that we want to work on a
 			particular mode. Valid arguments are "host",
 			"peripheral" and "otg". In case this attribute isn't
-- 
2.17.1

