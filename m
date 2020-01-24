Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0157FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2C7222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864880;
	bh=W5+b0vwn4o5f8wVFUj2p7qTxj4DyO6rGRMdNK5197fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=br4R5Vs5i5Zj4RMie/NCcT0bq/YvnZNU49xM2JoeKq9ohrj2ab9IfSfp3osVdpp6A
	 4fk9mXJ3i+QRtNC4YOCa0miQTlB4GC8T69ZaLBKikILKy4JwvO34VyuKaXffSpMfhs
	 cwmaqRn2cOz2B1TQt22CHxXcb5qwrdm9SJmluK5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391059AbgAXLVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:21:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391040AbgAXLVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:21:18 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD1E214AF;
        Fri, 24 Jan 2020 11:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864877;
        bh=W5+b0vwn4o5f8wVFUj2p7qTxj4DyO6rGRMdNK5197fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F45yKamNQh8Z9xz3KlByATzsl8rRUahhJpDvxv5PsZszBP2XOznfn8tguly7dDDcX
         oxmTtUScM9V7g1tBP16Bo4SXGzBFebN0zR16jrzFLSnRwWEq0LW+bdHQ2titzO4uy3
         4+NM33OD4DtmisqsgLyOWwiGknImDzQ078+G6uU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 368/639] nfp: bpf: fix static check error through tightening shift amount adjustment
Date:   Fri, 24 Jan 2020 10:28:58 +0100
Message-Id: <20200124093133.165700968@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiong Wang <jiong.wang@netronome.com>

[ Upstream commit 69e168ebdcfcb87ce7252d4857d570f99996fa27 ]

NFP shift instruction has something special. If shift direction is left
then shift amount of 1 to 31 is specified as 32 minus the amount to shift.

But no need to do this for indirect shift which has shift amount be 0. Even
after we do this subtraction, shift amount 0 will be turned into 32 which
will eventually be encoded the same as 0 because only low 5 bits are
encoded, but shift amount be 32 will fail the FIELD_PREP check done later
on shift mask (0x1f), due to 32 is out of mask range. Such error has been
observed when compiling nfp/bpf/jit.c using gcc 8.3 + O3.

This issue has started when indirect shift support added after which the
incoming shift amount to __emit_shf could be 0, therefore it is at that
time shift amount adjustment inside __emit_shf should have been tightened.

Fixes: 991f5b3651f6 ("nfp: bpf: support logic indirect shifts (BPF_[L|R]SH | BPF_X)")
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reported-by: Pablo Cascón <pablo.cascon@netronome.com
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/bpf/jit.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
index 4e18d95e548f1..c3ce0fb47a0f0 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
@@ -326,7 +326,18 @@ __emit_shf(struct nfp_prog *nfp_prog, u16 dst, enum alu_dst_ab dst_ab,
 		return;
 	}
 
-	if (sc == SHF_SC_L_SHF)
+	/* NFP shift instruction has something special. If shift direction is
+	 * left then shift amount of 1 to 31 is specified as 32 minus the amount
+	 * to shift.
+	 *
+	 * But no need to do this for indirect shift which has shift amount be
+	 * 0. Even after we do this subtraction, shift amount 0 will be turned
+	 * into 32 which will eventually be encoded the same as 0 because only
+	 * low 5 bits are encoded, but shift amount be 32 will fail the
+	 * FIELD_PREP check done later on shift mask (0x1f), due to 32 is out of
+	 * mask range.
+	 */
+	if (sc == SHF_SC_L_SHF && shift)
 		shift = 32 - shift;
 
 	insn = OP_SHF_BASE |
-- 
2.20.1



