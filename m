Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBD3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4A620657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826068;
	bh=hvqqDYaM6AyhaXkWz7Zgch97q9DfaBBza48GIAW7nbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cCOqzBSasz8PHR8p+KjRlgLs9H8TeY/yIjkEFnsmVXdw32mdgbDl+VZCr7Mh8rnLM
	 qu+iGKuVV13On9CBXg0RN/MsGbtcEUmK+PsVjDsuWHyTPRe6b24WtA5Cwgnh038649
	 RJhFAtf+EHJaq5xWIk/Q5lfsVhdpDujfK3GX+F4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbgERSVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730293AbgERRwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:52:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D49A320715;
        Mon, 18 May 2020 17:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824329;
        bh=hvqqDYaM6AyhaXkWz7Zgch97q9DfaBBza48GIAW7nbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bNreGVXLzIAlPjc6ThxNLAVIwYvjoeu8HJAeeiNVCFnwjIDhxcnNMopUcIsCeoWYP
         MAXqxH7ZtlUUmcbaCDRMnpAIexmsnST/IMVBhKK+zh8vP4iPXT+iCFa/D/N/eDx/Ia
         F2EwTVFxPLkyX269g2K3TX/ohCgv+vH2rgYMEfKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 48/80] gcc-10: disable zero-length-bounds warning for now
Date:   Mon, 18 May 2020 19:37:06 +0200
Message-Id: <20200518173500.146875633@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.097837707@linuxfoundation.org>
References: <20200518173450.097837707@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 Makefile |    3 +++
 1 file changed, 3 insertions(+)

--- a/Makefile
+++ b/Makefile
@@ -792,6 +792,9 @@ KBUILD_CFLAGS += $(call cc-disable-warni
 # disable stringop warnings in gcc 8+
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
+# We'll want to enable this eventually, but it's not going away for 5.7 at least
+KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
+
 # Enabled with W=2, disabled by default as noisy
 KBUILD_CFLAGS += $(call cc-disable-warning, maybe-uninitialized)
 


