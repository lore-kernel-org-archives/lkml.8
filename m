Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD7DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A11207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iqk00Hmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgHSH3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgHSHYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:24:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB09C06135D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 3so1128976wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpJGFhZ7lq89b4fQU2CLX0YYZznNJZa5+dtW6ao3V6o=;
        b=Iqk00HmxZ8Mpvy4BTJaRHdTxttDSNzpXR+o0P4CYh1ddH0KA4qMBY/RzGUF29Y6aA7
         A1EngZDMXBwYH/uO49VL1P7tk4cjoPr2LJivX3cfMJEE9cb37TfS+Clr2503UX1aQl+F
         BztKMijeXNXYbqsn8QgxrPTs9iF3rNfk7rK8Up7GBPQgp7O4cUj6HDjAvyM44llimqfc
         UL+uVUUxVUCdDdW6Xitpfm1LMVpoxaJHjUpeDmeCUOw1fJSn4zQ7gC7fuOyvjH7TpVrB
         9tjLpn968CSNyPMTI7u576U5AEwLYp3En9kZJYz/djWvK9xYiXX6HNZK4vDruJ//nO7X
         ZzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpJGFhZ7lq89b4fQU2CLX0YYZznNJZa5+dtW6ao3V6o=;
        b=OLJA/cSe70orn1yvvD5501L5owuR0ZfnRCYhg56fEVY6+0ZefYwWRP3UXkPjuCJvDd
         tTPlvtDj0AzheckIEvZ6EdUQWErwVL3kSlaxk88RAinVeK25f4d2LyGswjIzNdy5WhLQ
         im03RMbXiYB+lf3C3XHpOJITf5nTJaq63/wwpZWtdLn1BHKpAN7Z4OYlV6Z7yM8pWJgP
         cPVv8+/Ucazs1P9RG56Z9Iq3SExql9sUbm1s5es2zKyDCozCt2FILj4m1jD5pzS9CIYk
         QWrR5ndDR8SV6Xzm4T8PAVYnn9SeqwXM31TBdYVnqSs4lZ/juaeqviRA5E0sNxlv8FZI
         AHLA==
X-Gm-Message-State: AOAM533UQ9DuxlFpOZBYGa0475C+SOY5oaneJ/CZpQwKyGFtVmE64GkP
        Yqfi/JeSAlkml6hfSR6+4GqGCA==
X-Google-Smtp-Source: ABdhPJynxqpv1c3Pu0O7jBCGNAOoBJesUsfT7ytpD9b/jegM7Im9l2oUkdCWae9Niy8MnRKN6umV6A==
X-Received: by 2002:a1c:ba42:: with SMTP id k63mr3410582wmf.31.1597821856532;
        Wed, 19 Aug 2020 00:24:16 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Linux Wireless <ilw@linux.intel.com>
Subject: [PATCH 09/28] wireless: intel: iwlegacy: debug: Demote seemingly unintentional kerneldoc header
Date:   Wed, 19 Aug 2020 08:23:43 +0100
Message-Id: <20200819072402.3085022-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only use of kerneldoc in the sourcefile and no
descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlegacy/debug.c:1373: warning: Function parameter or member 'il' not described in 'il_dbgfs_unregister'

Cc: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Wireless <ilw@linux.intel.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intel/iwlegacy/debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/debug.c b/drivers/net/wireless/intel/iwlegacy/debug.c
index 4f741b305d964..d998a3f1b0566 100644
--- a/drivers/net/wireless/intel/iwlegacy/debug.c
+++ b/drivers/net/wireless/intel/iwlegacy/debug.c
@@ -1364,9 +1364,8 @@ il_dbgfs_register(struct il_priv *il, const char *name)
 }
 EXPORT_SYMBOL(il_dbgfs_register);
 
-/**
+/*
  * Remove the debugfs files and directories
- *
  */
 void
 il_dbgfs_unregister(struct il_priv *il)
-- 
2.25.1

