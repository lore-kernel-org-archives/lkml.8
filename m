Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86643C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C27C2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255716;
	bh=/Wqjtp4C2KTUJ7aU52LARgn34AvNvr/qfNFE2J64GG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AL3pXEci6lLWWsVzBK8uQ8fTJA/KgOUbj0pi0L0D6KbSAtqbDCRY7MzfBkkklAil1
	 j/zp6ujDeogowUVW7oTzi4WaEd8fxjIPzGkhuYo2S47+bZZnoIZBoKxHk0aGQ6DVNp
	 iv6DxMhH2jBM7Kl2Ii3DtsCvdGqzFYWEuvQUbG3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgD3OIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:32994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728308AbgD3NwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:52:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EED0B208D5;
        Thu, 30 Apr 2020 13:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254729;
        bh=/Wqjtp4C2KTUJ7aU52LARgn34AvNvr/qfNFE2J64GG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzhC1/bis+OGFDdRFX3iO44FK5EW2QI8KG8e+WgZ/o8RBpOomRLP+Yx2llDQOQQ1Y
         SRD4mb5pxs2sysdeF2vnnIB1dnFXbu8Ub3ZtEkMGRY8MFKWz1mmrdwf0aeW05+LjXb
         814Z+SBlUiOMJScFiibVe1fPJBE7HmIYaf2cTxts=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wang YanQing <udknight@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 76/79] bpf, x86_32: Fix logic error in BPF_LDX zero-extension
Date:   Thu, 30 Apr 2020 09:50:40 -0400
Message-Id: <20200430135043.19851-76-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135043.19851-1-sashal@kernel.org>
References: <20200430135043.19851-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang YanQing <udknight@gmail.com>

[ Upstream commit 5ca1ca01fae1e90f8d010eb1d83374f28dc11ee6 ]

When verifier_zext is true, we don't need to emit code
for zero-extension.

Fixes: 836256bf5f37 ("x32: bpf: eliminate zero extension code-gen")
Signed-off-by: Wang YanQing <udknight@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20200423050637.GA4029@udknight
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/net/bpf_jit_comp32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index ba7d9ccfc6626..66cd150b7e541 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1847,7 +1847,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			case BPF_B:
 			case BPF_H:
 			case BPF_W:
-				if (!bpf_prog->aux->verifier_zext)
+				if (bpf_prog->aux->verifier_zext)
 					break;
 				if (dstk) {
 					EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
-- 
2.20.1

