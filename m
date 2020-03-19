Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A557C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036FE20767
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgCSBAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:00:52 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:40440 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSBAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:00:52 -0400
Received: from [2a02:a31c:853f:a300::4] (helo=valinor.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1jEjYC-0000Dl-Ud; Thu, 19 Mar 2020 02:00:46 +0100
Received: from kilobyte by valinor.angband.pl with local (Exim 4.93)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1jEjYC-00070Z-Gi; Thu, 19 Mar 2020 02:00:44 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, linux-kbuild@vger.kernel.org,
        x86@kernel.org, gregkh@linuxfoundation.org,
        Petr Malat <oss@malat.biz>, Kees Cook <keescook@chromium.org>,
        Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Patrick Williams <patrickw3@fb.com>, rmikey@fb.com,
        mingo@kernel.org
Date:   Thu, 19 Mar 2020 02:00:15 +0100
Message-Id: <20200319010015.26880-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200318002303.977158-1-terrelln@fb.com>
References: <20200318002303.977158-1-terrelln@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:a31c:853f:a300::4
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH v2 8/7] .gitignore: add ZSTD-compressed files
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now, that's arch/x86/boot/compressed/vmlinux.bin.zst but probably more
will come, thus let's be consistent with all other compressors.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
Otherwise, "git status" will complain.


 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 72ef86a5570d..edb0191c294f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -43,6 +43,7 @@
 *.tab.[ch]
 *.tar
 *.xz
+*.zst
 Module.symvers
 modules.builtin
 modules.order
-- 
2.26.0.rc2

