Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61EDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C65206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467264;
	bh=jdiMQr74Yq2b5xzRJm8F6KeMfVMUP2Cub25O16tZpEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LhjZq2d8esqoPOcubqxaJuAMZPhgYUIlSt4ULY6FhTKse51v66M5CvPUqAmQFKr9Q
	 Muh7OWvUjWukTWsWHchm56B/hRRadvX/rSqRvqBRufPEShyMVf65txsj8i5imR3ZGu
	 5RPBrDBp7dRx6l1Xe4BKyfs8Nf9337fGrfT265Dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404248AbgF2Vrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgF2Sfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D46247FD;
        Mon, 29 Jun 2020 15:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444158;
        bh=jdiMQr74Yq2b5xzRJm8F6KeMfVMUP2Cub25O16tZpEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGjRo4XDZVDsRuKBN0OHfECxgUVkrJKlICu9IZHSz0a4Z0DZixTR3G925BwcDOP8T
         serqgrfbQoxKuabuG5oXXOHqe+koQUnwtokLh1LlBu1py8hGnumiA+JEli/K0HsTQr
         ENiRW7+i0GA0cq015ZgUMZ1gQy3pww/sbsDKE1o4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 265/265] Linux 5.7.7-rc1
Date:   Mon, 29 Jun 2020 11:18:18 -0400
Message-Id: <20200629151818.2493727-266-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
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
index f928cd1dfdc17..a07567cf0754f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 7
-SUBLEVEL = 6
-EXTRAVERSION =
+SUBLEVEL = 7
+EXTRAVERSION = -rc1
 NAME = Kleptomaniac Octopus
 
 # *DOCUMENTATION*
-- 
2.25.1

