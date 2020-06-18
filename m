Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2FAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9B621D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592442958;
	bh=h0D9f8SfqSG5dRuYkwYsO4LqVWOjWOhzRu88NoAcVDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NiMEUbCQaIOT07o9DHNEy8cJEj66fgMGv0H490WyQ/pz10h6a8gPpCxZwqwYyQvwz
	 KryAnhpFz3aCQocoU9hEdBmNsIRBNL5jre6wDgcQTFDuMz4rh1OIxKXNOyoyk4Px04
	 +oX9WSqPmv6dghzBSN4c94m37+4SywVR8qVaIp8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgFRBP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729273AbgFRBOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:14:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D493E20EDD;
        Thu, 18 Jun 2020 01:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442844;
        bh=h0D9f8SfqSG5dRuYkwYsO4LqVWOjWOhzRu88NoAcVDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0mgQUdXH1YhS7ALLNxoMWYoc7vSmwHM7Vrm926wdv4TlqNd4J1orz9cHsLIHrJ00
         u/e5voSyP4rjYWsYrs+y1Y7S+Jj+K98nDBpaHz0rQ03MZQ8JHxNIEypybjkiZ20HMA
         Y0Nr5VXHiuKmmUkdGqpKf40FY0n2YuaEU6OqKxl8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.7 277/388] powerpc/32s: Don't warn when mapping RO data ROX.
Date:   Wed, 17 Jun 2020 21:06:14 -0400
Message-Id: <20200618010805.600873-277-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 4b19f96a81bceaf0bcf44d79c0855c61158065ec ]

Mapping RO data as ROX is not an issue since that data
cannot be modified to introduce an exploit.

PPC64 accepts to have RO data mapped ROX, as a trade off
between kernel size and strictness of protection.

On PPC32, kernel size is even more critical as amount of
memory is usually small.

Depending on the number of available IBATs, the last IBATs
might overflow the end of text. Only warn if it crosses
the end of RO data.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/6499f8eeb2a36330e5c9fc1cee9a79374875bd54.1589866984.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/book3s32/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 39ba53ca5bb5..a9b2cbc74797 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -187,6 +187,7 @@ void mmu_mark_initmem_nx(void)
 	int i;
 	unsigned long base = (unsigned long)_stext - PAGE_OFFSET;
 	unsigned long top = (unsigned long)_etext - PAGE_OFFSET;
+	unsigned long border = (unsigned long)__init_begin - PAGE_OFFSET;
 	unsigned long size;
 
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S_601))
@@ -201,9 +202,10 @@ void mmu_mark_initmem_nx(void)
 		size = block_size(base, top);
 		size = max(size, 128UL << 10);
 		if ((top - base) > size) {
-			if (strict_kernel_rwx_enabled())
-				pr_warn("Kernel _etext not properly aligned\n");
 			size <<= 1;
+			if (strict_kernel_rwx_enabled() && base + size > border)
+				pr_warn("Some RW data is getting mapped X. "
+					"Adjust CONFIG_DATA_SHIFT to avoid that.\n");
 		}
 		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
 		base += size;
-- 
2.25.1

