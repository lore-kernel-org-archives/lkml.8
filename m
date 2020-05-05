Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407CCC3A5A9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D5A206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpXZlOjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgEEC0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 22:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727795AbgEEC0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 22:26:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC2DC061A41;
        Mon,  4 May 2020 19:26:45 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l19so88319lje.10;
        Mon, 04 May 2020 19:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTx/eaYAn2EOObOw5K1yoeTPkB5owPl9cMTn96Ty+/g=;
        b=dpXZlOjZ6q/4TjlGRmtEhZRkAqKY0VscXNa98R5sEq8OP45lw7WegB39Ug435z+6YN
         H3a5c+HBy6BB/qx/XZuWekytiaYYkpu9ULiv6IYSpquEkotEZa7fZ8rqWhCz1DGSLQV8
         baK8w6Cp0p+05cQtWuzu+jKiq1RcEjSgbMimjNGH8Oorg8m36tWhFieuxfMyDgEKC7+n
         GjqQzGjIuhK7RIYc5585to+VvQBUH66fivcyt++OvHzpu2fY7fflNv0iDfH0p0tqq5CC
         6DYVOI6ydwLFjse1m66PemV1YHjX3Z5TgYvgEZx/rOklk33v+K1yc2kpid24SREAXDb1
         1qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTx/eaYAn2EOObOw5K1yoeTPkB5owPl9cMTn96Ty+/g=;
        b=rbHY8faxFOFpXXUDpXcOmwKpy6bPi6kKm3sGrrNPw73ERCU8UXqYLgmuaq8sUeUSWR
         IvTVoM4aBeUXY3CAMZ/3RQt4BMNHVhWIgpY5u6C+R8mU8MHDRq91HHVwlh1OcV8KYYZq
         d3DAePoCJVQl6var+6awGczZGjVr8JkxM4L9RYxBQMUiVnfkgxVtf4e0et1EAbGqUgTR
         95XsQ1NXimz4+3AKnPvGrfrdMLzqOk4xzq1VtjUa4ABawiqvQikcu2cyopYWzj9kvhO0
         fqj3l1i6eLtmydOogmhn9MoJxjPU/bs6XqEAJWfgqyfilU0wK5XcZyOpuyq2LjdnqRdD
         DYiA==
X-Gm-Message-State: AGi0PuYqjlPeQxOC7GEnwkGeryXIqQd+HWeTIOCDJO9+IqSUDSIoETBS
        Wsu9OLOWpVn4YEnCOOhSshpP0woj
X-Google-Smtp-Source: APiQypJJ4ZNEnDRndAXYc96QlUTiVfLkPAMjyHiAhUd3ayO7Wzrzz3HCh7koiiV5wPkiSt0FsvfAAQ==
X-Received: by 2002:a2e:a417:: with SMTP id p23mr399014ljn.19.1588645604101;
        Mon, 04 May 2020 19:26:44 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id l25sm449251lfh.71.2020.05.04.19.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 19:26:43 -0700 (PDT)
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
Subject: [PATCH v7 4/6] dt-bindings: ARM: tegra: Add Acer Iconia Tab A500
Date:   Tue,  5 May 2020 05:25:15 +0300
Message-Id: <20200505022517.30523-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200505022517.30523-1-digetx@gmail.com>
References: <20200505022517.30523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Tegra20-based Acer Iconia Tab A500 tablet device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index 60b38eb5c61a..7fd0b66c69b2 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -34,6 +34,9 @@ properties:
               - toradex,colibri_t20-iris
           - const: toradex,colibri_t20
           - const: nvidia,tegra20
+      - items:
+          - const: acer,picasso
+          - const: nvidia,tegra20
       - items:
           - enum:
               - nvidia,beaver
-- 
2.26.0

