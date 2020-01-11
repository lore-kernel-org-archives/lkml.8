Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2ECC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F5E20848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738287;
	bh=QOJ/HmWlN3DYN2V57jaXJYrIYWXf794kujwxayZsLBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=flsSE+SoDia3r7yjJ3Ok8HIeN8ZY9YUiS7ErrlmbNiXtANUaft3V3zAsKfxTj15kW
	 UpXSu5DH+HjmeuBTRGtuI/tQ7L8BLhShKWlS/aHcSwCM/wUdbw6m1OwWCWaIhacjad
	 rQF/qW90bFLtbm44oKSW8O0lVo6rYbqhUD4npqz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbgAKKYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:24:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:54164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731011AbgAKKYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:24:43 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C4EE205F4;
        Sat, 11 Jan 2020 10:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738283;
        bh=QOJ/HmWlN3DYN2V57jaXJYrIYWXf794kujwxayZsLBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MjUZplPeTunXdYqURAg8l6BJfUeplbYT/n9O7UJpauo8vvd/fNpEsb0a6+wVm3NzH
         IYbgjqK+CDnyU+RFchoaSvCpZ3YYRvJZHsPvG1a9Ss604UA7cVkbM+UAGKVwTJKKxi
         O5/AHuz7UVapfGJ4THdA04Ajw+KL3xAi0Vqj9BUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 050/165] ARM: omap2plus_defconfig: Add back DEBUG_FS
Date:   Sat, 11 Jan 2020 10:49:29 +0100
Message-Id: <20200111094925.603072836@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit e00b59d30506dc9ef91caf2f3c584209cc9f61e4 ]

Commit 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_FS dependency")
removed select for DEBUG_FS but we still need it at least for enabling
deeper idle states for the SoCs.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 40d7f1a4fc45..4ec69fb8a698 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -552,5 +552,6 @@ CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_SPLIT=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
 CONFIG_SCHEDSTATS=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
-- 
2.20.1



