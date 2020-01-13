Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E166C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21551214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578898186;
	bh=sBkJQpHg73khztR6uTTT4C3eIu1cIMwtWT9hcMdZUd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VenrLIj1EgxZMCN4lyG89/Uo6L5qzJ/VcCpw32bjrA+Cj+9nB/1JOP2ixwyFodbdr
	 r5VLk2V8G5cSoDrRfET9UJPnsPbePazphN6Br7KWMij7NwmGrwnTfAhnrmMluvGrrw
	 +jgSDQ9Y4Uj5dJ6+3Af88iOjpD0uWUccOLJyoGHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgAMGtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:49:45 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:50772 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgAMGtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:49:41 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 00D6mj4v028522;
        Mon, 13 Jan 2020 15:48:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 00D6mj4v028522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578898127;
        bh=chiuS9+WebBejR+cotF9BxmICGPbZmTDz5VP5WMGOxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iq+vTDEYkzJ/OjIWKEWkbTaSBiwcuPGm+nBuZOUCmdJCiu0khxk3qy4rGCaikQSI2
         hqqTddu8XNLKsicm0j5QR7/zFUOBfuEqjxO4d8AMR38z8gjriHUIE85hf54dSOicuf
         cdRxpwuaWAGt7nbAkb1dMy5U5fKZ3NY/1vIhyVVDbisWImWQGNOH8rjzi4sEa5Hjl1
         vj2GNald9MniXcxjB0ycopsjx0jd/WjBtYkKp+IyLS/MPByvPpcG9J1z6IPgLIR+py
         MtANIg9dUe116HSp9fuwHGAyOWxDRsR0ctXjZP784BdeFqoIAidU+lakN0wiigQ6FP
         Y0yQyaLr7oWsA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] builddeb: match temporary directory name to the package name
Date:   Mon, 13 Jan 2020 15:48:36 +0900
Message-Id: <20200113064841.3946-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113064841.3946-1-masahiroy@kernel.org>
References: <20200113064841.3946-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The temporary directory names, debian/hdrtmp (linux-headers package)
and debian/headertmp (linux-libc-dev package) are confusing.

Matching the directory name to the package name is clearer, IMHO.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/builddeb | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index eb067d6f1370..0a0a7c1447f4 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -47,10 +47,10 @@ create_package() {
 }
 
 version=$KERNELRELEASE
-tmpdir="$objtree/debian/tmp"
-kernel_headers_dir="$objtree/debian/hdrtmp"
-libc_headers_dir="$objtree/debian/headertmp"
-dbg_dir="$objtree/debian/dbgtmp"
+tmpdir="$objtree/debian/linux-image"
+kernel_headers_dir="$objtree/debian/linux-headers"
+libc_headers_dir="$objtree/debian/linux-libc-dev"
+dbg_dir="$objtree/debian/linux-image-dbg"
 packagename=linux-image-$version
 kernel_headers_packagename=linux-headers-$version
 libc_headers_packagename=linux-libc-dev
-- 
2.17.1

