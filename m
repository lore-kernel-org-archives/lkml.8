Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A84C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E1022482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260478;
	bh=OAWEiNj0HxY5JoeCvIkJcL6gK3NsMqhllUtgiuN1mrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GbGwjUzthgvyi1384LOtl92UdhGf21fzmJUggHj6+welfoKVeMs0/fZ+OvYdFoZPG
	 yTdbUJgkuaPwqTVHLvyAXMJo3SiQku9iGFSkzZhaXFuG3Ndd0U/yBIXTsq3YhhkAle
	 s/6SxTaHRi7QdDS0thT2LfeWrOZwCZru7IatmqqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbgGTPyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731567AbgGTPy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:54:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87C0B22482;
        Mon, 20 Jul 2020 15:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260469;
        bh=OAWEiNj0HxY5JoeCvIkJcL6gK3NsMqhllUtgiuN1mrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GlO1lDUAfAZVPLAYO77Eoqzuun8XlKS/84N9/IwmJQgnkOMBapTcIFnVujOLRF2PS
         HfAojgt1pdxVeJ/KxgRWY/bu4uLQgMdl1gniDJnf0BzQHrJ4PE97kDTCipwOaryPKI
         1zHPuyVbc4NVAVMqy/gd2/6VobUjlMjib8yN1dy0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH 4.19 114/133] riscv: use 16KB kernel stack on 64-bit
Date:   Mon, 20 Jul 2020 17:37:41 +0200
Message-Id: <20200720152809.246674298@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Schwab <schwab@suse.de>

commit 0cac21b02ba5f3095fd2dcc77c26a25a0b2432ed upstream.

With the current 8KB stack size there are frequent overflows in a 64-bit
configuration.  We may split IRQ stacks off in the future, but this fixes a
number of issues right now.

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
[Palmer: mention irqstack in the commit text]
Fixes: 7db91e57a0ac ("RISC-V: Task implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/riscv/include/asm/thread_info.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -20,7 +20,11 @@
 #include <linux/const.h>
 
 /* thread information allocation */
+#ifdef CONFIG_64BIT
+#define THREAD_SIZE_ORDER	(2)
+#else
 #define THREAD_SIZE_ORDER	(1)
+#endif
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 
 #ifndef __ASSEMBLY__


