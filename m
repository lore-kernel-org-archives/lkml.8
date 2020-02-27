Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FA6C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351DE24693
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dvCJhmsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgB0Lba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:31:30 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:40704 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbgB0Lb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:31:29 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3F297C00A7;
        Thu, 27 Feb 2020 11:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582803089; bh=HjU3/UYAvX0diKwyd/eFtyAIBjvPB4/hJGXSga3A9jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=dvCJhmsLtvnHfMu2mhVLbmZn4aW0d9OQKp2e4R2ukjhQhitHpGa2S1Rk/4OOYjNyQ
         Rv4TvEn1f6/k+bLg7s79B2ewFW4Lcv7xj99EedcfC8/MD6SllAww5iHYqfh1hDC/0H
         u/RlzMvdcT8CUTFwaMctgm+/V2FZYpg2dREiazR7WvULBN1dwjNhlD8eNqayimlizn
         E0A9Dq/g1k1KBFbs8o3VdKIcygW66aReHoKAwDG/JScCyBVdbg0ASNAXqh2v149MRI
         1ZM8Lze4Jd6j2Wz6prIH3ZHSJ7aQCZE/ub6/0uGLaA5guV5dQNqKDypH6ohqw74/t1
         pMKskfVaXlnrA==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8755CA0061;
        Thu, 27 Feb 2020 11:31:26 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 57A443E9E1;
        Thu, 27 Feb 2020 12:31:26 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     pgaj@cadence.com, bbrezillon@kernel.org,
        linux-i3c@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v2 1/4] i3c: Fix MODALIAS uevents
Date:   Thu, 27 Feb 2020 12:31:06 +0100
Message-Id: <9ac5f1f8413fbb0481de76b5e43f2f4e1b2dc49f.1582796652.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1582796652.git.vitor.soares@synopsys.com>
References: <cover.1582796652.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1582796652.git.vitor.soares@synopsys.com>
References: <cover.1582796652.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@collabora.com>

file2alias uses %X formatters. Fix typos in the MODALIAS uevent to print
the part and ext IDs in uppercase.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index b56207b..b6db828 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -267,7 +267,7 @@ static int i3c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 				      devinfo.dcr, manuf);
 
 	return add_uevent_var(env,
-			      "MODALIAS=i3c:dcr%02Xmanuf%04Xpart%04xext%04x",
+			      "MODALIAS=i3c:dcr%02Xmanuf%04Xpart%04Xext%04X",
 			      devinfo.dcr, manuf, part, ext);
 }
 
-- 
2.7.4

