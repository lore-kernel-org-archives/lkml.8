Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BA0C3F2D9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABC62072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RUxeWUMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgCEUDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:03:07 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:44440 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbgCEUDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:03:06 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 12234C10DD;
        Thu,  5 Mar 2020 20:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583438586; bh=KxmfiRKc96Lw0HUN1flKo0En+90Ix6xmPDnhmOpmCYU=;
        h=From:To:Cc:Subject:Date:From;
        b=RUxeWUMRh/BaX0ePHWDbb+qAtJSk16MF80nfXBNyY9NIsRGbaNfQnEDp0O1Dt41Zs
         SSjm4S+WFKMGbxMw2Efo/u4Lq09Y/L659RZXh6FMfKTuwwcbstalog6UF01G3+JpFN
         RbHrcnupp285rzUM7yjJ7ecR2j6jW/YyqyPSVDaRGC9KhZf81U/7mUQfdgvKXnKZ7y
         bnO5j938rmbrkL665pB8DN9h5ljM5M5Erl/3tyJdskP0bq1mJIYlyBZvR10iYlDCyj
         NJYcLsYQeKmbt+A8GX6Gq22JPXS13rrbAl8iw3uVHslPd+HbT6dKx9JGVoKyS8Cko+
         s18puZuPKdojQ==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id 58E0CA005B;
        Thu,  5 Mar 2020 20:02:58 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 0/4] ARC: handle DSP presence in HW
Date:   Thu,  5 Mar 2020 23:02:48 +0300
Message-Id: <20200305200252.14278-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arc processors may have DSP extension which is optional.
In this patch series we:
* Handle issues caused by DSP extension presence in HW
* Add optional support for DSP-enabled applications in
  userspace (with optional AGU extension support)

Changes v1->v2:
 * use r10:r11 register pair as a scratch for ASM code instead of
   r58:r59
 * reset DSP_CTRL to value suitable for kernel also in case of
   DSP for userspcae enabled
 * Use "Ir" instead of "I" parameter modifier to inline ASM
   to give compiler wiggle room.
 * Save / restore ACC0_GLO, ACC0_GHI only in case of context
   switch
 * Don't define additional options in headers to not introduce
   explicit include dependencies
 * Mode DSP config check to DSP code itself
 * Minor fixes

Eugeniy Paltsev (4):
  ARC: add helpers to sanitize config options
  ARC: handle DSP presence in HW
  ARC: add support for DSP-enabled userspace applications
  ARC: allow userspace DSP applications to use AGU extensions

 arch/arc/Kconfig                   |  50 +++++++++-
 arch/arc/include/asm/arcregs.h     |  26 +++++
 arch/arc/include/asm/asserts.h     |  34 +++++++
 arch/arc/include/asm/dsp-impl.h    | 150 +++++++++++++++++++++++++++++
 arch/arc/include/asm/dsp.h         |  29 ++++++
 arch/arc/include/asm/entry-arcv2.h |   6 ++
 arch/arc/include/asm/processor.h   |   4 +
 arch/arc/include/asm/ptrace.h      |   3 +
 arch/arc/include/asm/switch_to.h   |   2 +
 arch/arc/kernel/asm-offsets.c      |   4 +
 arch/arc/kernel/head.S             |   4 +
 arch/arc/kernel/setup.c            |  34 ++++---
 12 files changed, 332 insertions(+), 14 deletions(-)
 create mode 100644 arch/arc/include/asm/asserts.h
 create mode 100644 arch/arc/include/asm/dsp-impl.h
 create mode 100644 arch/arc/include/asm/dsp.h

-- 
2.21.1

