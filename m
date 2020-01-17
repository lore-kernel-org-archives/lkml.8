Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032D9C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE06E2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="EWBPsPws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgAQOCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:02:47 -0500
Received: from mail.dlink.ru ([178.170.168.18]:55836 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbgAQOCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:02:45 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id 6EE6F1B21576; Fri, 17 Jan 2020 17:02:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 6EE6F1B21576
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1579269762; bh=5ylIyyrZHlzb5tLPn4yy5E0L0D4VwPrmEFZ7BGuuHO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EWBPsPwsX/FBRAeYsYwLjo7CLzvkeykEkH6W4hPSin3x4nVpHbx8dB0zBAd3+ybfw
         lPzxQX4Y/M5STsdDec+7dQ7JLXXIQuEPYvS6W8a3nFCJoj8oitsGYK/lorWNkw2e4c
         OB+UNMEDAhllfdOQFY64LqnJ0WuHq5oyN2/1aP4k=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id 0A6A61B214CE;
        Fri, 17 Jan 2020 17:02:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 0A6A61B214CE
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id 5DADB1B20AE9;
        Fri, 17 Jan 2020 17:02:31 +0300 (MSK)
Received: from localhost.localdomain (unknown [196.196.203.126])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA;
        Fri, 17 Jan 2020 17:02:31 +0300 (MSK)
From:   Alexander Lobakin <alobakin@dlink.ru>
To:     Paul Burton <paulburton@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Lobakin <alobakin@dlink.ru>,
        linux-mips@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH mips-fixes 3/3] MIPS: syscalls: fix indentation of the 'SYSNR' message
Date:   Fri, 17 Jan 2020 17:02:09 +0300
Message-Id: <20200117140209.17672-4-alobakin@dlink.ru>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200117140209.17672-1-alobakin@dlink.ru>
References: <20200117140209.17672-1-alobakin@dlink.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It also lacks a whitespace (copy'n'paste error?) and also messes up the
output:

  SYSHDR  arch/mips/include/generated/uapi/asm/unistd_n32.h
  SYSHDR  arch/mips/include/generated/uapi/asm/unistd_n64.h
  SYSHDR  arch/mips/include/generated/uapi/asm/unistd_o32.h
  SYSNR  arch/mips/include/generated/uapi/asm/unistd_nr_n32.h
  SYSNR  arch/mips/include/generated/uapi/asm/unistd_nr_n64.h
  SYSNR  arch/mips/include/generated/uapi/asm/unistd_nr_o32.h
  WRAP    arch/mips/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/mips/include/generated/uapi/asm/ipcbuf.h

After:

  SYSHDR  arch/mips/include/generated/uapi/asm/unistd_n32.h
  SYSHDR  arch/mips/include/generated/uapi/asm/unistd_n64.h
  SYSHDR  arch/mips/include/generated/uapi/asm/unistd_o32.h
  SYSNR   arch/mips/include/generated/uapi/asm/unistd_nr_n32.h
  SYSNR   arch/mips/include/generated/uapi/asm/unistd_nr_n64.h
  SYSNR   arch/mips/include/generated/uapi/asm/unistd_nr_o32.h
  WRAP    arch/mips/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/mips/include/generated/uapi/asm/ipcbuf.h

Present since day 0 of syscall table generation introduction for MIPS.

Fixes: 9bcbf97c6293 ("mips: add system call table generation support")
Cc: <stable@vger.kernel.org> # v5.0+
Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
---
 arch/mips/kernel/syscalls/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
index a3d4bec695c6..6efb2f6889a7 100644
--- a/arch/mips/kernel/syscalls/Makefile
+++ b/arch/mips/kernel/syscalls/Makefile
@@ -18,7 +18,7 @@ quiet_cmd_syshdr = SYSHDR  $@
 		   '$(syshdr_pfx_$(basetarget))'		\
 		   '$(syshdr_offset_$(basetarget))'
 
-quiet_cmd_sysnr = SYSNR  $@
+quiet_cmd_sysnr = SYSNR   $@
       cmd_sysnr = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@'		\
 		  '$(sysnr_abis_$(basetarget))'			\
 		  '$(sysnr_pfx_$(basetarget))'			\
-- 
2.25.0

