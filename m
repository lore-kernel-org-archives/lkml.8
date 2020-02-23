Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD29C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 22:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6F920836
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 22:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LJD9q40g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgBWWXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 17:23:16 -0500
Received: from mout.gmx.net ([212.227.15.19]:42613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgBWWXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 17:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582496563;
        bh=GqpjYXpiE2H1kys8r64foKMJ3IDT+M3VsZQ1o/tOYeU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=LJD9q40g3ubna3tECbxuybouTLAIH4STsLXqUDh8qJG5KLDH2Vn9h3he85G7z0FMA
         xMlgp56W0r1IvS32DK6iPnnJ4RGNNWxUNIs4MyQQ4IX0MhFJaFpczQ9Zs3B0ameaI8
         xaUPtd4aFkMSwd+kuWI6+trCyl57L5nGzYeRDf5w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.2]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD6W-1ja5Ka46N8-00eKf9; Sun, 23
 Feb 2020 23:22:43 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: process: changes.rst: Escape --version to fix Sphinx output
Date:   Sun, 23 Feb 2020 23:22:27 +0100
Message-Id: <20200223222228.27089-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zjmOS1t4qr9vxA5q0M/9b0mni4iQSB0qibJcF2d1r9UUxCF0D2s
 6R9UAqa4MGe2MvwE7GF2PfaF2ZQprgzNR/T2/gbR/SIiW8dsQt7dSWVSOolSF0h0jhv75IW
 d0xluWsBFPKVeFkL6MbgCA3f5otVae+lNHQ8pCcoOIHyORLh47bV05mJNsPpUGuab8LXhb/
 AdNzaG9ms4YOqJYKG+UlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iPfdU5EtNbs=:qt1lqb5DI3Q5Eja2F3ENCX
 zx4l0LLvOXfH983xHhMLBR2iL3bIQZXyZ/014jCWo9Y3N/PcSfxCQBmqUgy+KQv8+Y5iiytq8
 ealDr7KdmwJldzYuf5Uhbpyy79YrcBx9U8ZvHovERDYsRWzDgCQlFGKkoZ3R+D8hdxYibttyO
 VIQyAMG+sg7dZU/DPkKr9+DXcJg0hia7pbYgcSNaKrIQUqtKi+T64iV5DqOpcFqITd1u+2Qc8
 9ctl8uHJEsCQDKv/k2qCzg/70NK89yVKXdmwHf7bmhpJy2w38iSKVXruEiZQhKmdMA43U3NiI
 vNSIU5HIaf99o+sgqZwRrBkbrhW/888rQv3lqXq3V+N7ZF1KURgQBOjb9Co0w6PoqyfURF8f6
 wRVzKVV+k7Gr/CrMwcGKILA0ose3o4ma0uEg19nT17V9+hB1MZXvopCARlLYcgBSFQWPO97Ak
 7BqxHcIDh8XUUmw8KdNXl0drgy13cYQnf4TpG50QZn3TiA5nszqU/wQc6K41JY+pmCPTjKDsO
 OakuPtLGoREwytXVU1LojFVDY2xMHgUZ9AkwEWX7Pt14t+DGVjlcXIkbfK1EP2/rs6qqFCw3e
 6lqHQD/j38K2GocDdrY9Ls4NZnWMkcxe6sI925hmH4Md0diy+EbMv6zzvVY5z5/E6boHYBy84
 +alKswPg5r5PL2qKaTyn094cM/GqhQTgFA68qYzwoUeJSLVbltlBsayyx9l+l/7POjQZsbR2K
 P+DSQ3AtrKzOcdOX3POf68GuFS/01r6pz88n5VkUUN28TpsgWwYl0oP2Ihu3tnDCrUI3WBPfQ
 QDAWd4Rv5i2KpDmAszmZ0fwB0I20H1CP4gtKVni2JXskOc1HIK9TiyA3aOy722HfwuOW84gl9
 QrugZLjZMekPxgHXrFl6q03tdnK/NtNX+xivutfHenw0OCcJKktp5qRl5tD4ePqfF6byltipB
 sqdQaMbvJyqz3883J5k7Cxs3yrcgk3/PdcH2jrZBw3Z/PkpZrf8UPAQyAzScuYxRM4Etv/GC9
 aQ5xRhfQmlenOgXL+pSyqigGcqWyAPuYGH7uXojYfcg2wWqlXSZpZzm7WqRhzvoruZugVQMvT
 MWXbG49dxA+MNdzsoGvUmpjqDUH3e27eOOdBEJnAuAI2xJJUYQyvjU2mYJsqOD8WJQI+hVmDq
 nZx2IF8WRTsEpdtZITchGY4sb7xSAh5+zw344nC9b/JjyQzEKNIKV2hjqjissDv3YgZN3zFlj
 qVF7cs6mthH4GFcc7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without double-backticks, Sphinx wrongly turns "--version" into
"=E2=80=93version" with a Unicode EN DASH (U+2013), that is visually easy =
to
confuse with a single ASCII dash.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/process/changes.rst | 52 +++++++++++++++----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/cha=
nges.rst
index e47863575917..0aa765736b73 100644
=2D-- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -29,32 +29,32 @@ you probably needn't concern yourself with pcmciautils=
.
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
         Program        Minimal version       Command to check the version
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
-GNU C                  4.6              gcc --version
-GNU make               3.81             make --version
-binutils               2.21             ld -v
-flex                   2.5.35           flex --version
-bison                  2.0              bison --version
-util-linux             2.10o            fdformat --version
-kmod                   13               depmod -V
-e2fsprogs              1.41.4           e2fsck -V
-jfsutils               1.1.3            fsck.jfs -V
-reiserfsprogs          3.6.3            reiserfsck -V
-xfsprogs               2.6.0            xfs_db -V
-squashfs-tools         4.0              mksquashfs -version
-btrfs-progs            0.18             btrfsck
-pcmciautils            004              pccardctl -V
-quota-tools            3.09             quota -V
-PPP                    2.4.0            pppd --version
-nfs-utils              1.0.5            showmount --version
-procps                 3.2.0            ps --version
-oprofile               0.9              oprofiled --version
-udev                   081              udevd --version
-grub                   0.93             grub --version || grub-install --=
version
-mcelog                 0.6              mcelog --version
-iptables               1.4.2            iptables -V
-openssl & libcrypto    1.0.0            openssl version
-bc                     1.06.95          bc --version
-Sphinx\ [#f1]_	       1.3		sphinx-build --version
+GNU C                  4.6              ``gcc --version``
+GNU make               3.81             ``make --version``
+binutils               2.21             ``ld -v``
+flex                   2.5.35           ``flex --version``
+bison                  2.0              ``bison --version``
+util-linux             2.10o            ``fdformat --version``
+kmod                   13               ``depmod -V``
+e2fsprogs              1.41.4           ``e2fsck -V``
+jfsutils               1.1.3            ``fsck.jfs -V``
+reiserfsprogs          3.6.3            ``reiserfsck -V``
+xfsprogs               2.6.0            ``xfs_db -V``
+squashfs-tools         4.0              ``mksquashfs -version``
+btrfs-progs            0.18             ``btrfsck``
+pcmciautils            004              ``pccardctl -V``
+quota-tools            3.09             ``quota -V``
+PPP                    2.4.0            ``pppd --version``
+nfs-utils              1.0.5            ``showmount --version``
+procps                 3.2.0            ``ps --version``
+oprofile               0.9              ``oprofiled --version``
+udev                   081              ``udevd --version``
+grub                   0.93             ``grub --version || grub-install =
--version``
+mcelog                 0.6              ``mcelog --version``
+iptables               1.4.2            ``iptables -V``
+openssl & libcrypto    1.0.0            ``openssl version``
+bc                     1.06.95          ``bc --version``
+Sphinx\ [#f1]_	       1.3		``sphinx-build --version``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

 .. [#f1] Sphinx is needed only to build the Kernel documentation
=2D-
2.20.1

