Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EF9C35DE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B9220732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgBXXcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:32:01 -0500
Received: from ozlabs.org ([203.11.71.1]:48109 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbgBXXb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:31:57 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48RJHb119Pz9sRJ; Tue, 25 Feb 2020 10:31:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582587115;
        bh=wp7h+M9HoWPZWX7BCN8CXFDtNUVtpljsdviaDf+1Kxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKKOQ3bBR579xJqEBl/dcm8Lo0JAAfVJCLJiISuRwB6rKkWsE16irKWVwZFJKpW7f
         dW8loKpixifSmErEyk0BBbBNyfapCU9qUK31/Alx4ZVD9hdXnEdZs5CCAB0rGuhBeU
         iKAhV4binLoYtdBAbmSfEejadC8YT3Xpw9Dr5HnOXkPv3DaRti0F5Y2oc1pebAw289
         FR0XU8M+zxb7qVx2fS9Vcn2oPv2FBPAAoq/P17v6hIhJOIvgXz3UsgMUJWjqKeva4t
         1yGKMcZgORwTRwXiDR2sm2XaE2epW3jwTifecU0vFFVSS13sABNcBeajc7Lx8exqUS
         fKg4EFwyck21Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 7/8] powerpc: Update powermac MAINTAINERS entry
Date:   Tue, 25 Feb 2020 10:31:45 +1100
Message-Id: <20200224233146.23734-7-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200224233146.23734-1-mpe@ellerman.id.au>
References: <20200224233146.23734-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben is no longer actively maintaining the powermac code, but we know
where to find him if something really needs attention.

The www.penguinppc.org link is dead so remove it.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a46e19aadcbc..febffee28d00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9594,9 +9594,8 @@ F:	include/uapi/linux/lightnvm.h
 
 LINUX FOR POWER MACINTOSH
 M:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
-W:	http://www.penguinppc.org/
 L:	linuxppc-dev@lists.ozlabs.org
-S:	Maintained
+S:	Odd Fixes
 F:	arch/powerpc/platforms/powermac/
 F:	drivers/macintosh/
 
-- 
2.21.1

