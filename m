Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCDEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9A4207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0lTwkvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390280AbgE1NZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390161AbgE1NZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:25:53 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4646C05BD1E;
        Thu, 28 May 2020 06:25:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y11so3268222plt.12;
        Thu, 28 May 2020 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKHFIuRb8JFzqwgI1/TTV1c2cdYlcWtWooy7HhzqQ7o=;
        b=f0lTwkvPsjEGSI+BRI7kDWY7T7QMJZBBjNSt80WryFEz5AtJUDysU0IozJWfDpadRX
         +SQ9hum9XQJrvIIcdEf21QUlcTu+sc1p+fcbM+1U2ZLrXzWpf0dgNbq1o9mMi1H8R9Oc
         7H5AakLypHuixotL+DR9NLguz8BRhuzL4+Y1Qa3NEHEb7midtfFz6hEW6uKkZLAwh9HF
         uQhT/laUdwHt7V4gziNDIEiHUPmnNq0BI4WsbZUN/jwNeIRIceaNDpTUikfKBPxpfJNM
         YsoCB0YB8/DvJEBjrczbb15h5uke20uYjL9YZHXWXui5/o92/lf7BIXAOefSQeDYJ7LR
         M73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKHFIuRb8JFzqwgI1/TTV1c2cdYlcWtWooy7HhzqQ7o=;
        b=fqhpflhQ/XYe5JmQM6VNi70pvRvs0tXhuOsc2JYqmlsIfmJuff22IYo4ePK0c3B1dz
         gWxf87oI6V2GlqDMPDBMumzOgSuGvke9ZzR46aeS3gk7CLkEabjQJ8pWpRj0P4ff/TWP
         26c1H8WjNBscye0+rezdqr7x1ESKFbwA/7RN+jt5422yzMJl28kJfuvD1hS4VVv4ttf1
         MtdOAy5H1aunuytd3Kw+qPjjUeNAEgZoVscFSe+qOUThtELRVPKDfokJ1X9EY9dFUfD4
         0S8ZkUwas3zgCAlWiWs78MFeQlYSsDKfBUi3hPKm4BaBjylqOGp1CntqjIRCyjLokfjk
         vNLg==
X-Gm-Message-State: AOAM533+HXbZSRR5CksRa5on/D7zvP6ptQMTpyJXdF3Osg7QNAsUEZ11
        QlSZLD791/6dSA81/dROlz/NL1tvK+g=
X-Google-Smtp-Source: ABdhPJz8VC7DQMsEmrHiOxWQ16KQoUAxc+7rIER6X1Qw+ve5Duj50GcgF9uNeOXubcm5LHp+efFVgg==
X-Received: by 2002:a17:902:bc86:: with SMTP id bb6mr3414568plb.243.1590672351462;
        Thu, 28 May 2020 06:25:51 -0700 (PDT)
Received: from localhost.localdomain ([198.211.10.140])
        by smtp.gmail.com with ESMTPSA id j26sm4869359pfr.215.2020.05.28.06.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:25:50 -0700 (PDT)
From:   Qi Zheng <arch0.zheng@gmail.com>
To:     robh+dt@kernel.org, robh@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <arch0.zheng@gmail.com>
Subject: [PATCH v2] of/fdt: Remove redundant kbasename function call
Date:   Thu, 28 May 2020 21:25:41 +0800
Message-Id: <20200528132541.463300-1-arch0.zheng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For version 1 to 3 of the device tree, this is the node full
path as a zero terminated string, starting with "/". The
following equation will not hold, since the node name has
been processed in the fdt_get_name().

	*pathp == '/'

For version 16 and later, this is the node unit name only
(or an empty string for the root node). So the above
equation will still not hold.

So the kbasename() is redundant, just remove it.

Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
---

Change in v2:
	remove another kbasename() also.

 drivers/of/fdt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 38619e9ef6b2..4602e467ca8b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -643,8 +643,6 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
 	     offset = fdt_next_node(blob, offset, &depth)) {
 
 		pathp = fdt_get_name(blob, offset, NULL);
-		if (*pathp == '/')
-			pathp = kbasename(pathp);
 		rc = it(offset, pathp, depth, data);
 	}
 	return rc;
@@ -671,8 +669,6 @@ int __init of_scan_flat_dt_subnodes(unsigned long parent,
 		int rc;
 
 		pathp = fdt_get_name(blob, node, NULL);
-		if (*pathp == '/')
-			pathp = kbasename(pathp);
 		rc = it(node, pathp, data);
 		if (rc)
 			return rc;
-- 
2.25.1

