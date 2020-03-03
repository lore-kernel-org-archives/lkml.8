Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F48AC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6BB2072D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Xu4sE3PK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgCCTaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:30:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33210 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbgCCTaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:30:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id a25so3079803wmm.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 11:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLsvFFlZ8l09UWApmtGDnVPv6MG087h7rXG6DY2TdQE=;
        b=Xu4sE3PKhvoy3YjexN5KvyigUsTgJJBukVuuOSRBr0c/pIvm8TKwRPDfTIY4YbbujF
         klJ2W2xJVKFFfbOec8iHOip9Saic+QZ4m2Toy88Sxe0zyKXLfyWYmBWoZNEzhWDXe5+9
         FFGPggOGod2ndlcqGtG1xR+rhjH2jXV9O2JxV32xSmzFT5rAhFaTcaQpXjI8NWp44ndx
         u2oTtofjCNzMFdOlY9EH8TFVshAZWXIw9kpm/b+MZlW/zCWznxbXGEWExRPAqqOeivxp
         eta6po1Dysrdc6nJ8qxnjzV8TL1RlUWS5osRWJEA0RJLcji4LEuctGdbx+rgDk8fjQwB
         FQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLsvFFlZ8l09UWApmtGDnVPv6MG087h7rXG6DY2TdQE=;
        b=S3ZTvIG9kp5sr+TmAqzsJ2tvPp9gXodxVoN6azP1Fc8+0AmeBk0lp/gOfUH8pXKglc
         NIIAM3y69ZU9btZ9xpfIwAiOA/QNYJpsY93JqiTGsxNh+X5VUVNSd9RnSRYDGVSTc3jG
         NpZk08ZGMbJBvEpE5nwHXqKI4EwEtpNkU1Bu0H+T3DZOrk9hHe17fX5dZpkCZgHB7+cq
         6FCpnrL6lgfYInEsNgApSAvKiFIRr0TO2+PNadlxV6TpEc2mnCFAhcNI/VPR8ysJTCbr
         TJYJNFnaZxbamdUgDuMSXKb8Er0B7TloIWUOKj8THf8CcS7F9On9FHxdU0xRMSHZglEG
         BdHg==
X-Gm-Message-State: ANhLgQ03QpvoD3v6VD78wgD8dSMpp77XrFzfDT34zOgZilQVt7xbGjNZ
        NONMstrM0ufUJzwkLVcgDjiKJQ==
X-Google-Smtp-Source: ADFU+vvgohVRhFuFhTLyG/81TfZZbiRhxlI1wlFSO8TcMr7u7HNNf234Xb78qJex+ypXm4I6EEmadA==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr87984wmd.91.1583263813664;
        Tue, 03 Mar 2020 11:30:13 -0800 (PST)
Received: from localhost.localdomain (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id w22sm102469wmk.34.2020.03.03.11.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 11:30:13 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Reichl <m.reichl@fivetechno.de>
Subject: [PATCH] clk: rockchip: fix mmc get phase
Date:   Tue,  3 Mar 2020 20:29:56 +0100
Message-Id: <20200303192956.64410-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the mmc clock has no rate, it can be assumed to be constant.
In such case, there is no measurable phase shift. Just return 0
in this case instead of returning an error.

Fixes: 2760878662a2 ("clk: Bail out when calculating phase fails during clk
registration")
Tested-by: Markus Reichl <m.reichl@fivetechno.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/rockchip/clk-mmc-phase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-mmc-phase.c b/drivers/clk/rockchip/clk-mmc-phase.c
index 4abe7ff31f53..975454a3dd72 100644
--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -51,9 +51,9 @@ static int rockchip_mmc_get_phase(struct clk_hw *hw)
 	u16 degrees;
 	u32 delay_num = 0;
 
-	/* See the comment for rockchip_mmc_set_phase below */
+	/* Constant signal, no measurable phase shift */
 	if (!rate)
-		return -EINVAL;
+		return 0;
 
 	raw_value = readl(mmc_clock->reg) >> (mmc_clock->shift);
 
-- 
2.24.1

