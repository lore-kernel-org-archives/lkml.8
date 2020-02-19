Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DD4C169F9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F9A24671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajPOejSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgBSSKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:10:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36124 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgBSSKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:10:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so1374256ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 10:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4SdNyJxLKQOIopt47a2aKS0SgVzGo+LdVLFJnDNkr60=;
        b=ajPOejSF29nBVw6tbuq0GHQZOGRuvjPON14D3VaeaF1LH6vjeWwa6p0cWZgH6zesTO
         J1Ui38ijhxOoRdm3TfKDF4R7H0HmmLturnRvJa/QM09PzVlT2w1VMf00jpAGKNaPVMda
         I85l8KSzkxhJVo2F6blZ9iRu5HDzG9TpVxzSlDWUcSJJsNw115wPlajnlTjfu3T8/MB/
         um2nDZOxV7QVt9wg+SvolsJC9JibUC3jLBBcslW5qtJwHX3jUQMqxRwef/cxypmFvGGA
         pgEGAO5K85Kz4wINQicpr22O37S0uYBbibEPUUZ84Ss2H83dCNenjyM3p/98A/6tqqie
         LybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4SdNyJxLKQOIopt47a2aKS0SgVzGo+LdVLFJnDNkr60=;
        b=T9hi4l3E3ujXSre8CEw7ciQviqhbAMAgu5nmzyjEYsk+ooNj6Z9HITEZx4jtmgjprQ
         iyAWbZAb7LyodpkAlpR3BaBjnHvHx+AYqq7JQY4xiSd7B7CzQuQ0e+hSfj3SKR2r801N
         gdRPoLDdD00qPXW/xt7FVCxpOs+cvhEjUr7eZF019xlCEOI3LwElKgCrzeezZwFbQI0O
         Ezf2oiSpwAieGVUU4y4ewrk4VpXKpkNPwPWKLt5RVL8ITPFQ2aPnSjEcvn622c6t9sZ+
         XgcQlvDUonavrVjSlnO4u0wGo843lJeYmrrisI8JZ3jPHCqPH2tYJyEzRyMqTDuXcpf0
         Jm7A==
X-Gm-Message-State: APjAAAXNAgHIUbq/Bq+s7HFmAsFM4MJ0eWnIjNvFAMx31+9MTKL3yxqA
        XiKoxmurXkHE1Qlx0uFoOZw=
X-Google-Smtp-Source: APXvYqz6P5Gs4MdtlOwx7++w+qdzCPpaUxoDvbr0krs2YjnjQqicU5hmCYwRTr1W7tVRPTxgCIWT0Q==
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr16930038lji.214.1582135802940;
        Wed, 19 Feb 2020 10:10:02 -0800 (PST)
Received: from localhost.localdomain ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id 14sm183942lfz.47.2020.02.19.10.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 10:10:02 -0800 (PST)
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     mripard@kernel.org, wens@csie.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: [PATCH 4/5] dt-bindings: display: sun4i: New compatibles for A20 tcons
Date:   Wed, 19 Feb 2020 20:08:57 +0200
Message-Id: <20200219180858.4806-5-andrey.lebedev@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200219180858.4806-1-andrey.lebedev@gmail.com>
References: <20200210195633.GA21832@kedthinkpad>
 <20200219180858.4806-1-andrey.lebedev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Lebedev <andrey@lebedev.lt>

Document new compatibles used to differentiate between timing
controllers on A20 (sun7i)

Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
---
 .../bindings/display/allwinner,sun4i-a10-tcon.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
index 86ad617d2327..c0f6bb16fa34 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
@@ -46,6 +46,12 @@ properties:
           - allwinner,sun50i-h6-tcon-tv
         - const: allwinner,sun8i-a83t-tcon-tv
 
+      - items:
+        - enum:
+          - allwinner,sun7i-a20-tcon0
+          - allwinner,sun7i-a20-tcon1
+        - const: allwinner,sun7i-a20-tcon
+
   reg:
     maxItems: 1
 
-- 
2.20.1

