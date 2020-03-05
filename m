Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06871C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19F62072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="B+rC3aCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgCEEsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 23:48:14 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39242 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgCEEsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 23:48:14 -0500
Received: by mail-qv1-f68.google.com with SMTP id fc12so1884445qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 20:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bR0yHX0jt6RtU935MOjekAD7bW6X/oaFERrZJKbX81c=;
        b=B+rC3aCeemmKXHBSwju8vpHFCDXJcRs2zcFIZabqMKtnfwyC5IFe4UBlPY5IdtlbNT
         1TyZfkxYuwzKwN0UMI8cCtJb36E2zFRjAVnc0eTu/XkdwYPFezn/waq+VXkI+VqRmYnU
         n5Um4fRTCPyM9+n/57/Kx2tFyn3M9rwprh2/LZ9DPO1FiqsAsrfikh2KWR9wnIKxWeKi
         wQuv8uUejauid1qLg6ALj5Gl8V2WZ9t8GxEn4fMgbfQ68WJ41HfHuFXnXVo8/TisXRLL
         WU552JRA4VWKoyjVV+yCz4b1HxFOcjwfXTk29A3DP/yP+yFI6w8eE1hHRmZI3KKRG/Kg
         1B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bR0yHX0jt6RtU935MOjekAD7bW6X/oaFERrZJKbX81c=;
        b=movLjRJ49lUUla61r3d+Hi6EFo6SNExSlyz/XrMRiXjkkrHtmKxNizm8czv+LD0IF9
         YVhvno4QRkCe3PUpjonHfEOeIa1tj2/HptTlefzSWgwMXgtP5tZojW0ABvnV0T/r7+oF
         3B0fDCB/b7PcDWDIVS8vo+LpjjCRSZzNOA9kjsRgCJeWAXXxl7mjrYG71U2Pj8CVEwAt
         s5FKM8DsyEDQICJ/KdxPOxlyjSoR+x+L77AwO/OCW81RYNQEFfjEc9togC45Y68iL9lZ
         tTpyUhznISe+tTy81Fb7S1HDMoiHJs+/6Yw2FK/gPleE08Im2JkMt7OT5WtjucALb9N1
         hufg==
X-Gm-Message-State: ANhLgQ1RHh2dOAUgxFKQ0t5NufC5NnBmtFtxxEIrn4q05zFwSqFkLfeL
        Qk3VQx2DyP6RoaN+cu5aKAcquw==
X-Google-Smtp-Source: ADFU+vv4UwakNttileojs5+Urm6yioCkCkSY1Y4lDvERapnfL62VOgXHTglEEbpPG2qMx2Kb88J8Iw==
X-Received: by 2002:a0c:b669:: with SMTP id q41mr673037qvf.20.1583383693207;
        Wed, 04 Mar 2020 20:48:13 -0800 (PST)
Received: from localhost.localdomain (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f13sm10558859qkm.42.2020.03.04.20.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 20:48:12 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au, akpm@linux-foundation.org
Cc:     rashmicy@gmail.com, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] powerpc/mm/ptdump: fix an undefined behaviour
Date:   Wed,  4 Mar 2020 23:47:59 -0500
Message-Id: <20200305044759.1279-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting a power9 server with hash MMU could trigger an undefined
behaviour because pud_offset(p4d, 0) will do,

0 >> (PAGE_SHIFT:16 + PTE_INDEX_SIZE:8 + H_PMD_INDEX_SIZE:10)

 UBSAN: shift-out-of-bounds in arch/powerpc/mm/ptdump/ptdump.c:282:15
 shift exponent 34 is too large for 32-bit type 'int'
 CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc4-next-20200303+ #13
 Call Trace:
 dump_stack+0xf4/0x164 (unreliable)
 ubsan_epilogue+0x18/0x78
 __ubsan_handle_shift_out_of_bounds+0x160/0x21c
 walk_pagetables+0x2cc/0x700
 walk_pud at arch/powerpc/mm/ptdump/ptdump.c:282
 (inlined by) walk_pagetables at arch/powerpc/mm/ptdump/ptdump.c:311
 ptdump_check_wx+0x8c/0xf0
 mark_rodata_ro+0x48/0x80
 kernel_init+0x74/0x194
 ret_from_kernel_thread+0x5c/0x74

Fixes: 8eb07b187000 ("powerpc/mm: Dump linux pagetables")
Signed-off-by: Qian Cai <cai@lca.pw>
---

Notes for maintainers:

This is on the top of the linux-next commit "powerpc: add support for
folded p4d page tables" which is in the Andrew's tree.

 arch/powerpc/mm/ptdump/ptdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 9d6256b61df3..b530f81398a7 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -279,7 +279,7 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
 
 static void walk_pud(struct pg_state *st, p4d_t *p4d, unsigned long start)
 {
-	pud_t *pud = pud_offset(p4d, 0);
+	pud_t *pud = pud_offset(p4d, 0UL);
 	unsigned long addr;
 	unsigned int i;
 
-- 
2.21.0 (Apple Git-122.2)

