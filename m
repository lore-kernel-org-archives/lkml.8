Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AC9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0440720848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583242610;
	bh=IuMkBnbn8qI7W2W1dpa5J66X6PrVzs4Mk76Hqet1E54=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gDjhXV0Ebzp9CUKknfVCmtTkuskhLGFswrqoq6bZ4yKlwsv5azOW8bIHwKSMI+oZq
	 CFwF+uz0i58DEKarkngHRfCeu0qHDVqV6iCrz6lshNLFj9VjkWuS3lgaCmq0OidwrZ
	 7/Yg4yuf0VQy+RFz0TsOHS1sKrmzh84pkoKL+zrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgCCNgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:36:48 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:25963 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgCCNgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:36:48 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 023Da7N6031722;
        Tue, 3 Mar 2020 22:36:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 023Da7N6031722
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583242567;
        bh=8FGBy+riSt4rwct2pwA55KsvMYYZXWMXoGZn5qEOkjE=;
        h=From:To:Cc:Subject:Date:From;
        b=grxSx57ZX+gurmyI7mvzc52XjJyAxcPdujUCO7skfH02HvR2S5TGpOJuRPrRLYS9K
         4peS2kE6aZME2d9MvI5tlttoNLf5iOkQ+GbR2t7xFCOkoMAuvpH/zBvgNJuBElToHC
         R3lkjaCHDtrQ9UzercMLGEC/hJiV9C6uCNNTga5Z6UaSYlWn4Ze1+kYx+0QRtkQLd/
         2iGBEZfwYR3D6mqtEbWH5WimGV8ucr1pegmBBQQNxLABqy6C5xLhmPu+qHAsEAY4Es
         d/Jqmk2/hIjoLCwzIy7KalG53TnxyboDykbdOpRxmJJ2eom53kHuFnh26vDgp7CSR0
         RbiYxn3e3ot8A==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] .gitignore: remove too obvious comments
Date:   Tue,  3 Mar 2020 22:35:58 +0900
Message-Id: <20200303133600.9263-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some .gitignore files have comments like "Generated files",
"Ignore generated files" at the header part, but they are
too obvious.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 certs/.gitignore               | 3 ---
 drivers/atm/.gitignore         | 1 -
 drivers/video/logo/.gitignore  | 3 ---
 kernel/.gitignore              | 3 ---
 lib/.gitignore                 | 3 ---
 scripts/.gitignore             | 3 ---
 scripts/kconfig/.gitignore     | 3 ---
 scripts/selinux/mdp/.gitignore | 1 -
 security/apparmor/.gitignore   | 3 ---
 sound/oss/.gitignore           | 1 -
 10 files changed, 24 deletions(-)

diff --git a/certs/.gitignore b/certs/.gitignore
index f51aea4a71ec..4d58ba042b37 100644
--- a/certs/.gitignore
+++ b/certs/.gitignore
@@ -1,4 +1 @@
-#
-# Generated files
-#
 x509_certificate_list
diff --git a/drivers/atm/.gitignore b/drivers/atm/.gitignore
index fc0ae5eb05d8..19f3ffbd1d65 100644
--- a/drivers/atm/.gitignore
+++ b/drivers/atm/.gitignore
@@ -1,4 +1,3 @@
-# Ignore generated files
 fore200e_mkfirm
 fore200e_pca_fw.c
 pca200e.bin
diff --git a/drivers/video/logo/.gitignore b/drivers/video/logo/.gitignore
index 9dda1b26b2e4..1551a75afdbd 100644
--- a/drivers/video/logo/.gitignore
+++ b/drivers/video/logo/.gitignore
@@ -1,6 +1,3 @@
-#
-# Generated files
-#
 *_mono.c
 *_vga16.c
 *_clut224.c
diff --git a/kernel/.gitignore b/kernel/.gitignore
index 34d1e77ee9df..0a423a3ca2e1 100644
--- a/kernel/.gitignore
+++ b/kernel/.gitignore
@@ -1,6 +1,3 @@
-#
-# Generated files
-#
 kheaders.md5
 timeconst.h
 hz.bc
diff --git a/lib/.gitignore b/lib/.gitignore
index f2a39c9e5485..9af73655a239 100644
--- a/lib/.gitignore
+++ b/lib/.gitignore
@@ -1,6 +1,3 @@
-#
-# Generated files
-#
 gen_crc32table
 gen_crc64table
 crc32table.h
diff --git a/scripts/.gitignore b/scripts/.gitignore
index ef45f96cd7a5..9fe29efbcb95 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -1,6 +1,3 @@
-#
-# Generated files
-#
 bin2c
 kallsyms
 unifdef
diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index b5bf92f66d11..588988711e07 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -1,6 +1,3 @@
-#
-# Generated files
-#
 *.moc
 *conf-cfg
 
diff --git a/scripts/selinux/mdp/.gitignore b/scripts/selinux/mdp/.gitignore
index 654546d8dffd..0d9f827dc14b 100644
--- a/scripts/selinux/mdp/.gitignore
+++ b/scripts/selinux/mdp/.gitignore
@@ -1,2 +1 @@
-# Generated file
 mdp
diff --git a/security/apparmor/.gitignore b/security/apparmor/.gitignore
index d5b291e94264..0ace1d1dec44 100644
--- a/security/apparmor/.gitignore
+++ b/security/apparmor/.gitignore
@@ -1,6 +1,3 @@
-#
-# Generated include files
-#
 net_names.h
 capability_names.h
 rlim_names.h
diff --git a/sound/oss/.gitignore b/sound/oss/.gitignore
index 12a3920d6fb6..8fd8fd3eff62 100644
--- a/sound/oss/.gitignore
+++ b/sound/oss/.gitignore
@@ -1,3 +1,2 @@
-#Ignore generated files
 pss_boot.h
 trix_boot.h
-- 
2.17.1

