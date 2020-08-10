Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1B2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6B42075D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597072899;
	bh=tXAco+/hJuVY5Hoz8JSM+n9qDLrtNpmiQ6NZFbHlv64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W/WoX1kJwlxSoUjZtlVWjGFsZF8JPN0SHye1bqlQCabvzdhjusL0O+fg4jvlwNUoO
	 ZhLK0f6Re55qxKM6/9/8lF7RopjI2JUDaQKq21l9XkkMWeQyZEaG7wiGi/cd+hKSj4
	 0E0lPf+7wWaH1M/lnkATwCOcDvsN2jmxi5Ey6ygw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgHJPVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbgHJPUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:20:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB0220656;
        Mon, 10 Aug 2020 15:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597072844;
        bh=tXAco+/hJuVY5Hoz8JSM+n9qDLrtNpmiQ6NZFbHlv64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enE62gD+mp9pcW2BNWdMesytF7So6QucNm8eqnqAvmnXN+OLWmfE61Uj9P8K17wNq
         58vRYRaetpoVKBcdifxgtJe37GSIVYBdFbtR7NTEzodkUG1o+it41XPt6W5M5GKUdz
         OO9CI/YByWWYXAKXHrX1X8rBjHEE2yX6zeITf0h0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
Subject: [PATCH 5.8 37/38] random: random.h should include archrandom.h, not the other way around
Date:   Mon, 10 Aug 2020 17:19:27 +0200
Message-Id: <20200810151805.749334782@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151803.920113428@linuxfoundation.org>
References: <20200810151803.920113428@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 585524081ecdcde1c719e63916c514866d898217 upstream.

This is hopefully the final piece of the crazy puzzle with random.h
dependencies.

And by "hopefully" I obviously mean "Linus is a hopeless optimist".

Reported-and-tested-by: Daniel Díaz <daniel.diaz@linaro.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/archrandom.h |    1 -
 arch/arm64/kernel/kaslr.c           |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm64/include/asm/archrandom.h
+++ b/arch/arm64/include/asm/archrandom.h
@@ -6,7 +6,6 @@
 
 #include <linux/bug.h>
 #include <linux/kernel.h>
-#include <linux/random.h>
 #include <asm/cpufeature.h>
 
 static inline bool __arm64_rndr(unsigned long *v)
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -11,8 +11,8 @@
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/pgtable.h>
+#include <linux/random.h>
 
-#include <asm/archrandom.h>
 #include <asm/cacheflush.h>
 #include <asm/fixmap.h>
 #include <asm/kernel-pgtable.h>


