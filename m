Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA44EC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F8421941
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599496696;
	bh=Cs67b7b8aOKdlSY4NXgpobtUy8yeAmBH6EWwOpUJqEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N/K926/GVIoHObIn2huZpte9tLOb6XoxTUsFrkMRTPIEhziQhLJ3NsxZ5lqErLItY
	 QR8HjX4mqKgAovvMF7Gq11UGt2Zxs4neShds5uIyPbB2FdtPp7ig8IzhcDL1ciS72h
	 AbCDxhyUEoso9anzIx9ySLyoQW+ZKvxywUPjOfKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgIGQiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729878AbgIGQeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:34:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F4BD21D40;
        Mon,  7 Sep 2020 16:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496464;
        bh=Cs67b7b8aOKdlSY4NXgpobtUy8yeAmBH6EWwOpUJqEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RcLLHj0l0X04DIAW34reFt4vB4M0/g90Wg92HR5pYvhUhCxfrwwQjXjGTDEHEAOf7
         glsauiSYddTC/pAPLOB2QSDqLGgBBp/5B4x3Si9Joe5C+TSh/v4o/Tt4UC2sm9YShW
         ih8BTaNZaBK1Naj3Wg+Si4tnKcGr1CHPW/HdCSpM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Colin Ian King <colin.king@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 43/43] gcov: Disable gcov build with GCC 10
Date:   Mon,  7 Sep 2020 12:33:29 -0400
Message-Id: <20200907163329.1280888-43-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163329.1280888-1-sashal@kernel.org>
References: <20200907163329.1280888-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit cfc905f158eaa099d6258031614d11869e7ef71c ]

GCOV built with GCC 10 doesn't initialize n_function variable.  This
produces different kernel panics as was seen by Colin in Ubuntu and me
in FC 32.

As a workaround, let's disable GCOV build for broken GCC 10 version.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1891288
Link: https://lore.kernel.org/lkml/20200827133932.3338519-1-leon@kernel.org
Link: https://lore.kernel.org/lkml/CAHk-=whbijeSdSvx-Xcr0DPMj0BiwhJ+uiNnDSVZcr_h_kg7UA@mail.gmail.com/
Cc: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/gcov/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 3941a9c48f833..005d8b851bc18 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -4,6 +4,7 @@ menu "GCOV-based kernel profiling"
 config GCOV_KERNEL
 	bool "Enable gcov-based kernel profiling"
 	depends on DEBUG_FS
+	depends on !CC_IS_GCC || GCC_VERSION < 100000
 	select CONSTRUCTORS if !UML
 	default n
 	---help---
-- 
2.25.1

