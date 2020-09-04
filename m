Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C9CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B5220722
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599235107;
	bh=NAsK1sUFDlG4CiX9f4OB6b0xBhrLDeTgLHvblUMrtaM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Tzn0DDiNicCnibahYsggKY/M19aWgyUTTFcvebLhnmsfigazo3y+DJCZTASqm60aC
	 23OgT56pt9o9jdaqShpzygB/NI4+KUyl2/Bf6yVon2SFWt9jWX+RFoCGZA2ZI6FcGS
	 t1UobXmsBxOKsMVsXY915drKdBo21+yi8v1Sqgdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIDP6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgIDP6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:58:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA2CA20722;
        Fri,  4 Sep 2020 15:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599235103;
        bh=NAsK1sUFDlG4CiX9f4OB6b0xBhrLDeTgLHvblUMrtaM=;
        h=From:To:Cc:Subject:Date:From;
        b=CxiLcu+IavsmiFWc1grAlsJkcTXHw4K6ozpt2vBnh6R4XvrgV2X3QEICE/K0AVkcb
         d8WTjniGpJmbt4LqzmnCAg0v6srWri1CrBuTKxpJ4jYbvaV0yqF/8kD/inRqf3WqtK
         B4V36ETOe6xMXSoh8esmgZ2USCWKkz99piSAdOp0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH -rc v1] gcov: Disable gcov build with GCC 10
Date:   Fri,  4 Sep 2020 18:58:08 +0300
Message-Id: <20200904155808.4997-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

GCOV built with GCC 10 doesn't initialize n_function variable.
This produces different kernel panics as was seen by Colin in
Ubuntu [1] and me in FC 32 [2].

As a workaround, let's disable GCOV build for broken GCC 10 version.

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1891288
[2] https://lore.kernel.org/lkml/20200827133932.3338519-1-leon@kernel.org
Cc: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 As was discussed:
 https://lore.kernel.org/lkml/CAHk-=whbijeSdSvx-Xcr0DPMj0BiwhJ+uiNnDSVZcr_h_kg7UA@mail.gmail.com/
---
 kernel/gcov/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 3110c77230c7..bb4b680e8455 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -4,6 +4,7 @@ menu "GCOV-based kernel profiling"
 config GCOV_KERNEL
 	bool "Enable gcov-based kernel profiling"
 	depends on DEBUG_FS
+	depends on !CC_IS_GCC || GCC_VERSION < 100000
 	select CONSTRUCTORS if !UML
 	default n
 	help
--
2.26.2

