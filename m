Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5D4C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A938206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579105598;
	bh=Yn0/+IcC1oDld+uN4L5568VrbQlfpX4cCU2144CvLSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EyjEz8uoGnRvDiDjBh1bPkQIGMIAjBH0gp42FPQ5pInI5rsdMyRKBvHfkeXcG5rjB
	 RhxyaQ7a3ufiIGJ/4Wv5IPA2ILfQeM6xmSfxq2ycKX10G/o++MyM1ooiU/E3ehcgrY
	 6jX6DK7zBDILE0Q51ymIxUhBejd234a052zmrUb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgAOQ0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:26:37 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:58897 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgAOQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:26:36 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 00FGPX3E015075;
        Thu, 16 Jan 2020 01:25:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 00FGPX3E015075
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579105537;
        bh=sNE2F0kSkktCHvfxE2N29UtQt+eVh1lpwgFeM/VhRfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q0ibsP24OCjTzgrN0oWHuS1fJgmOx3EojUf5fQVYvZrATOrt44OXAFqs4/qmjzKyj
         yuvHXZOvux1XywE1cr02JTpizEp6T1kcm6OWS31fCakIX+GIzpu4/OqeoS5OyZ5k5i
         TJ9fD2LYo4flKs6kTPrlty5v/q3vVYXgTe9TYMwhtu1gvOgdpBQj6jPKVQOaE2Dx/0
         D5r1iT5+L9LDURA1ilFTSCCwQxaeKkY6qCvMNjfcYkVJQkDaRBTl5iIZPSpSM33+t7
         LxuW7FOjVdSEBltWYfalCvINq2deuXOTtF5z816qGXEkcp/MXNW4nsY+rVDMRbo4YK
         Z7uT3yiliUDfA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] builddeb: remove redundant make for ARCH=um
Date:   Thu, 16 Jan 2020 01:25:27 +0900
Message-Id: <20200115162529.11089-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115162529.11089-1-masahiroy@kernel.org>
References: <20200115162529.11089-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel build has already been done before builddeb is invoked.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 scripts/package/builddeb | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 7d7e0abe62b6..650572497811 100755
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

