Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BA7C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B7C22522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579113792;
	bh=EYn3cvBA+zKZZyuq+WQ0EKprn8+vzF11tgdyOEbIkzI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BtnrEDLOiDyq3zYZB+ZQY/GBWmZxh68zmy4h8KYyyFCliLTCe8dTOhs53QyB3Yh+z
	 vmHpB5bv4yDOBi0p5Vpdp0t9LheOYbP7Y4vDSEg9cFArRR1Pnkm7I0TtzRlITysjRL
	 qdvOXuo/w34JX7GYiZ2EFLlPIh8dFFqC4wLFJBhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgAOSnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:43:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAOSnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:43:11 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0175220728;
        Wed, 15 Jan 2020 18:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579113790;
        bh=EYn3cvBA+zKZZyuq+WQ0EKprn8+vzF11tgdyOEbIkzI=;
        h=From:To:Cc:Subject:Date:From;
        b=wGdhWFZoEOrLFAPd1W2WMEt146BJ/gYNPsZfSbluvNygAq1OLb0/3+kF1j7G3j9K5
         wAZgEWbxjWIhoAhSFQPmTDuPVItEyTBWO6KBBdHgzFjzhj2Oe34WKAzaF+TPphkAXi
         2qAIgW2yAh2knZCUz2Xv6m6oImdr1sD9PQlG8878=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH] Documentation: Call out example SYM_FUNC_* usage as x86-specific
Date:   Wed, 15 Jan 2020 18:43:05 +0000
Message-Id: <20200115184305.1187-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example given in asm-annotations.rst to describe the constraints that
a function should meet in order to be annotated with a SYM_FUNC_* macro
is x86-specific, and not necessarily applicable to architectures using
branch-and-link style calling conventions such as arm64.

Tweak the example text to call out the x86-specific text.

Cc: Mark Brown <broonie@kernel.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Will Deacon <will@kernel.org>
---

As an aside: if somebody could explain the high-level guarantees required
here for things like livepatching, then I'd be happy to try to put together
another patch adding an example for arm64. I'm currently not completely sure
about what is required in the face of things like leaf functions and tail calls.

 Documentation/asm-annotations.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index f55c2bb74d00..32ea57483378 100644
--- a/Documentation/asm-annotations.rst
+++ b/Documentation/asm-annotations.rst
@@ -73,10 +73,11 @@ The new macros are prefixed with the ``SYM_`` prefix and can be divided into
 three main groups:
 
 1. ``SYM_FUNC_*`` -- to annotate C-like functions. This means functions with
-   standard C calling conventions, i.e. the stack contains a return address at
-   the predefined place and a return from the function can happen in a
-   standard way. When frame pointers are enabled, save/restore of frame
-   pointer shall happen at the start/end of a function, respectively, too.
+   standard C calling conventions. For example, on x86, this means that the
+   stack contains a return address at the predefined place and a return from
+   the function can happen in a standard way. When frame pointers are enabled,
+   save/restore of frame pointer shall happen at the start/end of a function,
+   respectively, too.
 
    Checking tools like ``objtool`` should ensure such marked functions conform
    to these rules. The tools can also easily annotate these functions with
-- 
2.25.0.rc1.283.g88dfdc4193-goog

