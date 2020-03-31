Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1DDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C6220838
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj0/EDIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgCaVp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:45:28 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:32817 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbgCaVpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:45:25 -0400
Received: by mail-lj1-f182.google.com with SMTP id f20so23657453ljm.0;
        Tue, 31 Mar 2020 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qtvvgY+oQwzC6C15g6s473c+gdmOvol2/yXCpXgmnQ=;
        b=Nj0/EDIRyrx8JkqEovY/FEMtWJE9Hc9FEuajpCkoFySM7sGSNwtAEsSwUN08Vb7lVz
         jQajjFJEYPx+Ql0aBfeSi3zxXHdKA92GIq4xC+N7gLFmDPmInjRe9E+qfwsLa6r0DBMK
         wxJenlQ/wZo++raTYn+cqG2jIorFBuQyfQI/TTiRtHCR0o9h2kxIRzG958w17tlF1umt
         O4bMcoZwNarRxTyCdF993Y0DkPmfZ/QX141d40XSWA3+MVrRqhi397H5pUQyTUeyheGt
         ouqXqNhOixIfVUFb8M6b0BrmxDQZFUk9bv43vJfW/OJRJULNWtPzMl0o2UOQAlouF+ZX
         Jo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qtvvgY+oQwzC6C15g6s473c+gdmOvol2/yXCpXgmnQ=;
        b=AWEUQUuxlM0JL6hiXPGS9LFFx6zdyJ1l7gBdUetofvw2aDHsC/ogCsLU7EVlMH8knt
         2cIQwmXvGkVGHRAcHM04H/W0ppMM9VtqxHA+I6mErQILEqiWp6sC5K8rGEaYSOcEJWlt
         5KHb+pzlgg3o583T9lqB/HfSShBvCwxVWkKPrQtBXwwpuRYDZwCRe4hAghXD99IXhBh+
         q1i0jk6UJ6buMizGd3jGfgfiOu1HXED5TR+xIiHTBIh5+uSEo1BH37p2AhYqFASZsKvj
         zrqXJTJXeHHYrCRGLftTBzEH6okcgTUWdewW2fi9tHuowd0ynfGkZ8e/begkaNLWVf9P
         mu6g==
X-Gm-Message-State: AGi0Puawuy4QP32AGV5Xd+y2NCXbKL2vbA58HQ2VZDQhYpp39BEoC7LC
        SfEuyHUIqfXm6KPiy25/P+o=
X-Google-Smtp-Source: APiQypIDhnA8je37wjidai8ApC2JmlSUU7udaOUaZxlmJgc024zMS1RvsBpUGLoqtxyLQwL7Kpk9KQ==
X-Received: by 2002:a2e:9655:: with SMTP id z21mr11886862ljh.122.1585691122805;
        Tue, 31 Mar 2020 14:45:22 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id a4sm3757826ljb.27.2020.03.31.14.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:45:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Pedro=20=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] dt-bindings: Add vendor prefix for Acer Inc.
Date:   Wed,  1 Apr 2020 00:43:24 +0300
Message-Id: <20200331214327.6496-4-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200331214327.6496-1-digetx@gmail.com>
References: <20200331214327.6496-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acer is a hardware and electronics corporation, specializing in advanced
electronics technology. Acer's products include desktop PCs, laptop PCs,
tablets, servers, displays, storage devices, virtual reality devices,
smartphones and peripherals. Their web site is http://www.acer.com/.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index cd97efc34667..d15fcc922f67 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -27,6 +27,8 @@ patternProperties:
     description: Abilis Systems
   "^abracon,.*":
     description: Abracon Corporation
+  "^acer,.*":
+    description: Acer Inc.
   "^acme,.*":
     description: Acme Systems srl
   "^actions,.*":
-- 
2.25.1

