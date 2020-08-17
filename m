Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C015AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F4C204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690416;
	bh=eD/OFt1++bnzXdDBZwIFG18Hdy1KClaBq7QVFbnSbVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZjV5c+oRNg7srn3NKs+oXA1jhV6XYbd8zQkthUxEdkfyrAYmn36GxXxOa6lGgmtwZ
	 UqJg/0cZ6qdgQcuvRlRZaJd1PyMPuPPEkPJT//iFxfMa1aEYG0l5X2xbpc/HdAfenA
	 +7qgIo1RYkiegeHHYUHYXzzP4rribVlEeNzFj5M8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391787AbgHQSxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387814AbgHQPvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:51:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCB2120657;
        Mon, 17 Aug 2020 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679506;
        bh=eD/OFt1++bnzXdDBZwIFG18Hdy1KClaBq7QVFbnSbVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7rmBEmDMioYi23UERrSv2zGEEE6k3mMZU9IJmRI8sfq1ZJlKReT6KetNCKgzseL3
         Y9YEMcrLzMj5izifgA/XXBCpXVhX9JbgbS7xgsRfX+DnET2vHd9hZtflJDo9H3DH1T
         cYMD9uKaN0+gDEMcKMzwjAyvXp9M1eG9prsNxLzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 236/393] s390/bpf: Fix sign extension in branch_ku
Date:   Mon, 17 Aug 2020 17:14:46 +0200
Message-Id: <20200817143831.066765186@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit 7477d43be5b1448bc0d4c85cb185a0144cc080e1 ]

Both signed and unsigned variants of BPF_JMP | BPF_K require
sign-extending the immediate. JIT emits cgfi for the signed case,
which is correct, and clgfi for the unsigned case, which is not
correct: clgfi zero-extends the immediate.

s390 does not provide an instruction that does sign-extension and
unsigned comparison at the same time. Therefore, fix by first loading
the sign-extended immediate into work register REG_1 and proceeding
as if it's BPF_X.

Fixes: 4e9b4a6883dd ("s390/bpf: Use relative long branches")
Reported-by: Seth Forshee <seth.forshee@canonical.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Seth Forshee <seth.forshee@canonical.com>
Link: https://lore.kernel.org/bpf/20200717165326.6786-3-iii@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/net/bpf_jit_comp.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 0f37a1b635f85..ac227ea13cbe7 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1416,21 +1416,10 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 		}
 		break;
 branch_ku:
-		is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
-		/* clfi or clgfi %dst,imm */
-		EMIT6_IMM(is_jmp32 ? 0xc20f0000 : 0xc20e0000,
-			  dst_reg, imm);
-		if (!is_first_pass(jit) &&
-		    can_use_rel(jit, addrs[i + off + 1])) {
-			/* brc mask,off */
-			EMIT4_PCREL_RIC(0xa7040000,
-					mask >> 12, addrs[i + off + 1]);
-		} else {
-			/* brcl mask,off */
-			EMIT6_PCREL_RILC(0xc0040000,
-					 mask >> 12, addrs[i + off + 1]);
-		}
-		break;
+		/* lgfi %w1,imm (load sign extend imm) */
+		src_reg = REG_1;
+		EMIT6_IMM(0xc0010000, src_reg, imm);
+		goto branch_xu;
 branch_xs:
 		is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 		if (!is_first_pass(jit) &&
-- 
2.25.1



