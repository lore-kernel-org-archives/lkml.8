Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B9AC8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBDF214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="DZis8xfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgD3Jbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726502AbgD3Jbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:31:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE157C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 02:31:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x17so5994123wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 02:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JROjM52upfSN5TMvhJNz/+Rqg0p9AY4cohL9qzJLlpA=;
        b=DZis8xfVlXBziBr+P9Tnhicd37q8C/hUftvt3qILB4slhpcZ6QXL5hmG8NSRr9irEN
         5EM8NUtPUX9hh08v9tOvRMmkjfY1BMNb4LBRpIS5c+SALdY6RNfN4+++QJrhJ/pJrlZu
         Uc2QOrYPvFb3YxXdNuHUcgN+rRh7ERmeVZuTBEMFRF79M19Dr/0ThJcRCDcAC+/2puRN
         g/jylJdTSAw6YOFjoWf8x7A5i5NBRz3JHdF6N8J5O3+ROWrFhttYFEYiYOW0VouCTs6a
         NKPZKxIYqRicAuhlUxd3X9DbQjW8+ptWE0Sa0w5X7QINCgPpIK/dqKoKNbCp9VPtMIfH
         i4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JROjM52upfSN5TMvhJNz/+Rqg0p9AY4cohL9qzJLlpA=;
        b=NZeHW+pRVmqd85MUr7XMQly7d3ygmdRkdK1WYLBAaQhrkB/r86QoH6gkog0ilE9TbM
         GfM8oLAg/bJDr4Ol4+x3RouTpsVJ/7bxfavBvMzSmjjZ2xlgDeNSow9dtFadra81LRVl
         c6/TUAxeJ2EzKeOK7qNlhKFx6S3TyMrSgCxySTcB9bFsq/dlyArMQKAG+sDCOxTaylQE
         m6X+z7vJBNeW3WgDiY0hHdnfl1bZUsG+6JXW8+6Aid8wbJkEByR3IEzoJGDv21QLcOiv
         dYG5D/1Dd4tTdlsIoVRQ4AOpMUEbXLeXMcZHohOn6UYM3F4SRrWJNlHYEwZZmkv7qBLf
         QJlQ==
X-Gm-Message-State: AGi0PuY8QYyzld1+rR4kgc3B3AEGLRO28tUMoCV/+tEWrBZKJNYJjMcv
        6CeI09UKETYga3wrSNAj3nb0KPCVxMNxcjgg
X-Google-Smtp-Source: APiQypKAO0dYrrr6uRoO9RhjGOngejy1JjV9L20veTAAgAQ5EvddBGSNIX28H761oemDkK86JSyD6g==
X-Received: by 2002:a5d:6584:: with SMTP id q4mr3005745wru.403.1588239090050;
        Thu, 30 Apr 2020 02:31:30 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d133sm12851921wmc.27.2020.04.30.02.31.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Apr 2020 02:31:29 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, u-boot@lists.denx.de,
        Tom Rini <trini@konsulko.com>
Cc:     Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: vendor-prefixes: Add U-Boot bootloader prefix
Date:   Thu, 30 Apr 2020 11:31:27 +0200
Message-Id: <85b8dc9e6288270bbfdf55f1c156dba160293f01.1588239081.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

List U-Boot project in vendor prefixes.

For more information take a look at:
https://en.wikipedia.org/wiki/Das_U-Boot
Source code is available here:
https://gitlab.denx.de/u-boot/u-boot

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

The patch was created based on discussion with Rob
https://lore.kernel.org/linux-devicetree/CAL_Jsq+ehJSK7sjqmKtWOVjr-QZ3LDB+ywCO85uF8WJ+cB=AAw@mail.gmail.com/
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d3891386d671..2becc5ced47c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1045,6 +1045,8 @@ patternProperties:
     description: Tyan Computer Corporation
   "^u-blox,.*":
     description: u-blox
+  "^u-boot,.*":
+    description: U-Boot bootloader
   "^ucrobotics,.*":
     description: uCRobotics
   "^ubnt,.*":
-- 
2.26.2

