Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE4BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 04:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C4C2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 04:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgGJEzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 00:55:12 -0400
Received: from mcegress-30-lw-30.correio.biz ([191.252.30.30]:8810 "EHLO
        mcegress-30-lw-30.correio.biz" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgGJEzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 00:55:12 -0400
X-Greylist: delayed 7540 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jul 2020 00:55:09 EDT
X-Sender-Id: x-authuser|cesarb@cesarb.eti.br
Received: from mcbain0007.email.locaweb.com.br (unknown [10.30.225.41])
        by mcrelay.correio.biz (Postfix) with ESMTP id 55D2230F8FD3;
        Thu,  9 Jul 2020 19:11:24 -0300 (-03)
X-Sender-Id: x-authuser|cesarb@cesarb.eti.br
Received: from mcbain0007.email.locaweb.com.br
 (mcbain0007.email.locaweb.com.br [10.30.224.225])
        by 0.0.0.0:2500 (trex/5.9.14);
        Thu, 09 Jul 2020 19:11:24 -0300
X-LW-Relay: Bad
X-LW-SenderId: x-authuser|cesarb@cesarb.eti.br
Received: from mcbain0007.email.locaweb.com.br (localhost [127.0.0.1])
        by mcbain0007.email.locaweb.com.br (Postfix) with ESMTP id B8D245C035F;
        Thu,  9 Jul 2020 19:11:30 -0300 (-03)
Received: from proxy.email-ssl.com.br (bartf0025.email.locaweb.com.br [10.31.120.57])
        by mcbain0007.email.locaweb.com.br (Postfix) with ESMTP id A2BCA280069;
        Thu,  9 Jul 2020 19:11:29 -0300 (-03)
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOtj1caloRxiqgYbvP8P_wgmHwNblfkvCn6jCrhDIqFSGQeTZBx1E5oXeQ9zDDTUEye5I0CEEbtBqmQRdepJK3-NFd2BYMkda9wzmP4HD7U6VQ== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOtj1caloRxiqgYbvP8P_wgmHwNblfkvCn6jCrhDIqFSGQeTZBx1E5oXeQ9zDDTUEye5I0CEEbtBqmQRdepJK3-NFd2BYMkda9wzmP4HD7U6VQ== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
x-locaweb-id: 5II90qkwcFl608adNSKU11Mhs1xf0MgAzPC-CIfMoteOMOLYZkorw41aZgtgCBGiz7JOWdNt-MIUbUFIqc5n_VfP5aYHWPJEum0HS-HjJOtj1caloRxiqgYbvP8P_wgmHwNblfkvCn6jCrhDIqFSGQeTZBx1E5oXeQ9zDDTUEye5I0CEEbtBqmQRdepJK3-NFd2BYMkda9wzmP4HD7U6VQ== NjM2NTczNjE3MjYyNDA2MzY1NzM2MTcyNjIyZTY1NzQ2OTJlNjI3Mg==
X-LocaWeb-COR: locaweb_2009_x-mail
X-AuthUser: cesarb@cesarb.eti.br
Received: from cesarb-5490.home.cesarb.net (unknown [200.187.118.13])
        (Authenticated sender: cesarb@cesarb.eti.br)
        by proxy.email-ssl.com.br (Postfix) with ESMTPSA id 4A356C017A;
        Thu,  9 Jul 2020 19:11:19 -0300 (-03)
From:   Cesar Eduardo Barros <cesarb@cesarb.eti.br>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Cesar Eduardo Barros <cesarb@cesarb.eti.br>
Subject: [PATCH] Restore gcc check in mips asm/unroll.h
Date:   Thu,  9 Jul 2020 19:11:02 -0300
Message-Id: <20200709221102.323356-1-cesarb@cesarb.eti.br>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Outbound-RspamD: yes
X-MC:   yes
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While raising the gcc version requirement to 4.9, the compile-time check
in the unroll macro was accidentally changed from being used on gcc and
clang to being used on clang only.

Restore the gcc check, changing it from "gcc >=3D 4.7" to "all gcc".

Fixes: 6ec4476ac825 ("Raise gcc version requirement to 4.9")
Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.eti.br>
---
 arch/mips/include/asm/unroll.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/unroll.h b/arch/mips/include/asm/unrol=
l.h
index 8ed660adc84f..49009319ac2c 100644
--- a/arch/mips/include/asm/unroll.h
+++ b/arch/mips/include/asm/unroll.h
@@ -25,7 +25,8 @@
 	 * generate reasonable code for the switch statement,	\
 	 * so we skip the sanity check for those compilers.	\
 	 */							\
-	BUILD_BUG_ON((CONFIG_CLANG_VERSION >=3D 80000) &&		\
+	BUILD_BUG_ON((CONFIG_CC_IS_GCC ||			\
+		      CONFIG_CLANG_VERSION >=3D 80000) &&		\
 		     !__builtin_constant_p(times));		\
 								\
 	switch (times) {					\
--=20
2.26.2

