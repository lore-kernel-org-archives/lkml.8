Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51634C55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA8A20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4dOiAhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgDTV5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgDTV5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:57:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF7AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:57:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so1973447pfx.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NrTIGfIIMpJ/CNe125wA13W3OdRcgnbEi+8exEuNX+0=;
        b=c4dOiAhj7WKuRROmTvZUIggJYFStbr93zDKyoIo4mrZUZ7Dg0w0KzGPAqwZq6aHbE/
         pEWv+AQ/0f4aTdwmFkHYFgA2pmNLICB3fJ5bvS5og3alGEZIR7gcLUHnn3OLMrfTEYO3
         tRdz/XGvdb0TlZGlfEnXBDtrCa8wIIIcHaigWXxDve6A+8jL9FZ+SyRGgj1j9rm3/drh
         6JPd928o1fbfm2N3hcOsNJKsCdlTMgzv5X6YKwnoi29NHuD+BJhL0Q+Tff58Hd1q2OHe
         5pHVWhp2Y2bk2BLYUnjPIvhaEVoW5L+NcKVPegmXsfphEBHb7lIfVPrtAYR29t0Et9rb
         wyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NrTIGfIIMpJ/CNe125wA13W3OdRcgnbEi+8exEuNX+0=;
        b=iH8K1D7UP4Wp+zZ1HqHxGElJnZBBhnWfWaoGmIwkP3HpdLKrz20JcNgktQPJMTD1Pv
         TTKRVPmjjoXssA6VdcKWPgAoqjddqJaeDQZXomNfFQeu5YQlMB9IjWL7yKzV0o82XYRX
         iafEZrSJxK8ekWr25vuQOHGjTeE0svpgGmy8bO+f9LXn9Cw5tBBJlGHMou5Cc9CxkTod
         eAzEdSECCOkPsVbvcfv2i3muslYYWOiVzYu6S2Ke2O6FIPxKqhFiazD5u2kwP5XAXlQ+
         O9jMJZB13vNUnNr87nTkMMdFQ56wDhD2T+rWrDw4QKxjS8gYBK4M6L01wKuAiqo9H08H
         cxEA==
X-Gm-Message-State: AGi0PuYz+L+ZEkgq7pGO+atvQtEiwHLMTx+SKWnDbBCje09cvnRpRe+X
        zg4lnsmiuZWqqrBZTBkISh9w8g==
X-Google-Smtp-Source: APiQypJkcauE8WYj/wEOtxvtf/dp5pe0DcnKKp0GqhsvfSTlhq2o/cL8mXcrJ3FrznI2EiXkU2dXVQ==
X-Received: by 2002:a62:4d43:: with SMTP id a64mr20050370pfb.156.1587419838263;
        Mon, 20 Apr 2020 14:57:18 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 62sm455565pfu.181.2020.04.20.14.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:57:17 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display: simple: Add BOE NV133FHM-N61
Date:   Mon, 20 Apr 2020 14:57:41 -0700
Message-Id: <20200420215742.1927498-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the BOE NV133FHM-N61 13.3" FHD (1920x1080) TFT LCD Panel to the
compatible list of panel-simple.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 393ffc6acbba..daf86ba18f47 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -69,6 +69,8 @@ properties:
       - boe,hv070wsa-100
         # BOE OPTOELECTRONICS TECHNOLOGY 10.1" WXGA TFT LCD panel
       - boe,nv101wxmn51
+        # BOE NV133FHM-N61 13.3" FHD (1920x1080) TFT LCD Panel
+      - boe,nv133fhm-n61
         # BOE NV140FHM-N49 14.0" FHD a-Si FT panel
       - boe,nv140fhmn49
         # Boe Corporation 8.0" WUXGA TFT LCD panel
-- 
2.26.0

