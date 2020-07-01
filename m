Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B042C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0336D2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YWyZqyZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgGAIcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbgGAIb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CC8C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so22823333wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSh3DJM1KgVnqn7Sv/MtEFwOqhHf99gGKru6VjHaA6Q=;
        b=YWyZqyZbkcNrbyQVyAUxMI0wwgCyNlPNHUdv9Mx/Cyo78XQZh2bp6Y19j5UHSMEPWm
         54Q/C4y7AeRu4rcb7n+g38vung1Csq99dO1t/39BYvN/6U2IhiJ97gUa++kN8qbXHkl8
         Q6xxZN/E8wBBGarHvXnD5vm4YG0cjeU/p88Pn2YP9j2TQI5wBBQ9/t7sion9VymjNkfs
         LP8wRv4cihDSgRxULe2NRUe6wy/qePVPdvnN/j5dc82RZQhJnDrTE4gXxPPLQY1NWXVa
         JkdPfV0Z0f9H2+ca1I0p5kNv25soMsKpxSrI1IVAb4DE5IwgaAoDVavFqQ2STYmB6mV4
         z1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSh3DJM1KgVnqn7Sv/MtEFwOqhHf99gGKru6VjHaA6Q=;
        b=qOEEgSGuNlTa74NUXrf3zAaIG/0fpyKHHf3gEi3GWxNMi6j+N47JOuTlEh1NCfJvXj
         pydm7tdVwjwWvB5InMP2FaWPcg8jVC+TILNx/vFk49+glon0BQq8M0lKPLbiZFGucVqT
         VI8shF/mgN2/esjuU+90fYQlUj3P/O0/zVgJZFU6razGHUC0nXLNlMnMxeVDBocQL+vN
         GAUKhNBzd58Onc28bwW1tLY10Tm9Nv580oX3vAHyyrsdPm4karCgnoH/IR9wgYn5eEM+
         0TKNBmCvYDBR4uYCiflvP9eT3y7AMNuo+w2MZwb9t6VZAqnrw5iBacGSYcUQPcR1QHo5
         wkxw==
X-Gm-Message-State: AOAM532CCHntCKh11BUtZu64FSZVIINyDVTcBju8gnLXrxZGx0FUw32R
        HXmSE+OwEYLQNdSp5vdNry+Ubg==
X-Google-Smtp-Source: ABdhPJwHiT0jZiOjJE2XaFjQe7ksoR0dinpjyMRHcUvGD2Joalo1kPgarhqPpws8PxY//wdGBWqWIA==
X-Received: by 2002:adf:e98f:: with SMTP id h15mr27904610wrm.25.1593592317834;
        Wed, 01 Jul 2020 01:31:57 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Steven Royer <seroyer@linux.ibm.com>,
        Adam Reznechek <adreznec@linux.vnet.ibm.com>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Dave Engebretsen <engebret@us.ibm.com>
Subject: [PATCH v2 29/30] misc: ibmvmc: Repair ill-named function argument descriptions
Date:   Wed,  1 Jul 2020 09:31:17 +0100
Message-Id: <20200701083118.45744-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
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

