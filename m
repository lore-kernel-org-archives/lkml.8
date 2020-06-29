Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7CAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F06C920656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462376;
	bh=otQohPXqkANx665QZ3wgVwDboaMYHBEovRL/MRrVTCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eD9b+k9zChyvy8a/28wIeeDYkWMcUaU5NLPTg0TtR2rnt8xMNaz55mJf2oy1REK9z
	 u0A/JeEojhdK1mdVERHIqTi4yuby9a668ZTPL+zHRBM0Lzin98juHkm6cdaPuj56GF
	 69lua0Q+exeNkNXSFbNYKq5/gPG6OgwKVMwUxrV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbgF2U0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732527AbgF2TZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 700F92534B;
        Mon, 29 Jun 2020 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445188;
        bh=otQohPXqkANx665QZ3wgVwDboaMYHBEovRL/MRrVTCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/tzF/mk9+1Wi2p1NRVq5OvhwBiXIhHhgwpSP7IJabTm5pT3PJUGBalsqtnDg+NEb
         couXuRMjGIdyspjf3SuUD9ELXEUWYEbkEazKzyTb9DUbxZ/Kulkkw/bZM3a6Xijxjq
         byxBhUq2b3InjjoRHfjmDIBSAA1EkpdqclO+jofw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 78/78] Linux 4.14.186-rc1
Date:   Mon, 29 Jun 2020 11:38:06 -0400
Message-Id: <20200629153806.2494953-79-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153806.2494953-1-sashal@kernel.org>
References: <20200629153806.2494953-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.186-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.186-rc1
X-KernelTest-Deadline: 2020-07-01T15:38+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5152fefccab54..34b7c6a3a9708 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 14
-SUBLEVEL = 186
-EXTRAVERSION =
+SUBLEVEL = 187
+EXTRAVERSION = -rc1
 NAME = Petit Gorille
 
 # *DOCUMENTATION*
-- 
2.25.1

