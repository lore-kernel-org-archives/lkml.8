Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD8DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078E620775
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKUkNpo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgGAIbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbgGAIbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63776C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so22875224wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PcEwXK0xNmm8KLbdljUMIqWDcW1MZg3tkSRXZHPr9pQ=;
        b=HKUkNpo9vZeR1wPNruo124x3iRX3AH1yy7GJIK84RDR8oSoS239+0BwsmlcbIqIlRN
         RtXQklp2FthcBlrU4aYuXzZmm7ayRFvc/fbVkV/kj9t51P9BGcslEh9bTJFtMl0QDcUO
         hPa0ujaajnLgiu9fV2N1W1x9mfEhAAH3zM4CCJTZE4TmjN9a2EQnn2tyZgRGhqetHUiq
         k/wijNDQEmuBEBjoHXDtI8SfnhMSIjUIz0yxceXPN0UHG2yKUF5Dpv+BQqWL2uZqGNzF
         GKy32q/avxJwakLI58S9H70IPkapev9w6iTWTw7dC5WgXGpjZjez16E9aB9f16TOY1iw
         e8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PcEwXK0xNmm8KLbdljUMIqWDcW1MZg3tkSRXZHPr9pQ=;
        b=j1B84PklbIxqfLTNDFIh33O0RT3VP2Xeha09h+CYAYSSal+/JHFdMDK5LShQ5Yr9Ao
         sVcN/XNeQeqRTZ4NyE++J+G2lPHTj3rGEtkcBIURl9r+/e6sqrBMYnUW4IBa3uQW5iIu
         XmoScd7JYG6gKuIz3PQCPjUlamBRouE1M9QFFgKcWJHkrm9//gbRgoQBlCVKLVyTg+pc
         deCmaB2hJUpfxOsRWXUBEOCDKbFcg5tbAgulEr9QdGlsdFjC/41yXB/bw0TToitYOjo9
         vyUlBvABk64lq6h9SvTBqi270JZitsrWi6qRpcVX+15cRfC8gZGwRZptng1jy4wrsJgi
         bMJA==
X-Gm-Message-State: AOAM532ChZktBnEESsyVBh46grom8GHZNJA886tZJLFGxszJgj26dh7h
        3zjVqcex4YWiBxHzyaREyVIfmg==
X-Google-Smtp-Source: ABdhPJzdCeNIH5rNsVOqwSrT8Zr3ilbP/u+ZjoK8VzK6ZT8fzE/g5XN/TdkygYCbssiT6pMAl6S6vA==
X-Received: by 2002:adf:9062:: with SMTP id h89mr23820392wrh.285.1593592298146;
        Wed, 01 Jul 2020 01:31:38 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH v2 12/30] misc: mic: host: mic_x100: Add missing descriptions to kerneldoc headers
Date:   Wed,  1 Jul 2020 09:31:00 +0100
Message-Id: <20200701083118.45744-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 warnings:

 drivers/misc/mic/host/mic_x100.c:127: warning: Function parameter or member 'doorbell' not described in 'mic_x100_send_sbox_intr'
 drivers/misc/mic/host/mic_x100.c:148: warning: Function parameter or member 'doorbell' not described in 'mic_x100_send_rdmasr_intr'
 drivers/misc/mic/host/mic_x100.c:511: warning: Function parameter or member 'dma_addr' not described in 'mic_x100_smpt_set'
 drivers/misc/mic/host/mic_x100.c:511: warning: Function parameter or member 'index' not described in 'mic_x100_smpt_set'

Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/host/mic_x100.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/mic/host/mic_x100.c b/drivers/misc/mic/host/mic_x100.c
index 843ce13750158..f5536c1ad6071 100644
--- a/drivers/misc/mic/host/mic_x100.c
+++ b/drivers/misc/mic/host/mic_x100.c
@@ -121,6 +121,7 @@ static void mic_x100_disable_interrupts(struct mic_device *mdev)
 /**
  * mic_x100_send_sbox_intr - Send an MIC_X100_SBOX interrupt to MIC.
  * @mdev: pointer to mic_device instance
+ * @doorbell: doorbell number
  */
 static void mic_x100_send_sbox_intr(struct mic_device *mdev,
 				    int doorbell)
@@ -142,6 +143,7 @@ static void mic_x100_send_sbox_intr(struct mic_device *mdev,
 /**
  * mic_x100_send_rdmasr_intr - Send an RDMASR interrupt to MIC.
  * @mdev: pointer to mic_device instance
+ * @doorbell: doorbell number
  */
 static void mic_x100_send_rdmasr_intr(struct mic_device *mdev,
 				      int doorbell)
@@ -503,6 +505,8 @@ static u32 mic_x100_get_postcode(struct mic_device *mdev)
 /**
  * mic_x100_smpt_set - Update an SMPT entry with a DMA address.
  * @mdev: pointer to mic_device instance
+ * @dma_addr: DMA address to use
+ * @index: entry to write to
  *
  * RETURNS: none.
  */
-- 
2.25.1

