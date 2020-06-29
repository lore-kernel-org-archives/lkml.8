Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85700C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6C42065D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q366rras"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgF2Syu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbgF2Swv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEA9C00F816
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:32:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l17so15223812wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NcJWzHYOpdeqh8qGaDVcQ5xRq4JhsD2PhceqG1yeYgA=;
        b=Q366rrasZM+J0LbW/35YiKvihiuoapb6NfN+Zb4zZsqCvq9+SkLa23MzIyUfk8kh5e
         Tfzz+oPvckK85IfjKcsT2gzRYKGkjA9x48l/nKQyaBoJf04WdVxDuu5uycO/0JeIVv7l
         lOtSMb0HK9cCkVoeyc2/p1hyWjQjR6EecqDrCwB0F4vdpGgomiwLq5Ge5NkeB38l2s9p
         /RPpmnw26+sNuVt41FF5MJ94lR5+1+dlEqGMEV38RM0R9mtgMDHgqIuG7D8kGbWJx/HQ
         SSsL2oC165G4yp4HZa8wpyhQ42TMENenXjRufPEz16j5xH7YcPE37CvTwtIEREwDv7Hd
         yPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NcJWzHYOpdeqh8qGaDVcQ5xRq4JhsD2PhceqG1yeYgA=;
        b=VVfZILbmcYV9fQiQV5z8I8TnZ9+XyDXuZXU7KxXdwaZRIbBfSI2OSnpm/dPlIsJAEZ
         eIDK9JpwpeqQYVQIggcCwb5F0MqWtyI1Z2pIhoedBfoEFHOYN4L+NnjrGZ+cHi/FgmdR
         NtAcWSa+8msGj72nvf3PKBYa43rT0CfpvoDx4U0ju9WCMqrDADNGumNKKmVz48d9CJoE
         BV/64gf8361wpNpIJPdCWjTIkEhs5MRjRcGDfrjV68h1Ekw+35nsxCynB7LTq3ckOWXT
         XMBuIP3/9qRexse2jcc9lVP3hIgS9cnndMlrXNySiSpkJ963TKXc5bNIw0bPLLMnNReI
         CpqA==
X-Gm-Message-State: AOAM531eKjYHkD/X5AlmfDqtLVjzS3HwM/Osh86Af3GVR2l4VrPPXSg7
        pb7tl5dD2z44NJn4IeFDPgkjRg==
X-Google-Smtp-Source: ABdhPJx4+0k8HqfmTYlIin6K3HPVFB67u5CbChkf/P40Ljl2tLMP9fSC9+ZutsjMFevxWA0Kb++IlQ==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202mr15608911wme.64.1593433940462;
        Mon, 29 Jun 2020 05:32:20 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id d201sm28064111wmd.34.2020.06.29.05.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:32:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 1/5] mfd: si476x-cmd: Add missing documentation for si476x_cmd_fm_rds_status()'s arg 'report'
Date:   Mon, 29 Jun 2020 13:32:11 +0100
Message-Id: <20200629123215.1014747-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629123215.1014747-1-lee.jones@linaro.org>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc syntax is used, but not complete.

Descriptions are required for all arguments.

Fixes the following W=1 build warning:

 drivers/mfd/si476x-cmd.c:907: warning: Function parameter or member 'report' not described in 'si476x_core_cmd_fm_rds_status'

Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/si476x-cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/si476x-cmd.c b/drivers/mfd/si476x-cmd.c
index 0a40c5cb751db..d15b3e7833692 100644
--- a/drivers/mfd/si476x-cmd.c
+++ b/drivers/mfd/si476x-cmd.c
@@ -892,6 +892,8 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_fm_seek_start);
  *                rest RDS data contains the last valid info received
  * @mtfifo: if set the command clears RDS receive FIFO
  * @intack: if set the command clards the RDSINT bit.
+ * @report: - all signal quality information retured by the command
+ *           (if NULL then the output of the command is ignored)
  *
  * Function returns 0 on success and negative error code on failure
  */
-- 
2.25.1

