Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E03C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5D220757
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFeXjVAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgH2RmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgH2RmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 13:42:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B32DC061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 10:42:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so2020715pgf.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=v0+Y6jCCh/wg/QF1vN3peVwswvjJOdtClUaEODnQziQ=;
        b=oFeXjVAwrSsrDiXpvBkVKLGo4tCbl62Epz1MfOQSMzS8sQ6rpl2LHbpf/pQq8W68mC
         oTXIz5IQSy+EQf0kdwftqhfFFh4lXPXhC7TW9KKsqNv3gNfnaPMmIsEjiJKHbaCsndiS
         J53uLYxbt1mSOX0QfeA42tgjzAG9wd3btizSgcxC4Zd+NAa50m8bjfN1sIApgbPKmBkP
         G2HWgkjKHYzz8YWNos6xicICQj6D9a0Z5ihabi9rZZ9m9uZmEGpRsmaJL6gFqNenxINY
         Z8M2DPOjASl+gtr670VNie794YqbKioyR9WjY0Cp+03P0bdbv7stfoBESWNHvc8GSQ1c
         5sUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=v0+Y6jCCh/wg/QF1vN3peVwswvjJOdtClUaEODnQziQ=;
        b=eDal+wpGI62BPk2GUcifq4ytkz61rzOLtO8LpS0d3z03/f3yFQzyEXw5xgxqzMr0PE
         2bySLPUBHHR9k66DaW80oIehCMhNuZTLBZ89E2usgoVhPMHpbrzGj8srVkJFqh5sIXQ7
         jTy+Q89JcU5eCFeW1Q0xCjwul6NU+45kTjwPqB62lR7C1MhS43cJDUSwL9b3Iqgtj7CI
         ZF5+kpTU2JOmGEWUidb3MtMfeuRJqrMFRtg8Lzk7oSPMSa1qpOZ2ukCpw3oaaQiwdufw
         tdGo0UxdDGSUdxxlHH/mrBNo7UrmbmD6uN/14N7Si+XCqtXnEoU9/pIaqqaTp0+x+6DO
         uc+Q==
X-Gm-Message-State: AOAM530p58qFivBWJsdgzWDHGISqU8mkV5EkPg6IINGjB6hU4TqUMIBi
        9IR8igaisgSHj80ExNOUd68=
X-Google-Smtp-Source: ABdhPJyoHhXogLh3qAcZCEpJlOnGD0LhHXv5OxORHg9R4XYGNFGISknfIYc2luHIh0NLe2jeHn+/ig==
X-Received: by 2002:a63:1341:: with SMTP id 1mr3110890pgt.144.1598722919806;
        Sat, 29 Aug 2020 10:41:59 -0700 (PDT)
Received: from Kaladin ([49.207.221.164])
        by smtp.gmail.com with ESMTPSA id u2sm2591711pjj.57.2020.08.29.10.41.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Aug 2020 10:41:59 -0700 (PDT)
Date:   Sat, 29 Aug 2020 23:11:54 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     linus.walleij@linaro.org
Cc:     Julia.Lawall@lip6.fr, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bus: arm-integrator-lm: Add of_node_put() before return
 statement
Message-ID: <20200829174154.GA9319@Kaladin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every iteration of for_each_available_child_of_node() decrements
the reference count of the previous node, however when control is
transferred from the middle of the loop, as in the case of a return
or break or goto, there is no decrement thus ultimately resulting in
a memory leak.

Fix a potential memory leak in arm-integrator-lm.c by inserting
of_node_put() before a return statement.

Issue found with Coccinelle.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 drivers/bus/arm-integrator-lm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/arm-integrator-lm.c b/drivers/bus/arm-integrator-lm.c
index 845b6c43fef8..2344d560b144 100644
--- a/drivers/bus/arm-integrator-lm.c
+++ b/drivers/bus/arm-integrator-lm.c
@@ -54,6 +54,7 @@ static int integrator_lm_populate(int num, struct device *dev)
 			ret = of_platform_default_populate(child, NULL, dev);
 			if (ret) {
 				dev_err(dev, "failed to populate module\n");
+				of_node_put(child);
 				return ret;
 			}
 		}
-- 
2.17.1

