Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E355AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B970E206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzdyYWsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbgF3NwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388477AbgF3Nvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EBAC03E97B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so18905547wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSh3DJM1KgVnqn7Sv/MtEFwOqhHf99gGKru6VjHaA6Q=;
        b=bzdyYWsfGs9+EldNffhY0jZ/Xs/sS8GuliDUstrvPp9uYq6bQ/V5+lA5ZwfBeDmWm/
         i8m0UsGubprm9i/yZvA4l4TgVUivXrQfprf8t059FkPOjiDcVyjmQj8nOvJOixgrjgpL
         FgH1DuWJLz1B7oW2UybhBcX1rRi30VWbI7HNOqyD8U3YHbd/OvtJJjaqHU16CPtbGbve
         G+Ixv8V2cY2+TJvAIDBBSQPtk37vfanmlq7o41evKhr+kwCbKrEhwKj01jrnZTx6sWMx
         wSWW5htUaAUZrogFsTAnp32Egcjm7dxxxbBN/B1F4FDgSK+guhmaftONIhiv02gc+XuP
         svnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSh3DJM1KgVnqn7Sv/MtEFwOqhHf99gGKru6VjHaA6Q=;
        b=sI7cYv80kEzon1v1YR/dAJlxTJAFnRA5WMlysfoh70uVkSlo8gYkqpRi7PZUDHrg8w
         A73yqC8EI0CI63G+X6U83dWGEdzt8dsVwuJBHwuE9hZGfqmqXc9ZrGAJX4UgV0ptwsAS
         RQtGmRc/t+GXtsgcnodiGmlOArvbCjEtdaQGV7jzsfmtZt1aqy1LCsBQ1zr+teK3qaYD
         FYtsAQUkZsQ/oW27toEdxEuLdtnnSFtAxJfevRQEv8KhCksVkVPLmrSeZbH0TrzF6OxP
         jdGzt0DcNQuzFtU3C1HseMnW2u2CvKmJD6q2DF44nCOq4On9bLTFGdD9dGNUdI4ttOXo
         NZBQ==
X-Gm-Message-State: AOAM530DOnlcbGWz7islTDuKZxAZ3DJIMXcC8MEUd68vQc8FiMxdoaAg
        YZR4V8M4v75bPPb/tc+xuOovSg==
X-Google-Smtp-Source: ABdhPJydVK1MOk6qSoAzDSES+irwf5HdKi8xQQKwPP2tVuZl3KYPm79LNmnKWydLfpyDyImm9KJShQ==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr21460539wmk.39.1593525104998;
        Tue, 30 Jun 2020 06:51:44 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Steven Royer <seroyer@linux.ibm.com>,
        Adam Reznechek <adreznec@linux.vnet.ibm.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Dave Engebretsen <engebret@us.ibm.com>
Subject: [PATCH 29/30] misc: ibmvmc: Repair ill-named function argument descriptions
Date:   Tue, 30 Jun 2020 14:51:09 +0100
Message-Id: <20200630135110.2236389-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting is correct and descriptions are all present, but some
of the argument names are not properly represented in the
documentation.

Fixes the following W=1 build warnings:

 drivers/misc/ibmvmc.c:780: warning: Function parameter or member 'msg_len' not described in 'ibmvmc_send_msg'
 drivers/misc/ibmvmc.c:780: warning: Excess function parameter 'msg_length' description in 'ibmvmc_send_msg'
 drivers/misc/ibmvmc.c:1041: warning: Function parameter or member 'buffer' not described in 'ibmvmc_write'
 drivers/misc/ibmvmc.c:1041: warning: Excess function parameter 'buf' description in 'ibmvmc_write'
 drivers/misc/ibmvmc.c:1360: warning: Function parameter or member 'file' not described in 'ibmvmc_ioctl'
 drivers/misc/ibmvmc.c:1360: warning: Excess function parameter 'session' description in 'ibmvmc_ioctl'

Cc: Steven Royer <seroyer@linux.ibm.com>
Cc: Adam Reznechek <adreznec@linux.vnet.ibm.com>
Cc: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: Dave Engebretsen <engebret@us.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/ibmvmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index 2ed23c99f59fd..c0d139c265055 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -760,7 +760,7 @@ static int ibmvmc_send_rem_buffer_resp(struct crq_server_adapter *adapter,
  * @adapter:	crq_server_adapter struct
  * @buffer:	ibmvmc_buffer struct
  * @hmc:	ibmvmc_hmc struct
- * @msg_length:	message length field
+ * @msg_len:	message length field
  *
  * This command is sent between the management partition and the hypervisor
  * in order to signal the arrival of an HMC protocol message. The command
@@ -1028,7 +1028,7 @@ static unsigned int ibmvmc_poll(struct file *file, poll_table *wait)
  * ibmvmc_write - Write
  *
  * @file:	file struct
- * @buf:	Character buffer
+ * @buffer:	Character buffer
  * @count:	Count field
  * @ppos:	Offset
  *
@@ -1347,7 +1347,7 @@ static long ibmvmc_ioctl_requestvmc(struct ibmvmc_file_session *session,
 /**
  * ibmvmc_ioctl - IOCTL
  *
- * @session:	ibmvmc_file_session struct
+ * @file:	file information
  * @cmd:	cmd field
  * @arg:	Argument field
  *
-- 
2.25.1

