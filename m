Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFE8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8D12073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="YpholpuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgEVVun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:50:43 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:33418 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgEVVum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:50:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49TKtB2GS7z9wCZG
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 21:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hEYr1xrE_Dlr for <linux-kernel@vger.kernel.org>;
        Fri, 22 May 2020 16:50:42 -0500 (CDT)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49TKtB0kcJz9wCZX
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 16:50:42 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49TKtB0kcJz9wCZX
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49TKtB0kcJz9wCZX
Received: by mail-il1-f199.google.com with SMTP id b29so9762353ilb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QnQxecg34bqUdZINiYr2xryJqppsStQKMeRWBxxN/GY=;
        b=YpholpuHjF0WHc0kgsVphNDznXfkkcsqz5mrytjkO9sNgbLyvjptT8FgeVF2IehPwu
         PD6SdQGReD1MMFB0xgkm9X3LZOOuon7e+fZGp3l0x9EqjJfJoomsab6NwLQKPQAt6U4A
         mMy9FJshFD+T1bxogDXRZl2W/CF1Aor1oZJVfZ8ZQnTgbW6zmlfbwGZI1Pc29YqQ4Jke
         KbBqZPk+vxD7zu2CSa4l2bl0ZvRS9rX+y5IrRvO+cExg+567TCmBrcsHL7AiPoJQXKM+
         GR67XwmPKXGtqeDvOj5srFN6keVcJa2k9tfs2EFMF+B7qYxPen4INS6e43b3PRJXxrlh
         2sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QnQxecg34bqUdZINiYr2xryJqppsStQKMeRWBxxN/GY=;
        b=ea+si4Ffs0PHENONVjI50W1bUJGgZBdDX4fsiiuxlIwrRAnjbQ17fE4B4Z2dbGmQ8U
         h/aNHRx8Q0zBzQbHs3xdk/IPy86nSu9tzWTDbqsjbSwnAJwhuSsBmhk2X7abE+XdMboK
         2LEfM0w3Otvza9sB2WiH9yWewATqK4Ggy9ooylFF008KKfPtavnXb9jBOMcJFdRGUNhg
         SfnqAgncf26BJ+50p1NIlS6DL6uGAJIl3+w2tMANFlhrvYmZAJRtxbo5Rupwt0xcxCDW
         26XlSljx9+hwzdZ7v2I1yhA/H4AqknOQGOBgmeEZhjU/c6bydxwmtggcopix2plar1hj
         5bug==
X-Gm-Message-State: AOAM530AXGoRjv1Ytmz/5CkA4JLFHctswHzj+XwMBzJBo8T5zxOfJb+D
        bF0FkCtVXrgqBBC4/haZASeCUKF8BAztJn224SNGLL83Iz8Jsv3xxI1tveyJWxb7Gng9l2VTocl
        5jrL4o3r1/JkOFXt81mP60J3OhMl+
X-Received: by 2002:a92:1b17:: with SMTP id b23mr15119061ilb.199.1590184241632;
        Fri, 22 May 2020 14:50:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3IHta8Esaor63AmNN/5skTrVjceOXa80q0zwAtFpkTtxrBOXmSqZQlwJ8t2pbwIbGhFMwIA==
X-Received: by 2002:a92:1b17:: with SMTP id b23mr15119040ilb.199.1590184241297;
        Fri, 22 May 2020 14:50:41 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id z3sm4218651ior.45.2020.05.22.14.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 14:50:40 -0700 (PDT)
From:   wu000273@umn.edu
To:     davem@davemloft.net
Cc:     kuba@kernel.org, hkallweit1@gmail.com, jonathan.lemon@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kjlu@umn.edu,
        wu000273@umn.edu
Subject: [PATCH] net: sun: fix missing release regions in cas_init_one().
Date:   Fri, 22 May 2020 16:50:27 -0500
Message-Id: <20200522215027.4217-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In cas_init_one(), "pdev" is requested by "pci_request_regions", but it
was not released after a call of the function “pci_write_config_byte” 
failed. Thus replace the jump target “err_write_cacheline” by 
"err_out_free_res".

Fixes: 1f26dac32057 ("[NET]: Add Sun Cassini driver.")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/net/ethernet/sun/cassini.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index e6d1aa882fa5..f1c8615ab6f0 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -4963,7 +4963,7 @@ static int cas_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 					  cas_cacheline_size)) {
 			dev_err(&pdev->dev, "Could not set PCI cache "
 			       "line size\n");
-			goto err_write_cacheline;
+			goto err_out_free_res;
 		}
 	}
 #endif
@@ -5136,7 +5136,6 @@ static int cas_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_out_free_res:
 	pci_release_regions(pdev);
 
-err_write_cacheline:
 	/* Try to restore it in case the error occurred after we
 	 * set it.
 	 */
-- 
2.17.1

