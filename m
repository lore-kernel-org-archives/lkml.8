Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D536C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F7724650
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSxmEE/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgBMQkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:40:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36387 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgBMQkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:40:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so7500793wma.1;
        Thu, 13 Feb 2020 08:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYs51DTWcpY/Z0Mrusx8O/2oW5iuRXCgerYN0ZZKm9Y=;
        b=RSxmEE/jHbfX+qZPdrlhKUfzfZB0bOqYvOreeIMwy4VplOCTAPR6mhE8oQfjshT1U9
         5vYdcMghcYmzE4iAQHAUxqnfxAhfDHq63+XWobt34fNdDBrHbkXZ1okFQy3xLwbinAdO
         t4yRTBfxS7O9wiBOKiCCIjuvS4Pw2s8DYtvTJuIMZKkDtLy77EAdqJPzrGO0LdI/tdas
         adTfiqeBzrx/DvG6UZxpPKOHhR+hJF4T6CxRxiVsbTQo6tjfE286KoXQvV0IRHI27OTl
         SGovm73hq2DEDoElDGTDLsZPGcLCdRzEFSwfRkA1nfQc/ui+1CBhTG1bqmZMgTipkVHO
         v3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYs51DTWcpY/Z0Mrusx8O/2oW5iuRXCgerYN0ZZKm9Y=;
        b=a9TsAlrDWSec6NLK24/Zy7K19FvFBrtrzhGNDy8PjCK7/jhnx4OafEVgbM6DK0dpHi
         FMeFirBh8BINSO9RL83JiWOgOQhf23R0IYNk0wBGB7HpXIjn2UaJ71yqWBpPbyBEidg/
         ebovbyv4gvG4hsmkbeuRJ+/xXMa7qu8q5PtOAUs9or+g9BsZBowntJc/podUwBWl0ah1
         NWtwzqUr+nN/lA7Jn/6658iO2piM9AsFbJtkjn8O4Uppos+nnEZX1XleWI/O14BGvaU5
         uoLYWF5ickViY53NklAghmN9DKrDJs5hYrURYK3ytUs+0pvDj5+Z9X19Cq3KEfz6c13U
         ukMw==
X-Gm-Message-State: APjAAAUBeXN31QWx+VxtmnOou8e3e4WKLDa9v9C9amMcsPTfDqge0hg1
        jlDXTc0egoPBWzmneTTBdSS71AiR
X-Google-Smtp-Source: APXvYqw7j8Tekzs4LcNAuJ1ri+Mrd+LCBOLE2GE/xwhUFmLwrvqbghwhx63vfIvD8Gy3IDaZ3tHtcw==
X-Received: by 2002:a1c:e007:: with SMTP id x7mr6518555wmg.3.1581612012009;
        Thu, 13 Feb 2020 08:40:12 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id q1sm3347264wrw.5.2020.02.13.08.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:40:11 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Olof Johansson <olof@lixom.net>,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] of: Use memory-controllers property for DMA parent
Date:   Thu, 13 Feb 2020 17:39:56 +0100
Message-Id: <20200213163959.819733-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213163959.819733-1-thierry.reding@gmail.com>
References: <20200213163959.819733-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Prefer the memory-controllers property to determine the DMA parent of a
device over the interconnects property, which can be ambiguous since it
can be used to describe multiple paths to system memory.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/of/address.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index e8a39c3ec4d4..ae841bd36bb0 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -697,17 +697,24 @@ static struct device_node *__of_get_dma_parent(const struct device_node *np)
 	struct of_phandle_args args;
 	int ret, index;
 
-	index = of_property_match_string(np, "interconnect-names", "dma-mem");
-	if (index < 0)
-		return of_get_parent(np);
+	ret = of_parse_phandle_with_args(np, "memory-controllers",
+					 "#memory-controller-cells",
+					 0, &args);
+	if (!ret) {
+		return of_node_get(args.np);
+	}
 
-	ret = of_parse_phandle_with_args(np, "interconnects",
-					 "#interconnect-cells",
-					 index, &args);
-	if (ret < 0)
-		return of_get_parent(np);
+	index = of_property_match_string(np, "interconnect-names", "dma-mem");
+	if (index >= 0) {
+		ret = of_parse_phandle_with_args(np, "interconnects",
+						 "#interconnect-cells",
+						 index, &args);
+		if (!ret) {
+			return of_node_get(args.np);
+		}
+	}
 
-	return of_node_get(args.np);
+	return of_get_parent(np);
 }
 
 static struct device_node *of_get_next_dma_parent(struct device_node *np)
-- 
2.24.1

