Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8854DC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6305520BED
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098559;
	bh=qNus+Aotl4Ykw5mSaayfce2H6rMn0LHCUbNcuJPfFkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PCO6odVFwLK7TEosX/PoxTOM6nnxhA0Sse6c2DKOjh8Lj8jz2ywp3/Yl5URBiE9dK
	 mQS6G9kwhvu9B1LH5hGw+eDo1jtTipOwANZavMcFXObc66J80ufxa+Fl4em/0snGVn
	 H06OK2RvH5S8K8wOuNZW75w0p8uGQAdxCqhsHHTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgD1S3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbgD1S3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:29:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A2120B80;
        Tue, 28 Apr 2020 18:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098548;
        bh=qNus+Aotl4Ykw5mSaayfce2H6rMn0LHCUbNcuJPfFkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H1FUFKtN3GKC/CGLZU2pqUl8Jm1x6vH5+JsM7fJnkNNNDPqr2c/meVwP+EeiMrLTn
         bivTgO1PU9ifVNGlNOAzjqzwnNp4nxjhB9QAa4bxlWrncOCFq0rwWKtlq01+/TrGK5
         KPK2tOIFJyNmpzOqVwHvZVozDFGgOhLjmA2km8SI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 012/131] scsi: lpfc: Fix kasan slab-out-of-bounds error in lpfc_unreg_login
Date:   Tue, 28 Apr 2020 20:23:44 +0200
Message-Id: <20200428182226.716275284@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
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
index a801917d3c193..a56a939792ac1 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2472,6 +2472,8 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	    !pmb->u.mb.mbxStatus) {
 		rpi = pmb->u.mb.un.varWords[0];
 		vpi = pmb->u.mb.un.varRegLogin.vpi;
+		if (phba->sli_rev == LPFC_SLI_REV4)
+			vpi -= phba->sli4_hba.max_cfg_param.vpi_base;
 		lpfc_unreg_login(phba, vpi, rpi, pmb);
 		pmb->vport = vport;
 		pmb->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
-- 
2.20.1



