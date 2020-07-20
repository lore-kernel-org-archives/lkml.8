Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E72C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F5A22CB3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259471;
	bh=h4F2yTZK3IdWQB8sDn+EJnNGdU9kh0BdJhV7LLDa+lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=00Un8+3c0tOcpXlfOIIA3L4vDyoRAoi5bv+QGcho1V2Levq0kyn6qHc6yLhopYfub
	 Ax5I1c5aXFG3BluQWAsDOE2y5mRWdd8p4glh3JlhxwJHNmseh0HS08VD0UOySZHNjX
	 xDt9BFZArm4ySels4yBEvx12XaoW3gQYbzGMyosA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgGTPht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:37:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbgGTPhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:37:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BE6222CB2;
        Mon, 20 Jul 2020 15:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259466;
        bh=h4F2yTZK3IdWQB8sDn+EJnNGdU9kh0BdJhV7LLDa+lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p5xOmopzso9SfFZcBtKx7i20IZmjWw7RX/M23KdUcIWPrV6VSLQkOFTkw8yRbalXo
         wpimQdYBI+8qPXKbSPsDykC/Qvj9d6N3PrMdVbHH24RUpTQ7Xf6M9cQzkOPyt0qR+5
         hRn62kjalAxobCVZLyT0h6ZjKI/EdZXgnA0myp0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.4 18/58] ARC: elf: use right ELF_ARCH
Date:   Mon, 20 Jul 2020 17:36:34 +0200
Message-Id: <20200720152748.047496033@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
References: <20200720152747.127988571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

commit b7faf971081a4e56147f082234bfff55135305cb upstream.

Cc: <stable@vger.kernel.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/include/asm/elf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arc/include/asm/elf.h
+++ b/arch/arc/include/asm/elf.h
@@ -27,7 +27,7 @@
 #define  R_ARC_S25W_PCREL	0x11
 
 /*to set parameters in the core dumps */
-#define ELF_ARCH		EM_ARCOMPACT
+#define ELF_ARCH		EM_ARC_INUSE
 #define ELF_CLASS		ELFCLASS32
 
 #ifdef CONFIG_CPU_BIG_ENDIAN


