Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9E1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08297207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461173;
	bh=yq5v9GFR3nQRyLwxruwPhH9dHuZJJnO9qRvov30S4b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yoc3r7WiSZsT7ftLXYpVk1auWFn7UeCl8bJaHDCw+oN/W4Bzd9CuvQ2TQMdDsp3tz
	 J/qLTltRuHyeeG1eoMzKU50vxDlPpdITE6kvf5FfChJrwRhXLGKvr6Lawu1/MrqZYA
	 ljcNubvpF37LrZU3A/HKiWekegcna7jwyuJEnngI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbgF2UGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732971AbgF2Ta2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF7EA252C3;
        Mon, 29 Jun 2020 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445034;
        bh=yq5v9GFR3nQRyLwxruwPhH9dHuZJJnO9qRvov30S4b8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AHsgFQzRjZz+xAAaay7CDBXzeQMfcJNIMbCJfAaTTxx5aayiJv3F7kdOQYUHRsB77
         uOd1qW4vu/GUoqOXV3ib+JBvd3o6mB1lK9a/a79jmAoxqqApsEX59IY+6mxfSNC2uP
         o56svCVWPl2NNNL8GIGDobZYoH99F4nitZq5482c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 131/131] Linux 4.19.131-rc1
Date:   Mon, 29 Jun 2020 11:35:02 -0400
Message-Id: <20200629153502.2494656-132-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
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
index 6443cbd51f704..1ba4ddc0c04d6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 130
-EXTRAVERSION =
+SUBLEVEL = 131
+EXTRAVERSION = -rc1
 NAME = "People's Front"
 
 # *DOCUMENTATION*
-- 
2.25.1

