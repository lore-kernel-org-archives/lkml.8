Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C7C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362F820715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340901;
	bh=tv2aHYqyIna5OE/CPsFm9nPNz/x2eM8TBqRwW5i1d8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nPAgXptry4Lv0htTirmrt6Pyw1cDWisIsJKbMjRwT167XET4skfvrIfyg7q1RQ8WA
	 xhHSswb6puiDbFmxvN0XXItl5vR/bYu+VHnZ1sqHbW1y53FYGXB0JKYBw9sTbHITxD
	 Lyg3xvI2SmI7UJ9GzgQ88RS0SECIwAOk/nmOUuqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgBJNVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:21:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbgBJMha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:30 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C13B20838;
        Mon, 10 Feb 2020 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338250;
        bh=tv2aHYqyIna5OE/CPsFm9nPNz/x2eM8TBqRwW5i1d8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VLqANb86o9UzoVxOjMtG3uiGNWuAjzt3oIbIwpNXsZwH43wNiX+K5Erzwd63JuwBB
         cIxAgwKFFLpagPwpdOUzA2+TvsAkJHjFmVEpsKtjX6AMeApSbaUZGwetmSjVPSl/9e
         ID0Bpqh/TY4rINLNECYXKDvflek4m8b3CRdbYc+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 112/309] scsi: qla2xxx: Fix mtcp dump collection failure
Date:   Mon, 10 Feb 2020 04:31:08 -0800
Message-Id: <20200210122417.360236781@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
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
@@ -6151,9 +6151,8 @@ qla2x00_dump_mctp_data(scsi_qla_host_t *
 	mcp->mb[7] = LSW(MSD(req_dma));
 	mcp->mb[8] = MSW(addr);
 	/* Setting RAM ID to valid */
-	mcp->mb[10] |= BIT_7;
 	/* For MCTP RAM ID is 0x40 */
-	mcp->mb[10] |= 0x40;
+	mcp->mb[10] = BIT_7 | 0x40;
 
 	mcp->out_mb |= MBX_10|MBX_8|MBX_7|MBX_6|MBX_5|MBX_4|MBX_3|MBX_2|MBX_1|
 	    MBX_0;


