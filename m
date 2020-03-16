Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF02C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC2E20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="REDQumeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbgCPNgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:36:02 -0400
Received: from hermes.aosc.io ([199.195.250.187]:59114 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731330AbgCPNgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:36:01 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 565904C196;
        Mon, 16 Mar 2020 13:35:45 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Ondrej Jirman <megous@megous.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 1/5] dt-bindings: vendor-prefixes: Add Xingbangda
Date:   Mon, 16 Mar 2020 21:34:59 +0800
Message-Id: <20200316133503.144650-2-icenowy@aosc.io>
In-Reply-To: <20200316133503.144650-1-icenowy@aosc.io>
References: <20200316133503.144650-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1584365761;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
        bh=0HfFUPjqEgQwk282TtGVjN57mA1btMaLRbIZ6w6p3rA=;
        b=REDQumeYtu2hFfNE/0noLkFBnWLBO0K+j+7Cl1oibcFre31634hVU28mtpy55VHq7hemb5
        9Y/h3REpWyNd//ndafhD4+trF+cFKYr8mxOkJEW8BtetEuX3kI1XpnvOLWBbguNyciZFV+
        +hPgrwK9gX+BZf947U0jZ34pe2LBgAc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen Xingbangda Display Technology Co., Ltd is a company which
produces LCD modules. It supplies the LCD panels of the PinePhone series
(the developers' kit and the final phone).

Add the vendor prefix of it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
No changes in v2.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 23ca95bee298..0d9e966eff19 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1106,6 +1106,8 @@ patternProperties:
     description: Xiaomi Technology Co., Ltd.
   "^xillybus,.*":
     description: Xillybus Ltd.
+  "^xingbangda,.*":
+    description: Shenzhen Xingbangda Display Technology Co., Ltd
   "^xinpeng,.*":
     description: Shenzhen Xinpeng Technology Co., Ltd
   "^xlnx,.*":
-- 
2.24.1

