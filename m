Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B51C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B14EC206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Rf3ISlu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgFKWmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgFKWmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:42:39 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431ECC03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:42:39 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B4F51806AC;
        Fri, 12 Jun 2020 10:42:35 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1591915355;
        bh=cjerFYIms+8RgF43QiEKih5ca/ZDSYD1GIAP9cMnINI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Rf3ISlu9P6rX1ExytAr+ICN/jd7HxpkZHy5L9WRn5f+ywX3B7APxStunwHPMTbQ3m
         J8AyMupMmTffi+Yjwe7PGauJzkMazqN7okKc4CqRI/WGgnsld1KcP5JojSPX8mTx07
         /42Ym2tIJzxIH3xy8MspVCWvWcDnxvqFSK8LxfhbUmoByfYD5L0FYly8XrHTq75QiQ
         UYDtPby8L++6jpf4qyKwBK9IJY5mt5rMc8gZ4ZZtLLvhD99PlZAmluutDoiiPb86Ck
         tw10Q4J5MpTWclcReDVU+Kap3yp7rSXdxM43ZkP0NZHoT/fchck6/49Lr8CXWtiV8d
         L5wgzIb3CBjoQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ee2b35c0000>; Fri, 12 Jun 2020 10:42:36 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id CEA7813ED45;
        Fri, 12 Jun 2020 10:42:34 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 704FD280083; Fri, 12 Jun 2020 10:42:35 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 1/2] powerpc: Remove inaccessible CMDLINE default
Date:   Fri, 12 Jun 2020 10:42:19 +1200
Message-Id: <20200611224220.25066-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200611224220.25066-1-chris.packham@alliedtelesis.co.nz>
References: <20200611224220.25066-1-chris.packham@alliedtelesis.co.nz>
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

Changes in v3:
- none

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

