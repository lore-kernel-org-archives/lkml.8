Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708EFC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375AB20873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338428;
	bh=/4PVmad157sdCbn+p9w7YyKSbh/zgAC74+plCMl56+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S6VJ0Nh4OaeK8hJeToyAiMy6QX2Segabcvx97vP1XbLWnN1DuPS/ceC7JtdWsm2EV
	 +5sgwRt6qANBdk6pzZ8c0cXmIZzYVrUhRPrQRT3kBq26PqbQS+PmHAVjyDBZRv7Cr5
	 pt5AKvs0U5E2qzqD3RUQm/BpgPd30tiwuXZuQeGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgBJMk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbgBJMiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:19 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2163E20838;
        Mon, 10 Feb 2020 12:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338299;
        bh=/4PVmad157sdCbn+p9w7YyKSbh/zgAC74+plCMl56+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ok7Jtuf/B7Q9oTZOJS77hdXgL87baTYW3SxbKiLwo0J/ysld8D00NxTgzk/NXPF/V
         GFJwApnyOA38WeYNXCNtHPk1rGAZe8o86WCREJ1vTdVu4gg9VmYi79ThxMKq5bmq7M
         aHIIvu5gpc2De5zyI487KfyujzCA5CCDcJ7FqmDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.4 208/309] KVM: x86: Protect x86_decode_insn from Spectre-v1/L1TF attacks
Date:   Mon, 10 Feb 2020 04:32:44 -0800
Message-Id: <20200210122426.531253648@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marios Pomonis <pomonis@google.com>

commit 3c9053a2cae7ba2ba73766a34cea41baa70f57f7 upstream.

This fixes a Spectre-v1/L1TF vulnerability in x86_decode_insn().
kvm_emulate_instruction() (an ancestor of x86_decode_insn()) is an exported
symbol, so KVM should treat it conservatively from a security perspective.

Fixes: 045a282ca415 ("KVM: emulator: implement fninit, fnstsw, fnstcw")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/emulate.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5317,10 +5317,15 @@ done_prefixes:
 			}
 			break;
 		case Escape:
-			if (ctxt->modrm > 0xbf)
-				opcode = opcode.u.esc->high[ctxt->modrm - 0xc0];
-			else
+			if (ctxt->modrm > 0xbf) {
+				size_t size = ARRAY_SIZE(opcode.u.esc->high);
+				u32 index = array_index_nospec(
+					ctxt->modrm - 0xc0, size);
+
+				opcode = opcode.u.esc->high[index];
+			} else {
 				opcode = opcode.u.esc->op[(ctxt->modrm >> 3) & 7];
+			}
 			break;
 		case InstrDual:
 			if ((ctxt->modrm >> 6) == 3)


