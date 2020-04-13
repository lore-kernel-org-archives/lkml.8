Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD6FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0AE21D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRy1s7EG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgDMMOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729407AbgDMMOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:14:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE4BC03BC83
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 05:08:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id c23so4369079pgj.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BIBvMgUnvDgGZghMH04dMf9slrG7wjbl7QR/9HSXTJo=;
        b=uRy1s7EGEp8BkdEjZAQpmQo3cCodNSSvRaev6POOo+mew8bO4EAHrfOWQQCMqUIfiY
         tZZomzvqBubP3hpBJx91Tdt7UlfEGizPkNnPi08th3i0O5OFPQatYf26n4Im3rKwpkGr
         t8/MUJBK0cfSnwBxkBatfcLTOPDR+jrAR6UBZoq/c451VLHjzEDrv1ro4Qx2+27AVnC6
         2m8eIMS2J6shbLRpbcoIJFgG9Uk45VJDxRJwVk5uPLlVljS1M1Jvq0Qm/tKVOhqhaztq
         XwxsXZ08txZzy1uLTHGR0LTpgNi2Sf2ehPE3WQf8OYlML6Xo6KslCbYr0XiTty5KaEAA
         5PDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BIBvMgUnvDgGZghMH04dMf9slrG7wjbl7QR/9HSXTJo=;
        b=iExMwoRufWoOEUJPhY7irmRctgJHYedTjTy/aI69qMMMkcAqTSMaZ9tVEqRAHIu31x
         OhOwJvM18TufPeCFgkmpkhBBBkchXakvtd5LgfZ/AQg8ZnV7+bgXb4tfd6DS3wCqKgNZ
         AhcThz9XiHcnuOHFyyIqbRJFXP4ZOby++PBTPl9jC8Xt3UqifWVpf2DDKD02gC+wGSzV
         c8GXC4DqJ7u9KM3IzvswoEarYbeBooKJoMB6V9so5IISbRvEgxHez9LMg6Bf3aGbG0lP
         BQTZ0DRmBTmSYxZPafMUldrmfq6sl6oyp/DT08DS0zOvJqDcuTqqVzRZBt7Lcdl380rK
         +Tnw==
X-Gm-Message-State: AGi0Pub5IZDXaCm/1yLDm1oy8k3qBRelPB6dyDVc04sXpnQk84zfKype
        QC/EIN+sD3DyGZ6xl8rzurVA
X-Google-Smtp-Source: APiQypLIoeYk9G74CAvG8xdvpdDVlfoDimcpFm6oRfnwQBcwTRX6j+ysTHd1tHSRhBTGCvlmc+VtHw==
X-Received: by 2002:a63:2cd5:: with SMTP id s204mr16420791pgs.71.1586779684515;
        Mon, 13 Apr 2020 05:08:04 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:621d:5eab:c98c:e94e:e075:c316])
        by smtp.gmail.com with ESMTPSA id i187sm8493136pfg.33.2020.04.13.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 05:08:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     hemantk@codeaurora.org, jhugo@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        smohanad@codeaurora.org, dan.carpenter@oracle.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] bus: mhi: core: Fix parsing of mhi_flags
Date:   Mon, 13 Apr 2020 17:37:40 +0530
Message-Id: <20200413120741.2832-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the current parsing of mhi_flags, the following statement always
return false:

eob = !!(flags & MHI_EOB);

This is due to the fact that 'enum mhi_flags' starts with index 0 and we
are using direct AND operation to extract each bit. Fix this by using
BIT() macro to extract each bit and make the mhi_flags index start from 1.

Fixes: 189ff97cca53 ("bus: mhi: core: Add support for data transfer")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/main.c | 6 +++---
 include/linux/mhi.h         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index eb4256b81406..4165a853c189 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -1090,9 +1090,9 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
 	if (ret)
 		return ret;
 
-	eob = !!(flags & MHI_EOB);
-	eot = !!(flags & MHI_EOT);
-	chain = !!(flags & MHI_CHAIN);
+	eob = !!(flags & BIT(0));
+	eot = !!(flags & BIT(1));
+	chain = !!(flags & BIT(2));
 	bei = !!(mhi_chan->intmod);
 
 	mhi_tre = tre_ring->wp;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index ad1996001965..22185fecbbf2 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -53,7 +53,7 @@ enum mhi_callback {
  * @MHI_CHAIN: Linked transfer
  */
 enum mhi_flags {
-	MHI_EOB,
+	MHI_EOB = 1,
 	MHI_EOT,
 	MHI_CHAIN,
 };
-- 
2.17.1

