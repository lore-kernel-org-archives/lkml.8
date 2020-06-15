Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AF1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3142074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GdGGw/qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbgFOUhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:37:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:47263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgFOUhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592253414;
        bh=zUpiwtW/mBNBtxbltW5xvU1MTiYL1U9/ERiK0001imA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=GdGGw/quUe6yfg/W5GYqcIxjvnkXQaFir6A7/8cJiN8er/b9UtRZN1pCXXIxNffGS
         aoGYMz3ydxt3dChe7mPS11xZ2eIeljQztW8SVG9SLOsLgxh6uRTXE0eULfVfyInvRv
         RiRyue5RZd8C0CQbRyHKHWLQaFnbHUR2kXSKHSOs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([109.41.128.22]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MEFvp-1janMR0FG9-00AIkz; Mon, 15 Jun 2020 22:36:54 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] doc: x86/speculation: length of underlines
Date:   Mon, 15 Jun 2020 22:36:45 +0200
Message-Id: <20200615203645.11545-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O6vYLX022T0AXtIILO/LNdmaVEguVvZ5BOhMSLHHx0qeA9+Ixfr
 jzUoJajJIbMCw9Br1FdM6KLyltoYBG99uamUaeut7YN5i7j0nWngXCTpQ1wsDwu+lg2oCKp
 9Ygg+Bax0R0YG1VKUSVjIrLMFsl1HX9m3x9NBN27pO708RMNzh9eQgLnWQaFa4t/g0JK7YE
 bOs0mrt2lwvFQt9xuHCtw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I0Hprvszq2o=:B1jk4eY+Fl4Od1hksOGDKc
 IuR+eILWV0ifZr09qLj5+0DQpoDHzKEhVX9Sj6w8D9MvPRESHhYwetNHQAGdEHKVmC2LapAry
 JF4baaM++ysFjba1sPXUBfC+lGNh/EsKcMnw+OVou/h3Rm1OdgjQDI46JMSStnp0NCfMkABV7
 X8MvDwzjZcn2JtWak4svcE4FJnrczw4BRhZm75cQ0tY87fz9XyqWhDE5cFU31MQ2L1WRT+NOw
 FR9ag8/IbnGNRiXB716Gp+SL42LAF8k4qmYN02ulitJd7oYERKCRT5+OhHr8LNTM7Fgiyr9lH
 swwxIdnm99vG2IyOFiVcELRGVXgPp0X5RTul07TTjCUg+5oeRTVqtFh4ZyXdWUKHo/wtI5pD0
 YdN3Tktdz3MdJH7mTxecmKwwGvTbZnT1zruEJahz2jZzA/TvgGWSWFb6/d5PyKWqbT80PF01u
 SD5DPuIHtLkDREBPHawM811XaH6IgCL6WszPCvL7WgHFObNSHF25vz3knGCy9eUek68T4QLRW
 bt7XxMAltcXZ+5Pc8aPiepE6Nys8sSV/EvTxOyY3bBPuTqj+9zeLR/EouDV/Q1SEDzLj9XM70
 0pF3eZSV03QRYxWIUSFRtoTPtTM09oS5BjZqDPZfECjH59/tUhfqeTnVgTOV2aPW2g15cFXpl
 EVi+iduBCJOXQ1ToQWbdIU32sAzzjLH2P5vmecYJ5sNHbqwsVfkM+ypIR5Pcbd8rgpS7CP/t2
 AlAyCcKUY4d3UOaWPAvm+75LxlqXiG+prqGcsuZ8Srf8+EKmgZrLF5ri3eBDEjSZVEPB0ZA86
 ajRuYV256I2q+lXeSiClhRcX0rYhjKGyBg0+oPTPOb0SrCb7/hjnTZMx1yTBoT5aeQKqMbl7A
 3dRqbkSSDpEWgVDYx4Dt1P3nZ04L8buGIAhL0m4RzvZfdzVqXtWWvp2Dl0ugYvJ0LI+XfvKL8
 sM4w0MVL900XdW+CsJoQSgBpiESG+ANSYoc4R0SO5UJ85Qtn85+INVHYhiNEHyLZuHDXh7AtD
 FD3zkItmBfZFsdkkdUb9iUvd399EjCVsdkYUroQktNWy4YnbCkOfCGgK6DFi4y8DCJwCS2bZ5
 ZKhuIYx2Y9RUSu6/tbUXk3Y5z42ShuGzAyTl8PawUF7VASU2uIG7BU49rNG/SGVe1DiOnViTC
 MrKLT8Q9goMgMwTz8lJu3N7cGKPQLH/C14ndpUjTd6sIwXth+dCGixJiq4cHEkwjFANtI1+A7
 7jZA+z4G+r0b1k7GU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lengths of underlines must match the titles to avoid build warnings.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 .../hw-vuln/special-register-buffer-data-sampling.rst       | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/special-register-buffer-dat=
a-sampling.rst b/Documentation/admin-guide/hw-vuln/special-register-buffer=
-data-sampling.rst
index 47b1b3afac99..3b1ce68d2456 100644
=2D-- a/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sam=
pling.rst
+++ b/Documentation/admin-guide/hw-vuln/special-register-buffer-data-sampl=
ing.rst
@@ -14,7 +14,7 @@ to the core through the special register mechanism that =
is susceptible
 to MDS attacks.

 Affected processors
=2D--------------------
+-------------------
 Core models (desktop, mobile, Xeon-E3) that implement RDRAND and/or RDSEE=
D may
 be affected.

@@ -59,7 +59,7 @@ executed on another core or sibling thread using MDS tec=
hniques.


 Mitigation mechanism
=2D-------------------
+--------------------
 Intel will release microcode updates that modify the RDRAND, RDSEED, and
 EGETKEY instructions to overwrite secret special register data in the sha=
red
 staging buffer before the secret data can be accessed by another logical
@@ -118,7 +118,7 @@ with the option "srbds=3D".  The option for this is:
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

 SRBDS System Information
=2D-----------------------
+------------------------
 The Linux kernel provides vulnerability status information through sysfs.=
  For
 SRBDS this can be accessed by the following sysfs file:
 /sys/devices/system/cpu/vulnerabilities/srbds
=2D-
2.27.0

