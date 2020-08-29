Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3956C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D6E2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 08:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ47QGaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgH2ID4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 04:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgH2IDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 04:03:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952EDC061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 01:03:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so1174150wrs.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 01:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4suMcctfz6Bm64a3CG1Q4ZhgpBQhJ/zmSGep484vR+o=;
        b=pJ47QGaYLlIR0FCfo0Miafdetuo7SIrjDhAYZe3baVWNIffFQ8eGsS/Yu85Y9w1l59
         ptK9re46VkClF3RnLFwNZdVrIB0SG8HYrsnzhsYmiVCotUnnpEFbvqbLu1OP9GrS1Bz5
         QgHrdyWB0ZTICHq3dCHYNcJaEW5sfHNBAL+GSXlbSHO+gvSRVx5Ei+XO8gzE1CUmPm44
         yB/rybsaI0kyY8hR/uyrapT/ImAYCIr9lIilkC/dxbVsdchivhCidcgqnObWWX9LAGXw
         GILb4VK0BwXseLqmv6egjWZ45NwVtg6O/oJZrYHURW2LNWpbJ+U5JGZyUeiCpAFqJzOE
         C3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4suMcctfz6Bm64a3CG1Q4ZhgpBQhJ/zmSGep484vR+o=;
        b=GWrxuGPqSuYE7LArxRNHiVGwk3tZN0nrssAzUz9v1a/I1yEzsHygUwkY/0exIGsN5l
         fM2H/D1BM4uwUeiitUkmHx+HwwTRXrncPKiMYnrwLJC39LsGbgUaP2DO0dtsXUCX7Vox
         WECKjoZt0yU05bGR3TQWqAAXN7QEZUwsGBVCOhH9mxIhGKT6511rAza2Y+IQ1gKIqQWN
         /gBh6ZOVzxi+ijnd5h+efQl69/HkXwTbWN4JtY3APLXZdLU+Izs+U964mc5SuWmsyqcQ
         xhalPRkmmMBExFS6PoZUKLLOkkCEz1goVq5rfxGf8JtXXYZHml0+MTg2Hl4oXfuH6xwF
         LZtQ==
X-Gm-Message-State: AOAM531ZVJY03g2OtbVZfdq2t1M3Vti5EQ8FFZflbHEPXr9FqYKVmzRq
        ARXuAeorNZ72Cw6Iz3ux3ByHwTVL0J0=
X-Google-Smtp-Source: ABdhPJwhsK6r1U613D2Ndd1gtzrKQZDoIpExOi/QpMq8CljlwDhE8xAyNKhoLgvApwY8Z4FH3i1bSQ==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr2429157wro.86.1598688231122;
        Sat, 29 Aug 2020 01:03:51 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id g15sm2632631wrx.66.2020.08.29.01.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:03:50 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 1/2] habanalabs: prevent user buff overflow
Date:   Sat, 29 Aug 2020 11:03:46 +0300
Message-Id: <20200829080347.26050-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

This commit fixes a potential debugfs issue that may occur when
reading the clock gating mask into the user buffer since the
user buffer size was not taken into consideration.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 37701e4f9d5a..aa77771635d3 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -982,7 +982,7 @@ static ssize_t hl_clk_gate_read(struct file *f, char __user *buf,
 		return 0;
 
 	sprintf(tmp_buf, "0x%llx\n", hdev->clock_gating_mask);
-	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
+	rc = simple_read_from_buffer(buf, count, ppos, tmp_buf,
 			strlen(tmp_buf) + 1);
 
 	return rc;
-- 
2.17.1

