Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B906C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E398E21655
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658099;
	bh=cgUYMErB9r6HbfGLgWyshyjnWnZmYU1Bzyo9r7qAdR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dOIO2QV68Qv35mU7S+Tv6DLNKvP4wIY+ehRM54ZFrvWlfyTBdfAhSUhyQXpZ+rK4o
	 nHOrnExlmNHr+1qUwPMgKh3wJNIE/rl2A+eqs+/dRA3anOCDYmAk3BvhZZ9I2N0Hyu
	 Ea3GiZBorToynTVaRZ4iNGLXN//KG+vRY3TIlgLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgFHXO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbgFHXM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:12:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A4FC212CC;
        Mon,  8 Jun 2020 23:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657948;
        bh=cgUYMErB9r6HbfGLgWyshyjnWnZmYU1Bzyo9r7qAdR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SONunF+N7KKsA8pEWawqYoXtKHpIQGrROsGlbMZHT9WBx0vb1bshs6lwDjJ6pz0Ic
         ZXaDdeuQLhGN3LxZrTeRYovUJy6MrNQoPJVFu+XNehKsgN02cYp1WcrZXuZLuemLmD
         NEvV3amieVOVdXr97ymNH7wdFO95A2za1US+UATs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 013/606] gcc-10: disable 'stringop-overflow' warning for now
Date:   Mon,  8 Jun 2020 19:02:18 -0400
Message-Id: <20200608231211.3363633-13-sashal@kernel.org>
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

commit 5a76021c2eff7fcf2f0918a08fd8a37ce7922921 upstream.

This is the final array bounds warning removal for gcc-10 for now.

Again, the warning is good, and we should re-enable all these warnings
when we have converted all the legacy array declaration cases to
flexible arrays. But in the meantime, it's just noise.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index e7c2811856f1..8584003bfbca 100644
--- a/Makefile
+++ b/Makefile
@@ -860,6 +860,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 # We'll want to enable this eventually, but it's not going away for 5.7 at least
 KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
 KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
+KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
 
 # Enabled with W=2, disabled by default as noisy
 KBUILD_CFLAGS += $(call cc-disable-warning, maybe-uninitialized)
-- 
2.25.1

