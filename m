Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312DBC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8E42082E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eqxZMdCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCZWTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:19:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:55227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCZWTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585261163;
        bh=CEgtUg7TUhvxyaMOA49FPDRHRPdeUUl1ydJQGOwsNXU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=eqxZMdCUD6cAc4G1A9QDQjeepA+lElE+7zRzM0eGeEWfQSX5BMPG/RsHMulw+Koee
         GRcFyxGh4f8L9Us9SrR9pGSRjJH++CvIwfgbkWuRulAw4uBqXIkrACbT+NXc3vxyJc
         Y4Pv3TttihiYDp185xDYma/XyuU4XDpkohcXDi4g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.132.38]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzk3-1ikMdO2Vrt-00XLyj; Thu, 26
 Mar 2020 23:19:23 +0100
Date:   Thu, 26 Mar 2020 23:19:21 +0100
From:   Helge Deller <deller@gmx.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: Regenerate parisc defconfigs
Message-ID: <20200326221921.GA20495@ls3530.fritz.box>
References: <20200326202006.GA160630@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326202006.GA160630@roeck-us.net>
X-Provags-ID: V03:K1:128Tjev5o+FE/QYp7CL5RmvATG9R2JJqIJzLzcco9SSk2lwnoZQ
 O4HdcoLegxFLy6CD9AOWpSyGUfk14w6y1nTuLptMgvEoSBv/0shlmp+3Q910pBz0t5OwZZt
 yiscCcHcQS8MD3r9kHS/zKqjSus2jyz41UJB2Z2hmLotiCvUa8JxhraXXjtMQfweOWLMb4W
 f1R6D6nJxZZ5fT0ekglYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ErZNOB8qmSM=:VIf2UQrJSA1RQjfYZrLZxW
 cDRYSEJtUC0wYaS890EINqRE2mtjYCIDyj00bgr8ebUePGhQZ2RA5UQb2e+V3upaT2HjwPy7O
 xkUEa73lNYW92eNcg2c6GcZRIGrMmfat7M+oGxl4o+wN65F11JnUmDjKy7KR/noj09di1pExk
 O7kDXbTbUg2HIB4KsnKcaQIjdBVknBXtNc1IbNQTjQ92SINI53KhInh8X0Lpsb9u1BiNkAW3N
 Q7C9a2hl6EyW39TTYzzjiKIud5VnlAfzs60yNScJkQuos4xlx1WEMPoPOxEuwjucMPxKQFPT4
 M5zQqmALj/dpS/MfU1al0I7aN4JWnOIrWSdso9z8IfGIGU0+vzrMmjhKL9fFOD5rsTb7rWzLE
 wOo4O05Itcf9YabLIusAHoDQYBz27DlJMiIl1qR7wm6vy1/3anH3sVuY5ptgwvuR503Iyb4Iq
 xEdf+y33+Eiy4rfYdY5tBsgabqfkV3w2WpR29XLQK/e3JgwEMvrwpLWm/rv4H2raPFezhYzkS
 w33bzN8N8DfVEppiXt9YQSN1tjFLtufZyS1hwU85NGKkPg3Yx3dybd96WHdFwgjKRgdT2Y2RJ
 JZ9+rHt81ilwaV1mfKcUm9URtidZcSwVe83S+X/V0XxOY0W5miAOnprdvzjCs3PWj4YsdW9PB
 F/T7Vgk6WJuBZbPjd2lnisxhRkakEkYGZn/ywAYm3ACit8IRViKLQz8Ntd1oLIiUXgwwtfSXT
 oAPblHDQNgCggIjZ0UfgSqVSRdMI0j1DyaOFjKwgA6bW86uc9CG/M0mQVUmebEziOD3AlaYIm
 VlyGpodpKoe3V+fE5xgEsgZGLPql0dSi7m/IP25c7dTvPA61/qNQv6VsI7EJYXNX+LkWpyOOD
 HK3PVomu9q3MJ32AkeWsZ8mKXk3WvnnhEn5iHT67+rsck4kj1wo3cuf3PFQOZccG/itDvhze3
 XF2MalzX7yh9heceAhdVmPmQqMtxGJqWHt9E+US2k9HUdVTrlB6I9up9+Jw5/iKTfTmw443/V
 r/alRf0AL2UISnIjvYc9rWwUWy4ezlAlhMvd9/2JcDzVYiPwmKI9Fx+Bx9Rdu7DFY1dIDW3lf
 1RD/PRKEIfmQouAsbPyxbI5+Vk1Teg0ANweDSubblrOWEiumYiaNYO09O0g5+qes69DaGyz49
 MWgXXEdPNvIeaOxCc/SXVYnMJQjAL/KhooMFObpB1Yz0FKDuWTkFwTcdza2wjxnwqpD1k9FQ+
 VFCbRcik7ZMhevqM7
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net>:
> On Mon, Feb 03, 2020 at 10:31:22PM +0100, Helge Deller wrote:
> > Regenerate the 32- and 64-bit defconfigs and drop the outdated specifi=
c
> > machine defconfigs for the 712, A500, B160, C3000 and C8000 workstatio=
ns.
> > ---
> >  arch/parisc/configs/712_defconfig           | 181 ---------------
> >  arch/parisc/configs/a500_defconfig          | 177 ---------------
> >  arch/parisc/configs/defconfig               | 206 -----------------
>
> Since the removal of arch/parisc/configs/defconfig, "make ARCH=3Dparisc
> defconfig" results in an endless recursive make loop.

Can you please test the patch below?
Helge

=2D---
[PATCH] parisc: Fix defconfig selection

Fix the recursive loop when running "make ARCH=3Dparisc defconfig".

Fixes: 84669923e1ed ("parisc: Regenerate parisc defconfigs")
Noticed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 71034b54d74e..3801a2ef9bca 100644
=2D-- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -79,6 +79,11 @@ config MMU
 config STACK_GROWSUP
 	def_bool y

+config ARCH_DEFCONFIG
+	string
+	default "arch/parisc/configs/generic-32bit_defconfig" if !64BIT
+	default "arch/parisc/configs/generic-64bit_defconfig" if 64BIT
+
 config GENERIC_LOCKBREAK
 	bool
 	default y
diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index dca8f2de8cf5..628cd8bb7ad8 100644
=2D-- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -34,6 +34,13 @@ CC_ARCHES	=3D hppa hppa2.0 hppa1.1
 LD_BFD		:=3D elf32-hppa-linux
 endif

+# select defconfig based on actual architecture
+ifeq ($(shell uname -m),parisc64)
+	KBUILD_DEFCONFIG :=3D generic-64bit_defconfig
+else
+	KBUILD_DEFCONFIG :=3D generic-32bit_defconfig
+endif
+
 export LD_BFD

 ifneq ($(SUBARCH),$(UTS_MACHINE))
