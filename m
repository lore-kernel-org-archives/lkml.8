Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A79C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EFC20771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OjYZqbxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbgGVUNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgGVUNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:13:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE715C0619E1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:13:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d202so3686607ybh.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5HE+DPgFuSdGFfoLJSZ+xENvKObvtqAcA3kZq7fNcSk=;
        b=OjYZqbxqqBd15E3vL7dAmvvtsmLPBki0p1CT9K7bDASpyejzkVBiK7HRq8oD2v4oGQ
         G+aw3I9urc2O1sD6ivegwsExUWwp3O7fInDA25NSr1fOIsWjpHbeUEgwS7dBD/7pT9S6
         hHjDfK/0rAAoKohFco5oD3OhX9I0g9VfSZNIE1A6JxA/1WPmMOAWIVIMgzMxT6gZGWqQ
         iMb8Lotqp9ryIJRBLCFX/uB9jIFVRC/x4wfbB3CbkqeX5THzRjftMQYMQi6i/PhcFbVp
         plrXG8gdJNweyFRyOkDcLfA8mR8qa9lZWRlef0JlUvt7BF3TB5uxM3tYXcpDkpNQIw9a
         B0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5HE+DPgFuSdGFfoLJSZ+xENvKObvtqAcA3kZq7fNcSk=;
        b=cRfA2q10Y+rM27Btd8DLbruJ/2KUR88QoeTfxIYA/VZvkY6BvK2uLXeuZ7bJRJjRRm
         ucu+q0dbMRX4vRV63Ue/KNWiTPJ/3gu61p2qkSra9MAgqA9wvubGi7LB4R37VHsAi6jA
         VgCZ0PjQquam0w+mBqyC+nUkTtsAQWezXt4z+75OD5kui2AW+dfpRuReOEIIHh0P3ljj
         KpGWrjiwIY6CUHJlfIqXdo9jf2vXBkeAmIskEjtI00zObGur6sDkspjeikLAs0Cc8MKs
         VGxTTKoTXnclKNhIaoUif/FimjsrifH+1CmjRfVMgtV9gMzp/tUrHgJTU/C/E20Pt1g6
         jTlQ==
X-Gm-Message-State: AOAM532CuDPNugfpEpfmsV1QTTDH79u6nYCXzhBgaSe/BBkqU9vkSv1v
        oAvzaYZOMJyqfrybNm/vi7vRRz6nFKWXq4M=
X-Google-Smtp-Source: ABdhPJx1QX858Y2g9BmuFqZYhdR0ptjGdRV66PAj4MEYmMocIfDkUmI7olyg6e/zj9LXWnAd992SOl8kDkT6qYI=
X-Received: by 2002:a25:4dc4:: with SMTP id a187mr1571100ybb.429.1595448797087;
 Wed, 22 Jul 2020 13:13:17 -0700 (PDT)
Date:   Wed, 22 Jul 2020 13:13:12 -0700
Message-Id: <20200722201313.754671-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v1 1/2] of: property: Add device link support for multiple DT bindings
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
2.28.0.rc0.105.gf9edc3c819-goog

