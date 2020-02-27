Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D2EC3F355
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A6120801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811250;
	bh=BAiSBRFdJMN3ZHL/w78o+PZyV1AC1701XX/Z2jnkgC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p6pv0cZXrxcqfqPDjhiSnj1pJ/SJV/7AizI/8a9Rji0E1actGFNN3whUSK4N1Q0j4
	 ZjH4KaEMNFo17SzVV5uan32T7trfBwtjrXcfcWnzZM/Mt1xPQNHxN++37Jn0oCOLdS
	 qBUp798Ig+u1KIBVYUUg/u9S8bMobnMFdIQ5+vDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbgB0Nr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:47:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730687AbgB0Nr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:47:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1479720801;
        Thu, 27 Feb 2020 13:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811245;
        bh=BAiSBRFdJMN3ZHL/w78o+PZyV1AC1701XX/Z2jnkgC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNHVxbnd/vsNqkuLUnFBjNf2kwijDVuCzTuoXdp6k/WbthbSdSZ6x88YYk61aGMuk
         qZWWTni2tMStg2IvLwl3oZ8kqai8NN3chM11Sepi8oQjIa1CRlnVK1mKECni99Gdwt
         zyb6JCSaZcuhDmQhgp+6Z+Ll0T95cyMbZ2KijXWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 059/165] scsi: aic7xxx: Adjust indentation in ahc_find_syncrate
Date:   Thu, 27 Feb 2020 14:35:33 +0100
Message-Id: <20200227132240.091038761@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
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
index 64ab9eaec428c..def3208dd2905 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -2321,7 +2321,7 @@ ahc_find_syncrate(struct ahc_softc *ahc, u_int *period,
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



