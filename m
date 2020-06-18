Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B044C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14FD221FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444350;
	bh=FgYJtY6YjowxDgILyIBUCt/OhaAvMobU2W8m+To8XUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bIJG4xvzxtf7tqnkUPtkmQKmz/JwC75D83GwA2rERP9AUDIO+hWIWS0Gtg8MSPs2x
	 OmTSgq2hLUkWbgkWEOzA6j0JenoJeyLjEsx8EEAAMmHySt86CLSQZw/2HGx5+Q+ReU
	 JRMzPCk532/s+MOJsqJUf14LjoU/i59R7Kow81/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgFRBjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:39:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732508AbgFRBaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:30:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3644A207E8;
        Thu, 18 Jun 2020 01:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443822;
        bh=FgYJtY6YjowxDgILyIBUCt/OhaAvMobU2W8m+To8XUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ASz2RAxhkqzGuEADwS708RmmdvDhKrB40qdbn7gcOV1qJ2hZJObJwtZ62PrPTTg2
         m/UL5mDVPv4Qts0CwVJYZfYiIugXhPnoAoFPje88O1PIiGE6kiSWwXKx60260B6jra
         qrBTkqoYhfzYCr3NxKFwNOw1k4gHnlWsxk+7ZBT0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kajol Jain <kjain@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 14/60] powerpc/pseries: Update hv-24x7 information after migration
Date:   Wed, 17 Jun 2020 21:29:18 -0400
Message-Id: <20200618013004.610532-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618013004.610532-1-sashal@kernel.org>
References: <20200618013004.610532-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kajol Jain <kjain@linux.ibm.com>

[ Upstream commit 373b373053384f12951ae9f916043d955501d482 ]

Function 'read_sys_info_pseries()' is added to get system parameter
values like number of sockets and chips per socket.
and it gets these details via rtas_call with token
"PROCESSOR_MODULE_INFO".

Incase lpar migrate from one system to another, system
parameter details like chips per sockets or number of sockets might
change. So, it needs to be re-initialized otherwise, these values
corresponds to previous system values.
This patch adds a call to 'read_sys_info_pseries()' from
'post-mobility_fixup()' to re-init the physsockets and physchips values

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200525104308.9814-6-kjain@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/mobility.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 8d30a425a88a..58ddc4389a51 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -326,6 +326,9 @@ void post_mobility_fixup(void)
 	/* Possibly switch to a new RFI flush type */
 	pseries_setup_rfi_flush();
 
+	/* Reinitialise system information for hv-24x7 */
+	read_24x7_sys_info();
+
 	return;
 }
 
-- 
2.25.1

