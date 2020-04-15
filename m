Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862DFC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF57206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586951628;
	bh=Sql1Qa0q1sxaK1NvXSoxR08DQdz4Luetn7Wwjl1NXMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p1shKFcFiyWYM8XmM9orJx9s/YsWnwKkzUlekmV8HbFrQvmpGflvZvAMF8IGRwnLR
	 vAVRYAPh38+KdvbL0YobECy3SIljRnw8+jpBcfTY0dGJCH2eTkUEpQmrDMJ68BuUzb
	 Cb0NrfDUksOiiJ8GVSs8V7aCcULYFzulOohSGFvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897834AbgDOLxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406163AbgDOLpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:45:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C511421582;
        Wed, 15 Apr 2020 11:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951117;
        bh=Sql1Qa0q1sxaK1NvXSoxR08DQdz4Luetn7Wwjl1NXMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OuncJ1NinoP6bEJqkbGrrURx91BViYuJmK5f8OhNqu4peomz/0h0dNDBUIm8qqRWA
         lrWFFVvY0Bz0WNr8yYuM/KWGRHxC2jPYI8js0tK2H4e7QkQpuGWD/mll4EKLwnK0Ex
         YJiiqgX0BS8s1giaLm8q0NUXpqf01wrhHTJlfzvI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.4 31/84] powerpc/prom_init: Pass the "os-term" message to hypervisor
Date:   Wed, 15 Apr 2020 07:43:48 -0400
Message-Id: <20200415114442.14166-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114442.14166-1-sashal@kernel.org>
References: <20200415114442.14166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

[ Upstream commit 74bb84e5117146fa73eb9d01305975c53022b3c3 ]

The "os-term" RTAS calls has one argument with a message address of OS
termination cause. rtas_os_term() already passes it but the recently
added prom_init's version of that missed it; it also does not fill
args correctly.

This passes the message address and initializes the number of arguments.

Fixes: 6a9c930bd775 ("powerpc/prom_init: Add the ESM call to prom_init")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200312074404.87293-1-aik@ozlabs.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/prom_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index eba9d4ee4baf6..689664cd4e79b 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1761,6 +1761,9 @@ static void __init prom_rtas_os_term(char *str)
 	if (token == 0)
 		prom_panic("Could not get token for ibm,os-term\n");
 	os_term_args.token = cpu_to_be32(token);
+	os_term_args.nargs = cpu_to_be32(1);
+	os_term_args.nret = cpu_to_be32(1);
+	os_term_args.args[0] = cpu_to_be32(__pa(str));
 	prom_rtas_hcall((uint64_t)&os_term_args);
 }
 #endif /* CONFIG_PPC_SVM */
-- 
2.20.1

