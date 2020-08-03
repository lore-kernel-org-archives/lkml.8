Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6154EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3885E206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596458859;
	bh=cW0MevAFt8H5njALXBT6v761SRuxFMSBRNmZHnFg2CY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wr1vfx3YVcz6TmTz2L7RFK/M4icAKqnwzwPIfmDSAyO25DT8lOHVJWAK8OxH4CH5N
	 aAlzIBdbCw7IQFUUrSjbJwrPWgNf8sHOvn8Nub4qIJnNYslWTZCr81Ca5S3kKmBhUV
	 QkpIriiIn8J0PBZw0xPBDte28ZRVGeVLiH7dYKEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHCMre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgHCMZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:25:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D03D207FB;
        Mon,  3 Aug 2020 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457538;
        bh=cW0MevAFt8H5njALXBT6v761SRuxFMSBRNmZHnFg2CY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r10cWIta+6MIhJwmHhDJTeMLRWFXs4Kw0r5WoCU0wooj+glhLe/iOekWRHvgDM4Pu
         00H+gSV3oOXvn2GAUrsuP1syibBQqMEhllmh+c/FmmlckfVMS6APaChwZTWbwdBE/8
         ybA3fhp+6MhQqQRPwrM5kmLgEdtVFfopvuhJPuMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Dave Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 105/120] parisc: add support for cmpxchg on u8 pointers
Date:   Mon,  3 Aug 2020 14:19:23 +0200
Message-Id: <20200803121908.021555656@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121902.860751811@linuxfoundation.org>
References: <20200803121902.860751811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <liambeguin@gmail.com>

[ Upstream commit b344d6a83d01c52fddbefa6b3b4764da5b1022a0 ]

The kernel test bot reported[1] that using set_mask_bits on a u8 causes
the following issue on parisc:

	hppa-linux-ld: drivers/phy/ti/phy-tusb1210.o: in function `tusb1210_probe':
	>> (.text+0x2f4): undefined reference to `__cmpxchg_called_with_bad_pointer'
	>> hppa-linux-ld: (.text+0x324): undefined reference to `__cmpxchg_called_with_bad_pointer'
	hppa-linux-ld: (.text+0x354): undefined reference to `__cmpxchg_called_with_bad_pointer'

Add support for cmpxchg on u8 pointers.

[1] https://lore.kernel.org/patchwork/patch/1272617/#1468946

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Tested-by: Dave Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/include/asm/cmpxchg.h |  2 ++
 arch/parisc/lib/bitops.c          | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index ab5c215cf46c3..0689585758717 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -60,6 +60,7 @@ extern void __cmpxchg_called_with_bad_pointer(void);
 extern unsigned long __cmpxchg_u32(volatile unsigned int *m, unsigned int old,
 				   unsigned int new_);
 extern u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new_);
+extern u8 __cmpxchg_u8(volatile u8 *ptr, u8 old, u8 new_);
 
 /* don't worry...optimizer will get rid of most of this */
 static inline unsigned long
@@ -71,6 +72,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 #endif
 	case 4: return __cmpxchg_u32((unsigned int *)ptr,
 				     (unsigned int)old, (unsigned int)new_);
+	case 1: return __cmpxchg_u8((u8 *)ptr, (u8)old, (u8)new_);
 	}
 	__cmpxchg_called_with_bad_pointer();
 	return old;
diff --git a/arch/parisc/lib/bitops.c b/arch/parisc/lib/bitops.c
index 70ffbcf889b8e..2e4d1f05a9264 100644
--- a/arch/parisc/lib/bitops.c
+++ b/arch/parisc/lib/bitops.c
@@ -79,3 +79,15 @@ unsigned long __cmpxchg_u32(volatile unsigned int *ptr, unsigned int old, unsign
 	_atomic_spin_unlock_irqrestore(ptr, flags);
 	return (unsigned long)prev;
 }
+
+u8 __cmpxchg_u8(volatile u8 *ptr, u8 old, u8 new)
+{
+	unsigned long flags;
+	u8 prev;
+
+	_atomic_spin_lock_irqsave(ptr, flags);
+	if ((prev = *ptr) == old)
+		*ptr = new;
+	_atomic_spin_unlock_irqrestore(ptr, flags);
+	return prev;
+}
-- 
2.25.1



