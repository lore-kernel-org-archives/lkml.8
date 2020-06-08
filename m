Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0A0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80688206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662058;
	bh=ABke5fCnb4WtC7EIewoibSfRFGOJLJ1nVVXvihgqlJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pF8jkxSpOyOzSlNL4IHYM8wlbX1XS5JcN57Hoy8Kayf17rogviPDG3OmkpPNkkaF0
	 AkXtM4fWyGGeC520jghpmjY9ilXKj2nA3zur2nuW0t3VX/Jao/tmE/uJuaLPNOkU4d
	 ipW8Dqx8FubjEGnWx6x2mOvFdN6FUH1kueAhjClM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbgFHXR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729778AbgFHXOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9AB720C09;
        Mon,  8 Jun 2020 23:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658061;
        bh=ABke5fCnb4WtC7EIewoibSfRFGOJLJ1nVVXvihgqlJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FoiFvRPrhxRnEeKHQZcwQ/vWm/998GtD5HnTAe/+QmVpsUTZkU/kHmtdI8Zgxr4Yt
         a4F4Cz3nW1Ary4qbvw3WZ3UjXzjDQexKoiRyx+xY4/eCxVijibJufsZRTq2dQ1ePOi
         FhfIe9tF97Bd/wF6eRylm7xuUEcKv/t3HRL+O1BI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arun Easi <aeasi@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 108/606] scsi: qla2xxx: Fix hang when issuing nvme disconnect-all in NPIV
Date:   Mon,  8 Jun 2020 19:03:53 -0400
Message-Id: <20200608231211.3363633-108-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Easi <aeasi@marvell.com>

[ Upstream commit 45a76264c26fd8cfd0c9746196892d9b7e2657ee ]

In NPIV environment, a NPIV host may use a queue pair created by base host
or other NPIVs, so the check for a queue pair created by this NPIV is not
correct, and can cause an abort to fail, which in turn means the NVME
command not returned.  This leads to hang in nvme_fc layer in
nvme_fc_delete_association() which waits for all I/Os to be returned, which
is seen as hang in the application.

Link: https://lore.kernel.org/r/20200331104015.24868-3-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 9e09964f5c0e..7b341e41bb85 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -3117,7 +3117,7 @@ qla24xx_abort_command(srb_t *sp)
 	ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x108c,
 	    "Entered %s.\n", __func__);
 
-	if (vha->flags.qpairs_available && sp->qpair)
+	if (sp->qpair)
 		req = sp->qpair->req;
 	else
 		return QLA_FUNCTION_FAILED;
-- 
2.25.1

