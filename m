Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3795DC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F34B2467B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272964;
	bh=mZ3fx8mTTL31/4gxDSr6omrV4zrRgZozY8m6tMPa8Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jhnfpa3SLcloSVyHf05Yuz0u5QoYl0VGCXg4cpqVZ3MjBdnY1zTbeKM7roGz4yCh6
	 tIjNZrJcZDhT6jVc1c33tK9JD3sBZFX7+pFJMYFSAyMxhcB2WhMmC5hTEIKcIbAEjr
	 H4bW2WC2ozIva/Kr36lN3mOX+JXlwmDVUttL9OHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbgBUIQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:16:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733131AbgBUIPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:15:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4849C2467B;
        Fri, 21 Feb 2020 08:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272953;
        bh=mZ3fx8mTTL31/4gxDSr6omrV4zrRgZozY8m6tMPa8Eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AfgtVfimCivTdV+/QQJVBdBsZqj/UHkjfXDAivHIk6Dr1pw/qoc6rgT2+9TKcXe9H
         yh+W5uHn90u9jw9gatmbnQxQJORz2ZrlXivh+gxdUyyWU/87pKgO8kWy0J+dvF3nH/
         PeJh+5Gi5+7djnM3Z3ntFIVlu1PnOh1aHW0KrDNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 330/344] asm-generic/tlb: add missing CONFIG symbol
Date:   Fri, 21 Feb 2020 08:42:09 +0100
Message-Id: <20200221072420.266274766@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 27796d03c9c4b2b937ed4cc2b10f21559ad5a8c9 ]

Without this the symbol will not actually end up in .config files.

Link: http://lkml.kernel.org/r/20200116064531.483522-6-aneesh.kumar@linux.ibm.com
Fixes: a30e32bd79e9 ("asm-generic/tlb: Provide generic tlb_flush() based on flush_tlb_mm()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 43102756304c1..238dccfa76910 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -399,6 +399,9 @@ config HAVE_RCU_TABLE_FREE
 config HAVE_MMU_GATHER_PAGE_SIZE
 	bool
 
+config MMU_GATHER_NO_RANGE
+	bool
+
 config HAVE_MMU_GATHER_NO_GATHER
 	bool
 
-- 
2.20.1



