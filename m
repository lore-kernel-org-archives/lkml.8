Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CAEC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B4720870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eB87Lvzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbgCCTmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:42:43 -0500
Received: from mout.gmx.net ([212.227.17.22]:51695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729805AbgCCTmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583264548;
        bh=Xgx8WIi3rVuj8yf+6PVppo0/SP9PD759lC8C/ZJevX4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=eB87LvzpY4fH8lVAN/IclVKOQbJf21KNtSAXc7/AUx46dVjybVaZxNfZ4ptBYtUgQ
         iHzGKR8oYupmK0SgQSAXwIC+kAIh+NllSXDKT0GYMMvaiFT3TDnCcMLsaMyWxfSxVj
         EyMP6P9lCmC8A/wGDNTT0n4mbJHZyAR5yfXhthZw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.177]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsQ4-1jHyrM1mIC-008vBq; Tue, 03
 Mar 2020 20:42:28 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: dev-tools: kmemleak: Update list of architectures
Date:   Tue,  3 Mar 2020 20:42:15 +0100
Message-Id: <20200303194215.23756-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:68jtXPhX06Lu0qfwyrgusjtXB5xCqXNNE/R44+RUrOHmvDBNEdm
 NIiNnf+gsJzqBZPBuKBjjb29J4LB7iEZtOS/zH59Jj1NWplJMi6nRQPFL28DH9aRPG1PEnO
 IEbMpeM+euZ2hlHFz/N+eXEpkpem8vA576N+BgqWCakTV1s6jpw1VTFkza8A6Csz7NBtHsJ
 84hSagB4hFEd0SNNKRFJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MMUK9BaEfMo=:MxmQ3bsAR7UBqjddUaoy/4
 rQLobsayQQeUuuxlesKNFdMDaLbeme0DwvyaYW2tN7ouYxLIhentVrt1qfGCJiwkPM1oGLBRj
 5kFeNaDrNcQISCFu008xp6EfQxpWQZEvQNymYSuVQ4aQ1ZRz6rI5hWehjZrDbgxtM6c3UytP0
 BQxQfM4vKBcIG4qrrc1e9ZVTgI/nGYW9XohjUYWadH463qLOb15VgIOS+GsY1blT1rUSuXHam
 O3Biz/eDkGjwCG2vSGSUKJyIH2C8UAH7P55r/2+ePEXcrOWWnZh2vTlGecFTka4NsHEhAtQDt
 HZicvMCQmRvl+qGxz0qK+iRq4p72zU8xceuudwJcvKidxrzHgnzCT4Y+8x3FRkMXbQ5v6Q7u9
 SSycZcq3QThgY+cqNtWobwxK966RNW1vrhA5XDVHA1CVtSX6upZFFLPuhmcVsvulCKzQ2qP2M
 LDj9avTFs5chUFm/gDbaFBEOM4NkNJdezH7T4AUvD8pG59fUIm3DHx/h4SQsEDKLgLT6EqZ3H
 P952jEWmxC57NMwFoasPc6fNWEhtQ1B760KsB7VlyWjX3mOLaLjFlGIA4kyDnY1GwKxCLN4QG
 H1PxBafNWjdEartrUVdpoUbi6zjUVJuwhwx2TAFwv2MkWuRMYaQBxI6+nhqkaKAerFZE/LlwL
 jtfTJs2JUlc1L24dpV2zgwkcKAtgTZywKVXWdQcCvqhNaMW0mp3rO4JAUpgeLr0hxIQpdTAO5
 O/jAy1LOS3QmS1xotQ+ax56NH6AOZ3E/fihRXg57hc5Amg0CMAH5DsmJCEz3WfLo9udj8Re3G
 9xkfLmAk1xop/P4O/gOjM7Tte2SL3QhWv9w0Wn/fOdcQZxI8DrZZr7JDgT912TIcdEbDGTZSE
 WTu6DjSPO4fqTOGvWm2xHA+SMydVE0x12bdTiOUn98m5DEEImxaedJSrZCqTo3Bw7SBYojglR
 IvB6nOzgkaWWKg6q4+sPJcRSdDGzGqYkSfINRQC+N9oASahReFLKqJ8nYQgI/AbpAlCrR4VOc
 RDuIdohHgJrCD7KljUSpVL1BKw2nCnCJOJFE7aeOXEO5b4Qx6ymRn3FBMgPoN+mVTyX3HqaT8
 hvXEtgEJ60QpHT7R7r5YbhWjlMsO77MrejM6FmbhJwIaqYi8dfKm8v2ulSpuXStJPssUyomA/
 JyO0H50dXdunm1QfHFcMzJHAwXPaH+OOJmgz1zWfGAApvXSsXzzg8Zb5Bgn6gS6kflNlRhQcw
 q9b0Jl5nLtAu95qjt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Don't list powerpc twice (once as ppc)
* Drop tile, which has been removed from the source tree
* Mention arm64, nds32, arc, and xtensa

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/dev-tools/kmemleak.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tool=
s/kmemleak.rst
index 3a289e8a1d12..fce262883984 100644
=2D-- a/Documentation/dev-tools/kmemleak.rst
+++ b/Documentation/dev-tools/kmemleak.rst
@@ -8,7 +8,8 @@ with the difference that the orphan objects are not freed =
but only
 reported via /sys/kernel/debug/kmemleak. A similar method is used by the
 Valgrind tool (``memcheck --leak-check``) to detect the memory leaks in
 user-space applications.
-Kmemleak is supported on x86, arm, powerpc, sparc, sh, microblaze, ppc, m=
ips, s390 and tile.
+Kmemleak is supported on x86, arm, arm64, powerpc, sparc, sh, microblaze,=
 mips,
+s390, nds32, arc and xtensa.

 Usage
 -----
=2D-
2.20.1

