Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3C7C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60B524955
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340239;
	bh=lX7GO5zZRgBAxgEabLCkym2MplVXRl3kwn5k981MtVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1F5DgMmrq5C5TA6pe4N2phmEZP3v4LhP96mM2Y9tPpd4qHeham1nDGYVBcLTgXyWo
	 p/Akalz+/JFyGSeWngxZzUQ6Rvu3zREtp+3bgvIPkB/t+8eiWanS5idUMkj8IrA8ya
	 v/0ZtrqKXK0KdjGlHzbyrOA0ZRgEHD49lFbJrPgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbgEANhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730933AbgEANhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:37:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1980A24953;
        Fri,  1 May 2020 13:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340227;
        bh=lX7GO5zZRgBAxgEabLCkym2MplVXRl3kwn5k981MtVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pwLzLcXswMdeSyvK9rI7qw1A6SHhBOJBORsCWNXy9YpPsKIlQbupXum0Epz2tEVp+
         J+bbp1A+K39Mbj0SNcRmKD2EpHLRfaXe3Xk7NckXVz5mVyhFBcR8pMsaSS8wAHUoVS
         oGqtN+k48ngIwLL4EQnIGMqlNt+gayQ3wDRFQWaA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olaf Hering <olaf@aepfle.de>,
        Wei Liu <wei.liu@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 29/46] x86: hyperv: report value of misc_features
Date:   Fri,  1 May 2020 15:22:54 +0200
Message-Id: <20200501131509.204198464@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131457.023036302@linuxfoundation.org>
References: <20200501131457.023036302@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index fc93ae3255153..f8b0fa2dbe374 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -214,8 +214,8 @@ static void __init ms_hyperv_init_platform(void)
 	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
 
-	pr_info("Hyper-V: features 0x%x, hints 0x%x\n",
-		ms_hyperv.features, ms_hyperv.hints);
+	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
+		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
 
 	ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
 	ms_hyperv.max_lp_index = cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
-- 
2.20.1



