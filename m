Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C80C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274942082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PM41rsZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgAQL7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:59:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60594 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgAQL7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:59:51 -0500
Received: from zn.tnic (p200300EC2F08DC0079C7688FDBAC99E0.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:dc00:79c7:688f:dbac:99e0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E25881EC0BED;
        Fri, 17 Jan 2020 12:59:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579262390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=AtJoha7l9Yk3LZHJbuIP73vlwlGWTrB83wUfhtrYGmM=;
        b=PM41rsZGaO7WoZoE0zClsOUYJWoakrJ4QIKQNLMrb92cSQ33f7r7WatCdgCrDEYq2ysHuA
        +5pp6O/I2GJr7I0DzTCFGTNufb7+nOWO1rpp5ACD/hkx1V1gSJw72XAYmbA1eFvGhjjRoj
        qqWouBbFaBIIsnpFqRSPjXB/Jtnl/8Q=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC/amd64: Do not warn when removing instances
Date:   Fri, 17 Jan 2020 12:59:39 +0100
Message-Id: <20200117115939.5524-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

On machines which do not populate all nodes with DIMMs, the driver
doesn't initialize an instance there. However, the instance removal
remove_one_instance() path will warn unconditionally, which is wrong.

Remove the WARN_ON() even if the warning is innocent because it causes a
splat in dmesg.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/amd64_edac.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 428ce98f6776..d2a6d3319650 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3573,9 +3573,6 @@ static void remove_one_instance(unsigned int nid)
 	struct mem_ctl_info *mci;
 	struct amd64_pvt *pvt;
 
-	mci = find_mci_by_dev(&F3->dev);
-	WARN_ON(!mci);
-
 	/* Remove from EDAC CORE tracking list */
 	mci = edac_mc_del_mc(&F3->dev);
 	if (!mci)
-- 
2.21.0

