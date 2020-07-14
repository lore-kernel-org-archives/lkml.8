Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38D9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB812076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="y39K79kn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGNJG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNJGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:06:55 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1688C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 02:06:55 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9C3D48011F;
        Tue, 14 Jul 2020 21:06:52 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1594717612;
        bh=qdTFnkDDGIZWT55aHxHg3aqwbX/J1eEgFCeuhft5cjc=;
        h=From:To:Cc:Subject:Date;
        b=y39K79kn+th1xD4doeflX1wJQ9/wgesgBrd3DRu536hZiNM8tbHu7w8UxMsnk1peg
         75SeSSf5Q6xq0p8ea8EtK1p6UzcMYYHW7rgiYwOeYKhU0kDV7ZDCx1woVCD3HEgHr+
         97SI27lReFX//ZcAARHuARfyjTX7CEeGqqSF4q5U+ASlMZXiBrj9zw1wfxgkcLoD4v
         9KMLCnyM/+D2EOyXCU8fSGZGRR/odjbO3PWNHBrhy9xJapglyRt7iqwZ0/BuhYMafY
         GGpf9W78mDxuUcijvhGk7F7TWvZe3EaQwcZEL3157ZyXFaZbOIrr8BAH5PRQkpFkm/
         QC2/i9XhiLvnQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f0d75ab0000>; Tue, 14 Jul 2020 21:06:52 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id AD25613EFA5;
        Tue, 14 Jul 2020 21:06:50 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id EA9A9280641; Tue, 14 Jul 2020 21:06:51 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     adobriyan@gmail.com, corbet@lwn.net, mchehab+huawei@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/2] doc: filesystems: proc: Remove stray '-' preventing table output
Date:   Tue, 14 Jul 2020 21:06:43 +1200
Message-Id: <20200714090644.13011-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When processing proc.rst sphinx complained

  Documentation/filesystems/proc.rst:548: WARNING: Malformed table.
  Text in column margin in table line 29.

This caused the entire table to be dropped. Removing the stray '-'
resolves the error and produces the desired table.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/filesystems/proc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
index 996f3cfe7030..53a0230a08e2 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -545,7 +545,7 @@ encoded manner. The codes are the following:
     hg    huge page advise flag
     nh    no huge page advise flag
     mg    mergable advise flag
-    bt  - arm64 BTI guarded page
+    bt    arm64 BTI guarded page
     =3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Note that there is no guarantee that every flag and associated mnemonic =
will
--=20
2.27.0

