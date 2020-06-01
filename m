Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD92C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84CA32068D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034900;
	bh=dFnDNSHS2+OAHO0LGMtY8LKC5e1OPYAD0D0Dw5/i9t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=izXKv5P5bp95tNdKRF0Yg5tg27C5tL7T2+teBXb7bLnmB4QQ/SIKBRr55+mwONGfV
	 HsQ1JfP8+xt8j19AqNfPZhsR8F3tztpvTp7nxezXm2BRyUf9V1R6rqZo9MDnausW7x
	 lJdMIMdZiG/xAKr2TrWA2ixC3OI6AiTIM05woxO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgFASIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730663AbgFASIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:08:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F4C62077D;
        Mon,  1 Jun 2020 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034885;
        bh=dFnDNSHS2+OAHO0LGMtY8LKC5e1OPYAD0D0Dw5/i9t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jus+oXUD+gTS/Snrd9e28ZVERG0Mx/Fv3Xu4ypf2DoubahGrxC88NTY9tRJiFP2QQ
         adqxcggeP3LvujXyWNf9eCaeuT9lRU+uoc72mVnhVJAmuEK+hBGKwI9InGijcHwmaO
         mn4jVJmdEeU+LsGakQcVRH9nLxpIQyPlnelkU6yw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Yibin <jiulong@linux.alibaba.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 055/142] csky: Fixup msa highest 3 bits mask
Date:   Mon,  1 Jun 2020 19:53:33 +0200
Message-Id: <20200601174043.652111539@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Yibin <jiulong@linux.alibaba.com>

[ Upstream commit 165f2d2858013253042809df082b8df7e34e86d7 ]

Just as comment mentioned, the msa format:

 cr<30/31, 15> MSA register format:
 31 - 29 | 28 - 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
   BA     Reserved  SH  WA  B   SO SEC  C   D   V

So we should shift 29 bits not 28 bits for mask

Signed-off-by: Liu Yibin <jiulong@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/abiv1/inc/abi/entry.h | 4 ++--
 arch/csky/abiv2/inc/abi/entry.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/entry.h b/arch/csky/abiv1/inc/abi/entry.h
index 5056ebb902d1..61d94ec7dd16 100644
--- a/arch/csky/abiv1/inc/abi/entry.h
+++ b/arch/csky/abiv1/inc/abi/entry.h
@@ -167,8 +167,8 @@
 	 *   BA     Reserved  C   D   V
 	 */
 	cprcr	r6, cpcr30
-	lsri	r6, 28
-	lsli	r6, 28
+	lsri	r6, 29
+	lsli	r6, 29
 	addi	r6, 0xe
 	cpwcr	r6, cpcr30
 
diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index 111973c6c713..9023828ede97 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -225,8 +225,8 @@
 	 */
 	mfcr	r6, cr<30, 15> /* Get MSA0 */
 2:
-	lsri	r6, 28
-	lsli	r6, 28
+	lsri	r6, 29
+	lsli	r6, 29
 	addi	r6, 0x1ce
 	mtcr	r6, cr<30, 15> /* Set MSA0 */
 
-- 
2.25.1



