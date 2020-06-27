Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC9BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7888B2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593245838;
	bh=823ZeGyFFy5BoOmrk0GEhxGLRZDwTJnqPCvA2WheQgM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=selQ1t44BvklgJWz6u+Bg4uvP7TfW+kOieaHcahylOwU8PbRgXFxD86fkOCa4z16e
	 jw4yjrFqMA2P11bN7SdaL59HcwCXen9B+y/1IBgqAsUe54saPQ23xpyj4NeShypKhe
	 hIXwpJQ3o3e9YorymRPITPIMHstR6T6HXP9dwT44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgF0IRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 04:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgF0IRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 04:17:16 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AB512080C;
        Sat, 27 Jun 2020 08:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593245836;
        bh=823ZeGyFFy5BoOmrk0GEhxGLRZDwTJnqPCvA2WheQgM=;
        h=From:To:Cc:Subject:Date:From;
        b=pDtHUdN46bq4IFlAf+INwZcWh8Qck6B0vcNWGI43Hb6sl/+hSL/H+PL7dmuNLoIaa
         o4XEfsBcN+QJ+4sVBvL+Gv2TZV2+JQo/ctCvXTpBvRXoVVqtyZpS89ri4buAgq9xvC
         pjnJPrvttALvuI1yy3lX5xxOiajNTWujxFpXODYw=
From:   Mike Rapoport <rppt@kernel.org>
To:     sparclinux@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 0/2] sparc32: srmmu: improve type safety of __nocache_fix()
Date:   Sat, 27 Jun 2020 11:16:51 +0300
Message-Id: <20200627081653.25311-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

As discussed at [1] the __nocache_fix() macro in sparc's SRMMU can be made
type safe and so the compiler will yell anout misuse of pXd pointers for
which the __nocache_fix() is primarily used.

The first patch is an fix of such misuse that I've discovered after adding
type cast to __nocache_fix(), but to avoid breaking bisection I've made it
the first commit.

v2: rebased on v5.8-rc2+

--
Sincerely yours,
Mike.

[1] https://lkml.kernel.org/r/CAHk-=wisORTa7QVPnFqNw9pFs62UiwgsD4C4d=MtYy1o4JPyGQ@mail.gmail.com

Mike Rapoport (2):
  sparc32: use PUD rather than PGD to get PMD in srmmu_inherit_prom_mappings()
  sparc32: srmmu: improve type safety of __nocache_fix()

 arch/sparc/include/asm/pgtsrmmu.h |  2 +-
 arch/sparc/mm/srmmu.c             | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

base-commit: 1590a2e1c681b0991bd42c992cabfd380e0338f2
-- 
2.26.2

