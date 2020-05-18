Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCC9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E04520674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823934;
	bh=TkyQUb/hHwF5Zmma86qgaGPQM3IxEGf+vjAG8OOTAOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gw34lhP71zR3DHLkETR92HmEThnXm5BHZ82+F+0R8PzJZUr5hkN6WyukALECtLpi+
	 TbtBsw6PUPf+XKamHkuLwJs6TLsKNSzgpuTNyXxAitlCJp+A5C/GJf4QBkO+epFS55
	 edkcLDzG5p6dYmsowMGH7eK7aYH0XceRm97T+wEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgERRpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbgERRpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:45:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B02B420671;
        Mon, 18 May 2020 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823925;
        bh=TkyQUb/hHwF5Zmma86qgaGPQM3IxEGf+vjAG8OOTAOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P12pIEqPU9Y2R3hvSjzEzu7yWym/iJm/sSpyiyn6HI9zzqAAsPunhcsOp0fhLWkXK
         0YZGE481DpdGNlBgGdrWXwAFAqGNW6ogkZwS2YGhWnSCu3/u2K1zOuo7DKngdiWeyl
         7OhzwMbiFpcAN6QTQ36sZwzKHD9hNPlpZEz0uAaU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 66/90] gcc-10: disable stringop-overflow warning for now
Date:   Mon, 18 May 2020 19:36:44 +0200
Message-Id: <20200518173504.566882619@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/Makefile
+++ b/Makefile
@@ -800,6 +800,7 @@ KBUILD_CFLAGS += $(call cc-disable-warni
 # We'll want to enable this eventually, but it's not going away for 5.7 at least
 KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
 KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
+KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
 
 # Enabled with W=2, disabled by default as noisy
 KBUILD_CFLAGS += $(call cc-disable-warning, maybe-uninitialized)


