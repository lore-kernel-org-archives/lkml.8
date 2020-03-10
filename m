Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F00EC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072DF24699
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844625;
	bh=1Y8fBheo+gb39pMv7lTELFyrrzvQXoZGwB0CRyzuFc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LOj+rhdNAGWDQOpJoqwsYzhWDfh7urcgjNNnu/jgk2OaaEuC8bxvs5yOAhYb4XrIy
	 3CBt4o/1LdQB/SLEbHtcRwLw0mUBgGtFkYFAzq+9gP3Z2U32J4x650npe0qn4TikeC
	 cz9oDGNARzgFULgIZvTFCrJ9tGemLMr3V5+SiahY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgCJMuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728563AbgCJMuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:50:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 736AF20674;
        Tue, 10 Mar 2020 12:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844612;
        bh=1Y8fBheo+gb39pMv7lTELFyrrzvQXoZGwB0CRyzuFc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FzqMHnnp+fjeX1B3a+zSiOsJL4cpLbUr/7SeymM6ZSdDsjhh875nJGxgqyP+pQT70
         F+BijfB544YiBTwdoIkSvo2AeI9Riu2xkehZiSxpGrHyf5QZMGIAbg0fyZBIuKgnrw
         +7+Ihb7jEkrwI1tIpBTNn+M3YsqFgI+dO9R8yP+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 054/168] csky: Fixup compile warning for three unimplemented syscalls
Date:   Tue, 10 Mar 2020 13:38:20 +0100
Message-Id: <20200310123640.814044663@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

[ Upstream commit 2305f60b76110cb3e8658a4ae85d1f7eb0c66a5b ]

Implement fstat64, fstatat64, clone3 syscalls to fixup
checksyscalls.sh compile warnings.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/include/uapi/asm/unistd.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
index 211c983c7282d..ba40189297338 100644
--- a/arch/csky/include/uapi/asm/unistd.h
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -1,7 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
 #include <asm-generic/unistd.h>
-- 
2.20.1



