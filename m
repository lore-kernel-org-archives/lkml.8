Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D855BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A117206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599667015;
	bh=iY6OqVOcgu1zhpou4oMMQ2MqoLuggzVS9uTeM1VK3V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w6J9x7TeaXMiMKhx5ZSuf4zR/jlhkrWCP2CqYJNt38xafi79KEbwCjsrpfHhPuS0U
	 EVFTyFsQIzuHlGevAB23/WoOBV0hq+D49myCsb8XS9GaBXurq8DFukjWO/sXBGZ3PH
	 sKbvz946QbeBCPbx3V8RsBWIZYo7vP+UcrVhIoVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgIIP4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730547AbgIIPvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:21 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44546221E8;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=iY6OqVOcgu1zhpou4oMMQ2MqoLuggzVS9uTeM1VK3V8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCdjr+F3S/SUxOlc1bDPVGLdKtcVY4Cm21Hs3RkfNxm6TUWoGhAKvXl0HtKTPnuJc
         eWiRXuu0xCS5Iy19k6LbQdtChs1cGtoRFavApk2arVzpZ0B4XOoXVokg9tFi8CZojt
         V4tXBxnhPnoiRs8McKT3J7lXwWd9q1E1nw3icZEU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUWr-8U; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/30] docs: fix location of nommu-mmap.rst file
Date:   Wed,  9 Sep 2020 16:10:39 +0200
Message-Id: <275a0c634408d89a3b3fb51ca93a6c0e8b4f7905.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/nommu-mmap.rst -> admin-guide/mm/ nommu-mmap.rst

Fixes: 800c02f5d030 ("docs: move nommu-mmap.txt to admin-guide and rename to ReST")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 init/Kconfig | 2 +-
 mm/Kconfig   | 2 +-
 mm/nommu.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 91456ac0ef20..c9446911cf41 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1990,7 +1990,7 @@ config MMAP_ALLOW_UNINITIALIZED
 	  userspace.  Since that isn't generally a problem on no-MMU systems,
 	  it is normally safe to say Y here.
 
-	  See Documentation/mm/nommu-mmap.rst for more information.
+	  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
 
 config SYSTEM_DATA_VERIFICATION
 	def_bool n
diff --git a/mm/Kconfig b/mm/Kconfig
index 7d56281ff41e..c7f30f8b282b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -383,7 +383,7 @@ config NOMMU_INITIAL_TRIM_EXCESS
 	  This option specifies the initial value of this option.  The default
 	  of 1 says that all excess pages should be trimmed.
 
-	  See Documentation/mm/nommu-mmap.rst for more information.
+	  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
 
 config TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
diff --git a/mm/nommu.c b/mm/nommu.c
index 75a327149af1..0df7ca321314 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -5,7 +5,7 @@
  *  Replacement code for mm functions to support CPU's that don't
  *  have any form of memory management unit (thus no virtual memory).
  *
- *  See Documentation/mm/nommu-mmap.rst
+ *  See Documentation/admin-guide/mm/nommu-mmap.rst
  *
  *  Copyright (c) 2004-2008 David Howells <dhowells@redhat.com>
  *  Copyright (c) 2000-2003 David McCullough <davidm@snapgear.com>
-- 
2.26.2

