Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD4820657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826058;
	bh=cPyfDb2Pdf94PTooJ3wZouXnsU4rhHIHbOtfQvpJ4oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NMVdVCMIRHWANpGVdgA9LqhbO3KYePV8H0vHwqAnguAg0WGT+zc5+z/PEhDV6e49c
	 isu8juxEyssYpEuy6FDLkr2TSM4/wdvo9wpBhnNlVCt8LS8kLFWOT2cvX4lT4JS2G7
	 Ore/EQPASmy/yIXC4dRZn/UlcNd+6WjQrccS+ddo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbgERSU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730169AbgERRwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:52:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C044020674;
        Mon, 18 May 2020 17:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824334;
        bh=cPyfDb2Pdf94PTooJ3wZouXnsU4rhHIHbOtfQvpJ4oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WnLnCqBgumqLoc4f2sRSGFNmKMMcW2Yg+qcGMoNt+CKq4Q1TFmxAYYReCkCkTnHsu
         AP770oS/MMaER63kc82wKcv+seDjQRnxvGySALfw+8bRoH96zu9Udt0khXTS1DL/4R
         ANByZnHmBwfYxF6MTcADwmY+NraV/VmA0bS13GHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 50/80] gcc-10: disable stringop-overflow warning for now
Date:   Mon, 18 May 2020 19:37:08 +0200
Message-Id: <20200518173500.519400870@linuxfoundation.org>
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
@@ -795,6 +795,7 @@ KBUILD_CFLAGS += $(call cc-disable-warni
 # We'll want to enable this eventually, but it's not going away for 5.7 at least
 KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
 KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
+KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
 
 # Enabled with W=2, disabled by default as noisy
 KBUILD_CFLAGS += $(call cc-disable-warning, maybe-uninitialized)


