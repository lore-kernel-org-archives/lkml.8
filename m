Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90576C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7389220674
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460564;
	bh=xhWJChz3SBbtpKFTF6zZ2aiylfuY2mpZ7sYn66iPeus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o9efaAYe9F/0FKWwYIeGlWOyY+TFiu9oCKNFiXmdajAx4/sDVRMEBwHGFY154on6+
	 5OG0tuluNjYGu8VpTe3hSLUwdrCQNZeeOpxwoeR8l066DD7oBedQi5lgcj7YqsMFnJ
	 7n8vWjopoIYqwI0TECqQZuM8WAzShc2Kkk5MltUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbgF2T4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387657AbgF2TkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E3F3251DD;
        Mon, 29 Jun 2020 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444500;
        bh=xhWJChz3SBbtpKFTF6zZ2aiylfuY2mpZ7sYn66iPeus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcvsmngxQd9/gC1BZ5raLc3Jr+v1GySoQhajcpu04X8qv+NNx62GkaXxtUvsZ6xf4
         0ZZQdCi98PRwYcuDYawx/eGqrrEcNycCIexFFMAdbZekZn7KhNhn9bmb7mM9Nt8LnO
         3ZL142ODn4C89qYpWEBPrtRDdAhKQUJN1EmpEQPM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 178/178] Linux 5.4.50-rc1
Date:   Mon, 29 Jun 2020 11:25:23 -0400
Message-Id: <20200629152523.2494198-179-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
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
index 72230ad23299d..c68def87a88ad 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 49
-EXTRAVERSION =
+SUBLEVEL = 50
+EXTRAVERSION = -rc1
 NAME = Kleptomaniac Octopus
 
 # *DOCUMENTATION*
-- 
2.25.1

