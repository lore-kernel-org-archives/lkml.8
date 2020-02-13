Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C7CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62194206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610233;
	bh=1Iizuofl1M9QTJuqeATp+FLhwr0NT7Oa3L7BrSWjUnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x6OB5IzzE3ie1rIOqQU7LcaBwKQHzdUVGVqZSrh/Sl5yYM66XD6lEuMjvtWHqdvMh
	 3IeHu8khyXl81dMB12wyxcQPWy4CNPHdDw/nUtWacgDqxcaZJFWksacTwdgrdPq1pT
	 7bj8u8Y/hQgVBNbIKGO5JW2A1uxWjR/1M5u8jUqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBMQKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:10:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbgBMPWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:22:37 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB20024689;
        Thu, 13 Feb 2020 15:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607355;
        bh=1Iizuofl1M9QTJuqeATp+FLhwr0NT7Oa3L7BrSWjUnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFOr7qY51QvB8lHooFAGSknunz24tPiQurPIfa0G4QwXUkaF2cK+OSHezfZDgvq/Z
         z0o2gmmAKW1/9e32el0nLOfk4Xw6rn1RjzLPVjGkLbs46LilriZwZWVkrfdJOdzgDN
         hTx3AVpxkEqNErrOBHamjhYCzfkIrfhh2MBfH4vc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 22/91] scsi: qla2xxx: Fix mtcp dump collection failure
Date:   Thu, 13 Feb 2020 07:19:39 -0800
Message-Id: <20200213151830.210127935@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
References: <20200213151821.384445454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

commit 641e0efddcbde52461e017136acd3ce7f2ef0c14 upstream.

MTCP dump failed due to MB Reg 10 was picking garbage data from stack
memory.

Fixes: 81178772b636a ("[SCSI] qla2xxx: Implemetation of mctp.")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191217220617.28084-14-hmadhani@marvell.com
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_mbx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -5455,9 +5455,8 @@ qla2x00_dump_mctp_data(scsi_qla_host_t *
 	mcp->mb[7] = LSW(MSD(req_dma));
 	mcp->mb[8] = MSW(addr);
 	/* Setting RAM ID to valid */
-	mcp->mb[10] |= BIT_7;
 	/* For MCTP RAM ID is 0x40 */
-	mcp->mb[10] |= 0x40;
+	mcp->mb[10] = BIT_7 | 0x40;
 
 	mcp->out_mb |= MBX_10|MBX_8|MBX_7|MBX_6|MBX_5|MBX_4|MBX_3|MBX_2|MBX_1|
 	    MBX_0;


