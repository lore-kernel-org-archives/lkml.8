Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAACC11D28
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 03:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E1720722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 03:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HLO+Fko5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgBUD6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:58:45 -0500
Received: from mout.gmx.net ([212.227.15.18]:48053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729546AbgBUD6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 22:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582257517;
        bh=0IkpDyUNGf8U+GU3Ugfd91n4u77CmkJzZe7yNXdKVlU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=HLO+Fko5bBmMEX7nbVRH0agKHmoLAF1X2Vqw7tpPPFlw8OFmWkqquZqYyedDMEQ4W
         fSh0EwwHzVni1fYuhoQ3bNi+H1dlKXAB2nlTbD6esZcP9TiCY0Wl2Iao2jmQhntPea
         zPxypL8FvBaauMOKyptEuFoRNmo1o5YveqAYAdho=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.160]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7K3i-1j64rB0uwm-007jai; Fri, 21
 Feb 2020 04:58:37 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/libstub: add libstub/mem.c to documentation tree
Date:   Fri, 21 Feb 2020 04:58:32 +0100
Message-Id: <20200221035832.144960-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B5zMMZzZDcEChRX8xM7s90huWv02KHcZWjl4Nr7fYZneXQWEuX4
 c2qPlVGV1QyT+9iDia7ameJq2AxWyJw9RHxL5ph3jN8triHQJfV+OGbMKZup0c6eUqUjavD
 CniqN+Yb5+OmaQL+/f02tBxa9aoyXkuYeZ0t638XcHCRubvz2a7gF9vYiFNIbx/16UBkgoA
 kBHrIVA+/bI7dTV7Per4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vRkxicBFAd0=:kvE8new1AGXfkHQG1SvdVZ
 lorl0TLijFGxw9LSDT2FyptnFv/2sMKD32TX8ru7K9SY2VOaDmp23ry/8wsZom3o4qn/YNHHP
 egD65Ax/I0UrsArm4Uwf1csmKtEfsuU4fVsrxFblJ4vPNn186iHGzjdxVSeRKM1mW1q+4oYqD
 D6VmWx/NXVpxInY5eFcZ2vR0Eq+ZBUHcBPtdw2L2V5DZ6gFvckQ+f0as/6wZiFGoXuHQOk3d0
 n/ze9ivqyOH3XmaEQBPb26kqY26PWQLmrvFiEHKbXl8EJQM70EByW46mbgFb1q6xGfhvF1VAj
 6AgYznyy2vLUG8ltV98KNQ0ocu9Cb7n6QXMNEv1e1WO69eMQ41lbREcVnW+uKuFWD/7YNziGz
 kvinH+UqTN5qlRRKjO1SdJY3BtFi+/zmAaMiyGoAVJklC5gycX4mNkK4+ksx7L1LiPMXK5wW/
 Tv0xz0TKvWUCSF7AoASZBzGbs0EVW/73zz0ICk+FXR946CFSFzfxEX+bFkJE0AsJ3PRbmzX6N
 ZUTAhhud0qljw9iyQtUKpJ64F1JM8hhXFtt5BbiULgQpcPc/L6yPMxunpRrroxkOQpkIjpOzZ
 fT4qNUB75zepatAGtym2mmMB8/vTBQVQp+CkhPw9vGEaZApXiK+I0QlEio/KZlNb57JHSx8pS
 Xq8FCB6jhG0cmqgSrnxGbq0u8WhK+xMC9n5xb6WZQMUZcBQonWHFx40J7BNfA1/fyBxY77OCI
 tZIIrZptF766V/TxNT+L1P0M/iSrA+vaFNZcEyance5tT/1+TfCfAQD+YTza+mcHw1lKCiUwM
 9XkkpFqbmwb/VV8gXh34s0xrgl/4CI/EYA/wWlTaz+hSP8uHyI9t6D7X7VrZywfss+L6+28oJ
 FtXYA0wW0jb0QIiH/JXV2CVYF3KSo0Xk4WAgO84MloV9JxAgrv5vIFxSmAVTjkfvwneJZ4dMl
 G+sCTKMnP1i4+/A2Fin7DJ7fF5oTZcpI0mJjrArsQXBBl89Ib4ylEwmaN5dx5+9t41WBrVUXx
 6VM21J374Yzq7QIB1LtYNxWrHHF+9A+h4McuHlAq2VZn4cB3jQHduzOCtb/ZhhJ1V0O8Oup16
 xQLCiDnLqSOunvrD5WVKwEbUgQwUe9LTRmEEgHPBpEgakMNlUCr9CAt/C4z8C24zyCDVcqxxx
 vglkbWUA3tBpAavZoPu9Nm31zzR5iRQUyAT8eevpLmTUowzkSQC4ccpFJ5jOEWQUyoQR1MwAc
 QKwyAzDMb/j0qvI4H
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the description of the efi/libstub/mem.c functions appear in the Kerne=
l
API documentation in chapter

    The Linux driver implementer=E2=80=99s API guide
        Linux Firmware API
            UEFI Support
                UEFI stub library functions

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
The corresponding source patches are still in efi/next.

https://lkml.org/lkml/2020/2/20/115
https://lkml.org/lkml/2020/2/18/37
https://lkml.org/lkml/2020/2/16/154
=2D--
 Documentation/driver-api/firmware/efi/index.rst | 11 +++++++++++
 Documentation/driver-api/firmware/index.rst     |  1 +
 2 files changed, 12 insertions(+)
 create mode 100644 Documentation/driver-api/firmware/efi/index.rst

diff --git a/Documentation/driver-api/firmware/efi/index.rst b/Documentati=
on/driver-api/firmware/efi/index.rst
new file mode 100644
index 000000000000..4fe8abba9fc6
=2D-- /dev/null
+++ b/Documentation/driver-api/firmware/efi/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+UEFI Support
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+UEFI stub library functions
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+.. kernel-doc:: drivers/firmware/efi/libstub/mem.c
+   :internal:
diff --git a/Documentation/driver-api/firmware/index.rst b/Documentation/d=
river-api/firmware/index.rst
index 29da39ec4b8a..57415d657173 100644
=2D-- a/Documentation/driver-api/firmware/index.rst
+++ b/Documentation/driver-api/firmware/index.rst
@@ -6,6 +6,7 @@ Linux Firmware API

    introduction
    core
+   efi/index
    request_firmware
    other_interfaces

=2D-
2.25.0

