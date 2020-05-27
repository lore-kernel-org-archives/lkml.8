Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B8DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A3920723
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbgE0Nk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:40:28 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53945 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388098AbgE0Nk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:40:27 -0400
Received: from localhost.localdomain ([149.172.98.151]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MRTEr-1jPrFs1MOr-00NQt9; Wed, 27 May 2020 15:40:17 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] arm64: disable -fsanitize=shadow-call-stack for big-endian
Date:   Wed, 27 May 2020 15:39:46 +0200
Message-Id: <20200527134016.753354-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WMyBDjaVpnuIlG/nKy3Lfv0f53mC2eMeZk2hD1L4n7nGNgyw6xg
 b3nnLX7RQgVMDLaEP8jeYPeAoZu/zF0+z/vVS6FlpSZ1SIFpVVgeTGlO1P3Ep0Lb6nJG0Zt
 X7hH8s/zBBJhCqlR2UHeoEwOqmPu4huhF9KMCDNPoiOurHivHXkoO0/SR60IwHGXsXj/yAF
 b2s7GbapOF9ubsY1p+h1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F2IKGpPrHuM=:tVtK56yFtrrepWDvUzbOpT
 3us5e9MR1LU4mGSnKMn9Oify9OSZr+z1ryQsomr5xmHuXPTcDxkeL9FtQ6IIzaZK7M4TiGSfm
 SrfknaWXsLAXdIE0avmvLV0juYDzTAcvZtb9k/8fuDk5WLk1Xzj03wmeX+2+GlE+zBu5Uxtly
 3R9vMAQ+KN6313tG9I0lsEvMPCLQoVMlkpm95g50p9vQzl9dxAcXxemJgg5SGc+kTmITf88fw
 TzBvY2rXiGKyibM7Dok5SP7iaxP+NvipLQt1Ykwnqib722x77OfOGSRsjyyAi05G3a0HhkfLW
 /qlIZ3cfZ8HwyXCftttGaI+tPf4INmvSHFJhcz3sp8T8zFr1DfksvLUXYM0yW2t/kSyUXAY6r
 jqg7lgnshy4rjtPaSbqwns/ofBBDNm2riCNB1dm6j/QFwHquE7UuMkpmdNxd3Rhw355uhMZyG
 9WQzvmbaPYDkXMulDC/pFVUnnmk6JIMlNo7Lb4axzkRdQQrTE+TY5VKeSJqchQZ9k16DIJpfA
 DdpLlaK3d2hiHZaGGzVGDVaOXEUcC76oIrpg0ytLJaoNLJeVdcqjcrWlm0URQKYw5ffGf8cAc
 554DdULyt0uYgJix3t8iQctDwx76HodgMDd3y8TrLOfz6t5g9HUTBgCA/CHd72mCM9OMNU/Sn
 vh5Z1871+ipaobAjqACcsmCDRluu13MqfojKB79O1jaGP+0U5ndDp6R6JRAaiJnKMbYdxmimb
 BmZNfm1gtJUlSBep2bkWn5rM/hFM9OhO5b2MYMJxNJwdy0tcIsr+uEsM+4EX8ZBMrkNJ/14MP
 TsHpy/trLFTR2EQPAPCTZ2pxYPaGA3bxNgm8GAncGv7aa37U1Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang-11 and earlier do not support -fsanitize=shadow-call-stack
in combination with -mbig-endian, but the Kconfig check does not
pass the endianess flag, so building a big-endian kernel with
this fails at build time:

clang: error: unsupported option '-fsanitize=shadow-call-stack' for target 'aarch64_be-unknown-linux'

Change the Kconfig check to let Kconfig figure this out earlier
and prevent the broken configuration. I assume this is a bug
in clang that needs to be fixed, but we also have to work
around existing releases.

Fixes: 5287569a790d ("arm64: Implement Shadow Call Stack")
Link: https://bugs.llvm.org/show_bug.cgi?id=46076
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a82441d6dc36..692e1575a6c8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1031,7 +1031,9 @@ config ARCH_ENABLE_SPLIT_PMD_PTLOCK
 
 # Supported by clang >= 7.0
 config CC_HAVE_SHADOW_CALL_STACK
-	def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
+	bool
+	default $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18 -mbig-endian) if CPU_BIG_ENDIAN
+	default $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18 -mlittle-endian) if !CPU_BIG_ENDIAN
 
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
-- 
2.26.2

