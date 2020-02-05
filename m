Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DC8C352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88A421741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNt1RExN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBERRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:17:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42627 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgBERRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:17:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so1521300pfz.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 09:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gro8+/WYQ95dq/YkmpDcqQGotCrT27nrMh3aJyFjzsk=;
        b=JNt1RExN/SIzR4L+sA2jTVZkmBl9TCzvX4yznNaDxTzKH5uwzSKIjcVHnHftIcgrRg
         KYBgL6C7Ru3SaMQbgDtoWtkpax80mxWthUu6Ym72awzLGSn0BhSd6exozmiox08IevlU
         MEWzNCTypFjnXVPSl9ZBRP0NCqapmHz4Kz6mPPqRvMpBH3rtCOS+Wt4UEfnSnbjNrsas
         2WlnZ5UfN84c4R06vcs2DoKwwVO5yLSgr7PQwdExbgrdqa3oOYe9t42q0suG2yhXBNAu
         l6+I+qWAJSceesNmAeR4OI/SXfMLI3BXW+Zv1aE47L1g+ztjTA1Ab8gEGhXCjOHuvjbo
         +HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=gro8+/WYQ95dq/YkmpDcqQGotCrT27nrMh3aJyFjzsk=;
        b=O+yopllL8s46zvDUlJGOUOZ0UdJexJM6zHUepVWHNXa2SkiqQ1g3gq6kfGEEhJtgzC
         b29+NOyB9xcsJKweus+oUm0mszYlcGxtSvwKm2FAW3tkhYE0bdvzMndFGq7ck1hkx7Jq
         W0DrAervH5Dj2lF5maunV83uLhQZ0CxlRwuLMXJYpzviF6wAimVS/ZALhRV5mYrvBQJP
         bn0YHyOXjfW2kdC8z2pR9eR8Tt7Y5XTG/6gXYjhgk/rJu+445aSJrS/EUauXs6AAVrry
         8NOOHPOd6ofndnfbd5GuXaRKsNRgGcamIhLtuVVdWXGxMGjQ1XfJDQA/1dASAdVhLjxp
         EQ5Q==
X-Gm-Message-State: APjAAAU0YSfy5+ycstehrCLjvFSlOTD+zhTQtfoYuxVLM6IT/j4GYNjf
        MleMPalYSV0c8Gq+XS8J/7Q=
X-Google-Smtp-Source: APXvYqy551xfrDJoqYXivIxIxSmjY9zdoK00z+mXKQG5eLRTG5YwmPpFcVaWzOQSJwywuSGKezIagA==
X-Received: by 2002:a63:e04a:: with SMTP id n10mr36912315pgj.341.1580923064263;
        Wed, 05 Feb 2020 09:17:44 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id l8sm357945pjy.24.2020.02.05.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 09:17:43 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 2/4] ntb_perf: send command in response to EAGAIN
Date:   Wed,  5 Feb 2020 22:46:56 +0530
Message-Id: <a7db6b564428dd1d4d2e93fab76f8f582f63fb9a.1580921119.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580921119.git.arindam.nath@amd.com>
References: <cover.1580921119.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580921119.git.arindam.nath@amd.com>
References: <cover.1580921119.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_spad_cmd_send() and perf_msg_cmd_send() return
-EAGAIN after trying to send commands for a maximum
of MSG_TRIES re-tries. But currently there is no
handling for this error. These functions are invoked
from perf_service_work() through function pointers,
so rather than simply call these functions is not
enough. We need to make sure to invoke them again in
case of -EAGAIN. Since peer status bits were cleared
before calling these functions, we set the same status
bits before queueing the work again for later invocation.
This way we simply won't go ahead and initialize the
XLAT registers wrongfully in case sending the very first
command itself fails.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 0e9b9efe74a4..5116655f0211 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -625,14 +625,24 @@ static void perf_service_work(struct work_struct *work)
 {
 	struct perf_peer *peer = to_peer_service(work);
 
-	if (test_and_clear_bit(PERF_CMD_SSIZE, &peer->sts))
-		perf_cmd_send(peer, PERF_CMD_SSIZE, peer->outbuf_size);
+	if (test_and_clear_bit(PERF_CMD_SSIZE, &peer->sts)) {
+		if (perf_cmd_send(peer, PERF_CMD_SSIZE, peer->outbuf_size)
+		    == -EAGAIN) {
+			set_bit(PERF_CMD_SSIZE, &peer->sts);
+			(void)queue_work(system_highpri_wq, &peer->service);
+		}
+	}
 
 	if (test_and_clear_bit(PERF_CMD_RSIZE, &peer->sts))
 		perf_setup_inbuf(peer);
 
-	if (test_and_clear_bit(PERF_CMD_SXLAT, &peer->sts))
-		perf_cmd_send(peer, PERF_CMD_SXLAT, peer->inbuf_xlat);
+	if (test_and_clear_bit(PERF_CMD_SXLAT, &peer->sts)) {
+		if (perf_cmd_send(peer, PERF_CMD_SXLAT, peer->inbuf_xlat)
+		    == -EAGAIN) {
+			set_bit(PERF_CMD_SXLAT, &peer->sts);
+			(void)queue_work(system_highpri_wq, &peer->service);
+		}
+	}
 
 	if (test_and_clear_bit(PERF_CMD_RXLAT, &peer->sts))
 		perf_setup_outbuf(peer);
-- 
2.17.1

