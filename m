Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A50DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6897F214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262494;
	bh=8wABEDlREpvzT6ukPbd1Mmmvfg+2A2EvnE7zEw6dBsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FJMQoQcNQ0R32Fup430+PqY4XXqv54ncBu7siaUUjLwiBSRj/RT4xbzI23vUgahqP
	 AAtqTTYIXfOCP616kZ1ONRQxl7oF+p9Onv0qL94AvmIMT4zu8pZqJNbhVxw7yv19GA
	 kQnr0BdZf1v2JV0ROG1R08Wn1es1OfKKgun84NXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgHXJsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728806AbgHXIlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:41:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5409C2074D;
        Mon, 24 Aug 2020 08:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258467;
        bh=8wABEDlREpvzT6ukPbd1Mmmvfg+2A2EvnE7zEw6dBsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqFdAidqHLwDSzL6p1f6+7PujIdSgitlIxJQgtiWyUALP40iwlvLBgiRHSdT0WQzz
         n+CgtPSMqUI48TI9q4SUEl+wR8CRqSH4y5fh334+3ObDfunnWpU4sPBLZtZ6JA9wg9
         vlQcm+o1IDiL+UtBC1j33sW2C03O/hvv7pbYSzZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 057/124] alpha: fix annotation of io{read,write}{16,32}be()
Date:   Mon, 24 Aug 2020 10:29:51 +0200
Message-Id: <20200824082412.228000895@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit bd72866b8da499e60633ff28f8a4f6e09ca78efe ]

These accessors must be used to read/write a big-endian bus.  The value
returned or written is native-endian.

However, these accessors are defined using be{16,32}_to_cpu() or
cpu_to_be{16,32}() to make the endian conversion but these expect a
__be{16,32} when none is present.  Keeping them would need a force cast
that would solve nothing at all.

So, do the conversion using swab{16,32}, like done in asm-generic for
similar situations.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Link: http://lkml.kernel.org/r/20200622114232.80039-1-luc.vanoostenryck@gmail.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/alpha/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index e6225cf40de57..b09dd6bc98a12 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -490,10 +490,10 @@ extern inline void writeq(u64 b, volatile void __iomem *addr)
 }
 #endif
 
-#define ioread16be(p) be16_to_cpu(ioread16(p))
-#define ioread32be(p) be32_to_cpu(ioread32(p))
-#define iowrite16be(v,p) iowrite16(cpu_to_be16(v), (p))
-#define iowrite32be(v,p) iowrite32(cpu_to_be32(v), (p))
+#define ioread16be(p) swab16(ioread16(p))
+#define ioread32be(p) swab32(ioread32(p))
+#define iowrite16be(v,p) iowrite16(swab16(v), (p))
+#define iowrite32be(v,p) iowrite32(swab32(v), (p))
 
 #define inb_p		inb
 #define inw_p		inw
-- 
2.25.1



