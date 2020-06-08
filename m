Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEF3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5497121655
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658096;
	bh=oX/tieRFaB/cwnlPqM+xp17g7FUizixhpkom2w5vXmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IqU7zWljtJUfWi2oXj2MuKlbimeXmQl+r5+AaoAp45plFXGOk4t1p3WJ9uwwSOWrW
	 Q9LPKb/kv/RvhwqzWheL1gNFnOxia3f7shLNDSe8zSUSp14vk03ji19AzXy/kfyFuX
	 xt8KIjp7r/U32c5OpMSmam+zlkrIy+6aBHuz2eE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgFHXOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:14:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbgFHXM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:12:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F5520B80;
        Mon,  8 Jun 2020 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657946;
        bh=oX/tieRFaB/cwnlPqM+xp17g7FUizixhpkom2w5vXmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bccYW7XpXNETmRf22l/qPSkXb8um4JLq0kqabKwmFs4b6tF5x1oXBYCLG/9eMJo3z
         /WYedBIP/wm37669YXtLHFRHh95inSiqA0ptD2mxvL8GN6E74agIAeYxJWoXXwqUl5
         mZfMqSyrxtKok3ruw//XG8YfkR9heyoFGbF/+0Vk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 011/606] gcc-10: disable 'zero-length-bounds' warning for now
Date:   Mon,  8 Jun 2020 19:02:16 -0400
Message-Id: <20200608231211.3363633-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 5c45de21a2223fe46cf9488c99a7fbcf01527670 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index d4938ac6ebbf..b1ce2a7a25b0 100644
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
2.25.1

