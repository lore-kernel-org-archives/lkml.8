Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A03C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA5A20575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100432;
	bh=zxMAMCUGege0v8kJLkpgkDzKu7rKYEby4bGm0U/va+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WggIdP8RCvBLpJw2+hMd+FF+d0lhK3/8iuWt1Sj8gdSul/mWlBOHPU1AgQoxv+MFC
	 G07ywcgljyCCD+XgvYnx3ucUAuLHPorKC25GTA4W6j3xklgpO9CDEebTAFHDk2WE0W
	 jWft3zU8Ljs2fNfvNvyEcOGu9oNV+/OBFYSCaxUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgD1S1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbgD1S1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:27:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AAF920B1F;
        Tue, 28 Apr 2020 18:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098441;
        bh=zxMAMCUGege0v8kJLkpgkDzKu7rKYEby4bGm0U/va+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8QijU5mp0xBPBWxBZSDNt+S9iYSZo/UyPkKR0ToXylM+jL6Q9DpbYd+S0C53cieg
         uk9goOngtPNNMtPujOq8QisbNFF4EWDtmXoHlhYvmHJaQlFdL4+/VChPwOywlXxXyc
         kqtY6r0BKg20m1iby8Wz0lGLV4KpcQkoz8b8IdBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Javed Hasan <jhasan@marvell.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 008/167] scsi: libfc: If PRLI rejected, move rport to PLOGI state
Date:   Tue, 28 Apr 2020 20:23:04 +0200
Message-Id: <20200428182226.289083165@linuxfoundation.org>
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

From: Javed Hasan <jhasan@marvell.com>

[ Upstream commit 45e544bfdab2014d11c7595b8ccc3c4715a09015 ]

If PRLI reject code indicates "rejected status", move rport state machine
back to PLOGI state.

Link: https://lore.kernel.org/r/20200327060208.17104-2-skashyap@marvell.com
Signed-off-by: Javed Hasan <jhasan@marvell.com>
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_rport.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index da6e97d8dc3bb..6bb8917b99a19 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -1208,9 +1208,15 @@ static void fc_rport_prli_resp(struct fc_seq *sp, struct fc_frame *fp,
 		rjt = fc_frame_payload_get(fp, sizeof(*rjt));
 		if (!rjt)
 			FC_RPORT_DBG(rdata, "PRLI bad response\n");
-		else
+		else {
 			FC_RPORT_DBG(rdata, "PRLI ELS rejected, reason %x expl %x\n",
 				     rjt->er_reason, rjt->er_explan);
+			if (rjt->er_reason == ELS_RJT_UNAB &&
+			    rjt->er_explan == ELS_EXPL_PLOGI_REQD) {
+				fc_rport_enter_plogi(rdata);
+				goto out;
+			}
+		}
 		fc_rport_error_retry(rdata, FC_EX_ELS_RJT);
 	}
 
-- 
2.20.1



