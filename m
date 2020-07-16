Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21E0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 728CC206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4oAcF1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgGPO24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgGPO24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:28:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B1AC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:28:55 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so10499315wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6JRMdst6t7X7TTp06c6DTXphcwzBl33/L2DKEvEWMHo=;
        b=G4oAcF1WPTVdBIfQ6w4eXULeQ2T9EmAs2gdHdIkD85BVqmrgSroOjiHjaFRsNv+ONM
         11SpMBLH/32DcLe9/3OQXSFB+QpMyeh4A85hOTFlfBLndrUMQsln2TLZb+JGTaqqXxwW
         +nzB3p7n7MfL+bs62aknL2LPN3THFvneyLQNSNP6r2AdyEAxBS0ccFGXCF+90nu8kPVB
         e7oJqVZly8pPKFcbyYVTz83UsmhekrwEWFp4gtJS3xKSKtZuefKVn5dnPQrKK5z12g8W
         RDlsa0GC5XuWSi8r/5uXG0jkIlJwEjipOecoOCQ1Qfj8ZgU76eHA/fcSA1kHagm1A2sU
         BqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6JRMdst6t7X7TTp06c6DTXphcwzBl33/L2DKEvEWMHo=;
        b=F8jWSwo+G7MkPhM/jbWY30CUgKSBYzjuYUu7gPlXhch/M80w/evddjWiMUi97Ji2ZW
         GvGWjbWSJGp86Hnw9rGbTiBmmUQVRWcbNAFuvh2m2RrC19z6FBsG1PWU9CAr91mY21ME
         jpbLrWqzHdpn34I7zq4nq1dKuF9MY3eMMtofbLPQgJMC58WWNjp06PezfyevKAbU047e
         Q4z3Z8dLNO38MtkDwJBbg6QBXoveUiDTlIxcTV55BjHFC2y0O0R91ek9rX45WSIDSJ7l
         NncppHkGYpRDi17y2L5wH+Bugiz6wyVpyXLGpTiTnQTxceTZVkSDiJFHXnkCBuYA8YF0
         H8AA==
X-Gm-Message-State: AOAM532u1eJfU+R1DIbuWEsp2p7gtZ7RUw91VoQRRnLkcdz6z5tAaFwY
        /mppZgnHMDzyezl/Sga0P2tH6w==
X-Google-Smtp-Source: ABdhPJyHD8zrYi+EFetvc8uxd6vCIsnhmVFTMZ1dM9PRcghcTi/sTsarwrSdkE7Ex8nZ31dAkNCURg==
X-Received: by 2002:a05:600c:204d:: with SMTP id p13mr4584426wmg.88.1594909734319;
        Thu, 16 Jul 2020 07:28:54 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id 59sm9749215wrj.37.2020.07.16.07.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:28:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mfd: core: Fix memory leak of 'cell'
Date:   Thu, 16 Jul 2020 15:28:51 +0100
Message-Id: <20200716142851.1669946-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating a platform device from an MFD cell description, we
allocate some memory and make a copy which is then stored inside the
platform_device's structure.  However, care is not currently taken to
free the allocated memory when the platform device is torn down.

This patch takes care of the leak.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mfd-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index f5a73af60dd40..e831e733b38cf 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -297,7 +297,10 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
 
+	kfree(cell);
+
 	platform_device_unregister(pdev);
+
 	return 0;
 }
 
-- 
2.25.1

