Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA24AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5AC2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483349;
	bh=LIAMOJa5wfbbix5mguD+xD+vK9hdv1xD7K/rHhBz43g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mPIkmozBP+dNF7LjtHEEmeO/EzCk8CAWUjtbQ3zWe6rzFt0j6dPEybq6zATJpCcMX
	 QOWzk3iGQVZX2oAf62vER3H5QfAcLw27A4/jONsrBV3XJqH0tfoj6TRd+feRF175WB
	 mGZDmU57dFrRITqJ8wPzCLk3lNuY5Hyr7voA2QCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgENTJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbgENSxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:53:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4FAB207D4;
        Thu, 14 May 2020 18:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482380;
        bh=LIAMOJa5wfbbix5mguD+xD+vK9hdv1xD7K/rHhBz43g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bORhiR2KWc9RumwqGGlRd6NjeSn56vPFf5XttCKDDIq2Q8jSJKUsByKNs4DKj4nYJ
         fkSyrU/nC49qN8gTN+9n7iD04sdNKqJgNLv5VF9gTgm1dJv0GkMcFpaA8+l7+B9b/1
         Pz6Pz5EmUmR8BNrsRx5Z9AVrrCQhGgtJqlBEA7Ng=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 57/62] gcc-10: disable 'stringop-overflow' warning for now
Date:   Thu, 14 May 2020 14:51:42 -0400
Message-Id: <20200514185147.19716-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185147.19716-1-sashal@kernel.org>
References: <20200514185147.19716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 5a76021c2eff7fcf2f0918a08fd8a37ce7922921 ]

This is the final array bounds warning removal for gcc-10 for now.

Again, the warning is good, and we should re-enable all these warnings
when we have converted all the legacy array declaration cases to
flexible arrays. But in the meantime, it's just noise.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index bc5e9a5fc5cbf..dde725d9c17d2 100644
--- a/Makefile
+++ b/Makefile
@@ -861,6 +861,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 # We'll want to enable this eventually, but it's not going away for 5.7 at least
 KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
 KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
+KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
 
 # Enabled with W=2, disabled by default as noisy
 KBUILD_CFLAGS += $(call cc-disable-warning, maybe-uninitialized)
-- 
2.20.1

