Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7995C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4262495E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339513;
	bh=Z5FTm0I7htD8O8iicnQOKr9GS7r2PJvsZxRMoXwPYHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s83bDd+5CwkQQBUlvXqOVlcxBhnom1yAWPB1xsMmrYMNtkIIVfQF0Zz8xh9nMR8N/
	 7rU+1LZHt5VFoKl/n8686ooVm3H0Kqe3xCcTJbpx/MGAwX31gEVdDnju1ilKp2+TnF
	 EqYbuYLk8ez7YAcc/HP91ubLvWeCo7ltXcrDeIY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgEANZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbgEANZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:25:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C355B24959;
        Fri,  1 May 2020 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339507;
        bh=Z5FTm0I7htD8O8iicnQOKr9GS7r2PJvsZxRMoXwPYHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebConEbzQyvUOBNlCc3TO5oGErSg8uvhQQd1MUR/VXQKBhhRH+t/d8HMULG98MQMA
         fJYM/GTnsdnNa24VqxByOBtOVFyMOosbuAJpCbdDyoQSRVE8zy1ToLU+84WsoYKdqj
         zH4Fo2Kzaw1LR5l+TaVH6nB0ziRnUfF+JsTC19tQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 07/70] scsi: lpfc: Fix kasan slab-out-of-bounds error in lpfc_unreg_login
Date:   Fri,  1 May 2020 15:20:55 +0200
Message-Id: <20200501131514.951810627@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.302599262@linuxfoundation.org>
References: <20200501131513.302599262@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 38503943c89f0bafd9e3742f63f872301d44cbea ]

The following kasan bug was called out:

 BUG: KASAN: slab-out-of-bounds in lpfc_unreg_login+0x7c/0xc0 [lpfc]
 Read of size 2 at addr ffff889fc7c50a22 by task lpfc_worker_3/6676
 ...
 Call Trace:
 dump_stack+0x96/0xe0
 ? lpfc_unreg_login+0x7c/0xc0 [lpfc]
 print_address_description.constprop.6+0x1b/0x220
 ? lpfc_unreg_login+0x7c/0xc0 [lpfc]
 ? lpfc_unreg_login+0x7c/0xc0 [lpfc]
 __kasan_report.cold.9+0x37/0x7c
 ? lpfc_unreg_login+0x7c/0xc0 [lpfc]
 kasan_report+0xe/0x20
 lpfc_unreg_login+0x7c/0xc0 [lpfc]
 lpfc_sli_def_mbox_cmpl+0x334/0x430 [lpfc]
 ...

When processing the completion of a "Reg Rpi" login mailbox command in
lpfc_sli_def_mbox_cmpl, a call may be made to lpfc_unreg_login. The vpi is
extracted from the completing mailbox context and passed as an input for
the next. However, the vpi stored in the mailbox command context is an
absolute vpi, which for SLI4 represents both base + offset.  When used with
a non-zero base component, (function id > 0) this results in an
out-of-range access beyond the allocated phba->vpi_ids array.

Fix by subtracting the function's base value to get an accurate vpi number.

Link: https://lore.kernel.org/r/20200322181304.37655-2-jsmart2021@gmail.com
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_sli.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 065fdc17bbfbb..7a94c2d352390 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2186,6 +2186,8 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	    !pmb->u.mb.mbxStatus) {
 		rpi = pmb->u.mb.un.varWords[0];
 		vpi = pmb->u.mb.un.varRegLogin.vpi;
+		if (phba->sli_rev == LPFC_SLI_REV4)
+			vpi -= phba->sli4_hba.max_cfg_param.vpi_base;
 		lpfc_unreg_login(phba, vpi, rpi, pmb);
 		pmb->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
 		rc = lpfc_sli_issue_mbox(phba, pmb, MBX_NOWAIT);
-- 
2.20.1



