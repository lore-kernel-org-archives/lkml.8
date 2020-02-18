Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49381C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D85E21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HB3Mdirm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgBRQi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:38:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:32891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgBRQiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582043923;
        bh=IVqXr+uGnPkGBbiJMPcgDjV0gt1/2BJIB3tZaSUyyaI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=HB3MdirmzLWQ1eotKO/Ult0RApNyzTgD8D1ARKawYM/AyUqYViqKKZbbiBey3Vo0t
         viqMcHpDl5Bloh+iFaRuogzg7hI/1c0d+tZXr1hpOHrfTL9PYpfupfauxfLT1ONUnF
         ESFJtxfCCABeBYsTzmPEZ3aOUrkTWFj6hmHx644A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.223]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRMs-1is6xj0oVY-00TiE8; Tue, 18
 Feb 2020 17:38:43 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: arm: tcm: Fix a few typos
Date:   Tue, 18 Feb 2020 17:38:25 +0100
Message-Id: <20200218163829.13066-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XsnEgpb0SMbuM6bL4zw9xAPjlpTKAnjPflEqQ3J0j4jlcSGxCbZ
 ANaFs1yeZ10GIpUxF52R2meypAxdC/N+swCiqGyaNjGTdWxJ7lXMpXESWc4is4Htsy19NVq
 0EW3MKKqgG/EgSJR+nxqH+taN0rgKr595qJeIQSUccK/rJGzSzhO32uPMCqfZ4quAk7QSWQ
 b3B8iuyvRySJUxuqicw8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VJyloGK0TWI=:xint09mz6iPT/v6ozwcg6+
 y0gDM9MM4dx6qUkOSDO2l8ymL/L1Gmf/Rw1XF6LmVy6aMpwQ5BGsGjxsY5om928qgJIGwNSZF
 JhRNMHInPAkkA04TDO9MlaklWI4ijAR0hJgpdb+rld/S9g9q26rG/uvweGK//CV7LFQUd4bZv
 CIuSF78wd+KHUWdU23OMWdBAiLPzBhf4cgC+AFn9YpfWaa67c9bxuegQlNvhkKtN2XSvbDDJr
 aQ6VbNEGJfZc3prxlVZgVO4Odf7I2yMPWonbQv3+VmsrGCFvgSj2wxoe2Gl5ZEXRsWub8n84Z
 a8toFrF7CLgNJGgZcnleQzOyw6jGNm+UnDEif6mdmT//ZuIa8retKh99tTRgD5ygWIHAEbS8d
 S410ipOyKZiiqg1y0bjEZXZv4itk3SoikDq1rBH+8H8JrWug3OSbagVDV+1ouP6loNsYrcohB
 XY4XlsuclYQ8kzroebgkrhYiLTlMpVYQZLS/Tg0DKPY6X4XB2pCYPAsFPT9KYSkF7167+P3Qo
 8nJJ/lOy26mtLk7rY9ma7+/Upri6nESIGfgR7S0FPDR3123w1typcXZD6Tr7yy6/AlH8HWqla
 QI6QybP6U3kDKa5T9d4d9j2gBK2mBXSNcCQSEVnr2/UgKy5SW18ix76u/s0Wq/Kx0whKeMKqR
 RaqEegg4A1OZPeWXNwbG8fHvoMwCassZmAjWx+8aitMY6H8xmWZvkH4b41j93Ke3xhhwWKaWk
 IwvM6y4ZDwdIaF79SeOm0wXWRRb/82hS5xjoIctOyzUn2uCFY28hL0t7Gq/9Grqjdj6t3rSqz
 A1m14PzWDE1hQaBdTZ2coT+3aByODiT1vwhpBKpKMJ/+kkyI8gHULZHN2EIV4fFaHR0HHRl1n
 YDkQOJNAndC7NLU/CaEjN4afMovz7L9fK0h5XpkSPYTKwrnVkOXmtDDKbenmnfWatW29lrbbK
 KKywXZ3BdcFvqokZ/dH1ndBqxJiuczqKluBihB694mcHpKrtFD7cblpW34pzZKg2rq/PJFXeW
 /FD3u0xBAB8GY34nNE8TNl8vwZJPHBqNcgn30h/zd8feg86qvssicTRc91kY47oREjYwFhqtg
 Q+nnzzsEoS5k8GN034IFzx4peR+rQ2myX8LSU8oC1P2iA6i6icQgW1XTMrBXtTjX2MYTK88WP
 ljWouDSpJdTO53nxcT8VK0IABbWajxOUsb1VEIZxnCMlfupH77dK8P4egZYgNVvzZFJP5BxSZ
 k3ZZYzGq41bBfNFxI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/arm/tcm.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/arm/tcm.rst b/Documentation/arm/tcm.rst
index effd9c7bc968..b256f9783883 100644
=2D-- a/Documentation/arm/tcm.rst
+++ b/Documentation/arm/tcm.rst
@@ -4,18 +4,18 @@ ARM TCM (Tightly-Coupled Memory) handling in Linux

 Written by Linus Walleij <linus.walleij@stericsson.com>

-Some ARM SoC:s have a so-called TCM (Tightly-Coupled Memory).
+Some ARM SoCs have a so-called TCM (Tightly-Coupled Memory).
 This is usually just a few (4-64) KiB of RAM inside the ARM
 processor.

-Due to being embedded inside the CPU The TCM has a
+Due to being embedded inside the CPU, the TCM has a
 Harvard-architecture, so there is an ITCM (instruction TCM)
 and a DTCM (data TCM). The DTCM can not contain any
 instructions, but the ITCM can actually contain data.
 The size of DTCM or ITCM is minimum 4KiB so the typical
 minimum configuration is 4KiB ITCM and 4KiB DTCM.

-ARM CPU:s have special registers to read out status, physical
+ARM CPUs have special registers to read out status, physical
 location and size of TCM memories. arch/arm/include/asm/cputype.h
 defines a CPUID_TCM register that you can read out from the
 system control coprocessor. Documentation from ARM can be found
=2D-
2.20.1

