Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB33AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A903A206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579199208;
	bh=nOHIRwqlVVlXune0UWF1vjWR3cQL8ZSctx46XJgiuV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wqvE6iN8TNfLLQfiZw2TT5Du6GxEn1rGiS0dBx0/bRhxq1Pg+IEX3Lk4qQA01eopg
	 ISLQ1RQVua5wZaLY9n7sHdV7/uz3c9zER0ui1zpoW5O4+TLcU52mwqTrF/1YtLXrYI
	 tjWABtZ+6Os0ld6zjHfS4qs1tra2KCvKGKIaGIQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436710AbgAPS0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:26:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403992AbgAPR0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:26:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7C27246D1;
        Thu, 16 Jan 2020 17:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195597;
        bh=nOHIRwqlVVlXune0UWF1vjWR3cQL8ZSctx46XJgiuV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GX/hv9tENwxjrEWahNCv2TBPUyhiImPN0yEwlWTzC3IRcEb8X+zj7KKyRVHisOLRQ
         qnDkPJkeZfsSU4r7Ccar7NFEFKQ7f8k8uExAQ9qVqLR0GDpMB9iBcBKGfhdLYlQfJg
         J5EaD/vSpg1CsSULotSfR5hffMmvSGFBkd0l3HTw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 174/371] scsi: qla2xxx: Fix a format specifier
Date:   Thu, 16 Jan 2020 12:20:46 -0500
Message-Id: <20200116172403.18149-117-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 19ce192cd718e02f880197c0983404ca48236807 ]

Since mcmd->sess->port_name is eight bytes long, use %8phC to format that
port name instead of %phC.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Fixes: 726b85487067 ("qla2xxx: Add framework for async fabric discovery") # v4.11.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 55227d20496a..1000422ef4f8 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -2179,7 +2179,7 @@ void qlt_xmit_tm_rsp(struct qla_tgt_mgmt_cmd *mcmd)
 		    mcmd->orig_iocb.imm_ntfy.u.isp24.status_subcode ==
 		    ELS_TPRLO) {
 			ql_dbg(ql_dbg_disc, vha, 0x2106,
-			    "TM response logo %phC status %#x state %#x",
+			    "TM response logo %8phC status %#x state %#x",
 			    mcmd->sess->port_name, mcmd->fc_tm_rsp,
 			    mcmd->flags);
 			qlt_schedule_sess_for_deletion_lock(mcmd->sess);
-- 
2.20.1

