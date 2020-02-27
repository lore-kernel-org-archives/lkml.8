Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51853C52D24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D02E24697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812527;
	bh=lqpYNNcrPhcEJCoVEm5zSXwt3P8XbK0+uztpjf3ftmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y3bcSQuVEw08K/appzY/EjDWW/rQJEMxY/EH6EPS50I6sCqJo4UtNI5wEGoMNg5om
	 FBTsUfkQClCbvDT8PxWC5XEptuZfKO3C/4yQZDV2I+da9mhmPKSYIsMCVc2JYYFAlV
	 p+IwlynIEEnRcKDhsl5hCM25wCivw6Cqt4HKWvGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbgB0OIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:08:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387925AbgB0OIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:08:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEFDE20714;
        Thu, 27 Feb 2020 14:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812518;
        bh=lqpYNNcrPhcEJCoVEm5zSXwt3P8XbK0+uztpjf3ftmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVOpT1+6cqofYMssT2C+t+YtR/rnxf+ZVWGm143EaeR8RSURTCqNB+N1ixQUVSa1H
         JYTeovN/NBAUCtWLGYj00s0uLyoa9JlITqur27EmUVtFVoNt+zVncvXSoS9fed2n7p
         FxDBZ5ZG7qZ4lVPRHumQsRxucn+oZ7DWamk6aW98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 048/135] powerpc/hugetlb: Fix 8M hugepages on 8xx
Date:   Thu, 27 Feb 2020 14:36:28 +0100
Message-Id: <20200227132236.315442234@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 50a175dd18de7a647e72aca7daf4744e3a5a81e3 upstream.

With HW assistance all page tables must be 4k aligned, the 8xx drops
the last 12 bits during the walk.

Redefine HUGEPD_SHIFT_MASK to mask last 12 bits out. HUGEPD_SHIFT_MASK
is used to for alignment of page table cache.

Fixes: 22569b881d37 ("powerpc/8xx: Enable 8M hugepage support with HW assistance")
Cc: stable@vger.kernel.org # v5.0+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/778b1a248c4c7ca79640eeff7740044da6a220a0.1581264115.git.christophe.leroy@c-s.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/page.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -295,8 +295,13 @@ static inline bool pfn_valid(unsigned lo
 /*
  * Some number of bits at the level of the page table that points to
  * a hugepte are used to encode the size.  This masks those bits.
+ * On 8xx, HW assistance requires 4k alignment for the hugepte.
  */
+#ifdef CONFIG_PPC_8xx
+#define HUGEPD_SHIFT_MASK     0xfff
+#else
 #define HUGEPD_SHIFT_MASK     0x3f
+#endif
 
 #ifndef __ASSEMBLY__
 


