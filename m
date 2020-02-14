Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10B7C3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A8E222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581720221;
	bh=H/TPqHRNSmD4IwUAivQ4lInBziR9Asin4p/pl6/mCO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZMWVouhrgNTS3IwuglbynE12zKghCS0/M9wi6SBMyEe6xwzg7vQuiALZ28BMkfasK
	 k/lWcD7uhutlgU5zkbKCz7dxDDY3BwqDKoSVg1XAbbSPcF6p6bncHP3q1yGM0ibvyl
	 0/781NN6yzQvvnfzXKbNso/yGDg6w7v97pF15b3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgBNWnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:43:40 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43094 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgBNWnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:43:33 -0500
Received: by mail-oi1-f195.google.com with SMTP id p125so10951895oif.10;
        Fri, 14 Feb 2020 14:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRK+etse5GdhzRRMSbN0AsTFv8NtL6Mf75PwYVcJU44=;
        b=ufV4By3kONxEZnyPWsfuV2Gp6foK6U9A7tSQdfSdzAel/6TDFgZw+/8/HBKXxffZd1
         VSXS6wlcC5Vy3zpTHZVjrJN9R0R5VcUuErrWkvkORdP1gFCIltpDwTt0FeBF4NKSIm5e
         jCwbS+hrkea14hx1vctyT1k32qmWR65sRNuP9/oxQwxNDWSaHpD7HVJt71ZH/uZndGfn
         7YIpH+TAofUj3kKsjTNErV1o6ZVG8pq4RuHml7rDUybEroKiC1fskapyJvlmWXbj697e
         oaPjFj6ykMoFCux0u9FDbtjN+0b7skh0K0gx2npo/sHvIqTEfKfGGwLDEPflr32EdaM1
         1m9A==
X-Gm-Message-State: APjAAAUk4xspchTzZNmxV0SMxD8P/pHscfcMpVtUrTKKHysPGLTjSols
        2aZtRNnbRA80nYy5ZAyPNEERqDA=
X-Google-Smtp-Source: APXvYqz909Fzl/Mv16+lZxspbsDGyoBiYnJJXHR2kdCOGJNisRMIBPTjbnRMOa+Vuf4buMe01/NvvA==
X-Received: by 2002:aca:f0b:: with SMTP id 11mr3564215oip.34.1581720212297;
        Fri, 14 Feb 2020 14:43:32 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m69sm2453167otc.78.2020.02.14.14.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 14:43:31 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 7/7] of/address: Support multiple 'dma-ranges' entries
Date:   Fri, 14 Feb 2020 16:43:22 -0600
Message-Id: <20200214224322.20030-8-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214224322.20030-1-robh@kernel.org>
References: <20200214224322.20030-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the DMA offset and mask for a device are set based only on the
first 'dma-ranges' entry. We should really be using all the entries. The
kernel doesn't yet support multiple offsets and sizes, so the best we can
do is to find the biggest size for a single offset. The algorithm is
copied from acpi_dma_get_range().

If there's different offsets from the first entry, then we warn and
continue. It really should be an error, but this will likely break
existing DTs.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index a2c45812a50e..8eea3f6e29a4 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -944,6 +944,7 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 	bool found_dma_ranges = false;
 	struct of_range_parser parser;
 	struct of_range range;
+	u64 dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
 
 	while (node) {
 		ranges = of_get_property(node, "dma-ranges", &len);
@@ -974,14 +975,33 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 		pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
 			 range.bus_addr, range.cpu_addr, range.size);
 
-		*dma_addr = range.bus_addr;
-		*paddr = range.cpu_addr;
-		*size = range.size;
+		if (dma_offset && range.cpu_addr - range.bus_addr != dma_offset) {
+			pr_warn("Can't handle multiple dma-ranges with different offsets on node(%pOF)\n", node);
+			/* Don't error out as we'd break some existing DTs */
+			continue;
+		}
+		dma_offset = range.cpu_addr - range.bus_addr;
+
+		/* Take lower and upper limits */
+		if (range.bus_addr < dma_start)
+			dma_start = range.bus_addr;
+		if (range.bus_addr + range.size > dma_end)
+			dma_end = range.bus_addr + range.size;
+	}
 
+	if (dma_start >= dma_end) {
+		ret = -EINVAL;
+		pr_debug("Invalid DMA ranges configuration on node(%pOF)\n",
+			 node);
 		goto out;
 	}
 
-	pr_err("translation of DMA ranges failed on node(%pOF)\n", np);
+	*dma_addr = dma_start;
+	*size = dma_end - dma_start;
+	*paddr = dma_start + dma_offset;
+
+	pr_debug("final: dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
+		 *dma_addr, *paddr, *size);
 
 out:
 	of_node_put(node);
-- 
2.20.1

