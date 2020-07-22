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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13B5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA74420825
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jzml84ER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbgGVUNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732844AbgGVUNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:13:20 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BFAC0619E1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:13:20 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id e6so2191073qva.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bHKxXLzRxjp9sEodI13FMKA+gAY4CEHn5pKoXQX0rac=;
        b=Jzml84ERxyON/0dqHs6IN8pWEjMh/QmFsgLXzpjdyKxK3ZfpSq+8radDDcLKWiX6mp
         xEMUN4dHkCM4alWtyKevkNUQrUO5TG2bOiKu/HtVR0drayo34qNM8OL1cH1bsVpCCU92
         gXEGQAHjUzoQsd+NQNpGFjGBvVJTzjgv/sGOtIsMmC2X4Oz+gs0tE1sAQS6ZoKeaL6T+
         uPqdt0PwvAdIdJuCdiyGd6LvscIk/c0isaS49EHK1EDTXlZDHDkYe7bndI+hJZxlS0hW
         Y+fPG7uRQFrMmM6UNgrMlRfag6Hfmcl2HPlYADPfrrFiFZdPA8oPMolwuHvkgSHV534i
         EW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bHKxXLzRxjp9sEodI13FMKA+gAY4CEHn5pKoXQX0rac=;
        b=E/efQPU/YsdeSnadRZeogF06ff+++f/2tV+hhn+hxyT3t2L6L6n62FL+8nsAYcuHQb
         MKhzdUrB94niZ8RA0hzgFYfx6BWAOO2vq/EsgFNlazEYJ8IswCu0Q/QLl2YnbzepDXX/
         beqS9ALHUYncC7CMCCiTsgnlq0DNHX4hzjLv/yipl1Q9yUzfGgtUMgLKhngvCd+R83pu
         o/+X+rXf4srW1+siku5H3aBWu2IDeowmraxa0/rgclwQa8jSZkCGoWMO9KOy0iAKS4gU
         ydJu817tuM7IogcB12c1RpW5XFGc6gTRpIlr37A4DfzLn/BapQHsnj/iYSOjBKCw93TI
         2QkA==
X-Gm-Message-State: AOAM530HNVUEV9cHkVY2c8RGd4xGrUs0CSL0Q9lVkl5rVg6gnSlV3sQT
        y8y92nVmlNEBOsn2IeCWMOz3LsZP4OyWjvY=
X-Google-Smtp-Source: ABdhPJwj4x5AqnsnHuU7eLFaaCrg7iFEgECz0x2EW+4lWy5xpGyNNzbzxFRm5bhYysPyfFoZL3rvQRkwzt8D9MY=
X-Received: by 2002:ad4:476a:: with SMTP id d10mr1724517qvx.13.1595448799289;
 Wed, 22 Jul 2020 13:13:19 -0700 (PDT)
Date:   Wed, 22 Jul 2020 13:13:13 -0700
In-Reply-To: <20200722201313.754671-1-saravanak@google.com>
Message-Id: <20200722201313.754671-2-saravanak@google.com>
Mime-Version: 1.0
References: <20200722201313.754671-1-saravanak@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v1 2/2] of: property: Add device link support for pinctrl-0
 through pinctrl-8
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

Add support for pinctrl-0 through pinctrl-8 explicitly instead of trying
to add support for pinctrl-%d properties.

Of all the pinctrl-* properties in dts files (20322), only 47% (9531)
are pinctrl-%d properties. Of all the pinctrl-%d properties, 99.5%
(9486) are made up of pinctrl-[0-2].

Trying to parse all pinctrl-* properties and checking for pinctrl-%d is
unnecessarily complicated. So, just add support for pinctrl-[0-8] for
now. In the unlikely event we ever exceed pinctrl-8, we can come back
and improve this.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index b06edeb1f88b..d40d923ffeaf 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1274,6 +1274,15 @@ DEFINE_SIMPLE_PROP(interrupts_extended, "interrupts-extended",
 DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", NULL)
 DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
 DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
+DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
+DEFINE_SIMPLE_PROP(pinctrl1, "pinctrl-1", NULL)
+DEFINE_SIMPLE_PROP(pinctrl2, "pinctrl-2", NULL)
+DEFINE_SIMPLE_PROP(pinctrl3, "pinctrl-3", NULL)
+DEFINE_SIMPLE_PROP(pinctrl4, "pinctrl-4", NULL)
+DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
+DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
+DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
+DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 DEFINE_SUFFIX_PROP(gpios, "-gpios", "#gpio-cells")
@@ -1303,6 +1312,15 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_nvmem_cells, },
 	{ .parse_prop = parse_phys, },
 	{ .parse_prop = parse_wakeup_parent, },
+	{ .parse_prop = parse_pinctrl0, },
+	{ .parse_prop = parse_pinctrl1, },
+	{ .parse_prop = parse_pinctrl2, },
+	{ .parse_prop = parse_pinctrl3, },
+	{ .parse_prop = parse_pinctrl4, },
+	{ .parse_prop = parse_pinctrl5, },
+	{ .parse_prop = parse_pinctrl6, },
+	{ .parse_prop = parse_pinctrl7, },
+	{ .parse_prop = parse_pinctrl8, },
 	{ .parse_prop = parse_regulators, },
 	{ .parse_prop = parse_gpio, },
 	{ .parse_prop = parse_gpios, },
-- 
2.28.0.rc0.105.gf9edc3c819-goog

