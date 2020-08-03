Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97742C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 674102054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457965;
	bh=t2oT0uhxQ0+DVoa3OutONu5D6FifUlSdmQ2IaDTNpbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zWO9Ex2u74a9k5A/V3h2G+CPvYjPD6ZeDojA/+YvmE31GFdPGp/4sxUeDvfabl2GA
	 4ikF5+4Iq3xIXni6Zrh6W5i0zVBzrj/ZJLzTCDzM32O8Q1qg2FCXM3GXb6m4WEmD0z
	 l+ykIZalTssCDQ9GK0E4zh6FGSAGMIbL4LLAiXKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbgHCMcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729333AbgHCMcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:32:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5FD6204EC;
        Mon,  3 Aug 2020 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457955;
        bh=t2oT0uhxQ0+DVoa3OutONu5D6FifUlSdmQ2IaDTNpbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhSl0rV3Zn2voRDxzk4fbdvE/Z+LZxCHjW9+iZxL/O0X6J0peYsSKTRzSo9dYPGjA
         qAvEqHNXPk0pbneyvRKETX8ybRosFjuZrs4lFlICGEnRnVLjpPRsDHFsapMkw3+6zO
         KSogFdUbUH7j13hFeGPTqE2QKAGZEeP+r1oR+RA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, guodeqing <geffrey.guo@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 42/56] arm64: csum: Fix handling of bad packets
Date:   Mon,  3 Aug 2020 14:19:57 +0200
Message-Id: <20200803121852.370952603@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121850.306734207@linuxfoundation.org>
References: <20200803121850.306734207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 05fb3dbda187bbd9cc1cd0e97e5d6595af570ac6 ]

Although iph is expected to point to at least 20 bytes of valid memory,
ihl may be bogus, for example on reception of a corrupt packet. If it
happens to be less than 5, we really don't want to run away and
dereference 16GB worth of memory until it wraps back to exactly zero...

Fixes: 0e455d8e80aa ("arm64: Implement optimised IP checksum helpers")
Reported-by: guodeqing <geffrey.guo@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/checksum.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/checksum.h b/arch/arm64/include/asm/checksum.h
index 0b6f5a7d4027c..fd11e0d70e446 100644
--- a/arch/arm64/include/asm/checksum.h
+++ b/arch/arm64/include/asm/checksum.h
@@ -30,16 +30,17 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 {
 	__uint128_t tmp;
 	u64 sum;
+	int n = ihl; /* we want it signed */
 
 	tmp = *(const __uint128_t *)iph;
 	iph += 16;
-	ihl -= 4;
+	n -= 4;
 	tmp += ((tmp >> 64) | (tmp << 64));
 	sum = tmp >> 64;
 	do {
 		sum += *(const u32 *)iph;
 		iph += 4;
-	} while (--ihl);
+	} while (--n > 0);
 
 	sum += ((sum >> 32) | (sum << 32));
 	return csum_fold((__force u32)(sum >> 32));
-- 
2.25.1



