Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB69C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D116C2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262157;
	bh=ywTZQoPHFm5xNDERvgrcnsMxT2rIgAxrrrPjsaiuDCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DEutPiQI6mhDEoZTUCSq70UCDQW5ZJ8LSq6MpN6emsWv3o/wTVgNscyrvhLbOFeOP
	 SoJzgX6Zo4+msTFUUQGK8m9Flqy5HjFgaAm3osIfNgbBEf0O9C1CQ6aMmAlXsEwgaW
	 qQkR0Hbiz7c13y5hiRmJXEsWqYLL6/EfV+Y/gmHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgHXIo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728923AbgHXIor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:44:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BEBA2074D;
        Mon, 24 Aug 2020 08:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258686;
        bh=ywTZQoPHFm5xNDERvgrcnsMxT2rIgAxrrrPjsaiuDCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZwTVWrSf3lw1X6nLNglZKT4AOBOCOxj9yEcBav+z/whIYDtCCEfRA60fZfaV7/n27
         h9OpKuOagY1GuSgWOsfsznlna9HD5Hw3r+xQoPnt3b39Mj19/P+BJQsyf6F4WYCLic
         PRImefFz8dD+vaa5g/DmUPTmAoqEgAjrZY26yaFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 5.4 002/107] Documentation/llvm: fix the name of llvm-size
Date:   Mon, 24 Aug 2020 10:29:28 +0200
Message-Id: <20200824082405.149935933@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fangrui Song <maskray@google.com>

commit 0f44fbc162b737ff6251ae248184390ae2279fee upstream.

The tool is called llvm-size, not llvm-objsize.

Fixes: fcf1b6a35c16 ("Documentation/llvm: add documentation on building w/ Clang/LLVM")
Signed-off-by: Fangrui Song <maskray@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/kbuild/llvm.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -51,7 +51,7 @@ LLVM has substitutes for GNU binutils ut
 additional parameters to `make`.
 
 	make CC=clang AS=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \\
-	  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-objsize \\
+	  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-size \\
 	  READELF=llvm-readelf HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar \\
 	  HOSTLD=ld.lld
 


