Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A757C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450752100A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584280;
	bh=yQxQpjtkHjofVTksYCvmMXdlPiITVMnCbSS367MJYxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OdSYmPVmB1SnP5T9kzGFjBwsEQn7jHl3dwlbghCY2+lrw40EnDLCCcojw7t28Nq8L
	 XRhuVzYTfrcTJ92Kne5ymThc5RsjQtRM2ZiBCtJb/8+o7lF2iL4SBa9hImbQq49hqL
	 pwSxJn2HAbFCsO2vUYjqyYM4Ps7oq43azoptdBTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbgFSOw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388738AbgFSOwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:52:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 394D821556;
        Fri, 19 Jun 2020 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578358;
        bh=yQxQpjtkHjofVTksYCvmMXdlPiITVMnCbSS367MJYxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAzaOs842SGnqUrQClSyy5TdTcTsaxFk0xnipd8M+b2iivnVnNWYRVbU4cwodBff8
         sYRFkTBnx6JCUr5+EwHMEMRT3DMMNNMEoZ8dArqFuRqUFDwufyaR+FWy6s0TFwhFl3
         JPNEjVF9G5zwm+BOXpG/B+1o2GGqS1c9M1zezMGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4.14 182/190] kbuild: force to build vmlinux if CONFIG_MODVERSION=y
Date:   Fri, 19 Jun 2020 16:33:47 +0200
Message-Id: <20200619141642.949498508@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

commit 4b50c8c4eaf06a825d1c005c0b1b4a8307087b83 upstream.

This code does not work as stated in the comment.

$(CONFIG_MODVERSIONS) is always empty because it is expanded before
include/config/auto.conf is included. Hence, 'make modules' with
CONFIG_MODVERSION=y cannot record the version CRCs.

This has been broken since 2003, commit ("kbuild: Enable modules to be
build using the "make dir/" syntax"). [1]

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=15c6240cdc44bbeef3c4797ec860f9765ef4f1a7
Cc: linux-stable <stable@vger.kernel.org> # v2.5.71+
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -542,12 +542,8 @@ KBUILD_MODULES :=
 KBUILD_BUILTIN := 1
 
 # If we have only "make modules", don't compile built-in objects.
-# When we're building modules with modversions, we need to consider
-# the built-in objects during the descend as well, in order to
-# make sure the checksums are up to date before we record them.
-
 ifeq ($(MAKECMDGOALS),modules)
-  KBUILD_BUILTIN := $(if $(CONFIG_MODVERSIONS),1)
+  KBUILD_BUILTIN :=
 endif
 
 # If we have "make <whatever> modules", compile modules
@@ -1249,6 +1245,13 @@ ifdef CONFIG_MODULES
 
 all: modules
 
+# When we're building modules with modversions, we need to consider
+# the built-in objects during the descend as well, in order to
+# make sure the checksums are up to date before we record them.
+ifdef CONFIG_MODVERSIONS
+  KBUILD_BUILTIN := 1
+endif
+
 # Build modules
 #
 # A module can be listed more than once in obj-m resulting in


