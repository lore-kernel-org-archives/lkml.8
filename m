Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B8BC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E809221734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338157;
	bh=K+/he/n1c+PN/6j0+lELbKlArIe5xgLR9HveOrdaBB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=znv13BTB2F3NHolXjXji4NB6mdKDFP8dNXQsa91HLSAeDs4/RV15JkLV+kJ+PlQ15
	 3G4qt8SfPYO9VbSWKYuxEyJJeE97Xs+3ZgBbDtEzoSUFYyYRVjkjjMDIqONXXM3JZP
	 oNqC6cAJYAOG0R2yd6QwLOTUj3IXuF44eerwY5hQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgBJMf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:35:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgBJMfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:33 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EBEB20873;
        Mon, 10 Feb 2020 12:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338133;
        bh=K+/he/n1c+PN/6j0+lELbKlArIe5xgLR9HveOrdaBB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tXXbm0rFDqg5oNklpJj2Vq1AVCCL2KOWRoYFxrPyFA8uoU0qLn2hUxJuGQ+RNtL51
         z9EOtNNcLWUz8zwpIGleJq3FCx16RRB52mmyJsrLxJmrKZzBX2SxLbPPiD8jDd6pz4
         EkT/ODLSnnWDEjQGhfuAb91qjoOW+CFyVOKQdJUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 078/195] scsi: qla2xxx: Fix mtcp dump collection failure
Date:   Mon, 10 Feb 2020 04:32:16 -0800
Message-Id: <20200210122313.250552123@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
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
@@ -5994,9 +5994,8 @@ qla2x00_dump_mctp_data(scsi_qla_host_t *
 	mcp->mb[7] = LSW(MSD(req_dma));
 	mcp->mb[8] = MSW(addr);
 	/* Setting RAM ID to valid */
-	mcp->mb[10] |= BIT_7;
 	/* For MCTP RAM ID is 0x40 */
-	mcp->mb[10] |= 0x40;
+	mcp->mb[10] = BIT_7 | 0x40;
 
 	mcp->out_mb |= MBX_10|MBX_8|MBX_7|MBX_6|MBX_5|MBX_4|MBX_3|MBX_2|MBX_1|
 	    MBX_0;


