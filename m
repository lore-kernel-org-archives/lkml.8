Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC45C35DE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E65520732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgBXXcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:32:11 -0500
Received: from ozlabs.org ([203.11.71.1]:48545 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbgBXXbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:31:52 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48RJHV2RF7z9sRJ; Tue, 25 Feb 2020 10:31:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582587110;
        bh=iMhwIn4qZ6J9t/aXW+vFOqz6zFFtCUD/Scd2rEKsk6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0VLEUMqCZTTFakFDK0QSpyidvf//x3QQ8H+dKeS57KHmsX8U24xBpGITYIBPutAC
         /Pc4T5VbukMx8OsMy/+DJC+Jc7QFxZKNuLNnCmpDgA3hz8HS4LZXx1MExfE474IgQ/
         XG6jHlyCucjU+yzfdgzMjt0+xTlOD1utjCC9nuVLxtqB8hRW45Dg4Xj4IWqBaMyywc
         aSQs5vUFCcLD7Z1CC8VUSRY5xe+yMBo2NReQ9yU1qh5Nwtoj7BmEwdxqRyWme7i7OT
         V27rNh0Ij6pD1Pt06Y/vlQUT745n7tywAGDKyjMVACy5AdoIB6QDK2eEtS1eeUeSO5
         BIYCjYUo2uEqA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH 3/8] powerpc: Remove PA SEMI MAINTAINERS entries
Date:   Tue, 25 Feb 2020 10:31:41 +1100
Message-Id: <20200224233146.23734-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200224233146.23734-1-mpe@ellerman.id.au>
References: <20200224233146.23734-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PA SEMI entries have been orphaned for 3 ½ years, so fold them
into the main POWERPC entry. The result of get_maintainer.pl is more
or less unchanged.

Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 435e4efc9a32..5c4f37c41188 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9621,6 +9621,8 @@ F:	drivers/crypto/vmx/
 F:	drivers/i2c/busses/i2c-opal.c
 F:	drivers/net/ethernet/ibm/ibmveth.*
 F:	drivers/net/ethernet/ibm/ibmvnic.*
+F:	drivers/*/*/*pasemi*
+F:	drivers/*/*pasemi*
 F:	drivers/pci/hotplug/pnv_php.c
 F:	drivers/pci/hotplug/rpa*
 F:	drivers/rtc/rtc-opal.c
@@ -9675,13 +9677,6 @@ S:	Orphan
 F:	arch/powerpc/*/*virtex*
 F:	arch/powerpc/*/*/*virtex*
 
-LINUX FOR POWERPC PA SEMI PWRFICIENT
-L:	linuxppc-dev@lists.ozlabs.org
-S:	Orphan
-F:	arch/powerpc/platforms/pasemi/
-F:	drivers/*/*pasemi*
-F:	drivers/*/*/*pasemi*
-
 LINUX KERNEL DUMP TEST MODULE (LKDTM)
 M:	Kees Cook <keescook@chromium.org>
 S:	Maintained
@@ -12541,16 +12536,6 @@ W:	http://wireless.kernel.org/en/users/Drivers/p54
 S:	Maintained
 F:	drivers/net/wireless/intersil/p54/
 
-PA SEMI ETHERNET DRIVER
-L:	netdev@vger.kernel.org
-S:	Orphan
-F:	drivers/net/ethernet/pasemi/*
-
-PA SEMI SMBUS DRIVER
-L:	linux-i2c@vger.kernel.org
-S:	Orphan
-F:	drivers/i2c/busses/i2c-pasemi.c
-
 PACKING
 M:	Vladimir Oltean <olteanv@gmail.com>
 L:	netdev@vger.kernel.org
-- 
2.21.1

