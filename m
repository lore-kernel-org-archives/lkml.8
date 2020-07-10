Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9097C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982BB20775
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="bEPkhEJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgGJJqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgGJJqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:46:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3468BC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gc15so4366601pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+lxJpUZmbIP8WtaPYkeWggcG2CfEZeJKxP7Ov+QkUq8=;
        b=bEPkhEJhMyo+7fM5al3P6QkH+uUZYUDpaYJWnTA/Z1w0qxxHdyG8In1x3dIke6d7bu
         GUBQxhZagBqRmWtbTXaX8MwSphswCos/RoVpMtoMfybb26uZ/AXDf90DdWmgYBZ9vupg
         aU8Nu9T9o6ZNKcMZu/0FJFxLdN4wf010gw+bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+lxJpUZmbIP8WtaPYkeWggcG2CfEZeJKxP7Ov+QkUq8=;
        b=CFsszLJMqERkc01sYWekqCFM37nnfsChZl5HiIO6Xk4MpE68zB4lkGWWtzzeB0uWtb
         3Y19GqPpHOIeiYW9uWgkhdMPWOUSS5l/pnMWr3LedM/qR7YqK7CgyGOlh57Fu92OX8yj
         VugNuWbQdT7EvKVIC/X8FRHfCUN5MivUWsn+0LGTIRFC98EovcfUBKXJgR8ZawO6lLPk
         X0a0no0TIJbzMYh+/fktlvFamvUO1bZYnJ3oxaGp0rJE/P8gfEV1VMCUlK9yIqFZnlVM
         wfdPVPrLb/5wFHY49kF9JJIkFGZvCsgJlTYxZqUYuI+tGFUuYtPsU7N/rlOxfkeNjyla
         Xi1Q==
X-Gm-Message-State: AOAM533I3/cbtE/pKhI4P+LJ2pVzZgnWn0aH1VEU62pvzYyFU/xgWtod
        azIlQSXXTTrHmb/8uvmnrTDaifn/+VipuA==
X-Google-Smtp-Source: ABdhPJwPiyAsSpz6/dGW2By7TLuAjGOMXxDU5eb6gp85lvMSrEQHzLkKD3fL8nDC2+fxWwEKTDd0zA==
X-Received: by 2002:a17:90a:b10e:: with SMTP id z14mr1373899pjq.146.1594374373705;
        Fri, 10 Jul 2020 02:46:13 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id z9sm5133213pgh.94.2020.07.10.02.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:46:13 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        afaerber@suse.de, maz@kernel.org, w@1wt.eu,
        Daniel Palmer <daniel@0x0f.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 04/12] dt-bindings: vendor-prefixes: Add thingy.jp prefix
Date:   Fri, 10 Jul 2020 18:45:36 +0900
Message-Id: <20200710094544.430258-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710094544.430258-1-daniel@0x0f.com>
References: <20200710094544.430258-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for thingy.jp

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 53cd050668e6..c209b3dc7ecc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1038,6 +1038,8 @@ patternProperties:
     description: Three Five Corp
   "^thine,.*":
     description: THine Electronics, Inc.
+  "^thingyjp,.*":
+    description: thingy.jp
   "^ti,.*":
     description: Texas Instruments
   "^tianma,.*":
-- 
2.27.0

