Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E38CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D67A2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520725;
	bh=ABke5fCnb4WtC7EIewoibSfRFGOJLJ1nVVXvihgqlJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sdekR4RD7b/kNRsoLhmvSS3Xjab4wZk37BCwLZGuDnbF5eKfT8OLy+zLmim/LlllR
	 RftjdwnvRIfWNc+3avLo0jKAejGcUrYoEHLmECxLKPh6RKco2MrcpWSykLHp9grXN9
	 /nzud5g0w1W0d9LLgFIRhpa2EivV3aXZqzpDtEeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404331AbgEZTSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391048AbgEZTNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:13:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEE2920888;
        Tue, 26 May 2020 19:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520414;
        bh=ABke5fCnb4WtC7EIewoibSfRFGOJLJ1nVVXvihgqlJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trWFktulLJBuA8fbgr8qhcmsgXHtGsmQ1QVuBQ46XyK1gFaL+WpAsi1LsPWxzg4rj
         0ji15A+cKklbyltv4hc0Q8/bOnpGdjxNwWQFywIzDZ6JmFCR7Ef1lAPwqLcReLl1xZ
         Oydl3GyYQMJ/DUch8pn39sPQtCAnljpTYM7Zirnc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Arun Easi <aeasi@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 029/126] scsi: qla2xxx: Fix hang when issuing nvme disconnect-all in NPIV
Date:   Tue, 26 May 2020 20:52:46 +0200
Message-Id: <20200526183940.206343877@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



