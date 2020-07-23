Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F0BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F042086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6b8PeJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgGWMZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgGWMZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:25:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0619FC0619E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so4783882wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=duCZHMtFtzXyExTB0Q+GFLV/xuB9l4Kwhqee+hE7dLA=;
        b=p6b8PeJsRy24yesc+jDHDCth5H78oH46TXSpWJZbKpx2gl2sHbf6+G4Zf3tTMTd5wG
         felIDQJm3gax6G04NzCKrDn3bPW0GP/sdmSkdMNWcDQf21x66X5T7xQGe9sh2TQub5S5
         BJE0FB+lKwSkoatc+Rl/X+vvcEZz9uDbV/g7WX5rWzcuO/qbZZ7GTxGYwvZBPvazZPVW
         R8842FCKWP7O2UtL3Zw0Hki5lNq/XRt/nVfLA9APCoLIrHLQEdUQet5LRcJDsfXwHEmo
         oUrP9MIaPgd2VY8yDP/KVBjjT0nGVVXk9aDYjnlFMdMVMrjVzXTS3Sa52EZ2386Qf6eO
         7oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=duCZHMtFtzXyExTB0Q+GFLV/xuB9l4Kwhqee+hE7dLA=;
        b=eTotqe5kSSOlWizSRgUsemMGko2HDU66dcOaRbXyMx6K9kpp1AbXbL4BS2FV3EbK9k
         kEMBym9mTIMV+o2LMPMel5dzpfqtfkjUgEjCQpdJ7PUzDhrNNVBW7kqhpiwxb7wvSK+N
         6kMQW1L3/yi6KiPyItpQ5Dqw6KZNFrDgyGgWocqcFCWzOWovr817dCKP8LXhby0ojl3Q
         9/NjpY5+jkZPdzFriiUTltz9wCoVwHNWRCQ7EFOVIpNxb38XZqF7tvLrbyV1jS6B+x/G
         ONqTeDIpssg5OuSueEu4ZgrGjAJ15ZAHB4B0K55q8h+QLhU/vJLEfFCd70BUXWzYF8uB
         AL1A==
X-Gm-Message-State: AOAM53016ZjkW+ItiAnFsC1ljEUoUTXsOqbgjDayuC0VEnukFnumFnI8
        MTUUgkuCWz1/uawY65mY2BC2Ud0F0f8=
X-Google-Smtp-Source: ABdhPJwoU/9ZYtQP3da4TAPZiJq17uJJDvfGmbb1oGeN6ilrPX5HaT+1czWksFkgqvlwrD0VhWgQQw==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr3922801wme.50.1595507127792;
        Thu, 23 Jul 2020 05:25:27 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:25:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        QLogic-Storage-Upstream@cavium.com
Subject: [PATCH 31/40] scsi: qedi: qedi_fw: Remove set but unused variable 'tmp'
Date:   Thu, 23 Jul 2020 13:24:37 +0100
Message-Id: <20200723122446.1329773-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723122446.1329773-1-lee.jones@linaro.org>
References: <20200723122446.1329773-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/qedi/qedi_fw.c: In function ‘qedi_put_rq_bdq_buf’:
 drivers/scsi/qedi/qedi_fw.c:355:6: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]

Cc: QLogic-Storage-Upstream@cavium.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/qedi/qedi_fw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_fw.c b/drivers/scsi/qedi/qedi_fw.c
index 946cebc4c9322..6ed74583b1b9b 100644
--- a/drivers/scsi/qedi/qedi_fw.c
+++ b/drivers/scsi/qedi/qedi_fw.c
@@ -352,7 +352,6 @@ static void qedi_put_rq_bdq_buf(struct qedi_ctx *qedi,
 				struct iscsi_cqe_unsolicited *cqe,
 				int count)
 {
-	u16 tmp;
 	u16 idx = 0;
 	struct scsi_bd *pbl;
 
@@ -381,10 +380,10 @@ static void qedi_put_rq_bdq_buf(struct qedi_ctx *qedi,
 	qedi->bdq_prod_idx += count;
 
 	writew(qedi->bdq_prod_idx, qedi->bdq_primary_prod);
-	tmp = readw(qedi->bdq_primary_prod);
+	readw(qedi->bdq_primary_prod);
 
 	writew(qedi->bdq_prod_idx, qedi->bdq_secondary_prod);
-	tmp = readw(qedi->bdq_secondary_prod);
+	readw(qedi->bdq_secondary_prod);
 }
 
 static void qedi_unsol_pdu_adjust_bdq(struct qedi_ctx *qedi,
-- 
2.25.1

