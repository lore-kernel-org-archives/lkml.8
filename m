Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704B1C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 05:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F33120838
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 05:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598678212;
	bh=+F2EOPtddeC9kSdDJvGLBLqOo1a51vtmiM/5btBMX+U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ayz3rPyuGL/siwcodCOmmmjmHzmnzORTyz9qL86BjrBzqTxu3RUH36Xui4ksY75H4
	 KuPqIA1DmpoeLOyJaSNtdTUcXfSAOIR/GeaLOrcxrVOCoiPiAgBEaxJqokrOjGSIa/
	 HzRjUvgxPqMPKPNdIm3J0Tmh/0auB0ijXp6KQ6C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgH2FQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 01:16:51 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:35285 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgH2FQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 01:16:45 -0400
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 07T5FRB7012582;
        Sat, 29 Aug 2020 14:15:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 07T5FRB7012582
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598678128;
        bh=LVsIE8pOMnNIR6mtGLK7uU0ZbQuhigKtOBoHF9Cro6g=;
        h=From:To:Cc:Subject:Date:From;
        b=p2mhvfjq+pNdkZEq+VGJVU+MKYFBXjXGA6p0PU8N2KD08IuRIrcGbrjA8zQ+af9Nf
         GazXaKt4Yx4PGQJyVKgvcwvj148TORAz3mEJn9VSHaOGxg/qWkCbbjEENE474n0Mzr
         Q7aprxpqwjPAIbx5f/JNcAl1+hB+gQBkiuxgtctnc8YzRSoMy93rNGaTGMMRg96dxT
         qXZifa8f+9nL1aj1ewlKHvbjaVzYBKNro/fhiu4X4u8btqWj+5BvmplGWwWQPla31r
         8AJmuCoG11Ra5LFdzDTVCA5Sh8/Sm1ijoBmv1YrpXbRlEktPKeuORJGCDFThf4f8zH
         RdPnFXgZKdj+g==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ia64: clean-up header dependency and build process, fix build warning
Date:   Sat, 29 Aug 2020 14:15:21 +0900
Message-Id: <20200829051524.706585-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Randy Dunlap reports the following warning with CONFIG_IA64_PALINFO=m:

../scripts/Makefile.build:68: 'arch/ia64/kernel/palinfo.ko' will not be built even though obj-m is specified.
../scripts/Makefile.build:69: You cannot use subdir-y/m to visit a module Makefile. Use obj-y/m instead.

This comes from the fact Kbuild descends into arch/ia64/kernel/ twice.

First, to generate <generated/nr-irqs.h>,
Second, to build kernel and module objects.

The warning is emitted in the first descend because it is not the
intended usage.

I looked into the code closely, and noticed arch/ia64/kernel/nr-irqs.c
was not needed in the first place.

It was separated out of arch/ia64/kernel/asm-offsets.c just because
<asm/mca.h> was including too many bogus headers.

IA64 is not actively maintained, and there exists unneeded obsolete code.

The first two patches are the outcome when I played with ARCH=ia64 builds,
but not prerequisites for 3/3. Anyway I believe they are nice cleanups
and folded in this patch set.

3/3 is the important one to fix the false positive warning,
and it is a nice cleanup too.



Masahiro Yamada (3):
  ia64: do not typedef struct pal_min_state_area_s
  ia64: remove unneeded header includes from <asm/mca.h>
  ia64: remove generated/nr-irqs.h generation to fix build warning

 arch/ia64/Makefile             |  6 ------
 arch/ia64/include/asm/irq.h    |  4 +++-
 arch/ia64/include/asm/mca.h    | 11 ++++-------
 arch/ia64/include/asm/pal.h    |  4 ++--
 arch/ia64/include/asm/sal.h    |  2 +-
 arch/ia64/kernel/Makefile      |  5 -----
 arch/ia64/kernel/asm-offsets.c | 18 +++++++++---------
 arch/ia64/kernel/efi.c         |  1 +
 arch/ia64/kernel/mca.c         |  5 +++--
 arch/ia64/kernel/mca_drv.c     |  2 +-
 arch/ia64/kernel/nr-irqs.c     | 22 ----------------------
 11 files changed, 24 insertions(+), 56 deletions(-)
 delete mode 100644 arch/ia64/kernel/nr-irqs.c

-- 
2.25.1

