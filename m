Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85EFC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C0F2072F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFT1U64E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgDFTny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:43:54 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:40041 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgDFTnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:43:51 -0400
Received: by mail-lf1-f43.google.com with SMTP id j17so462017lfe.7;
        Mon, 06 Apr 2020 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OQduJrIJ0M6lVkhdvPA5KPzWn/6ZJ/mPlQwccUPG7sc=;
        b=JFT1U64Eyc8U9s8C4QCe6XQmB8xH4c1d1dN7q9HGE698EN2SgeBznvzrQEmYq8T/As
         kcA+F+nf6HVbP5S9cTHTFPCw+4pb35zuUmNiOgrWDUEhZ03o/bH/BtGNzpZMpCR9NAII
         qkWKXAhyG6ER5jLNNnx9+UxSmPudsEg8sgAIP1npZu5V900SZxRHt927N8JVkC6pNARe
         6lcHs5rOgOwoZUQH6vuJn8UOfcurWS9gR3fjUeXyeONMnbpxQdMpOj1Ikm7R7SGKSqD2
         aEoLGE+fQzUOrDN/bHzhuiRmH911AqjMN/OQXbTBkb2/GkOIz6vGs/SsVKh0sAKLpPFJ
         Uamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQduJrIJ0M6lVkhdvPA5KPzWn/6ZJ/mPlQwccUPG7sc=;
        b=Gem0ulELBjcpqPZvJBBh208z2ce5yuVCp27KIwQGiaX+DuEshOMtabqebQJJ6MSnJF
         8sGUgMd83cpmnwfacGUyivhbZkEJJQKKEI+5Ogx6Jyzo2Pmb8WoGuFv+W7G+snYCXSNr
         UsH4d8tlgXNPUqIjnj7nHu+IYt+9FpKfUQFKFhoIKXxnGOwYRtJe1MiJkVPd6szM7SXu
         XtJJViVESM10hIFr06Ceq/R6dAzIVp2Yi1fs68swChWgp/N+FIiFW2KmaAoVMMNLH+pH
         44ZSMBhykn3WyiAqmn2c3tiyWIfjKyOJHvO96WjH34Xf7wxaCUXOJKPsLB+mXol9V7RY
         XIOQ==
X-Gm-Message-State: AGi0PuZDeC0YNdZQvam/KglBv7GP0U2hIrTWB02E3Q8TmRLSHuw+aldX
        ScipY2gR4tCaTm+Hgt+7xYk=
X-Google-Smtp-Source: APiQypIXrbHFPG1bvd8dHCzGMY94CISAElEzWhlYmumNaQ5PJx2IO17W8ysymbphyWZW5o4WCJK7hw==
X-Received: by 2002:ac2:50cf:: with SMTP id h15mr14412940lfm.127.1586202228234;
        Mon, 06 Apr 2020 12:43:48 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id r206sm4996233lff.65.2020.04.06.12.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 12:43:47 -0700 (PDT)
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
Subject: [PATCH v2 3/6] dt-bindings: Add vendor prefix for Acer Inc.
Date:   Mon,  6 Apr 2020 22:41:07 +0300
Message-Id: <20200406194110.21283-4-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406194110.21283-1-digetx@gmail.com>
References: <20200406194110.21283-1-digetx@gmail.com>
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
index bf95079a82da..90c178abfa9e 100644
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

