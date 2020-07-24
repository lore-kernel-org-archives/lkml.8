Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CE0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513B1206E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSE9Xo3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgGXXoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGXXoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:44:19 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FE1C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 16:44:19 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id t82so6145291qka.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 16:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cx5rtLU8xqliH8LTX82DtFOmXnkZhOGKEwyJ8VR9z80=;
        b=GSE9Xo3HSLQ8K4OR7/wOyR7U9WgENeEP5zZGO+4owVsDbz5Dejlv7E7ipVfkrvZ1kv
         G/RSI0eudaXFehUGRLeFUTKwjShcjT97LMBV69BTuVkoqCNnC4E1gBTVxoKOiLSQwMjf
         nLo9dMWKgMLKfu0pOdtDOaBr5VHrZDqeN3HBFkaOY4itEKqRmdF+Q8PpxuHvopv3wq67
         u5pYYoeZEokZrL9OKqFEi20ORBb7aLnDywbMRnQAsyjSPSvbxMsD0oiyuzeolkWbQYbu
         9Z5tIXW0wqmxgzPrUVVC6DI1ugXK5mtfJKmDaJU4tAci2ctoaKgtZSKT12boNHUtbCM3
         FySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cx5rtLU8xqliH8LTX82DtFOmXnkZhOGKEwyJ8VR9z80=;
        b=Xl6FnusDkAnDI+E6R4wAdx16/Iqltf+8jnuDprS2TG4LTh6ARsZ/g5hOJ4wxA3CAdP
         X8QchSfN58tYe6cXHtDMf9waNOUH6d9xJ0MCXpAvkFNFwBWbnBzRj970NsFa+YEsKeZ3
         2mCYi3Crmv7IgrPHTT3xHDnSS/L879AFdIVYyPMm5ZlWGqLxrzuiiSjRxyNvpugsnhqu
         oSQLXYxT2NXlqE/J2xa2jZVv0Q8IkarBasI8/vMWSkKwWmqzWvsPAIoPg48xNEBvuRFK
         G1fqRLRCYUsgicjtqchpQPULssVzpGXThqZkJZ7Qhr4I42ukHnp7WY6904uxWmQYKxaY
         iIFA==
X-Gm-Message-State: AOAM532uVOo0kda9Sf+j0EMq4429TidcKtCtDqXzJR5uGoKkyP/5leOQ
        wA0UAeiOUugSYDPomCRUQxF2S3Hesnmp6HE=
X-Google-Smtp-Source: ABdhPJxol4qZmmuGdPWMn98HVFoQcIjnalYXFwE84XH5FOS0tGNY5axHz/B6a5xOisRHey4JcQ0xpUEB9HC2Ztk=
X-Received: by 2002:a0c:eb46:: with SMTP id c6mr2030423qvq.137.1595634258604;
 Fri, 24 Jul 2020 16:44:18 -0700 (PDT)
Date:   Fri, 24 Jul 2020 16:44:14 -0700
Message-Id: <20200724234415.1651639-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v2 1/2] of: property: Add device link support for multiple DT bindings
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for creating device links out of the following DT bindings:
- interrupts-extended
- nvmem-cells
- phys
- wakeup-parent

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
v1->v2: No changes. Just sending again because v2 has changes in Patch 2/2.

 drivers/of/property.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 6a5760f0d6cd..b06edeb1f88b 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1269,6 +1269,11 @@ DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
 DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
 DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
+DEFINE_SIMPLE_PROP(interrupts_extended, "interrupts-extended",
+					"#interrupt-cells")
+DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", NULL)
+DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
+DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 DEFINE_SUFFIX_PROP(gpios, "-gpios", "#gpio-cells")
@@ -1294,6 +1299,10 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_power_domains, },
 	{ .parse_prop = parse_hwlocks, },
 	{ .parse_prop = parse_extcon, },
+	{ .parse_prop = parse_interrupts_extended, },
+	{ .parse_prop = parse_nvmem_cells, },
+	{ .parse_prop = parse_phys, },
+	{ .parse_prop = parse_wakeup_parent, },
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
-- 
2.28.0.rc0.142.g3c755180ce-goog

