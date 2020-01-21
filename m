Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7ADC33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB1C24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="KwASRaBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAUXdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:33:55 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:54692 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAUXdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:33:54 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 482PxY5cSWz9vKTK
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 23:33:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nu9mCrTi-BDb for <linux-kernel@vger.kernel.org>;
        Tue, 21 Jan 2020 17:33:53 -0600 (CST)
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com [209.85.161.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 482PxY4PqLz9vK4v
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 17:33:53 -0600 (CST)
Received: by mail-yw1-f70.google.com with SMTP id q130so3785402ywh.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 15:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6DJOeztgVtEUvqWLNWMSEIAkWiKOtPrRMe2WYbDoYo=;
        b=KwASRaBXKDXBrd3U+BHyR/8BeUvKPeRm8uFBCdUu15PV4nFZfrxcAEnapBWvwV6h5W
         njhhUvjsD4MgUa0BGYfvfctFVRhPZuAZcxTrUFaeh6QBiKd4S5lse6w6dA1+pnlsabwD
         yTipzcOd2Fu9AzRxohQU/M2AI/WcdTp8v4TRhcBYqPt9dyk9bbuNJfQy0bOc18YSQ0vq
         vCUP87CL/KmEyn6m40weOhp0OFwTg6hPD2zS3+hpdbRKqjRk0ezyxv4/xIPQzmzOfZQJ
         RTZxjTmKXo5FGKDSi+cV9jWjkxpN/voa4A59+gzkf9OePy5FJ4EQWb57xdA4fNgYWjRg
         VWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j6DJOeztgVtEUvqWLNWMSEIAkWiKOtPrRMe2WYbDoYo=;
        b=eEQ5FisujL1McZOFPlws4dRDsCRBXQzehpNW7oSReEiAv2NdR3xjlve9YehRs7Rs+m
         nfKL6byrmx+VOr0Nn9humnbJ5R/y+RvlqG6CY9OojCWl456G1/nIVbt4oUuWmiBI1c49
         1cqEQUgzy1DC7yPbE5I5XIDCNCPZE/M+UOMjGpsC9XGIgC4f4JkyMqlnSmoRq01wb/dD
         m91l0lvGuVEJL1tU7UWaezm/VBhYjviTsbgxZbfwtIr9OeSbYkwgm45GUK+cwsvyrXZV
         nPsYHJljlE8eRx3gHNJsMOAP89JgPxZobPcX7+xTaRarqMB8ElUl2iBqsD8hRQbOhnPA
         FzQw==
X-Gm-Message-State: APjAAAW5q6XGQcqTwnT+juP66lB6cgUXAR3olzUizeIy/Rn4svs1/yEQ
        N2dmoREdDy7hGR6X3XSgcjS3xYB3e+P5hb5rYY1W/XOY/7XTUdxhP9VnpRqZbPV5z3EuXSXukDA
        elYRnJVcZ9LT6xJEP0ifi9e98KoHV
X-Received: by 2002:a81:9e49:: with SMTP id n9mr5204350ywj.234.1579649633103;
        Tue, 21 Jan 2020 15:33:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCUKRM+rhNc3HX4RueGcoUHZAG+tpxb0+FiK6A2UC7mVWzW3DIwGZJJZBJ0T0YvyGQ/ZIWzA==
X-Received: by 2002:a81:9e49:: with SMTP id n9mr5204337ywj.234.1579649632829;
        Tue, 21 Jan 2020 15:33:52 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id g65sm17650663ywd.109.2020.01.21.15.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 15:33:52 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: samsung: Remove redundant check in samsung_cmu_register_one
Date:   Tue, 21 Jan 2020 17:33:49 -0600
Message-Id: <20200121233349.28627-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consistent with other instances of samsung_clk_init, the check
if ctx is NULL is redundant. The function currently does not
return NULL.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/clk/samsung/clk.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index dad31308c071..1949ae7851b2 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -356,10 +356,6 @@ struct samsung_clk_provider * __init samsung_cmu_register_one(
 	}
 
 	ctx = samsung_clk_init(np, reg_base, cmu->nr_clk_ids);
-	if (!ctx) {
-		panic("%s: unable to allocate ctx\n", __func__);
-		return ctx;
-	}
 
 	if (cmu->pll_clks)
 		samsung_clk_register_pll(ctx, cmu->pll_clks, cmu->nr_pll_clks,
-- 
2.20.1

