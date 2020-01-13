Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19696C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B6C20661
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeR/VQc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgAMOyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:54:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38233 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgAMOyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:54:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so7083865lfm.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 06:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/4VDJozUtUDRjtxB/kp8itvm7M638W5AdxJEFSJoD5Y=;
        b=jeR/VQc0PulVYOUfup/ulU2nIDU3eIPyVE1weFWd76SjMLSZRil90wY2EOshZQzElQ
         nkdh6c/fMQ38jXiVKrtgxkYluellmr2kx98HQExcEtz4VSZLtdTjRNlW30Cu/iMQ7X8k
         xRYnX5Vji9x/H58DTFq/VVsQkZB6hvVj8yBwTEj/klOgcOawK1ufqLcZmT3nPsub+4ZH
         gLg3/9zmkHJ+o/dVlWO6M6RNSxonmkF/GNAZb2o3/8NXXkgz6ZXp8YEvOCEVL3ifEYM4
         qjpsGeguLTyPjw/iY/1lz0BXq9nyWnboyFX0eNafZyNNNcWd/wG2EnUDK+LPz1r1GoSc
         L3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/4VDJozUtUDRjtxB/kp8itvm7M638W5AdxJEFSJoD5Y=;
        b=EoZSc45dPcPs1QP63QzhhDeVJeAue7BhkA3f+XeTkMC5miV9YMZ7cl15QwbyN08rsr
         NleMrbCm9jjZpIZgqh9ZY6DI25bax0j9Ad4RE4WC17tc3RPCf8aobfjzIWq4paOxtWCE
         +YFzIwLXNB1+ZmBbAsIdSkvbjE4+BEmpSTJU8jSpPuYBQieZ2ablbaER+bQ5aEHrG/jV
         YJXqCxBWE7OjU+3sHYyq54DswAt7u032SvQX8CX2kVnHz4lHa7zB5kqLs9E1hcW6YZ6C
         9EAO2tG+UeSQ6RjOjX4pcUJP1USp+VkJvp6dL1PSYnpOZQVqJ2lJgCB0sRXIPPpKnndu
         8x6g==
X-Gm-Message-State: APjAAAV8VLtJIqas+Tz+Jin9WBY060GtjDRLeWdWABlzSjhucIP0EGlu
        AXXzXSA5bxtZB3aZWuZgOCKzpzq66FI=
X-Google-Smtp-Source: APXvYqxXGFZweM5WZczXbpuahrbpAK1LP3x1QwThF2hCHZ3knvtCEIHnQooimEJkoHWuXmCGMGXEXg==
X-Received: by 2002:a19:4849:: with SMTP id v70mr9680953lfa.30.1578927291997;
        Mon, 13 Jan 2020 06:54:51 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id w71sm6822281lff.0.2020.01.13.06.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 06:54:51 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] MAINTAINERS: Add dt-binding files for Venus
Date:   Mon, 13 Jan 2020 16:54:24 +0200
Message-Id: <20200113145424.4867-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a path to devicetree dt-binding files.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 983d3c97edd1..8c97d1e7ea50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13732,6 +13732,7 @@ L:	linux-arm-msm@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
 F:	drivers/media/platform/qcom/venus/
+F:	Documentation/devicetree/bindings/media/*venus*
 
 QUALCOMM WCN36XX WIRELESS DRIVER
 M:	Kalle Valo <kvalo@codeaurora.org>
-- 
2.17.1

