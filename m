Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B144C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3432064B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CsFSfEo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgGHSpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGHSpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:45:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58516C061A0B;
        Wed,  8 Jul 2020 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=X5sU3Y5k7l2zx5kjwIM6nayHkuGkr91LnvbglkYd9lI=; b=CsFSfEo04Q3L53He7i0fyJ9Brb
        SFAZ2fXipfdBoRl9NQlrDcJGwq/174xvbrf2xGycN/H4Kw4uQJLDvofeJ5QyrSinSbrLbhI3TC8+T
        wUrCQvZkmLlQ7i7tW+3Oj8qeLwY1MDcJBVyUJwI8+nR1l7N8PaUuKah+Oy2MqCsn1Cxw/uw9wgGcK
        8IvHtocnt/JOWWbXMic0krhLmYaHyzrOASQLgsJ/EFrkPhKHr80qe6jm80SKmIIlUL5b8sRxqYCO1
        OmeoQErek4er5x+76761nLwbDKu5BbE4n6UFcMCiIe5H+lkqQy8MxGUzCkpXs1aoagCoWfXRZQP4s
        dEOVOWCw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtF42-00045C-V0; Wed, 08 Jul 2020 18:45:03 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: update for gcc 4.9 requirement
Message-ID: <a98e9c26-5405-3894-6197-3f5e388a5698@infradead.org>
Date:   Wed, 8 Jul 2020 11:44:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Update Documentation for the gcc v4.9 upgrade requirement.

Fixes: 6ec4476ac825 ("Raise gcc version requirement to 4.9")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/admin-guide/README.rst |    2 +-
 Documentation/process/changes.rst    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200708.orig/Documentation/admin-guide/README.rst
+++ linux-next-20200708/Documentation/admin-guide/README.rst
@@ -258,7 +258,7 @@ Configuring the kernel
 Compiling the kernel
 --------------------
 
- - Make sure you have at least gcc 4.6 available.
+ - Make sure you have at least gcc 4.9 available.
    For more information, refer to :ref:`Documentation/process/changes.rst <changes>`.
 
    Please note that you can still run a.out user programs with this kernel.
--- linux-next-20200708.orig/Documentation/process/changes.rst
+++ linux-next-20200708/Documentation/process/changes.rst
@@ -29,7 +29,7 @@ you probably needn't concern yourself wi
 ====================== ===============  ========================================
         Program        Minimal version       Command to check the version
 ====================== ===============  ========================================
-GNU C                  4.8              gcc --version
+GNU C                  4.9              gcc --version
 GNU make               3.81             make --version
 binutils               2.23             ld -v
 flex                   2.5.35           flex --version

