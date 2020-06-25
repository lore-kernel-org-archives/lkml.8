Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD43DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3CC206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ygOQGNld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406226AbgFYQby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406208AbgFYQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:31:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB73C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t194so6588816wmt.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y53vRxEwQ50K5Q0PMsRsFAgyQQXwXSqIk0yKzOk+/Yg=;
        b=ygOQGNldRss3ZrXxaWpr3Kq52jwGWchTxUrLqhRwme27ejGnxmqjUyEo8F+4nxWkCA
         XKcxpasME/p10DALC6HMosS9zfa9xWOqQzHgCgayfs5qgPqbmoo4H01qdumnqvME1Kno
         J5C3fSWJhbBTMTSHHHUbxQmBWc/Uq1/gg6d+CHx+q7thEAzAc7+grbNmBIpNTjFvEmvs
         VxUcBbTnxq6X9/pVcBgtJ6XlbabnIAeujJwvhFSpuqJEYAR6xvthwEubPhjrNf+FEHjZ
         274vL/H0EhN37cbYCSfRwaHgSdxGzonJaBwwwB/6x4LXpzjloDtEN2QEXILZ3znXZjNI
         b/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y53vRxEwQ50K5Q0PMsRsFAgyQQXwXSqIk0yKzOk+/Yg=;
        b=UvNBDJfj0Nw3U5/Jr7kz3CBOYJZrHO4VkhTICFrVTUMpDkIk32XYuX7f6DKv1Jn0rk
         DBpVmiX/5pw2Bm4Bx6ngLvH9fv41hWslOTX7TSOeASyE/YGo644H76rI+P3TDdWu+GXm
         aNM9HcuBL6fJYAHc7reCLkvKGwfKFYyg7EPJbYzjpt0yzSFBW4maQduZJ25EW1Vq5muC
         8zKrB/cGDg0/ZTLVpiiM5AZbEURPb+qBnapOuTbxWzR3FYkbNxTAki8cUdKdwEYJE3TG
         REGf3Yh3Y1QmSqQq0fxdaoCk/n1/tMFI/+H1BiJjQnw07GFlN34Du95DzvrIXB4XDVLq
         DyeQ==
X-Gm-Message-State: AOAM532/EaQDRboDXeHsUsFr9s5T8WKAEg0uywUrxBS1wlrPyQWup+1e
        TrmPIe9yASXuHRDMecooBEBS3w==
X-Google-Smtp-Source: ABdhPJxVlcey9CUUrRsBfa+vrJu/ehTYMV9CuIPvXnAb/B4gjmZE8r9aXK80SK7xubjTyX0cSXma/g==
X-Received: by 2002:a7b:cf2c:: with SMTP id m12mr4286288wmg.70.1593102704141;
        Thu, 25 Jun 2020 09:31:44 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id l8sm32090847wrq.15.2020.06.25.09.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:31:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 10/10] mfd: si476x-cmd: Update si476x_cmd_am_rsq_status()'s kerneldoc
Date:   Thu, 25 Jun 2020 17:31:27 +0100
Message-Id: <20200625163127.4000462-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163127.4000462-1-lee.jones@linaro.org>
References: <20200625163127.4000462-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4 of the old arguments were grouped and moved into a struct which
is now passed as a pointer instead of the arguments themselves.
However, whoever carried out this work forgot to update the
function's kerneldoc header.

Fixes the following W=1 warnings:

 drivers/mfd/si476x-cmd.c:746: warning: Function parameter or member 'rsqargs' not described in 'si476x_core_cmd_am_rsq_s
 drivers/mfd/si476x-cmd.c:746: warning: Excess function parameter 'rsqack' description in 'si476x_core_cmd_am_rsq_status'
 drivers/mfd/si476x-cmd.c:746: warning: Excess function parameter 'attune' description in 'si476x_core_cmd_am_rsq_status'
 drivers/mfd/si476x-cmd.c:746: warning: Excess function parameter 'cancel' description in 'si476x_core_cmd_am_rsq_status'
 drivers/mfd/si476x-cmd.c:746: warning: Excess function parameter 'stcack' description in 'si476x_core_cmd_am_rsq_status'

Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/si476x-cmd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/si476x-cmd.c b/drivers/mfd/si476x-cmd.c
index 5b42dfab431a3..0a40c5cb751db 100644
--- a/drivers/mfd/si476x-cmd.c
+++ b/drivers/mfd/si476x-cmd.c
@@ -729,12 +729,8 @@ static int si476x_core_cmd_intb_pin_cfg_a20(struct si476x_core *core,
  * si476x_cmd_am_rsq_status - send 'AM_RSQ_STATUS' command to the
  * device
  * @core:  - device to send the command to
- * @rsqack: - if set command clears RSQINT, SNRINT, SNRLINT, RSSIHINT,
- *           RSSSILINT, BLENDINT, MULTHINT and MULTLINT
- * @attune: - when set the values in the status report are the values
- *           that were calculated at tune
- * @cancel: - abort ongoing seek/tune opertation
- * @stcack: - clear the STCINT bin in status register
+ * @rsqargs: - pointer to a structure containing a group of sub-args
+ *             relevant to sending the RSQ status command
  * @report: - all signal quality information retured by the command
  *           (if NULL then the output of the command is ignored)
  *
-- 
2.25.1

