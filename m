Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29220C3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03758208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581902892;
	bh=baeScyGusiRV3berIPUSOlWdyV9yx07QvTcPq58GHt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XHhH9oNmiZq4dss6behIduKfaC3diU8eyAFIC5mudMuO832CGYEIw/ijcYfVMIf7j
	 iuTvaCW3cJmnohqQVIK9cmzqyEGc9iekaR8b0XHgBlJM3Y22jC9wwrR/Du1ZweZPUI
	 vp/9Jnj0vE8qFkhmeP0BU0zOPtOYi39CtsdYffEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgBQB2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 20:28:08 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:24958 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgBQB2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 20:28:07 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 01H1Rgfd021181;
        Mon, 17 Feb 2020 10:27:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 01H1Rgfd021181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581902863;
        bh=b2C0mNSiSflBIpFhx2jp8oS9m4aSg9to0J1QrHz8qhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmCerFE/26omD4hEnBrJOEOvxuBEvN0ndLWDwILhFUo5QBArg/YHmmMH5BUQGZIU+
         uiGLh3G1mdl/7YW4Gfio4U7MsCBqVlwgLsipYW7edFR+BL35di2LLA/pVdI3si/kLh
         Ju2/74G9ZdoVGUEK2U9X2eUeOAW4Kja0/+WgO3D+KoLhJakITC06mrDvkLKY7t9Vv/
         qH0ZaIV7Lt9gwgBySD3HDnJ+x2SN7Bx8pPp6kpypxtwtIBiEPORaFD1EXwqSs20c5C
         ZumERDqn1Wgx2Fn8GELKmYVQkNq6OsVKxh6hb8esdbMd1kfABo3Pl1kc6ySME/vvEX
         DwlPS5mbuRD0g==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 2/2] kbuild: add -Wall to KBUILD_HOSTCXXFLAGS
Date:   Mon, 17 Feb 2020 10:27:41 +0900
Message-Id: <20200217012741.22100-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217012741.22100-1-masahiroy@kernel.org>
References: <20200217012741.22100-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add -Wall to catch more warnings for host programs written in C++.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8f15926b83bb..0ad7c1b14d59 100644
--- a/Makefile
+++ b/Makefile
@@ -399,7 +399,7 @@ HOSTCXX      = g++
 KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
 		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS) \
 		$(HOSTCFLAGS)
-KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
+KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
 KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
 KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
 
-- 
2.17.1

