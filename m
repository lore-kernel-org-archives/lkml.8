Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A63C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBD420722
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH0e4gJl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgENViS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbgENViN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:38:13 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53CFC061A0F;
        Thu, 14 May 2020 14:38:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h26so53845lfg.6;
        Thu, 14 May 2020 14:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uB7DT7MRbFh7x8YP2bGUd3lqMMP5akxCugf8i9f9hFI=;
        b=AH0e4gJlr0H5+ahGQzKdu9Ky8fbRTs33SXugzK2MjqgtktaJddQiYM9qtgguskdSsj
         wJ6+59RjwQGzhCBxYT/6lkvzOPGlWUn1nS6fyAuULHCLqRljl6PLdsT9g2Ed7PUDbXmS
         +NCPjbC/lV7ws8mIeBlX9K8aowu9HxqCcZ8zUUbwl4rhAV6X9fp9Fht23YAAlix6TPww
         NxhSzkrEgBDHj6ZUzInvho8SKKtIXxZgAJThXPzCp6wqvvf3Bq4uBpfK0rxTrAhOSLNC
         fC87JHKuPGJlaa7QXSLbMO0ftDkhGeolNgFs8itwFuVxuTBC1wfx0Mw+r548KdzSf68u
         9GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uB7DT7MRbFh7x8YP2bGUd3lqMMP5akxCugf8i9f9hFI=;
        b=p5QubmbXfDASemYLJQHAWays2zb5gzH8mqNOYXZ4VxIvGYCs30T5kXWzAusmAEN+yn
         pBMQqWqihZD/yAtyAY67OecUauXqB7LTQsBOte6QXsTuxU2ohSLnaegZ2/Y6cQ1nyW2C
         jH3px9+hVY2saaCZ3PLKE2Ki3cEm6kAptGvaVhJb/4clV0So4pN6nuS3vvVr208ZLdPm
         2KncBAOWvIKeADxyRbQoLuhhBEDPUAF1rRDvzW/nMdUR3n4BIf5EyQF6U4WgydWD5pQ3
         PpYNHv4Vn/CSum6QoBhO239uc9HO1/rXfSd5uJqJGFnwtuQk0BZ4T5EnEwhwUSIuvXmD
         EF/Q==
X-Gm-Message-State: AOAM533cDCwtsmijRZVCv0FR4PSK6VKOcaHDWu800eEKyES9L1SzEd1z
        6bWkQlUgQnxpCKXvImiGzsM=
X-Google-Smtp-Source: ABdhPJznCOqc2atJJY1XIE6ijoLSVO7IBErUmwlbqSNfnBtoGg+01i4PYwF6IWrHufSEE21iee0tsg==
X-Received: by 2002:ac2:5b5e:: with SMTP id i30mr114411lfp.161.1589492290077;
        Thu, 14 May 2020 14:38:10 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id a12sm63628ljj.64.2020.05.14.14.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 14:38:09 -0700 (PDT)
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
Subject: [PATCH v8 3/6] dt-bindings: Add vendor prefix for Acer Inc.
Date:   Fri, 15 May 2020 00:36:51 +0300
Message-Id: <20200514213654.12834-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200514213654.12834-1-digetx@gmail.com>
References: <20200514213654.12834-1-digetx@gmail.com>
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
index a43ad3f9ff59..ce71327cce11 100644
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

