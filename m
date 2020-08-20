Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C8FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD9EB20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926743;
	bh=t0FemPTXVLJhenMknaFvW9MP28XXPehRZv4k9/uc2SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IfgtVmHnnOcid7zB+AJM0xh+x+Sx9MLsU7OVVP+4jU8317ArfWBDxOYIyPRTze2bT
	 7/mgn83ZU/ggSGagzQaXpwsegRW4RWvGeO8JCNHFObKh9ghHD0kHrrI9QVNSpN6Llz
	 5yHWQ8py/KAFntJSsu95vblnR8paINZ6zkNSK0qA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgHTMcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729701AbgHTJuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:50:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E04520724;
        Thu, 20 Aug 2020 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916999;
        bh=t0FemPTXVLJhenMknaFvW9MP28XXPehRZv4k9/uc2SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9pTccNHbRfWe8+AuXFpFRhzq+PfRJWVgrFFcFrTLUS8ROgDb8NoB/gM+kClCVBXk
         5U3kOQPR4KNLRRS1M/G/PL7cXlLHRq1nqSIebBWJz1JL+MPvX5aBQbPZkyQjsPNu57
         C5p4KJEGLgRHvshe5gBXIY793+ArhoZHukADICA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Smart <james.smart@broadcom.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 121/152] scsi: lpfc: nvmet: Avoid hang / use-after-free again when destroying targetport
Date:   Thu, 20 Aug 2020 11:21:28 +0200
Message-Id: <20200820091559.970586743@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ewan D. Milne <emilne@redhat.com>

[ Upstream commit af6de8c60fe9433afa73cea6fcccdccd98ad3e5e ]

We cannot wait on a completion object in the lpfc_nvme_targetport structure
in the _destroy_targetport() code path because the NVMe/fc transport will
free that structure immediately after the .targetport_delete() callback.
This results in a use-after-free, and a crash if slub_debug=FZPU is
enabled.

An earlier fix put put the completion on the stack, but commit 2a0fb340fcc8
("scsi: lpfc: Correct localport timeout duration error") subsequently
changed the code to reference the completion through a pointer in the
object rather than the local stack variable.  Fix this by using the stack
variable directly.

Link: https://lore.kernel.org/r/20200729231011.13240-1-emilne@redhat.com
Fixes: 2a0fb340fcc8 ("scsi: lpfc: Correct localport timeout duration error")
Reviewed-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 9884228800a50..f14394ab0e037 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1923,7 +1923,7 @@ lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba)
 		}
 		tgtp->tport_unreg_cmp = &tport_unreg_cmp;
 		nvmet_fc_unregister_targetport(phba->targetport);
-		if (!wait_for_completion_timeout(tgtp->tport_unreg_cmp,
+		if (!wait_for_completion_timeout(&tport_unreg_cmp,
 					msecs_to_jiffies(LPFC_NVMET_WAIT_TMO)))
 			lpfc_printf_log(phba, KERN_ERR, LOG_NVME,
 					"6179 Unreg targetport x%px timeout "
-- 
2.25.1



