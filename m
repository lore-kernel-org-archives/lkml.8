Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A1CC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E069620753
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584929452;
	bh=68EJQjEar+UsfKLiDjF2JAQc6ZEgqxWm6jTIrxcMeaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WdD93tFGr2L2WjNgVSubf23y+MOhMyAiiPvLK14FiKF70mRqLZh7+KELJ+oSOgZsy
	 uAWWK/+a2NftMyaOuB96aOgbawK1uSycb9R0zra/d5ly1QkANr5jNF16cMKE+tVamv
	 EsbZYrtqd2rqM5zQwT/rc9HYkXHnfyufxaqAH2SY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgCWCKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 22:10:51 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:44556 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgCWCKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 22:10:51 -0400
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 02N28urY002941;
        Mon, 23 Mar 2020 11:09:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 02N28urY002941
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584929345;
        bh=E2psVuEg+JhrGKw/xZVOkRp9XPBXsZqoNs5V0bJG/gA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MfRamYOstzaL5Sdv1wE9lZXnE8bLRnXna+yR1JH4iXjmaUPwYMnh2NWst9/ff8YPw
         AXJKIQ3+rVT9RGaDi4j9DWLail38HYCjOzAZqjdjkEA4KAAqQRsX+EqrFmR+07iOkN
         QvgMAy0+YFGccpWjhxWNNm2ic37LK2yOhmqyRyDphkwIoVjJKxo8xk4C6yWkFUS6cz
         /Fv4pcHguDHLpP2fxOlPLBWqc4upQ0sUQd3cs2XWW4CdFVrk8TizPmVCzYxbpalFW0
         XDM2TEFWRMJnV/gu1kuYYz/qnk7T37MZsS89UoLTLe74Mq3caI6+MueCVI52hB8+br
         i7i0vEneYa5uw==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        clang-built-linux@googlegroups.com
Subject: [PATCH 7/7] x86: add comments about the binutils version to support code in as-instr
Date:   Mon, 23 Mar 2020 11:08:44 +0900
Message-Id: <20200323020844.17064-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323020844.17064-1-masahiroy@kernel.org>
References: <20200323020844.17064-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We raise the minimal supported binutils version from time to time.
The last bump was commit 1fb12b35e5ff ("kbuild: Raise the minimum
required binutils version to 2.21").

We need to keep these as-instr checks because binutils 2.21 does not
support them.

I hope this will be a good hint which one can be dropped when we
bump the minimal binutils version next time.

As for the Clang/LLVM builds, we require very new LLVM version,
so the LLVM integrated assembler supports all of them.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f32ef7b8d5ca..4c57cb3018fb 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -178,10 +178,15 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
 endif
 
 # does binutils support specific instructions?
+# binutils >= 2.22
 avx2_instr :=$(call as-instr,vpbroadcastb %xmm0$(comma)%ymm1,-DCONFIG_AS_AVX2=1)
+# binutils >= 2.25
 avx512_instr :=$(call as-instr,vpmovm2b %k1$(comma)%zmm5,-DCONFIG_AS_AVX512=1)
+# binutils >= 2.24
 sha1_ni_instr :=$(call as-instr,sha1msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA1_NI=1)
+# binutils >= 2.24
 sha256_ni_instr :=$(call as-instr,sha256msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA256_NI=1)
+# binutils >= 2.23
 adx_instr := $(call as-instr,adox %r10$(comma)%r10,-DCONFIG_AS_ADX=1)
 
 KBUILD_AFLAGS += $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
-- 
2.17.1

