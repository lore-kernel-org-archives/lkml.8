Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CA8C33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B7A214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578898181;
	bh=/UIoclWQpF1hPzC0wn783AoXihHvUweJtKLiMAnNF0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Etd4MBwDWLgBgSQD7atF3PvazJ8heSbbEj5z+ZAEtsYjw9LKJ+ZRGu+9YB7jp4T+P
	 CYVgtk/UV2uG6OWtEIKcpX0IX8nyFq0CgcqSIlO7mQZqzb+7/nEOrcgJkzxBXE9zvG
	 5kogU5UneE/QgKxm7kB2LJSlLifwgsT5TXPizPBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgAMGtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:49:40 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:50761 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgAMGtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:49:40 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 00D6mj50028522;
        Mon, 13 Jan 2020 15:48:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 00D6mj50028522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578898129;
        bh=H7O98kstoP0UqA5tGgs5uc8MGRr0zv+QxBTEbQCMTck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=myU4wCONaxkLVjBNxdq1pD9Udh/niRsklQtDSBsxvGH8JDy9Le/KaqLBCIzoWLXR1
         9S3uR/DQQ6xFdl5w8TnIMlgKM59jZof3f1cSYgMNFFPizjh/pRLpsrxKRjIoQ2X2pd
         G68ZcRvqjY1mxYQepbIcAs2xiSX5HHKGJ3VL4i+ZSr7/LakLE6JZmb2nhCXSqV7pVX
         iMorq81mV6R0bcqZ/vJAqKAohIvH54b9t8/gtTxm5ZLGx/RcLSAy0kibug9aeBXV/0
         bChQn3VWoWPuSaVGhfot7mXNiMq+it4eXznKwSSyefX6XIfBIFkg/ymXmcedfxy9HV
         OO5ecDS9JwfyA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] builddeb: remove redundant make for ARCH=um
Date:   Mon, 13 Jan 2020 15:48:39 +0900
Message-Id: <20200113064841.3946-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113064841.3946-1-masahiroy@kernel.org>
References: <20200113064841.3946-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel build has already been done before builddeb is invoked.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/builddeb | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 7c561ffe1de0..5efb6155ac0a 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -82,10 +82,9 @@ mkdir -m 755 -p "$tmpdir/DEBIAN"
 mkdir -p "$tmpdir/lib" "$tmpdir/boot"
 mkdir -p "$kernel_headers_dir/lib/modules/$version/"
 
-# Build and install the kernel
+# Install the kernel
 if [ "$ARCH" = "um" ] ; then
 	mkdir -p "$tmpdir/usr/lib/uml/modules/$version" "$tmpdir/usr/bin" "$tmpdir/usr/share/doc/$packagename"
-	$MAKE linux
 	cp System.map "$tmpdir/usr/lib/uml/modules/$version/System.map"
 	cp $KCONFIG_CONFIG "$tmpdir/usr/share/doc/$packagename/config"
 	gzip "$tmpdir/usr/share/doc/$packagename/config"
-- 
2.17.1

