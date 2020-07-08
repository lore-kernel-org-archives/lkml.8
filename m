Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F9CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E2E20772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oE7zSyqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgGHMER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbgGHMCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:02:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE659C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:02:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so48641522wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+pt3rF/aF9MXBxaxOWkhoV3OTeQnwTFN7tbYNZX5zs=;
        b=oE7zSyqND80DYg6poQGupsJ8X6JD6kP5o9tqMqKexmIZ5T1XZjMpjTu+uc7XV6qG7C
         kgRV15okIHcFVrQO3kFLU1I/IukiFmYdYwspufNCTRM1gYnW9u4QQmEd4wNPjU9bXeY1
         4F54e1h99u1e3nHDUhuna8VpdSI0KEA8ciSGQSTWgQcJPnBXfHbNoj0+Myq6rxp/eRmo
         ykuFjG2I1w+jLuHT3F04K3g0Nc5DtiGlrm1JnI/1KFlsdjpK91/142ie+NT+ae16cS8T
         Ubys/GUaWZV1JQrnzxbGaWGDvtMlqqZ63FShQOSNGLNQQeM8svaxthO8fb8w6nQJAEyV
         APvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+pt3rF/aF9MXBxaxOWkhoV3OTeQnwTFN7tbYNZX5zs=;
        b=aN4w8AtQ7ysutz4VFym++QlU5avPsWr4/el0yusyE5c+nvjC4DAKuNo3/QiBgG/t1G
         iJzx0vAHEwaoetf5fyq5brgoLm7BCVST9nMlcQ8vVlyYhbbpQu034YCnkKnT4H6Np4Zj
         Yreynnw2z2eafOa3rPcZQsSQUTAutfZiPz0iLNeqj2X5eBZ/IcvCegCl5MDPRT5de0o9
         Tze+Pm7HRvKazwM1g5MfVAynyZit/Nrr4uX26AvOiJuIqpsOaqeKcXVsnZ/EMe+6WWpL
         VeXWOUeRzh9ndWaXQN7K5ySRZnlhXNQNYpNDutqy2klYm3jZY53yo+zk3iD9G+i6XE88
         iUUQ==
X-Gm-Message-State: AOAM5320TUIJAdk9Pthp5ykjEtyXilqV+pwncuvt+IoefA3mTA4Igpl8
        Ro4a2JJcVZt0q5l9Km3hl3IAPA==
X-Google-Smtp-Source: ABdhPJxURppvfG7DEhP9spdQjCHFBwUzs5wOqtlXraGeSTbxLP6VMc4VjMRGbCLjqZhSHFVRG8rCJA==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr60185807wrt.191.1594209765523;
        Wed, 08 Jul 2020 05:02:45 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:02:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        QLogic-Storage-Upstream@qlogic.com,
        Prakash Gollapudi <bprakash@broadcom.com>
Subject: [PATCH 14/30] scsi: bnx2fc: bnx2fc_hwi: Fix a couple  of bitrotted function documentation headers
Date:   Wed,  8 Jul 2020 13:02:05 +0100
Message-Id: <20200708120221.3386672-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708120221.3386672-1-lee.jones@linaro.org>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Likely a result of documentation not keeping up with API updates (a.k.a. bitrot).

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/bnx2fc/bnx2fc_hwi.c:493: warning: Function parameter or member 'hba' not described in 'bnx2fc_send_session_destroy_req'
 drivers/scsi/bnx2fc/bnx2fc_hwi.c:493: warning: Excess function parameter 'port' description in 'bnx2fc_send_session_destroy_req'
 drivers/scsi/bnx2fc/bnx2fc_hwi.c:1345: warning: Function parameter or member 'context' not described in 'bnx2fc_indicate_kcqe'
 drivers/scsi/bnx2fc/bnx2fc_hwi.c:1345: warning: Function parameter or member 'kcq' not described in 'bnx2fc_indicate_kcqe'
 drivers/scsi/bnx2fc/bnx2fc_hwi.c:1345: warning: Excess function parameter 'hba' description in 'bnx2fc_indicate_kcqe'
 drivers/scsi/bnx2fc/bnx2fc_hwi.c:1345: warning: Excess function parameter 'kcqe' description in 'bnx2fc_indicate_kcqe'

Cc: QLogic-Storage-Upstream@qlogic.com
Cc: Prakash Gollapudi <bprakash@broadcom.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/bnx2fc/bnx2fc_hwi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
index 8c0d6866cf3b8..e72d7bb7f4f42 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
@@ -485,7 +485,7 @@ int bnx2fc_send_session_disable_req(struct fcoe_port *port,
 /**
  * bnx2fc_send_session_destroy_req - initiates FCoE Session destroy
  *
- * @port:		port structure pointer
+ * @hba:		adapter structure pointer
  * @tgt:		bnx2fc_rport structure pointer
  */
 int bnx2fc_send_session_destroy_req(struct bnx2fc_hba *hba,
@@ -1334,8 +1334,8 @@ static void bnx2fc_init_failure(struct bnx2fc_hba *hba, u32 err_code)
 /**
  * bnx2fc_indicae_kcqe - process KCQE
  *
- * @hba:	adapter structure pointer
- * @kcqe:	kcqe pointer
+ * @context:	adapter structure pointer
+ * @kcq:	kcqe pointer
  * @num_cqe:	Number of completion queue elements
  *
  * Generic KCQ event handler
-- 
2.25.1

