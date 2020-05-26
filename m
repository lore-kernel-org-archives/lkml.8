Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B005DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BDE20849
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519636;
	bh=2daPSeBpK2D69QgGS2J3i1uLMjBYRlOd3LEOgCryJ7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iylKc5UBg3Q89r1jvc87iK0UzCuILN6QLHK8Khi7KVb+jJMNOe78Wx+vbleV3JK3F
	 15b2ypPry6kpjUJDFKYm/esy7tRnYhWgW+ejm5Aa9fXV+M088kUyOzZU5XwgHDiX86
	 CUdORTpXwm1cWVSIm6ZoQJIbrnFNbMe77Sfeht58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390764AbgEZTAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389533AbgEZTAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:00:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987F52084C;
        Tue, 26 May 2020 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519631;
        bh=2daPSeBpK2D69QgGS2J3i1uLMjBYRlOd3LEOgCryJ7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMHVJ9vCukVA6WRVVHkk/55KVQD3I0QC+sMfNSFdbPAMTCkBFFrdf3uY171ybg4Pm
         16Eeit+9mn0JsZLTC1a/+gfteGia+B+2y8GDpmDSXsq87yPzRnABijYBtHeBj6nQhE
         jnU4HixtL7wW/4J4f5RkVjNo4lPDKXV8ZGWLWDII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Arun Easi <aeasi@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 15/59] scsi: qla2xxx: Fix hang when issuing nvme disconnect-all in NPIV
Date:   Tue, 26 May 2020 20:53:00 +0200
Message-Id: <20200526183913.080919425@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183907.123822792@linuxfoundation.org>
References: <20200526183907.123822792@linuxfoundation.org>
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
index 5e8ae510aef8..9d9737114dcf 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -2998,7 +2998,7 @@ qla24xx_abort_command(srb_t *sp)
 	ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x108c,
 	    "Entered %s.\n", __func__);
 
-	if (vha->flags.qpairs_available && sp->qpair)
+	if (sp->qpair)
 		req = sp->qpair->req;
 
 	if (ql2xasynctmfenable)
-- 
2.25.1



