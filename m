Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0020C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 03:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F2CF2072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 03:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="G+51MYtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgFKDmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 23:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgFKDmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 23:42:08 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F2BC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 20:42:07 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E14CA8066C;
        Thu, 11 Jun 2020 15:42:00 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1591846920;
        bh=pwafHa80MS48ZYS1w+T8ti3oHQ+XDqAf4v1bbkbcS9Y=;
        h=From:To:Cc:Subject:Date;
        b=G+51MYtWispe9zo+EqobmmCcvJ9ZPm1CPezyWwqE3SuKGa19vni9XeMcKLRyb9t+4
         VpBcq6/X7+vbocXrDPcIUh33jDpNbDL8DkvzTry4w8NYC9M5WnIJVdQaJ+ZbjkTAjy
         0lLEEzwCfzkjzNf02NVCsyklzv3P8fOlhGAXvNGA2EA9ABPLfw09ZjIkmsn5FrWYub
         IE1uXDKAJLq3jqCVn9Lb1FXvU9ZSScRPf4O3+Ph+2Pn9QW2s3FmhOkAwfHFJHbRlJk
         5kX5htHlDBFq5HFPnotezxauGrpkwJ5XMRAGQuA6FnBqUDQzmgoMAc9gK0rIZFPkV7
         pgI48YJrKslIw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ee1a7fe0000>; Thu, 11 Jun 2020 15:41:50 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 95E2B13EDE4;
        Thu, 11 Jun 2020 15:41:49 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id D1D52280083; Thu, 11 Jun 2020 15:41:49 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2] powerpc: Remove inaccessible CMDLINE default
Date:   Thu, 11 Jun 2020 15:41:40 +1200
Message-Id: <20200611034140.9133-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cbe46bd4f510 ("powerpc: remove CONFIG_CMDLINE #ifdef mess")
CONFIG_CMDLINE has always had a value regardless of CONFIG_CMDLINE_BOOL.

For example:

 $ make ARCH=3Dpowerpc defconfig
 $ cat .config
 # CONFIG_CMDLINE_BOOL is not set
 CONFIG_CMDLINE=3D""

When enabling CONFIG_CMDLINE_BOOL this value is kept making the 'default
"..." if CONFIG_CMDLINE_BOOL' ineffective.

 $ ./scripts/config --enable CONFIG_CMDLINE_BOOL
 $ cat .config
 CONFIG_CMDLINE_BOOL=3Dy
 CONFIG_CMDLINE=3D""

Remove CONFIG_CMDLINE_BOOL and the inaccessible default.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
It took me a while to get round to sending a v2, for a refresher v1 can b=
e found here:

http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20190802050232.229=
78-1-chris.packham@alliedtelesis.co.nz/

Changes in v2:
- Rebase on top of Linus's tree
- Fix some typos in commit message
- Add review from Christophe
- Remove CONFIG_CMDLINE_BOOL

 arch/powerpc/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9fa23eb320ff..51abc59c3334 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -859,12 +859,8 @@ config PPC_DENORMALISATION
 	  Add support for handling denormalisation of single precision
 	  values.  Useful for bare metal only.  If unsure say Y here.
=20
-config CMDLINE_BOOL
-	bool "Default bootloader kernel arguments"
-
 config CMDLINE
-	string "Initial kernel command string" if CMDLINE_BOOL
-	default "console=3DttyS0,9600 console=3Dtty0 root=3D/dev/sda2" if CMDLI=
NE_BOOL
+	string "Initial kernel command string"
 	default ""
 	help
 	  On some platforms, there is currently no way for the boot loader to
--=20
2.27.0

