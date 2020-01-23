Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F98AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F9021734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gO136xNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgAWQ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:58:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37076 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbgAWQ6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:58:25 -0500
Received: from zn.tnic (p200300EC2F095B000C549FEBFD6AD70E.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5b00:c54:9feb:fd6a:d70e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 152221EC0591;
        Thu, 23 Jan 2020 17:58:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579798704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=LGG3bEOWyXI1HASoj1cICm3LhrrPb29MCvP/DndsTAY=;
        b=gO136xNjVdQah+IXtBy2wbIcqJ8TwTDhyqKXi8fdR9izSFOGXihgXQTeQKpOMqUHLX2Se9
        7/wmW8PZITpR3CyK84fhTAevplfZZrfI5oZU1emyMWuqaP0QQM4y48Fvns4aEK7CSie2nv
        h9Fv++xY8aFKszd7gQ4o1tuv4gJuq4c=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/CPU/AMD: Remove amd_get_topology_early()
Date:   Thu, 23 Jan 2020 17:58:11 +0100
Message-Id: <20200123165811.5288-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... and fold its function body into its single call site.

No functional changes:

  # arch/x86/kernel/cpu/amd.o:

   text    data     bss     dec     hex filename
   5994     385       1    6380    18ec amd.o.before
   5994     385       1    6380    18ec amd.o.after

md5:
   99ec6daa095b502297884e949c520f90  amd.o.before.asm
   99ec6daa095b502297884e949c520f90  amd.o.after.asm

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/amd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 90f75e515876..8a88d3f01476 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -319,13 +319,6 @@ static void legacy_fixup_core_id(struct cpuinfo_x86 *c)
 	c->cpu_core_id %= cus_per_node;
 }
 
-
-static void amd_get_topology_early(struct cpuinfo_x86 *c)
-{
-	if (cpu_has(c, X86_FEATURE_TOPOEXT))
-		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
-}
-
 /*
  * Fixup core topology information for
  * (1) AMD multi-node processors
@@ -717,7 +710,8 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 		}
 	}
 
-	amd_get_topology_early(c);
+	if (cpu_has(c, X86_FEATURE_TOPOEXT))
+		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
 }
 
 static void init_amd_k8(struct cpuinfo_x86 *c)
-- 
2.21.0

