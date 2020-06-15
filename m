Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B0CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 00:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7600920714
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 00:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dsx35gnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgFOATS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgFOATR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 20:19:17 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE006C03E97C;
        Sun, 14 Jun 2020 17:19:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w16so14992771ejj.5;
        Sun, 14 Jun 2020 17:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MvzWh7ntbR4YRbqL0fe9yC8lYGPLWjK+zEaU00Ka2r8=;
        b=Dsx35gnZaujqVzCZYcBcsEMwZg6EZ+YwfF4LxfsNM7x7XjIirvjzuJeF4rXun60Wea
         nJCkJECJCW/wID032A4zW1QJDWJwoht6JTeOS566f1MYjOYgH1a9PhcUzgUhxZ12Ij72
         Qo2uRuNE6WmN9jvXoBw/1qTMbSwIQk2ycoyDJ6EGSTQu4N4mu3mpn9AfF/sQFqSLLlXi
         91ufNKlQm/WLOUB3pU1l8HCOOCCurnuNcxKqcm3kKh2FXNC+qajm0o3UlttL4PmFGGVe
         wVv8lG65IXTMAXIqicPB/2ww3ztT4ExYEQhBRTnpKfBiDi8sU/9j6hIY3VIGZpduunUc
         fPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MvzWh7ntbR4YRbqL0fe9yC8lYGPLWjK+zEaU00Ka2r8=;
        b=auGO3r+ObU8BytAcNBUMZmMLoVxLNIbzgPXxKSuxpczFv88qyR2oIKRS1EtJvLCqS3
         XvQC99S0BY/+u2H3vcdaHWE8ha9pgS/GQGNAVhdT4eJLb1JRgyyVQ1fufVOkDPJuD/aH
         veujmbJTPzxbFuw/5MYaB+8NxK3eAreLbPIKjn9CSODAz1E5dBgYepp6jXV0eAnh/HUi
         E8hGvv8cWYgSSasFwRdq1XqXvEnyy7EetcI9GUKMMreyB8+9n+bJr2zBVnpaxnLrOy4N
         rTiQuZ+2cO4yqAwvcIR+E+mIOcfxUVH75/XYaJAtPbfwD8jBM2JICNM7gNO39w9aWbD2
         0yzA==
X-Gm-Message-State: AOAM530iq7+NI4zjkTiTmeH0U4d5rEPK5geS21EW2bd5RCx8SEwKyHTi
        /eA8c1LjVRykdLyMdLOrurk=
X-Google-Smtp-Source: ABdhPJx5007V+Ypg/0tr5muHgQdWqqtP0DrVPuv+f2ljVFZFffy3YiMODLTWU4xmt3Zw4+ZrpzFUtw==
X-Received: by 2002:a17:906:11ca:: with SMTP id o10mr17214791eja.334.1592180354581;
        Sun, 14 Jun 2020 17:19:14 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id m30sm7450666eda.16.2020.06.14.17.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 17:19:14 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: Add vendor prefix for RoseapplePi.org
Date:   Mon, 15 Jun 2020 03:19:09 +0300
Message-Id: <b34021779d95a4185a15118e2f13be90f5c4286f.1592123160.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
References: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree vendor prefix for RoseapplePi.org Foundation.
Website: http://roseapplepi.org/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d3891386d671..e58dbe719fcd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -864,6 +864,8 @@ patternProperties:
     description: Ronbo Electronics
   "^roofull,.*":
     description: Shenzhen Roofull Technology Co, Ltd
+  "^roseapplepi,.*":
+    description: RoseapplePi.org
   "^samsung,.*":
     description: Samsung Semiconductor
   "^samtec,.*":
-- 
2.27.0

