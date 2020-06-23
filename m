Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB382C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE12320781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947557;
	bh=mENqh6y1+loYM3lndCqWeQVz3f18lqycNcM3H9cKtfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GWQmLjK6lqn1YLtat8Y8pRTTzwEriMv2hHZrqWA54XGxTEL+iNVzcjpMWg5KtqS1g
	 HuMdrCNg93cDJw8o5i07bvUWd6TXWdqS/9MN+BogHbbl/+/O/gtaJt43wkVCOz75C+
	 Ng3soouB7OrSJ7ffTpz6evRSYK0AxL+so7ZfcLco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393549AbgFWVZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389686AbgFWUSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:18:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 957B52080C;
        Tue, 23 Jun 2020 20:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943511;
        bh=mENqh6y1+loYM3lndCqWeQVz3f18lqycNcM3H9cKtfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0cxYweT8MQrUeVVXYYfSdiSx9zD0H9YdUZFVLhlIURKfosRBluMUB29zlgQxrfel
         xPQNaL+J736mN1vzLYHe7SzshZYgI7AEg8Ynk0Y731fcPW5LaVeth3X4VTUWNwnSsL
         Rv47b7NMOtHywNZUnj3obWnerfEoT/oI3UiQHEIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rich Felker <dalias@libc.org>
Subject: [PATCH 5.7 420/477] sh: Convert iounmap() macros to inline functions
Date:   Tue, 23 Jun 2020 21:56:57 +0200
Message-Id: <20200623195427.382451217@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 4580ba4ad2e6b8ddaada3db61d179d4dfac12047 upstream.

Macro iounmap() do nothing, but that results in
unused variable warnings all over the place.
This patch convert it to inline to avoid warning

We will get this warning without this patch

	${LINUX}/drivers/thermal/broadcom/ns-thermal.c:78:21: \
	  warning: unused variable 'ns_thermal' [-Wunused-variable]
	struct ns_thermal *ns_thermal = platform_get_drvdata(pdev);
	^~~~~~~~~~

Fixes: 98c90e5ea34e9 ("sh: remove __iounmap")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Rich Felker <dalias@libc.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/sh/include/asm/io.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -328,7 +328,7 @@ __ioremap_mode(phys_addr_t offset, unsig
 #else
 #define __ioremap(offset, size, prot)		((void __iomem *)(offset))
 #define __ioremap_mode(offset, size, prot)	((void __iomem *)(offset))
-#define iounmap(addr)				do { } while (0)
+static inline void iounmap(void __iomem *addr) {}
 #endif /* CONFIG_MMU */
 
 static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)


