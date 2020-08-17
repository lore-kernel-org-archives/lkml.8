Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE96C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF9B204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689794;
	bh=w/2g3aLvQltOZyeGMCGkAoO5Cozq7K1AwA0txE6qThI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CJKQOZdA8+sg6V1pI1l2nU0C/8tT5/bfFXwabq3YUNRCiniWzWKXI1QEnT8xli8Qb
	 eP82nStHrouUWZx3sZtJDEz46kmOpQ/TedV7UbEi3V3t4sBLy3y67Bg6C/4brlCUtR
	 esc4Tp5AVALphunnQNTxZynL+RqOe8NWs1kEWKbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391471AbgHQSnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388099AbgHQP5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:57:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D6020888;
        Mon, 17 Aug 2020 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679824;
        bh=w/2g3aLvQltOZyeGMCGkAoO5Cozq7K1AwA0txE6qThI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2UBIDcP7IPnvjePKanQHSOUru6B+J3ofi4MWKWjYKJs/1dZIy28bIpufd/oPoDF0
         G4bnMjHQhRH7uRNaU86cEh4zohuGEXL6bgscPf/bPr0bFvWhch9kDBcBP2XzSt0fnE
         is0weWqeLdnGG67diTEH+tZZT/vByLhif46Garhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH 5.7 346/393] bitfield.h: dont compile-time validate _val in FIELD_FIT
Date:   Mon, 17 Aug 2020 17:16:36 +0200
Message-Id: <20200817143836.387374469@linuxfoundation.org>
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

From: Jakub Kicinski <kuba@kernel.org>

commit 444da3f52407d74c9aa12187ac6b01f76ee47d62 upstream.

When ur_load_imm_any() is inlined into jeq_imm(), it's possible for the
compiler to deduce a case where _val can only have the value of -1 at
compile time. Specifically,

/* struct bpf_insn: _s32 imm */
u64 imm = insn->imm; /* sign extend */
if (imm >> 32) { /* non-zero only if insn->imm is negative */
  /* inlined from ur_load_imm_any */
  u32 __imm = imm >> 32; /* therefore, always 0xffffffff */
  if (__builtin_constant_p(__imm) && __imm > 255)
    compiletime_assert_XXX()

This can result in tripping a BUILD_BUG_ON() in __BF_FIELD_CHECK() that
checks that a given value is representable in one byte (interpreted as
unsigned).

FIELD_FIT() should return true or false at runtime for whether a value
can fit for not. Don't break the build over a value that's too large for
the mask. We'd prefer to keep the inlining and compiler optimizations
though we know this case will always return false.

Cc: stable@vger.kernel.org
Fixes: 1697599ee301a ("bitfield.h: add FIELD_FIT() helper")
Link: https://lore.kernel.org/kernel-hardening/CAK7LNASvb0UDJ0U5wkYYRzTAdnEs64HjXpEUL7d=V0CXiAXcNw@mail.gmail.com/
Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Debugged-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/bitfield.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -77,7 +77,7 @@
  */
 #define FIELD_FIT(_mask, _val)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_FIT: ");	\
+		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");	\
 		!((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
 	})
 


