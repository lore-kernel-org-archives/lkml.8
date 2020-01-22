Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82369C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EC82071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699771;
	bh=1Db3lYeWizfiMaW+Ghe6xbopy16WjdgWkpy59aWx5q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h1olEsah/IAl480Gu4xn8ZpzAuDML+tGC/wSm2Z4satDY+HGbjAr6WgRQAoFv8dLX
	 0ilEcDq+EkFmDMRBmsLsGc8yWF+o3FQIBlKmBmLx0e2jGrae3muow1spHKeL9cCdIe
	 7dj95Nan2JwPSw6JcrQ98gTNyt2i03sGG+pqZzOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgAVN3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:29:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730879AbgAVN1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:27:20 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 008A0205F4;
        Wed, 22 Jan 2020 13:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699639;
        bh=1Db3lYeWizfiMaW+Ghe6xbopy16WjdgWkpy59aWx5q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bniotb0FL/vM+Qwg83xOdS0sT7HOuV3/yW61I27MyHCBrf5IklSikkEv3kVIX9GLd
         0CQOiQudNOQNZgo8HYdxN1fIIVFIO9MFFmtzudXfowbQ5n6ZO0EXtj8ncycAIKvfjh
         RYBfD1tkrkorLmVy+qPx9ssnvwe3rwFtx90QCmOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 5.4 205/222] scsi: lpfc: fix: Coverity: lpfc_get_scsi_buf_s3(): Null pointer dereferences
Date:   Wed, 22 Jan 2020 10:29:51 +0100
Message-Id: <20200122092848.379097881@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

commit 6f23f8c5c9f1be4eb17c035129c80e49000c18a7 upstream.

Coverity reported the following:

---
 drivers/scsi/lpfc/lpfc_scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -719,7 +719,7 @@ lpfc_get_scsi_buf_s4(struct lpfc_hba *ph
 	iocb->ulpLe = 1;
 	iocb->ulpClass = CLASS3;
 
-	if (lpfc_ndlp_check_qdepth(phba, ndlp)) {
+	if (lpfc_ndlp_check_qdepth(phba, ndlp) && lpfc_cmd) {
 		atomic_inc(&ndlp->cmd_pending);
 		lpfc_cmd->flags |= LPFC_SBUF_BUMP_QDEPTH;
 	}


