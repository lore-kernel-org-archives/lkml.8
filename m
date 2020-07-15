Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D80C433F8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A543020672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZ/TT1t8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgGOPG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgGOPGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:06:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1556C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so3039944wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IfYptBKxQvrYFn67V4A+QmgFkUNV62He06/dIZhBEjs=;
        b=KZ/TT1t8CLQwqRlkcCPqM5ZK4eIUzF122chFSiLAFw9aUgHkXoJwedsjFUWNkqBK8w
         xoB4tfqJRd7SZyxqiKTR0kyAIdXPlACO3EGTzoXFXhuypYOk/pAabYnC9cCRagJh7ra6
         ys8mn2pnkIg3p3UpxtX1bwTvZquhEm5FSmtxNhh0OL5NHOsLK1CSoHoAZKQZe3U63AC6
         kWdU4mIEZiRg7ZLXpgfvBAeuZbFLsSu/s8OANq5iu9F/gUzRFCpo8TyvZzhRXipVMsh/
         W/JWNHB7R1SpSzw5769jWnV7f2oaRtgeMcQNpgQUwUsncIOaqTP5xM4uwZc4qtUaYnV4
         /oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IfYptBKxQvrYFn67V4A+QmgFkUNV62He06/dIZhBEjs=;
        b=Pr/m7HJr3m22bEQDru8UCuxwXVZEzOBYG54+FiWw2q1UpmNZkBIx1VV4iOQ6vge1Qa
         92c2VDN9p84CJNOrfq7zdwBsYZFK0wHxz1Q9U4+qfnKGW5isXWGH8T1S/fd9UmpTv5AV
         WbmYMOQmKyS9IqTAP1kVuEBZovGhqwDEACxYpo3km+6CeByqoIXXA98Y9tdXvgsg3ZxS
         BF7fTxwfRqW4oPx3kB93vXNXq1je62DtS2tIGlWfoiupIoDvTSkAy009z3yullH0DG44
         5SuBp8wHH4aptYkRiKzTS8tNzwgWzU4qp05Y1tpiLgibESN731wVzeyH9m23SyJ0xPPH
         tRCQ==
X-Gm-Message-State: AOAM533aA7oVdIzkC0/9Z3QDWlRmk02/7yWXY8eL4ARsUmf6oblA/917
        6OJZ++S8Pf6sF6HAZprzwfbcHg==
X-Google-Smtp-Source: ABdhPJxrrdTj/aQFIMBJUj58shw/EWz9k6o034iUJPO0GSeP71Qz7tMabUEkuVxpSHB3KuZgJnnDiQ==
X-Received: by 2002:a5d:4992:: with SMTP id r18mr11145302wrq.323.1594825608304;
        Wed, 15 Jul 2020 08:06:48 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 10/14] spi: spi-zynqmp-gqspi: Correct a couple of misspellings in kerneldoc
Date:   Wed, 15 Jul 2020 16:06:28 +0100
Message-Id: <20200715150632.409077-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Function parameter or member 'slavecs' not described in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Function parameter or member 'slavebus' not described in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Excess function parameter 'flashcs' description in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Excess function parameter 'flashbus' description in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:902: warning: Function parameter or member 'dev' not described in 'zynqmp_qspi_suspend'
 drivers/spi/spi-zynqmp-gqspi.c:902: warning: Excess function parameter '_dev' description in 'zynqmp_qspi_suspend'

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 811c97a7c8589..e17a201252557 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -197,8 +197,8 @@ static inline void zynqmp_gqspi_write(struct zynqmp_qspi *xqspi, u32 offset,
 /**
  * zynqmp_gqspi_selectslave:	For selection of slave device
  * @instanceptr:	Pointer to the zynqmp_qspi structure
- * @flashcs:	For chip select
- * @flashbus:	To check which bus is selected- upper or lower
+ * @slavecs:	For chip select
+ * @slavebus:	To check which bus is selected- upper or lower
  */
 static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
 				     u8 slavecs, u8 slavebus)
@@ -892,7 +892,7 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
 
 /**
  * zynqmp_qspi_suspend:	Suspend method for the QSPI driver
- * @_dev:	Address of the platform_device structure
+ * @dev:	Address of the platform_device structure
  *
  * This function stops the QSPI driver queue and disables the QSPI controller
  *
-- 
2.25.1

