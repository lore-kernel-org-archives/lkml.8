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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECCEC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D522070E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HgXDl9TK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGXXoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGXXoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:44:22 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C93C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 16:44:22 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u1so6867050qvu.18
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 16:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EJx+C1HYJpJVI4jXDzDWz4LJBm2Ud6mpPDBO8ER+7Wc=;
        b=HgXDl9TKIDoWYF/R/fYHaSb0seq98go57RS2bIjZWpUXOZMi6t6isak1S6tKCf0LZn
         eV055hAWKgifbYzNam7PB8uIECiuOdwkcow/qKXUpAp4AM6RIOpp0WlS70wHr9kBbiQp
         SEfuuZSp7HBaHyTbPyvPW/seQtfzS2XupEzp8mUx/zHn4f28dYpxGi0CJkAc9lIHxka7
         2dglrGhL0jisZNwGFTEiIOxa/fs7Hy4gMikfFA4XP52JK6om7nV3tw6CGQc/GlYlHHj4
         +fbXwQacjAi3Lxl99+V1ngtF12soKztTWZzvRzWIuOLr/fz7NVp6+7gHGJM3SPUiB7uC
         xPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EJx+C1HYJpJVI4jXDzDWz4LJBm2Ud6mpPDBO8ER+7Wc=;
        b=dGp4cbUS4166TEipqbvG4dujeJRcWMd46KJb0PHkFP+bLiHK6mWSgKFZaYTdhWW3w8
         SqC5C38vpl4sNfjVm0e3vJv+7j/q0r0UxBo5ff3VAOX8gVqDzSnHQCg8YLVnGogHMvXa
         CQHDtMl3jKDLyXnE2ko0cE1yAnv2y4STI2gkGsH9yIqg/TTBeMDA+7NLZBayXQBH94EW
         XdwVbuxmlVVd4slOY0Qsz3BNo5S6H2WafEaOqZ40IilH25vUMa1hb8KiLe1f3UxrRTxb
         rk7ysleIRy5IW2F4o9eIbmBrloLb3kiaeXZOrhNRyfrY/1BnhZCfZtW6DoYFWvU4JicQ
         Dnag==
X-Gm-Message-State: AOAM531SsD7lnX/b8T7FKqyRF3Uxsyd//pCEZbJ7db8JBVRGfKtDXJ8y
        1v4QqZObpdodpKc1H5uHLimKpzH4WiRpJwE=
X-Google-Smtp-Source: ABdhPJxPTlKJ7K9anYI69wdC69b+QBWLttCo2NrtIdtXsGifaFrPZASMRq8FQQ8b3DDRBVcMXrLQNKCt67TTE7E=
X-Received: by 2002:a0c:ee4a:: with SMTP id m10mr11725156qvs.41.1595634261784;
 Fri, 24 Jul 2020 16:44:21 -0700 (PDT)
Date:   Fri, 24 Jul 2020 16:44:15 -0700
In-Reply-To: <20200724234415.1651639-1-saravanak@google.com>
Message-Id: <20200724234415.1651639-2-saravanak@google.com>
Mime-Version: 1.0
References: <20200724234415.1651639-1-saravanak@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v2 2/2] of: property: Add device link support for pinctrl-0
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
(9486) are made up of pinctrl-[0-2]. 'pinctrl-8' is the current maximum
found in dts files.

Trying to parse all pinctrl-* properties and checking for pinctrl-%d is
unnecessarily complicated. So, just add support for pinctrl-[0-8] for
now. In the unlikely event we ever exceed pinctrl-8, we can come back
and improve this.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
v1->v2:
- Clarified in commit text that pinctrl-8 is the max found in the dts
  files.

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
2.28.0.rc0.142.g3c755180ce-goog

