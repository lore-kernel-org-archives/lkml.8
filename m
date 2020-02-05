Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F87C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5481F20702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMvfnoQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgBEPzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:55:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41235 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBEPzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:55:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id j9so1406796pfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1F3xjpehDBjF/Myx3pb+XfwnS5+rAD0AgER+Dd+bkYE=;
        b=ZMvfnoQzLVt2DEGa6vft0hPU6wagQS8qAwDVCZnLP3bjyrVwpqnEEeNZUj22GEDL/7
         SzqN7EsKAVx0hHfegN1V3efK+eCNoFM217W+ewOkx79251X6ZLVYx2iQNnq9B1ZHb079
         3tS6yNLxDs++k3xy3lDhBtkNxUfijLxo5hcXzxmpBSh4Dut+qDK+oId+S3fSfawjnD6+
         DL95KkbP/0XBkytWDW3ZFVzQSZsaGkID5J3bhJbRx7Dxn14e/aT7U42l4ToiNrojBQC0
         5SJTW9MszrPyxNpDOJKEeamhPMoIY576NWyrPH+rwrAKLSpUhvHMTOzRJaA7p2qC5agX
         n4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=1F3xjpehDBjF/Myx3pb+XfwnS5+rAD0AgER+Dd+bkYE=;
        b=njhisFNtyJdZJYySHQvwRF6Jn3kCjd52ABu6g+BvUSYHIswFEz1f5NOoP+Ab2MdOUi
         1SiWQhAncSg2L7sNeyUxl7ZrOrJ5qLCIfDfj73Pcz/KlTX99D2etqVjCTuWJ84iCa5D3
         n9biw7e630qeQIoNHJVza2ztUys34ChseALNCXZQ7RgST1ZFbd6fmelGl6KpzSabEYUI
         THy0XGBcM9uV7MERII6OOBSFmtrjRCZ1RY2KsxRD6J35nNZS+YrtOwPZZornn2zE6zjY
         M0XNSS/NIRPdoCfLz40GF9Er3uKtScBXYxr9/qc5WXQEOpwFsXctESN4CMi8kb3zEFGJ
         QMrA==
X-Gm-Message-State: APjAAAVf7g0q4LXo2Gxh2OIQp5WJ1Q+Sz0pL1R/q5kV26+FeNLMoKzCo
        56gQ7C8+fUt0/rxrLGnKCKyofE1IOebOMw==
X-Google-Smtp-Source: APXvYqzX7pgchkRW2fMhsgy6vezMO4CqyRu90jou3aJWtF0l1U5UP9s2gbcCqWTsY+0qrIlptKHrJg==
X-Received: by 2002:a62:e414:: with SMTP id r20mr36831080pfh.154.1580918109339;
        Wed, 05 Feb 2020 07:55:09 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:55:08 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 07/15] NTB: remove handling of peer_sta from amd_link_is_up
Date:   Wed,  5 Feb 2020 21:24:24 +0530
Message-Id: <7239c2cfca73382562ba8c6579e262b308143304.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_link_is_up() is a callback to inquire whether
the NTB link is up or not. So it should not indulge
itself into clearing the bitmasks of peer_sta.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index b85af150f2c6..e964442ae2c3 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -253,17 +253,6 @@ static int amd_link_is_up(struct amd_ntb_dev *ndev)
 		return 1;
 	}
 
-	/* If peer_sta is reset or D0 event, the ISR has
-	 * started a timer to check link status of hardware.
-	 * So here just clear status bit. And if peer_sta is
-	 * D3 or PME_TO, D0/reset event will be happened when
-	 * system wakeup/poweron, so do nothing here.
-	 */
-	if (ndev->peer_sta & AMD_PEER_RESET_EVENT)
-		ndev->peer_sta &= ~AMD_PEER_RESET_EVENT;
-	else if (ndev->peer_sta & (AMD_PEER_D0_EVENT | AMD_LINK_DOWN_EVENT))
-		ndev->peer_sta = 0;
-
 	return 0;
 }
 
-- 
2.17.1

