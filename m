Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2201C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821C72071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262507;
	bh=lnxsdBh+zE47m4uo4Po/DXympUpbxUrHQw2OAbpZ/no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2OLDK0DvwJBLJ6gDiT3+OtBCjS//IjMNRh/xfstgXI+DnZTicEXWzu+xt0N91UNwU
	 FmtuQMtPQSS7npdlLmAbUvaaFW/swAV2HdntAZyAE/pHPfadH1MywHOQkNoVxpHDEW
	 Hni3xxvfKk552ExeXQBTxEA1coe+y2/z6SKV2llU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgHXJsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbgHXIkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:40:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D2502075B;
        Mon, 24 Aug 2020 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258453;
        bh=lnxsdBh+zE47m4uo4Po/DXympUpbxUrHQw2OAbpZ/no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cUIDcLH7rUitLJphbpMS9AiESb6Z0+vv2nXKI6CjMXGzpBd3eVC5y/l91WzrZCs8w
         HdCgJbJV5WkeeM204bKwhWa56hxssd4wjKowbkA/7HqeenhXDUf1UUzUBz64ZiCafw
         D+hoW7Td7m1Sb+DC1OOBVTq2i48/DMBONE6I1kIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Girish Basrur <gbasrur@marvell.com>,
        Santosh Vernekar <svernekar@marvell.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        Shyam Sundar <ssundar@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 052/124] scsi: libfc: Free skb in fc_disc_gpn_id_resp() for valid cases
Date:   Mon, 24 Aug 2020 10:29:46 +0200
Message-Id: <20200824082411.979792996@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javed Hasan <jhasan@marvell.com>

[ Upstream commit ec007ef40abb6a164d148b0dc19789a7a2de2cc8 ]

In fc_disc_gpn_id_resp(), skb is supposed to get freed in all cases except
for PTR_ERR. However, in some cases it didn't.

This fix is to call fc_frame_free(fp) before function returns.

Link: https://lore.kernel.org/r/20200729081824.30996-2-jhasan@marvell.com
Reviewed-by: Girish Basrur <gbasrur@marvell.com>
Reviewed-by: Santosh Vernekar <svernekar@marvell.com>
Reviewed-by: Saurav Kashyap <skashyap@marvell.com>
Reviewed-by: Shyam Sundar <ssundar@marvell.com>
Signed-off-by: Javed Hasan <jhasan@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_disc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libfc/fc_disc.c b/drivers/scsi/libfc/fc_disc.c
index 2b865c6423e29..e00dc4693fcbd 100644
--- a/drivers/scsi/libfc/fc_disc.c
+++ b/drivers/scsi/libfc/fc_disc.c
@@ -581,8 +581,12 @@ static void fc_disc_gpn_id_resp(struct fc_seq *sp, struct fc_frame *fp,
 
 	if (PTR_ERR(fp) == -FC_EX_CLOSED)
 		goto out;
-	if (IS_ERR(fp))
-		goto redisc;
+	if (IS_ERR(fp)) {
+		mutex_lock(&disc->disc_mutex);
+		fc_disc_restart(disc);
+		mutex_unlock(&disc->disc_mutex);
+		goto out;
+	}
 
 	cp = fc_frame_payload_get(fp, sizeof(*cp));
 	if (!cp)
@@ -609,7 +613,7 @@ static void fc_disc_gpn_id_resp(struct fc_seq *sp, struct fc_frame *fp,
 				new_rdata->disc_id = disc->disc_id;
 				fc_rport_login(new_rdata);
 			}
-			goto out;
+			goto free_fp;
 		}
 		rdata->disc_id = disc->disc_id;
 		mutex_unlock(&rdata->rp_mutex);
@@ -626,6 +630,8 @@ redisc:
 		fc_disc_restart(disc);
 		mutex_unlock(&disc->disc_mutex);
 	}
+free_fp:
+	fc_frame_free(fp);
 out:
 	kref_put(&rdata->kref, fc_rport_destroy);
 	if (!IS_ERR(fp))
-- 
2.25.1



