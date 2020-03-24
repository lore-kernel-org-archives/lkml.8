Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11753C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCC1208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056453;
	bh=TJSgWLjZqZ062BhG1QYysmN7zPRFVUmoSPFqx57+PJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q26aMFD8LbHlktZXNDKuxkQnd0eD+BC0DLbExELPrAKVRDK7oTXGXViEECH5VseHf
	 IIwQQsLqbO61hI8Oey+Hsuxje3w3R9V/PjxIkWdLAI3EIu7EvETMChoMrs0AbXXztU
	 zYrlKwEXMclc4zBFQmryuBMDsqKBGuDjTIQC+IU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgCXN11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgCXN1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:27:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06294208D6;
        Tue, 24 Mar 2020 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056445;
        bh=TJSgWLjZqZ062BhG1QYysmN7zPRFVUmoSPFqx57+PJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xcBmoupzQioQVudl0w/xeAgwFjLEWmh8lzc2FKvy8moAwCWBaBZQRvuGr5KzINnSW
         5Th/cVIQi5dQZMb7qP5XPZLVzeh8qZwYPIcWpKbI957je2DjgSMGpzPM5KYPXuRM2R
         pgrPBkV5Eg8x7fS3qWLAbcGwTyQ7JmA/UQ9YJMfg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, George Spelvin <lkml@sdf.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 5.5 119/119] int128: fix __uint128_t compiler test in Kconfig
Date:   Tue, 24 Mar 2020 14:11:44 +0100
Message-Id: <20200324130819.391456542@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

commit 3a7c733165a4799fa1beb262fe244bfbcdd1c163 upstream.

The support for __uint128_t is dependent on the target bit size.

GCC that defaults to the 32-bit can still build the 64-bit kernel
with -m64 flag passed.

However, $(cc-option,-D__SIZEOF_INT128__=0) is evaluated against the
default machine bit, which may not match to the kernel it is building.

Theoretically, this could be evaluated separately for 64BIT/32BIT.

  config CC_HAS_INT128
          bool
          default !$(cc-option,$(m64-flag) -D__SIZEOF_INT128__=0) if 64BIT
          default !$(cc-option,$(m32-flag) -D__SIZEOF_INT128__=0)

I simplified it more because the 32-bit compiler is unlikely to support
__uint128_t.

Fixes: c12d3362a74b ("int128: move __uint128_t compiler test to Kconfig")
Reported-by: George Spelvin <lkml@sdf.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Tested-by: George Spelvin <lkml@sdf.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 init/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -767,8 +767,7 @@ config ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	bool
 
 config CC_HAS_INT128
-	def_bool y
-	depends on !$(cc-option,-D__SIZEOF_INT128__=0)
+	def_bool !$(cc-option,$(m64-flag) -D__SIZEOF_INT128__=0) && 64BIT
 
 #
 # For architectures that know their GCC __int128 support is sound


