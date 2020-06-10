Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E223FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF30F2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591818389;
	bh=V8MuN/Ny5mYSCxK6kfQBnHwCVaOFlIo95wDoCgwHkk4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=C2h5Y0aSJw0b+HfSmRnP2yuFHOdXI2eXjSi9IwPgMk+jvFKhOKWvUaUtD/7z2IwUu
	 X5+fcv9JWK2QmWi5cUpWpz3V/swwZq3yYPtiZ9o5H3RStT1TCkP42yE4C4CJFXCh07
	 +SydNXypHo8ueHC8v/1o8hVy6VAfeTgtxIvhNB0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgFJTq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:46:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37068 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbgFJTq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 15:46:28 -0400
Received: by mail-io1-f66.google.com with SMTP id r2so3690532ioo.4;
        Wed, 10 Jun 2020 12:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9mGfZeBBTKc+FrE4dVawruNqiY96bl764hS1tXehIIE=;
        b=BecvtJMdybauIYqlvP3mmq1I+zjaWUVy2T1dWLXCqVPui0f9ZrXHIw5OgZMR9jD2nz
         6Kkenw1bpplToRE8BnldssPAk16BOX0ycFGCjDzmK1lkxgfYvlC9FFMakTmXRNoR2FMh
         K+vbuoOeYDFTB5s/UpPSC+HNmv1Yx1WWKxoQ6jFmKmkGGEF3eXJZI+xIpHlBd0MoNWlr
         FNDABuN/T559h36U1z7LpsGZfM3UktZaQsWPI3cBeQy7kiJjnq7+YmXm+i8UnvxBXaXT
         F0OB7wM/ODV6QrD5ci8+ov4frah/6vVmaMjekwZhFFLK1fQsFCq/R0c80J6HgyeCpukj
         IZ9Q==
X-Gm-Message-State: AOAM531/4+66IXuJAmV50bbZXPfsk4uBwtBv+uSykua8O/lLf89jxhmV
        fqRoVulh2xEJwsgihS/wC6KclbQ=
X-Google-Smtp-Source: ABdhPJyTfZ7stvJ1zJp4PDYd4mXFlNbonBQ7OxS6Ub6k8MoKgsezkrMt64D7x1mMgr57NVmsKtVrYA==
X-Received: by 2002:a02:2c6:: with SMTP id 189mr4797468jau.115.1591818386360;
        Wed, 10 Jun 2020 12:46:26 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id a6sm385535ilh.60.2020.06.10.12.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 12:46:25 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH] dt-bindings: mfd: Ensure 'syscon' has a more specific compatible
Date:   Wed, 10 Jun 2020 13:46:25 -0600
Message-Id: <20200610194625.3597460-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using 'syscon' alone should be avoided as compatible strings should be
specific enough to identify the exact set of registers contained. Update
the schema to ensure at least 2 compatible strings are present.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Rob Herring <robh@kernel.org>
---
FYI, there's 43 cases of this on arm32 in my testing.

 Documentation/devicetree/bindings/mfd/syscon.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 19bdaf781853..af7a68051392 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -43,7 +43,8 @@ properties:
 
       - contains:
           const: syscon
-        additionalItems: true
+        minItems: 2
+        maxItems: 4  # Should be enough
 
   reg:
     maxItems: 1
-- 
2.25.1

