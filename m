Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FBCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0098D2076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="TbzpPQSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGNJG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgGNJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:06:56 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B483C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 02:06:56 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 58E7B8066C;
        Tue, 14 Jul 2020 21:06:54 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1594717614;
        bh=wHGlVAJozZhlDMqQofme/sP/ZAXIEJN33oJSja7DG4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TbzpPQSuAFn19nxffMh2ief/YqUv8ys/AIuRSbWB6GwuatOzrRsYwdvZGHp0NJKow
         BXPWc8SBC6yuKm9sKxi0ulKhrpCy8QaQTobII/tTMkIMksNu0Nnf/iJVsyjyV0ACM+
         tIB/UMzsFPiHlVUCa8P2abxNg9U19fYufUjoc0Qnsui3HStRYzNCoeQfMPuW++jUL4
         2WtX0D3awV0MkbYCeBMWwVUzy1P7DGC6FI3wWm+x0NxzAId6ToAHx0Yz/18Z5Rf3tG
         ivIaIENynl6S6YrN17mTAjbsuWGk/QWU46Uf0skC4Nl23VbNMZdeRxc5zg88TmatNG
         QSUeAdneOVk4w==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f0d75ae0000>; Tue, 14 Jul 2020 21:06:54 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id E146A13EFA5;
        Tue, 14 Jul 2020 21:06:52 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 2E629280641; Tue, 14 Jul 2020 21:06:54 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     adobriyan@gmail.com, corbet@lwn.net, mchehab+huawei@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/2] doc: filesystems: proc: Fix literal blocks
Date:   Tue, 14 Jul 2020 21:06:44 +1200
Message-Id: <20200714090644.13011-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714090644.13011-1-chris.packham@alliedtelesis.co.nz>
References: <20200714090644.13011-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx complains

  Documentation/filesystems/proc.rst:2194: WARNING: Inconsistent literal =
block quoting.

Update the command line snippets to be properly formed literal blocks.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/filesystems/proc.rst | 38 +++++++++++++++++-------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
index 53a0230a08e2..6027dc94755f 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2190,25 +2190,27 @@ mountpoints within the same namespace.
=20
 ::
=20
-# grep ^proc /proc/mounts
-proc /proc proc rw,relatime,hidepid=3D2 0 0
+ # grep ^proc /proc/mounts
+ proc /proc proc rw,relatime,hidepid=3D2 0 0
=20
-# strace -e mount mount -o hidepid=3D1 -t proc proc /tmp/proc
-mount("proc", "/tmp/proc", "proc", 0, "hidepid=3D1") =3D 0
-+++ exited with 0 +++
+ # strace -e mount mount -o hidepid=3D1 -t proc proc /tmp/proc
+ mount("proc", "/tmp/proc", "proc", 0, "hidepid=3D1") =3D 0
+ +++ exited with 0 +++
=20
-# grep ^proc /proc/mounts
-proc /proc proc rw,relatime,hidepid=3D2 0 0
-proc /tmp/proc proc rw,relatime,hidepid=3D2 0 0
+ # grep ^proc /proc/mounts
+ proc /proc proc rw,relatime,hidepid=3D2 0 0
+ proc /tmp/proc proc rw,relatime,hidepid=3D2 0 0
=20
 and only after remounting procfs mount options will change at all
 mountpoints.
=20
-# mount -o remount,hidepid=3D1 -t proc proc /tmp/proc
+::
+
+ # mount -o remount,hidepid=3D1 -t proc proc /tmp/proc
=20
-# grep ^proc /proc/mounts
-proc /proc proc rw,relatime,hidepid=3D1 0 0
-proc /tmp/proc proc rw,relatime,hidepid=3D1 0 0
+ # grep ^proc /proc/mounts
+ proc /proc proc rw,relatime,hidepid=3D1 0 0
+ proc /tmp/proc proc rw,relatime,hidepid=3D1 0 0
=20
 This behavior is different from the behavior of other filesystems.
=20
@@ -2217,8 +2219,10 @@ creates a new procfs instance. Mount options affec=
t own procfs instance.
 It means that it became possible to have several procfs instances
 displaying tasks with different filtering options in one pid namespace.
=20
-# mount -o hidepid=3Dinvisible -t proc proc /proc
-# mount -o hidepid=3Dnoaccess -t proc proc /tmp/proc
-# grep ^proc /proc/mounts
-proc /proc proc rw,relatime,hidepid=3Dinvisible 0 0
-proc /tmp/proc proc rw,relatime,hidepid=3Dnoaccess 0 0
+::
+
+ # mount -o hidepid=3Dinvisible -t proc proc /proc
+ # mount -o hidepid=3Dnoaccess -t proc proc /tmp/proc
+ # grep ^proc /proc/mounts
+ proc /proc proc rw,relatime,hidepid=3Dinvisible 0 0
+ proc /tmp/proc proc rw,relatime,hidepid=3Dnoaccess 0 0
--=20
2.27.0

