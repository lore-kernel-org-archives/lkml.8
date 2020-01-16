Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533E6C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7562073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217245;
	bh=Xbd4Pi587JJL8ECsMUBMkasjez4+TzwBv56c6oecqBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nzRGaPgHdo7sI45kXtNzjImp5N01UsnNxpa0FCqqU3wy79flXDeRgM9fgtPRr/EnQ
	 H6G+GjXll48i6GU9JONxiJOHhIJ8hgquv2e15URxsLdkVuSmIhvyJg6xFlcjXsPXZT
	 XP8WHbqGzSzAleRyNViMk7BlnPLVvJDY7Iob7+wE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390097AbgAPX1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:27:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389852AbgAPX1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:27:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 452C520684;
        Thu, 16 Jan 2020 23:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217226;
        bh=Xbd4Pi587JJL8ECsMUBMkasjez4+TzwBv56c6oecqBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DAUH/xj0wn65nHoB9xTIG4O8fOkUKeU8lr7vjqw33Cbd1Prc8dGNfr6PFL/ptkUwJ
         SE6V+2CFzixnORRL1GF+3c/4tHJ8NqvIHxEhl57KRXelXxxpgXiTZFbo10bdz63vsh
         xXBXyICZO2LLn9FUznTFxkUHNrfv513rdIYIlJAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 200/203] kbuild/deb-pkg: annotate libelf-dev dependency as :native
Date:   Fri, 17 Jan 2020 00:18:37 +0100
Message-Id: <20200116231801.576178782@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit 8ffdc54b6f4cd718a45802e645bb853e3a46a078 ]

Cross compiling the x86 kernel on a non-x86 build machine produces
the following error when CONFIG_UNWINDER_ORC is enabled, regardless
of whether libelf-dev is installed or not.

  dpkg-checkbuilddeps: error: Unmet build dependencies: libelf-dev
  dpkg-buildpackage: warning: build dependencies/conflicts unsatisfied; aborting
  dpkg-buildpackage: warning: (Use -d flag to override.)

Since this is a build time dependency for a build tool, we need to
depend on the native version of libelf-dev so add the appropriate
annotation.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/package/mkdebian | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 7c230016b08d..357dc56bcf30 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -136,7 +136,7 @@ mkdir -p debian/source/
 echo "1.0" > debian/source/format
 
 echo $debarch > debian/arch
-extra_build_depends=", $(if_enabled_echo CONFIG_UNWINDER_ORC libelf-dev)"
+extra_build_depends=", $(if_enabled_echo CONFIG_UNWINDER_ORC libelf-dev:native)"
 extra_build_depends="$extra_build_depends, $(if_enabled_echo CONFIG_SYSTEM_TRUSTED_KEYRING libssl-dev:native)"
 
 # Generate a simple changelog template
-- 
2.20.1



