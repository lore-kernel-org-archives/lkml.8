Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60219C35DE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3546F20732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgBXXbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:31:53 -0500
Received: from ozlabs.org ([203.11.71.1]:33703 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbgBXXbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:31:51 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48RJHT2jVKz9sRG; Tue, 25 Feb 2020 10:31:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582587109;
        bh=qAkvkPIb2184/CM7bghWxy4H6X1MMehAVdAaBWnulSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJq7+z+Y4dXUOKRfV1sAnSnmjEPJkN9omyF4y9RI0bcVxPFkHbMdNb2ARhO+oLseO
         wHF7L3iO9lc79ThzX4kKY3D0FO2T/pdaD74icIaxqvQDM9TMQ4D24AW+Ojw2+6XrxB
         ek6TGnlL2eOuAORk3XEWZRffU5lvsNBwXB1ICswEIc5TOLda3quw14a9rWHJClBuN7
         mVGN0YSjQj/vRhT0A1yQ5fSuNY3DiN8M4RFk2AxRwFD5AhcD2dU35fm/xY77LPanF4
         r+hzhSyDd5CI1QB//Rj2AVDo1YKt+eIHICqqhLQd4V1tnHReW0womCxGW8D3X6++0m
         3HiXfFGhDKWtg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] powerpc: Update wiki link in MAINTAINERS
Date:   Tue, 25 Feb 2020 10:31:40 +1100
Message-Id: <20200224233146.23734-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200224233146.23734-1-mpe@ellerman.id.au>
References: <20200224233146.23734-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wiki has moved, update the link.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 339bc3e53862..435e4efc9a32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9604,7 +9604,7 @@ LINUX FOR POWERPC (32-BIT AND 64-BIT)
 M:	Michael Ellerman <mpe@ellerman.id.au>
 R:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
 R:	Paul Mackerras <paulus@samba.org>
-W:	https://github.com/linuxppc/linux/wiki
+W:	https://github.com/linuxppc/wiki/wiki
 L:	linuxppc-dev@lists.ozlabs.org
 Q:	http://patchwork.ozlabs.org/project/linuxppc-dev/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
-- 
2.21.1

