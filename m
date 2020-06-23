Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A7FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9845204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946660;
	bh=6XFOWRwqP51ncHyM1K4Bi9eh6F1DgMWmP/TQ/75CFAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f9g2KAAzxp7uMnWnVSl2in1imI1j0olXHWghjAJ0tXKWKV4krE9f9SQhHWTMLCCFk
	 c7lEJ80Dc9g+KjNhrDN3+TpEaLuC3JUMBcOFF6fCUGocW7jEsV1bHuSWhskZSRyzGO
	 7L4gwpVYa+gHMZprjM7ca2xe5kuw5Zp0Ao0TeCOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393333AbgFWVK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391343AbgFWUck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:32:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 605A42064B;
        Tue, 23 Jun 2020 20:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944360;
        bh=6XFOWRwqP51ncHyM1K4Bi9eh6F1DgMWmP/TQ/75CFAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H15HTdQ5+xFUpF4fbyjH3KSuJwpJVCUXJI8/ifxmH5aBj0LF9frtHok9z2I49sQNM
         Gqu60+hc0ALm8OmWELMBQV3v8HnxlHyZQ21RWDoVfKQ26jNfUii+1GuXEslD+pHSNM
         9p0Ngos69aSCYLWeBY1O+yCjFa2e1EpqdStDI+uw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 275/314] scsi: ufs-bsg: Fix runtime PM imbalance on error
Date:   Tue, 23 Jun 2020 21:57:50 +0200
Message-Id: <20200623195352.102621485@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit a1e17eb03e69bb61bd1b1a14610436b7b9be12d9 ]

When ufs_bsg_alloc_desc_buffer() returns an error code, a pairing runtime
PM usage counter decrement is needed to keep the counter balanced.

Link: https://lore.kernel.org/r/20200522045932.31795-1-dinghao.liu@zju.edu.cn
Fixes: 74e5e468b664 (scsi: ufs-bsg: Wake the device before sending raw upiu commands)
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs_bsg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index d2197a31abe58..bad366e491591 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -106,8 +106,10 @@ static int ufs_bsg_request(struct bsg_job *job)
 		desc_op = bsg_request->upiu_req.qr.opcode;
 		ret = ufs_bsg_alloc_desc_buffer(hba, job, &desc_buff,
 						&desc_len, desc_op);
-		if (ret)
+		if (ret) {
+			pm_runtime_put_sync(hba->dev);
 			goto out;
+		}
 
 		/* fall through */
 	case UPIU_TRANSACTION_NOP_OUT:
-- 
2.25.1



