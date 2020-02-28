Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E939C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 20:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27ACD24691
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 20:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gHm1LeLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgB1UnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 15:43:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:47289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgB1UnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 15:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582922580;
        bh=mnDLdHX2jiK86oTf4iMjN6Ul6eAwKIxqADER55BWgUk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=gHm1LeLAu63ND9noxnJ5ymlI79AIjr9NYEGsoG3w8taGyfCnUj81LPzvv27d9ONSz
         RHIf9ZZJZpLcA5jesIRQAXnOa9tXsjm8Keo335A5N4jntMZpO4P6X1SgTn2aVqRwmC
         LYLihhF8/rS6uRRR7EiHbNjSOZU2+GFQaYTJx4go=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.40.65.191]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLiCo-1iq73z44oq-00HjTB; Fri, 28
 Feb 2020 21:43:00 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: kernel-docs: Remove "Here is its" at the end of lines
Date:   Fri, 28 Feb 2020 21:41:45 +0100
Message-Id: <20200228204147.8622-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p8CgkGvumOFen7nK/zSvLjGFcepfCf3eS+ZZ6ffWYBqcwaNcntv
 XLRmbidNszU29wrByfTLAeSevCMnjz2YoiUEunmy0xj08p5RCYkLVSu62uMBLK8twDtYo7L
 2EVEmhMHHrXbQIf8QeBcV3J9ETL3U2rw+ScFrhds2bbjMV5/Y/qPyr+ty2I1u0qA/F88EgH
 due6CH5BYqa7RK+qkhd/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:39oJChzYCHw=:VMDsjOZVGzIlMIyuuK2P8E
 dpHH3g/gzLGKKgGy2K4Od7ZIjEY6bzHFH939MzBYZICQFOTFVg8YlbdAGu4LVkYq2B/IdB0be
 zrLeg2bTbR1Imju0MiLRcrqPAhxE3wr5yPXHyZ7eJCNUxmls+NCfnnejFQnQHBqEheqeUb8h8
 P/Zy4m/HdkH2ItN/tA3cHmJdiCSZjxlmczNcPUl5CG6XMdhgWZGNGpRCytRSgvH9qcyCvioNg
 aMCGxWpv+uijnHeHz7E/eeyRL8VThTfGzWz9yC6wxWo0FQJ4RXanbmf6ipZje5ikPkEhazInh
 1wX0aESg2+XHPu9iq0yycgjPCJoHnxHh4ebzDAJI0kcaOhMwUoJVbGRjy+V4o+4037QpdNDAL
 dWlvRd4PgJ8tGknnNR9rXK4OKYOV8wu3UjhG5M5NKFsSDPm7mjnd6sgGpg7xt90MQRR4cmnF/
 TVi5jXOq04cKfJ20h7gJPW8/Um3CupbP0hWZDZSZ6IEIBAFY4L3SPAAaxmvo+bw0x6UOZwCNb
 aXWsrAcZmhIkZmZ1HN4c2Kl3gsRzl2aKoP8bMhbo1woVZ7asgg7KCK72HiVE4ZifksC94ERrN
 mrz+GXcIwnhQ8suaAnoRsHsHvtpidF8xTQ1oV9hy466C2IiGqbgBdVC3Eh/K4KI4VsWD2Fh0Y
 uYDYPcbRD6GIj/z8FmHQpJYR+dk3HigXkgkwG7r7rGLAhrupYQA6jFtPgkXHYIoEE6y8OuGVk
 fMtRpQJa8YJabrtkHifASSz/zJ641GDikbixGv/XPZQ2PJUMQWyLflUKmq8JfdldZeUyeqYTT
 HYAocPp3nEIcWCLbP3iOmzd8hZQ3s3om8cTKPvg6NcheH/OM2f9PK8Tv5eUDbZUz6yLEYU43Z
 j11fhHlMY4+CqBEeuO32J2PDxgBtoGbBkz1C4hHgVcNbzrlzNsLbPScE/csWLIgcy/dU5Gc9h
 MHWICP7MJCKUCZ/Cg0bdQ4GqR9DkNQDrU1m4XbUL1gLiXUytQhVoh2iqRl5HRFgSR7brYiEk6
 i6QVsFvqi+1hRua1F0eZTKWyCqT1UEe01nt15zCGibfiVPUEBFz2sdoH268N7LqvW0+DfgMlt
 YdDJdmvkDMNLtKv+P+OVTgbQhgNncqf/v+KCR2rbE2vMx4Yh52spENM9FhVt9FnPpj7eS2ysw
 x6PwFI2fIGmwHWkIy0Y/qQJ18A02F8XSh8aEXRaVCJcCLaKhfoMAsZtJlpK2ABoBj83Wubl3A
 8VQUeUppI3sI4Toiw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit 9e03ea7f683e ("Documentation/kernel-docs.txt: convert it
to ReST markup"), it read:

       Description: Linux Journal Kernel Korner article. Here is its
       abstract: "..."

In Sphinx' HTML formatting, however, the "Here is its" doesn't make
sense anymore, because the "Abstract:" is clearly separated.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/process/kernel-docs.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process=
/kernel-docs.rst
index 7a45a8e36ea7..9d6d0ac4fca9 100644
=2D-- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -313,7 +313,7 @@ On-line docs
       :URL: http://www.linuxjournal.com/article.php?sid=3D2391
       :Date: 1997
       :Keywords: RAID, MD driver.
-      :Description: Linux Journal Kernel Korner article. Here is its
+      :Description: Linux Journal Kernel Korner article.
       :Abstract: *A description of the implementation of the RAID-1,
         RAID-4 and RAID-5 personalities of the MD device driver in the
         Linux kernel, providing users with high performance and reliable,
@@ -338,7 +338,7 @@ On-line docs
       :Date: 1996
       :Keywords: device driver, module, loading/unloading modules,
         allocating resources.
-      :Description: Linux Journal Kernel Korner article. Here is its
+      :Description: Linux Journal Kernel Korner article.
       :Abstract: *This is the first of a series of four articles
         co-authored by Alessandro Rubini and Georg Zezchwitz which presen=
t
         a practical approach to writing Linux device drivers as kernel
@@ -354,7 +354,7 @@ On-line docs
       :Keywords: character driver, init_module, clean_up module,
         autodetection, mayor number, minor number, file operations,
         open(), close().
-      :Description: Linux Journal Kernel Korner article. Here is its
+      :Description: Linux Journal Kernel Korner article.
       :Abstract: *This article, the second of four, introduces part of
         the actual code to create custom module implementing a character
         device driver. It describes the code for module initialization an=
d
@@ -367,7 +367,7 @@ On-line docs
       :Date: 1996
       :Keywords: read(), write(), select(), ioctl(), blocking/non
         blocking mode, interrupt handler.
-      :Description: Linux Journal Kernel Korner article. Here is its
+      :Description: Linux Journal Kernel Korner article.
       :Abstract: *This article, the third of four on writing character
         device drivers, introduces concepts of reading, writing, and usin=
g
         ioctl-calls*.
@@ -378,7 +378,7 @@ On-line docs
       :URL: http://www.linuxjournal.com/article.php?sid=3D1222
       :Date: 1996
       :Keywords: interrupts, irqs, DMA, bottom halves, task queues.
-      :Description: Linux Journal Kernel Korner article. Here is its
+      :Description: Linux Journal Kernel Korner article.
       :Abstract: *This is the fourth in a series of articles about
         writing character device drivers as loadable kernel modules. This
         month, we further investigate the field of interrupt handling.
=2D-
2.20.1

