Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBC3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA9520866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqtBGyrS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgHNLnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgHNLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E167AC06138A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:04 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k20so7657010wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/mL6RqaAdBiLmuXVeHhJK3J3fsDrt9yKqZOgLAYFAw=;
        b=QqtBGyrStEAU+EDjLF4EzSj1gEM6DRPMeV7x1903UbO3EpPFG1JFPAQTSze1goS+qq
         XOhkvY830PVDitir20GP91+hgCD9Mwn8MfVpM310mjWrqwZyNZjM6ZX4Q9zGIQYeK8fV
         dwLS3JOv7qVRTh4ccwhI/PRSwDorU+9PlKI7Q3wWtq5LJyj3vJmcdEXOZFka1MhhepBF
         JQGrYsaZL1LP4JCDr+xjUYct0pJRhq7fcR0H4CVYbymxeg7kSyoB0kDWtMJkQt2tz8hW
         /3Roj44jhR0rscPXmkFkOQcloO7ZSVRL7Oj1wk0CElTEQY4yJfszYtqUaP+0mUSGmPUh
         OJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/mL6RqaAdBiLmuXVeHhJK3J3fsDrt9yKqZOgLAYFAw=;
        b=dVOgbZaDzuYKLdPCHyGxcXgJXON0QwsWsKINmqFUrTOAOveFkvvLWrNkr7GYIRBN8j
         NCW1AXI41wJ1snP+1E9dAyIr/P6iSIXV/N3l35ReeVtm/BAoNzoxbUbh0i21arXmhdt7
         ccuTQEm39ykC7CnGHr4HUBGKsEhMAtGgUUDsJuRJ4iRyFqSoHdfQzZ9J/9H09xLh0vlI
         r77Q+7VEoFe89sfaFA+8DB5s/Nhy2Tavn4ryzz/+qlk+szFgDRw1IUm1To2b3VIges8n
         krUZ7nsZY6gzbq3bkG/wr8e51C4Rh4T0nci4SYjDJmvQy/pz2wiOVNF3Rdi70yzxdr+u
         Nzow==
X-Gm-Message-State: AOAM531ztbJrHoW2tp0oWd2z38vemV/kIGtsrWfUNT0s485GWg2ptGiu
        xLvRKG26/IZ+Zf5tlL1etVwQTA==
X-Google-Smtp-Source: ABdhPJwadpwV0cMVShI8hxVfz4uE1ct+D58aY3i6FzV24SvCOAOYjR1k5+EDY64SlNSW+1v2bm9+Nw==
X-Received: by 2002:a1c:e0d7:: with SMTP id x206mr2372137wmg.91.1597405203683;
        Fri, 14 Aug 2020 04:40:03 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linux Wireless <ilw@linux.intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 14/30] net: wireless: intel: iwlegacy: common: Remove set but not used variable 'len'
Date:   Fri, 14 Aug 2020 12:39:17 +0100
Message-Id: <20200814113933.1903438-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlegacy/common.c: In function ‘il_enqueue_hcmd’:
 drivers/net/wireless/intel/iwlegacy/common.c:3126:6: warning: variable ‘len’ set but not used [-Wunused-but-set-variable]

Cc: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Wireless <ilw@linux.intel.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intel/iwlegacy/common.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index f78e062df572a..ff00c50db7c46 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -3123,7 +3123,6 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
 	struct il_cmd_meta *out_meta;
 	dma_addr_t phys_addr;
 	unsigned long flags;
-	int len;
 	u32 idx;
 	u16 fix_size;
 
@@ -3182,9 +3181,6 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
 	    cpu_to_le16(QUEUE_TO_SEQ(il->cmd_queue) | IDX_TO_SEQ(q->write_ptr));
 	if (cmd->flags & CMD_SIZE_HUGE)
 		out_cmd->hdr.sequence |= SEQ_HUGE_FRAME;
-	len = sizeof(struct il_device_cmd);
-	if (idx == TFD_CMD_SLOTS)
-		len = IL_MAX_CMD_SIZE;
 
 #ifdef CONFIG_IWLEGACY_DEBUG
 	switch (out_cmd->hdr.cmd) {
-- 
2.25.1

