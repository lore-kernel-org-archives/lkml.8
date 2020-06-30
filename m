Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A18C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF7320809
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 04:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WlbOS/rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgF3EdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 00:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgF3EdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:33:11 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6846C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:33:10 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d67so11000328pfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BfxhdyAtqRfaskkZwcQe9jhhrIlwrtNYUAU6BoBKsU0=;
        b=WlbOS/rxcV/nfmL42gU+2uW5605vPpCXptWNJaFjQi66NImbnUdE6YUsetFLBNuK/Q
         e0IrRdvdbc0ascmCOGvBQVu8qaN9dcV03MGj478OkMAON0upmpBr4NNymtMqgprgB6qJ
         V/XgCdqQyV/4MoLD6zs7xCrSqcKAJu21Vvq451gB+OHOMv4J0/jjF/3GzHjgSxextSrw
         FfB8Fq47pm/JhiUmx5By8xgA2xIFK+FTaUFU4l+pE01+jOU/pVRq1/VrYj0XEu2ltNaQ
         Pe0a575vblABxCv93pMWXadn7FFRDkZtJiq3vqbvTo4Pt+7oF4jpwQWhCUgTAxR7DWfv
         XJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BfxhdyAtqRfaskkZwcQe9jhhrIlwrtNYUAU6BoBKsU0=;
        b=nfIui0ZZyrDp8CKVZhkDPJ58AL8zF6devf6YcjWXk+Rqufdb0PsTLC2CpV6+ncyD/b
         Tx/pko2MOr4D311CTAW658t5GDImDXtz2tBSbz/dC74LNn6bbhy39aTg9PB3dBVfZp+0
         C/o/ox0jURoF+3uutL3XoBa1ZwpVZhD+zeSGHxqI9YAu8v1bCKK0nxPvcjlKgIdTGLSZ
         atgNVt9nM54muFvW6to9ptQfBya/HXXXGaBHsCkZ+cj3a6rc5tHAeH0iijrqx2rH1U5Y
         tDoCaWUDP6znB8Y1Tb98ySqrLB0n0dZEJiHshaQOmKsHvcvNR22z44WsuUbtKiYUHH58
         ixNg==
X-Gm-Message-State: AOAM530DF+fl25/uTWbc59QyfOm/AQOmqF4WwPjexB7gj4XRHCHRSGR7
        ZV6OFHWLE4G38/FsgbLO9Fd2tMuNNiYp8A==
X-Google-Smtp-Source: ABdhPJzjDYrzCee7PJbQXNWpdVP3KKDk5o0jdZbS8zAHzV1bEo0J1F0IKWlOtMQhuDNnPi+Qz1VkgwhZGFZGsQ==
X-Received: by 2002:a17:90a:246:: with SMTP id t6mr20697187pje.230.1593491590176;
 Mon, 29 Jun 2020 21:33:10 -0700 (PDT)
Date:   Mon, 29 Jun 2020 21:32:14 -0700
Message-Id: <20200630043214.1080961-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] clk: Specify IOMEM dependency for HSDK pll driver
From:   David Gow <davidgow@google.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HSDK pll driver uses the devm_ioremap_resource function, but does
not specify a dependency on IOMEM in Kconfig. This causes a build
failure on architectures without IOMEM, for example, UML (notably with
make allyesconfig).

Fix this by making CONFIG_CLK_HSDK depend on CONFIG_IOMEM.

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/clk/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 69934c0c3dd8..326f91b2dda9 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -50,6 +50,7 @@ source "drivers/clk/versatile/Kconfig"
 config CLK_HSDK
 	bool "PLL Driver for HSDK platform"
 	depends on OF || COMPILE_TEST
+	depends on IOMEM
 	help
 	  This driver supports the HSDK core, system, ddr, tunnel and hdmi PLLs
 	  control.
-- 
2.27.0.212.ge8ba1cc988-goog

