Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8401AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5863E206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIAErbA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgF3NxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388428AbgF3Nvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B38C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so18904779wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oA8RTovB0rd6yTwQFM7j/fT5zajZLuFIh0xLtIq5guU=;
        b=UIAErbA5c+2SMZ+wjP2jjX5s6AjjcaaAxML/0/lVekLqDa7u3dTrURRKA75hCWNmYg
         wtzMu/ZtLDLINdwqAlf8KtdzHF388IABv3nsxfqPua5jV4xeDRdVaT3Ytmaz1tc5xDWH
         QYVsNgqDAm6LQp+d0HSkJosNriujwdQmsVrMymBfIGblaaNqvduC27Pdzw/BlxENFEx3
         dRyMLxx0bcSZIEwod7ftiX3r1ofa4jbIGZF4VQ9G6crqLedLlnE9F5QWBn5lcS9NG5er
         EaDWLakcusn3lWrDIIAUDnufmxRM0RuYXPbUNf/jXX0E0aPPxlCquh9cb5dbfktfHXFI
         708Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oA8RTovB0rd6yTwQFM7j/fT5zajZLuFIh0xLtIq5guU=;
        b=SFr5zmhjRzCyAgFGAgx7k9xQZpadExelEIPVLmbhkSPB0O/LjYggQVPUPKmirqS13V
         bhPDe5zU0SbFLzcT0v2AEFhslknum4UB1qrh4tTh0w8Zku1wCEmG6Sj12P+hyasChf26
         UI6SvgKH7pPGlcx1IKybtQAbakwbYHdH2AIXJthKONHDS092gymzbGmykfGNuuZq9jSq
         7a1IIUT2u84HEEa2wbJyLViJ8Sb4IFJYYMYF4F3pTtNzg5WIAlqbXuoAxI3fS9scWT3X
         pr6gqwpwdojSkIp52hPPFEOTiluyM83q48Q7DWqYEfe+MYiUnpQN+mW9nzOBTLCZIRIN
         KLNA==
X-Gm-Message-State: AOAM530iJUWd1m/CVDZQctdSOY9Ko4icqGkXtlJvHs4hcTTOTk84N8un
        3mRPhxL3X6loKsymMO9gN94kaA==
X-Google-Smtp-Source: ABdhPJwwBQaKJSpY60ja6PdGUXZLEsscFN3/NRLrOYALfhdPnliSxjMd73lWq+QUHPqsPmJ0PYqLMw==
X-Received: by 2002:a1c:4343:: with SMTP id q64mr21699175wma.20.1593525090438;
        Tue, 30 Jun 2020 06:51:30 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 15/30] misc: mic: cosm: cosm_main: Document 'force' function argument
Date:   Tue, 30 Jun 2020 14:50:55 +0100
Message-Id: <20200630135110.2236389-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning:

 drivers/misc/mic/cosm/cosm_main.c:31: warning: Function parameter or member 'force' not described in 'cosm_hw_reset'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/cosm/cosm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mic/cosm/cosm_main.c b/drivers/misc/mic/cosm/cosm_main.c
index f9133c4f61050..ebb0eac43754a 100644
--- a/drivers/misc/mic/cosm/cosm_main.c
+++ b/drivers/misc/mic/cosm/cosm_main.c
@@ -26,6 +26,7 @@ static atomic_t g_num_dev;
 /**
  * cosm_hw_reset - Issue a HW reset for the MIC device
  * @cdev: pointer to cosm_device instance
+ * @force: force a MIC to reset even if it is already reset and ready
  */
 static void cosm_hw_reset(struct cosm_device *cdev, bool force)
 {
-- 
2.25.1

