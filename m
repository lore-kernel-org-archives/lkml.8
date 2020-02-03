Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8DDC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C812051A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748554;
	bh=Yyoggdhu5x9DZsRzhyrznpN1Ss91IeU0GL8C1rPwGeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mGVdJEayZ46me5j/AcX00Ry4Le8n+lR2EJ52QgAEku2QnXTIlzj9epZeYviRvgGm/
	 YaosQL0Tb9I4QJW5HKNRlMFM1DjLDDp9T7O0uhM5FxjeniEryTAF67oVgnUzRZ0Fxk
	 ktTJwH0JAYv6jcuwdcPjV2SioNld9AkRui2PPHGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgBCQtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbgBCQZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:25:17 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69CB320838;
        Mon,  3 Feb 2020 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747116;
        bh=Yyoggdhu5x9DZsRzhyrznpN1Ss91IeU0GL8C1rPwGeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LtrnR4/PoMvO1sbkokU1uc0o34l1bC2vWFO5hMELqDNYlousJpEc7FUBQCi546K0J
         nVu5pTeWs9wRtzdXF2oeHb0kZKPv8j7acWuJU89CgQURjsuOlCse/ONGtRFJOTfRYI
         F+tybATmIBVrFFmbCuTfptPF0bQqDG9H3upn47kY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 19/68] drivers/net/b44: Change to non-atomic bit operations on pwol_mask
Date:   Mon,  3 Feb 2020 16:19:15 +0000
Message-Id: <20200203161908.221127019@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161904.705434837@linuxfoundation.org>
References: <20200203161904.705434837@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

[ Upstream commit f11421ba4af706cb4f5703de34fa77fba8472776 ]

Atomic operations that span cache lines are super-expensive on x86
(not just to the current processor, but also to other processes as all
memory operations are blocked until the operation completes). Upcoming
x86 processors have a switch to cause such operations to generate a #AC
trap. It is expected that some real time systems will enable this mode
in BIOS.

In preparation for this, it is necessary to fix code that may execute
atomic instructions with operands that cross cachelines because the #AC
trap will crash the kernel.

Since "pwol_mask" is local and never exposed to concurrency, there is
no need to set bits in pwol_mask using atomic operations.

Directly operate on the byte which contains the bit instead of using
__set_bit() to avoid any big endian concern due to type cast to
unsigned long in __set_bit().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/b44.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 17aa33c5567d6..d95dec5957861 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -1524,8 +1524,10 @@ static int b44_magic_pattern(u8 *macaddr, u8 *ppattern, u8 *pmask, int offset)
 	int ethaddr_bytes = ETH_ALEN;
 
 	memset(ppattern + offset, 0xff, magicsync);
-	for (j = 0; j < magicsync; j++)
-		set_bit(len++, (unsigned long *) pmask);
+	for (j = 0; j < magicsync; j++) {
+		pmask[len >> 3] |= BIT(len & 7);
+		len++;
+	}
 
 	for (j = 0; j < B44_MAX_PATTERNS; j++) {
 		if ((B44_PATTERN_SIZE - len) >= ETH_ALEN)
@@ -1537,7 +1539,8 @@ static int b44_magic_pattern(u8 *macaddr, u8 *ppattern, u8 *pmask, int offset)
 		for (k = 0; k< ethaddr_bytes; k++) {
 			ppattern[offset + magicsync +
 				(j * ETH_ALEN) + k] = macaddr[k];
-			set_bit(len++, (unsigned long *) pmask);
+			pmask[len >> 3] |= BIT(len & 7);
+			len++;
 		}
 	}
 	return len - 1;
-- 
2.20.1



