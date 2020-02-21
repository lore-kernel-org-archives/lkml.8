Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C20C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6C42465D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272553;
	bh=S3JQ2UnbkSepe0YPKZPgiY0Z/Igmz5BB5w122SddXJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y3i1Y7M+naK1S1OBoKlDqtMXeAnZgny5yRsZ7PAvy+Ix1sIPZY/artpCYAvwzGKa+
	 UIQewW96u76YUIPpcE2AXOYgmGvp0O8mqtLlTD2Q41yNFY6IMIrguS4CUrDthYFMC2
	 yMs5Z2myOC4P8DbHRP41yO0fyjy2sB8x3TU/dWJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbgBUIJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:09:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732301AbgBUIJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:09:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A1622465D;
        Fri, 21 Feb 2020 08:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272547;
        bh=S3JQ2UnbkSepe0YPKZPgiY0Z/Igmz5BB5w122SddXJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neNsyNO4qeBzWCa/SdJM2zsRB1J68MDCp+x/EylLWaFCBSatNXkOtx7p8Wp2gZcqH
         waPCtqRErmR4wJBaIDQNAhgMDGkcSrIgKXX7ImWmB1MmLOyiACMb3Yt2U3pfYhP/1A
         ayUke4MUTABv5kIxkVE+tpGwkCV3xrxGrI76AIeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 147/344] scsi: aic7xxx: Adjust indentation in ahc_find_syncrate
Date:   Fri, 21 Feb 2020 08:39:06 +0100
Message-Id: <20200221072402.146119680@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 4dbc96ad65c45cdd4e895ed7ae4c151b780790c5 ]

Clang warns:

../drivers/scsi/aic7xxx/aic7xxx_core.c:2317:5: warning: misleading
indentation; statement is not part of the previous 'if'
[-Wmisleading-indentation]
                        if ((syncrate->sxfr_u2 & ST_SXFR) != 0)
                        ^
../drivers/scsi/aic7xxx/aic7xxx_core.c:2310:4: note: previous statement
is here
                        if (syncrate == &ahc_syncrates[maxsync])
                        ^
1 warning generated.

This warning occurs because there is a space amongst the tabs on this
line. Remove it so that the indentation is consistent with the Linux kernel
coding style and clang no longer warns.

This has been a problem since the beginning of git history hence no fixes
tag.

Link: https://github.com/ClangBuiltLinux/linux/issues/817
Link: https://lore.kernel.org/r/20191218014220.52746-1-natechancellor@gmail.com
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/aic7xxx/aic7xxx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index a9d40d3b90efc..4190a025381a5 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -2314,7 +2314,7 @@ ahc_find_syncrate(struct ahc_softc *ahc, u_int *period,
 			 * At some speeds, we only support
 			 * ST transfers.
 			 */
-		 	if ((syncrate->sxfr_u2 & ST_SXFR) != 0)
+			if ((syncrate->sxfr_u2 & ST_SXFR) != 0)
 				*ppr_options &= ~MSG_EXT_PPR_DT_REQ;
 			break;
 		}
-- 
2.20.1



