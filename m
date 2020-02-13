Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982BFC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEA1206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609962;
	bh=XXb20+cl7ObgXcj/kFd/QmhIqjvVjJSEWhKs5xo0lEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y0q9NQi6rwYETG4Ztv7W+PSXap0rJQMQUDFTiHL/8QA7+Q4K1U/VGOL6uZrg7evrw
	 LQX8odELuO+n0wqRGszqCsiyhF5kMnBLGM/vNYyAT9xFGb6SkbKOqVNrjjL0EUBeKP
	 /aXASzvtiL3+dinW14P+PNjuDft7xtDVo+W8zQic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgBMQGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:06:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgBMPXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:44 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5212469C;
        Thu, 13 Feb 2020 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607423;
        bh=XXb20+cl7ObgXcj/kFd/QmhIqjvVjJSEWhKs5xo0lEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+9h/sHq7jB8HQftmZuCvifaXaDT6CvX2WYkKfjlYAPg9YL9C1BpimlZKqJw8c0mg
         Eepx12+eUyx5ki543RJF/i3PDw+rFrAQzSjUeyg0Ud5iH5Zpp9WBvfEz41JneoIPa1
         1hZ/K4t1HedkF6Trq3oOGGqE2at0jIpmjsD3MEqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 052/116] KVM: x86: Protect x86_decode_insn from Spectre-v1/L1TF attacks
Date:   Thu, 13 Feb 2020 07:19:56 -0800
Message-Id: <20200213151903.154634019@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
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
 arch/x86/kvm/emulate.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/kvm_host.h>
+#include <linux/nospec.h>
 #include "kvm_cache_regs.h"
 #include <asm/kvm_emulate.h>
 #include <linux/stringify.h>
@@ -5158,10 +5159,15 @@ done_prefixes:
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


