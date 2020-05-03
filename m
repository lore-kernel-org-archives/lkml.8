Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E6EC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 10:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA8E2073E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 10:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QmgWuRA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgECKbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 06:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbgECKbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 06:31:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFC6C061A0C
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 03:31:16 -0700 (PDT)
Received: from zn.tnic (p200300EC2F2A2700882AA5D9A50AC15C.dip0.t-ipconnect.de [IPv6:2003:ec:2f2a:2700:882a:a5d9:a50a:c15c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F6381EC00EE;
        Sun,  3 May 2020 12:31:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588501874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ostmp7kykRgcpZMrZEUHwqIHhGgOh09tY8s3r1HU8No=;
        b=QmgWuRA93FYzkVLEmudPlMGEZycQWHrEoI/lj2gyqCrBLKJG58Y2ZcAgPyKUZBnfTCxaFk
        hFw2x9wSVHVOhnVbxJFLj6EIkaYXojfmAKc9+1cWGwYOJJs4BHVmY2g60Ha3h90m7jao1g
        pSS4Ay1+Irprtbiwmx4gHOY+FJnzXvI=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/tlb/uv: Add a forward declaration for struct flush_tlb_info
Date:   Sun,  3 May 2020 12:31:07 +0200
Message-Id: <20200503103107.3419-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... to fix these build warnings:

  In file included from ./arch/x86/include/asm/uv/uv_hub.h:22,
                   from drivers/misc/sgi-gru/grukdump.c:16:
  ./arch/x86/include/asm/uv/uv.h:39:21: warning: ‘struct flush_tlb_info’ declared \
     inside parameter list will not be visible outside of this definition or declaration
     39 |        const struct flush_tlb_info *info);
        |                     ^~~~~~~~~~~~~~
  In file included from ./arch/x86/include/asm/uv/uv_hub.h:22,
                   from drivers/misc/sgi-gru/grutlbpurge.c:28:
  ./arch/x86/include/asm/uv/uv.h:39:21: warning: ‘struct flush_tlb_info’ declared \
    inside parameter list will not be visible outside of this definition or declaration
     39 |        const struct flush_tlb_info *info);
        |                     ^~~~~~~~~~~~~~

  ...

after

  bfe3d8f6313d ("x86/tlb: Restrict access to tlbstate")

restricted access to tlbstate.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/uv/uv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index 45ea95ce79b4..91e088ac6904 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -8,6 +8,7 @@ enum uv_system_type {UV_NONE, UV_LEGACY_APIC, UV_X2APIC, UV_NON_UNIQUE_APIC};
 
 struct cpumask;
 struct mm_struct;
+struct flush_tlb_info;
 
 #ifdef CONFIG_X86_UV
 #include <linux/efi.h>
-- 
2.21.0

