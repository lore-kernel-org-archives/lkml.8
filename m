Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01C6C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7183F20716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693002;
	bh=xzGdJq5ZEHKRz89wIxGgZnomao0LLdOSiZM64wGcDRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IAULGRQ6KdlxnY/loEv4epUjTlKX4ti8x76eldKGH5H9wqs1YJIsaz2mxamGmMBfi
	 edQXpLleIIcE8IVbeSGRAf0Vjex/iTRdsy5mRQxh3Fdzz/EeOqKv9dQkwkjocKzsPe
	 NRWhZiFMFKHCvOEuAwx2non62wLeALV4yadlh+bo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgHQTgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbgHQP2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:28:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81B1123BEB;
        Mon, 17 Aug 2020 15:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678112;
        bh=xzGdJq5ZEHKRz89wIxGgZnomao0LLdOSiZM64wGcDRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTHTjCvWgIGmDPeiYQQBhvDoEp+kUN4CyL98VGMWDy4+QFE3+6rJNQjoiZ6mT7ehx
         cLXl4+LqgzbHr43AN+a3BGpnhYSnyFBLiUIGByLNeZIlNQdvzANsglYQwRPXFgh90W
         4WDgfqIgkoOHUQGk8BGAey0whqfwlYF9uI9X+fFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Martin Wilck <mwilck@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 192/464] scsi: qla2xxx: Make __qla2x00_alloc_iocbs() initialize 32 bits of request_t.handle
Date:   Mon, 17 Aug 2020 17:12:25 +0200
Message-Id: <20200817143843.020042046@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit f8f12bda53eae87ca2dea42b36d19e48c9851b9f ]

The request_t 'handle' member is 32-bits wide, hence use wrt_reg_dword().
Change the cast in the wrt_reg_byte() call to make it clear that a regular
pointer is casted to an __iomem pointer.

Note: 'pkt' points to I/O memory for the qlafx00 adapter family and to
coherent memory for all other adapter families.

This patch fixes the following Coverity complaint:

CID 358864 (#1 of 1): Reliance on integer endianness (INCOMPATIBLE_CAST)
incompatible_cast: Pointer &pkt->handle points to an object whose effective
type is unsigned int (32 bits, unsigned) but is dereferenced as a narrower
unsigned short (16 bits, unsigned). This may lead to unexpected results
depending on machine endianness.

Link: https://lore.kernel.org/r/20200629225454.22863-7-bvanassche@acm.org
Fixes: 8ae6d9c7eb10 ("[SCSI] qla2xxx: Enhancements to support ISPFx00.")
Cc: Nilesh Javali <njavali@marvell.com>
Cc: Quinn Tran <qutran@marvell.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 8865c35d34211..7c2ad8c18398c 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2305,8 +2305,8 @@ __qla2x00_alloc_iocbs(struct qla_qpair *qpair, srb_t *sp)
 	pkt = req->ring_ptr;
 	memset(pkt, 0, REQUEST_ENTRY_SIZE);
 	if (IS_QLAFX00(ha)) {
-		wrt_reg_byte((void __iomem *)&pkt->entry_count, req_cnt);
-		wrt_reg_word((void __iomem *)&pkt->handle, handle);
+		wrt_reg_byte((u8 __force __iomem *)&pkt->entry_count, req_cnt);
+		wrt_reg_dword((__le32 __force __iomem *)&pkt->handle, handle);
 	} else {
 		pkt->entry_count = req_cnt;
 		pkt->handle = handle;
-- 
2.25.1



