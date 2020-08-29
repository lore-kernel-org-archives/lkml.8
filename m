Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D35C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6852071B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 17:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHvExVGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgH2R5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 13:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgH2R5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 13:57:10 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8024C061236;
        Sat, 29 Aug 2020 10:57:09 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ds1so1023390pjb.1;
        Sat, 29 Aug 2020 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nXrk/kbkqy9ClgLwV0Wr/6W8seRn97oLX3UsuxPWEoY=;
        b=nHvExVGcx1v5QIMuNToDfBdw5r05ACuQOvQVL0p0Mv7PF5Dv7tkS0/hatJ5fvM7Xe3
         2/FqOoQTZ12UciQ1z9PpbYlxgsYqOVHrM6OWCuaq5ic56dZVeMCSDk2TxN7ZtXEsVQjx
         lD7JOzPS865iRr7U/qypbQwlE9ZiSLukddyuj+cNj7BeiyoXN01+J9s76jAqkT3fFm3S
         Ogu1na4EKzTVGBQ02b3UHuw/NvWTA2NUgIq81VLOCCHRSva9uD0p+ZrNgxrSAAAcTLPi
         XkGGcSxok9dAtE0wqyXC2M+wdOcLvsmc1wJ2aKu/iOqh5GYqFnXL/KdMHJ9KfkltZVPS
         fKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nXrk/kbkqy9ClgLwV0Wr/6W8seRn97oLX3UsuxPWEoY=;
        b=GrFRkInhgzJ5YtNL08UB8yTbIdoa04kxV/RLgKgybqSTZ2DFrtpaXwMQfmxMQWntgR
         3Q/0yA1CSa62r73vve9vQ/tI5PzIeb5jPJJiNcKO3y/42wJDa9Qj2PA0It5xlL9QSyLw
         aNmp0sb5g8F2iAtsbce/dY9zAeteCNMV/A3E9zHVeGdMKATMlRO6bgjKKgR38T0s/nKj
         T8v2/J1J64LqvtV+ofGsG+7pEbdfAXaeu9/27xwqFMqQnpU4bSrGV5kayuo8Mzu5f4Nh
         p2PAJ6eddNH+tBQ00qAydEV10LdCjF5/ijt8yRILgKOQqoIZoWIbO1BW9rWW4VOP/dh5
         P99A==
X-Gm-Message-State: AOAM5321n2P8R+nRRmGhWcBoXpeus0jg8u1oDB7cAsKja0cgz1Yc8PBB
        d/XbRHZ0V4/6ZNtfth1lv1w48xaxmXZDSlRK
X-Google-Smtp-Source: ABdhPJz8kvXRTnTuh/ujkGXu/cl/rzn4a8toQGh/PurvhJq+27dEU+2ROM4rHVN/5lRrk2Eyk4IRfg==
X-Received: by 2002:a17:902:8d82:: with SMTP id v2mr3404174plo.180.1598723829381;
        Sat, 29 Aug 2020 10:57:09 -0700 (PDT)
Received: from Kaladin ([49.207.221.164])
        by smtp.gmail.com with ESMTPSA id j13sm3254207pfn.166.2020.08.29.10.57.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Aug 2020 10:57:08 -0700 (PDT)
Date:   Sat, 29 Aug 2020 23:27:04 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     linus.walleij@linaro.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, Julia.Lawall@lip6.fr,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: versatile: Add of_node_put() before return statement
Message-ID: <20200829175704.GA10998@Kaladin>
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

Fix a potential memory leak in clk-impd1.c by inserting
of_node_put() before a return statement.

Issue found with Coccinelle.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 drivers/clk/versatile/clk-impd1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/versatile/clk-impd1.c b/drivers/clk/versatile/clk-impd1.c
index ca798249544d..85c395df9c00 100644
--- a/drivers/clk/versatile/clk-impd1.c
+++ b/drivers/clk/versatile/clk-impd1.c
@@ -109,8 +109,10 @@ static int integrator_impd1_clk_probe(struct platform_device *pdev)
 
 	for_each_available_child_of_node(np, child) {
 		ret = integrator_impd1_clk_spawn(dev, np, child);
-		if (ret)
+		if (ret) {
+			of_node_put(child);
 			break;
+		}
 	}
 
 	return ret;
-- 
2.17.1

