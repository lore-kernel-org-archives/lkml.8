Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70552C35DE6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495F220732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgBXXcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:32:10 -0500
Received: from ozlabs.org ([203.11.71.1]:48545 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbgBXXbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:31:55 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48RJHX3jXFz9sRG; Tue, 25 Feb 2020 10:31:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582587112;
        bh=njTLi7D5ip7n3f03+M5bR2JYHfPVMZZ1e3nNXFT2Clg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSLzswJTlkFp3AllxzJXzByQVXuFj0PSpuq0gzkClTXPsZFbmhhdwicQWtFtbyDzk
         kAQs+o2OMCOj9RYOyvfNEO5mgUXz8LZ+HlJ94wvJLFYZQKxFoxuGHDLCwLwy1rB/H4
         D3hIop/r6BJx0im8ft/ZoJS9cyICkAmQv4oMLYX5G+a7X9+O4uXHOfsEkSY2+9whqm
         Ppt5oBOiGhToEzTTIW4m1ntbYHadpVWEjCyzBfYoUr4Js+4mT7ciSOnIc6U/y8VILB
         YATymtBYz7dyW9kSR+i3OC1CgX3PpKeIfH5Nh1DGgBCsudmPudBncsk/9EejcVP4jZ
         sTQ7YtSi0M8nA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Grant Likely <grant.likely@arm.com>
Subject: [PATCH 5/8] powerpc: Drop XILINX MAINTAINERS entry
Date:   Tue, 25 Feb 2020 10:31:43 +1100
Message-Id: <20200224233146.23734-5-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200224233146.23734-1-mpe@ellerman.id.au>
References: <20200224233146.23734-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has been orphaned for ~7 years, remove it.

Cc: Grant Likely <grant.likely@arm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 939da2ac08db..d5db5cac5a39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9668,12 +9668,6 @@ L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	arch/powerpc/platforms/8xx/
 
-LINUX FOR POWERPC EMBEDDED XILINX VIRTEX
-L:	linuxppc-dev@lists.ozlabs.org
-S:	Orphan
-F:	arch/powerpc/*/*virtex*
-F:	arch/powerpc/*/*/*virtex*
-
 LINUX KERNEL DUMP TEST MODULE (LKDTM)
 M:	Kees Cook <keescook@chromium.org>
 S:	Maintained
-- 
2.21.1

