Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92281C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BFCB217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731277;
	bh=cQVFE2oXggkz34TEBtKvHUTAk0MrHQLs86Hg/SE6S/I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=T52UiKZx0j3Bzs8e7rHDroRKEUPu39bCfS/pW8t00bU0oj798LlWhZuRBa5ysrX/N
	 HpNNYwACLdGH2a+9DKMRLfYno8fK5650hMYZjUToTyKN44QYhG1p/a/MNtMDBFikVg
	 rR8MJodyjbCiA+A0X5qLQl/90+kay9qtXtHHuBEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgDXMY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbgDXMYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:24:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 617D121569;
        Fri, 24 Apr 2020 12:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731061;
        bh=cQVFE2oXggkz34TEBtKvHUTAk0MrHQLs86Hg/SE6S/I=;
        h=From:To:Cc:Subject:Date:From;
        b=N2xjMA/7jb9BEyfQ2fySJTd5Hvpd1vinwJP6NZn/F9Wr4qOkZde2JQ5PkpmcwGKz0
         nEoPwy8OxR9zGX9SvFYcXsenKZvjuyYqiyemveWwhOakGIAZUGRPxbpJiKoxVu+CEL
         nak3StgrgZZDgh6DmkZBfZfepUuJcaUhyiVAm4j8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olaf Hering <olaf@aepfle.de>, Wei Liu <wei.liu@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 01/21] x86: hyperv: report value of misc_features
Date:   Fri, 24 Apr 2020 08:23:59 -0400
Message-Id: <20200424122419.10648-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olaf Hering <olaf@aepfle.de>

[ Upstream commit 97d9f1c43bedd400301d6f1eff54d46e8c636e47 ]

A few kernel features depend on ms_hyperv.misc_features, but unlike its
siblings ->features and ->hints, the value was never reported during boot.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Link: https://lore.kernel.org/r/20200407172739.31371-1-olaf@aepfle.de
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mshyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c0201b11e9e2a..a6b323a3a6304 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -178,8 +178,8 @@ static void __init ms_hyperv_init_platform(void)
 	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
 
-	pr_info("Hyper-V: features 0x%x, hints 0x%x\n",
-		ms_hyperv.features, ms_hyperv.hints);
+	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
+		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
 
 	ms_hyperv.max_vp_index = cpuid_eax(HVCPUID_IMPLEMENTATION_LIMITS);
 	ms_hyperv.max_lp_index = cpuid_ebx(HVCPUID_IMPLEMENTATION_LIMITS);
-- 
2.20.1

