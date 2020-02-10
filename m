Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0EFC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097FC2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340009;
	bh=aiNr3OYhLrbNTi7lnXmgk4AC0sPo007jR98wm2Qgfw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=brBTD9G02e3zkXRN27b97BHh7jg1qMEMyyU+1QwdaKJPQ6K+hEIa/GBERwAhDb5Bq
	 OdAwhf3XtFH2/KD00qHT+U2YbghiggfJq9vPE4o1CtToRJjfpM05N1fBaPqCGoXK/t
	 qTTJYWp3S77+6ZL7ow8E/SYjPzIKdvJts11WcQDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgBJNGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:06:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbgBJMjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:52 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FE8624677;
        Mon, 10 Feb 2020 12:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338390;
        bh=aiNr3OYhLrbNTi7lnXmgk4AC0sPo007jR98wm2Qgfw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bm7ZRJQcNLEThm2b2PHaJ+6qljW9c4yf6YGZZKkjzqGLdkhJYBm/KMlT+uzxjNS5U
         GM4+yIvDNPNOCTA94dPD2uiTZQ1N/9KHSN85xnrtNx+q7U0t8RQvsTNV7LuPa6YTdl
         JRPWH+Usje4Y1eUrNu5/zt0SevxQPC3v3ImGj0KU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Xuerui <git@xen0n.name>,
        Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 5.5 081/367] MIPS: asm: local: add barriers for Loongson
Date:   Mon, 10 Feb 2020 04:29:54 -0800
Message-Id: <20200210122431.790813750@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Xuerui <git@xen0n.name>

commit 3e86460ebe2340df6a33b35a55312cc369bdcbd0 upstream.

Somehow these LL/SC usages are not taken care of, breaking Loongson
builds. Add the SYNCs appropriately.

Signed-off-by: Wang Xuerui <git@xen0n.name>
Signed-off-by: Paul Burton <paulburton@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: <stable@vger.kernel.org> # v5.5+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/local.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/mips/include/asm/local.h
+++ b/arch/mips/include/asm/local.h
@@ -37,6 +37,7 @@ static __inline__ long local_add_return(
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	arch=r4000				\n"
+			__SYNC(full, loongson3_war) "			\n"
 		"1:"	__LL	"%1, %2		# local_add_return	\n"
 		"	addu	%0, %1, %3				\n"
 			__SC	"%0, %2					\n"
@@ -52,6 +53,7 @@ static __inline__ long local_add_return(
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
+			__SYNC(full, loongson3_war) "			\n"
 		"1:"	__LL	"%1, %2		# local_add_return	\n"
 		"	addu	%0, %1, %3				\n"
 			__SC	"%0, %2					\n"
@@ -84,6 +86,7 @@ static __inline__ long local_sub_return(
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	arch=r4000				\n"
+			__SYNC(full, loongson3_war) "			\n"
 		"1:"	__LL	"%1, %2		# local_sub_return	\n"
 		"	subu	%0, %1, %3				\n"
 			__SC	"%0, %2					\n"
@@ -99,6 +102,7 @@ static __inline__ long local_sub_return(
 		__asm__ __volatile__(
 		"	.set	push					\n"
 		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
+			__SYNC(full, loongson3_war) "			\n"
 		"1:"	__LL	"%1, %2		# local_sub_return	\n"
 		"	subu	%0, %1, %3				\n"
 			__SC	"%0, %2					\n"


