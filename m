Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDAAC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E04E520B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098439;
	bh=Agzc/Ytq7wcrS0tRGzK7u1Nb+yTiJQUNi1nRpquZG7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WfBGaAYlfyuwsO5E8FITX0F8wWC4ot9yGC6Xbn9mjSv7T/8tBAQ+9YZ+rPnQf9luu
	 W19CQdaUQ4R/8vfocEnEyz+Iqa9jvpzv7BGNZ4PlHZC7CtUJw+UQhxjrv4NsnytoFC
	 KS/ohPCIypnCoM2mbpQChCRu5i22qZtQbC/nFmTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgD1S1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbgD1S1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:27:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 647E520BED;
        Tue, 28 Apr 2020 18:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098431;
        bh=Agzc/Ytq7wcrS0tRGzK7u1Nb+yTiJQUNi1nRpquZG7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lV1ucB91K55PIVFwyLGz3nl2LJSZOwdVgfwxDWgYvSpUqGGwywSwdRfkyliGv9sO+
         GMPSYPpaZnekv+re5MEggFWJYu+FBjpDbHauZHvKhDGWyvdutNe81q0xkobwtu3ugf
         rE/2Bj5WBSuxFmyM7mGWwDGIc3YqFMXdnPK1A7cM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 004/167] scsi: lpfc: Fix kasan slab-out-of-bounds error in lpfc_unreg_login
Date:   Tue, 28 Apr 2020 20:23:00 +0200
Message-Id: <20200428182225.899865710@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
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
index 64002b0cb02d4..5939ea0e3b1eb 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2511,6 +2511,8 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
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



