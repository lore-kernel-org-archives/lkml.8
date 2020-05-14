Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C2CC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9242F2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483108;
	bh=vsTKuHrKkE/7x8B7/4x31pbZ2FUZOb26c9ExD8o/O/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GaVjUf5f37VulTzMnDMZ6/anZSHQyq0Xny75y2wjLo4P/qZ2n9u0NN8zAWaHjB2IV
	 fQuHfYifrHEQ4QD2HM4Oe/tCDp5sy8q286uN1fLr4CDeY3367d1fa2H0fQUOnRyA4E
	 4vB8i9Uor45QmWz+4tEpopVamsE+Vx+u6AFzyMDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgENSyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbgENSyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:54:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 099E320767;
        Thu, 14 May 2020 18:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482443;
        bh=vsTKuHrKkE/7x8B7/4x31pbZ2FUZOb26c9ExD8o/O/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=daH3/IOJ/sktMQkrqDozZKh6tpkwFbXd1cbfWFKBOMXNGBATHgeNofJlZoIknJGA1
         oQ6uB07IFj5/Gm58KiXJrGjcbd4XorsBo/XUDNiL2hLV3rdCk29HQrAKjWz7XNsY1G
         uzZibnFFalnmd3WkP4drQQVsdBl1BNa1F3CAIcNo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 42/49] gcc-10: disable 'zero-length-bounds' warning for now
Date:   Thu, 14 May 2020 14:53:03 -0400
Message-Id: <20200514185311.20294-42-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185311.20294-1-sashal@kernel.org>
References: <20200514185311.20294-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 5c45de21a2223fe46cf9488c99a7fbcf01527670 ]

This is a fine warning, but we still have a number of zero-length arrays
in the kernel that come from the traditional gcc extension.  Yes, they
are getting converted to flexible arrays, but in the meantime the gcc-10
warning about zero-length bounds is very verbose, and is hiding other
issues.

I missed one actual build failure because it was hidden among hundreds
of lines of warning.  Thankfully I caught it on the second go before
pushing things out, but it convinced me that I really need to disable
the new warnings for now.

We'll hopefully be all done with our conversion to flexible arrays in
the not too distant future, and we can then re-enable this warning.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 68708ae07fbd3..49c74e8b55df4 100644
--- a/Makefile
+++ b/Makefile
@@ -857,6 +857,9 @@ KBUILD_CFLAGS += -Wno-pointer-sign
 # disable stringop warnings in gcc 8+
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
+# We'll want to enable this eventually, but it's not going away for 5.7 at least
+KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
+
 # Enabled with W=2, disabled by default as noisy
 KBUILD_CFLAGS += $(call cc-disable-warning, maybe-uninitialized)
 
-- 
2.20.1

