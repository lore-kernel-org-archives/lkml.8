Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE5C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 15:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 507472067B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 15:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRuubA5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgFGPn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgFGPns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 11:43:48 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D0EC08C5C5;
        Sun,  7 Jun 2020 08:43:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e125so8699049lfd.1;
        Sun, 07 Jun 2020 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3jYAyhoWO96DwU8aVF+4Uno1zYQiOFU7cQs+3bijby4=;
        b=WRuubA5OCz7cP40Q92Sl7PMlWuIGp4eyRx6poV8TLQLahrfyx9GmnZY8ikp8gP7hi7
         mYCjIP9/NX920LkRPy1xYWyPq+2UKB0RiKUTnzgAYwv/DIAKx3I6GrYk1iQfjc/dFKm9
         xDeYsrs88bP5pqWxtl2JBVXNSUasr4ICh4mXbyM076qkmf86ssDGLQh8t5C5ysz1e1uo
         QovKNTqjLa4tMPyR+0dYwrns/aCJLbtquL/flZFFPXi6qZkeESu7tLkwKUDVtwh68f1n
         rJGwTuc7ZIBoffI7BnAGe7ecnM5niDJTvh5sm5s7LJT2ZtyBELNyHdtbo6C/AP7Dw2mk
         7zCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3jYAyhoWO96DwU8aVF+4Uno1zYQiOFU7cQs+3bijby4=;
        b=mTNX9kAfIlCsm7ByuFUcN0JS3J8N7vQJSBlbW/dyZWWsooIwfUFtE18m0pF7j2d/77
         KITDKmX2aEHsVBBFOiHXByy14Q39hFP5r7Xe/KOGbpwGQNFzjeLnx3UWKKJ25IYj2HTG
         44USEb9+sAN9thxy+wQvFQQmRGT3pJKaxDpM5pn9iGt226BAfWy8tCNjGy8vIal+WjoZ
         91YSRRsngeu2A0TdVahgyhJ6Km/ICz8aYKRv3y5yxBQ9wL+/q36gmdnnttgodf4WzE/x
         pL7G1Cr0c8H2e07KZIBSCLyWw4KujItLojo6/2c1W1S/LGoQUR4MWpXu2WIbdTYnu/dl
         k7gQ==
X-Gm-Message-State: AOAM531Z8HtfCULi4Pp4+Oq/8MNgGNg9YKs4zlMcDqxMZ5rZ4WDZ6kAe
        TBeYdDBSob6Q4gvQEOnNTBg=
X-Google-Smtp-Source: ABdhPJzkYOlWzj6DJV6KxozPpoQ/jHZ3f2NbJrMHITe+wHnWPoZvYhzRbiNrpYHa+UKevQWts4yjUQ==
X-Received: by 2002:ac2:44bb:: with SMTP id c27mr10673902lfm.59.1591544626559;
        Sun, 07 Jun 2020 08:43:46 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id a7sm3592234lfm.4.2020.06.07.08.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 08:43:46 -0700 (PDT)
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
        Matt Merhar <mattmerhar@protonmail.com>,
        Zack Pearsall <zpearsall@yahoo.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/6] dt-bindings: Add vendor prefix for Acer Inc.
Date:   Sun,  7 Jun 2020 18:43:24 +0300
Message-Id: <20200607154327.18589-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607154327.18589-1-digetx@gmail.com>
References: <20200607154327.18589-1-digetx@gmail.com>
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

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9aeab66be85f..9f7af78d6864 100644
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
2.26.0

