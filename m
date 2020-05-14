Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46495C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1935D20675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482404;
	bh=ED73cyVGG3lGrKMi4I5pTPwgx72l7uyHVJq0WjKJR4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BzwwftBc9rdIBa9y8ayKH+ckOEv62RnFOVrs56wMRYQ+Lm6k7p25hOMCQFVm7yTEq
	 jB/WWHKH9diWCrJ21hBRaf4wDOveaW5ArX/IRVYHFYKGCMoK23ct/8aqqziTDbtf15
	 haOPp0V7p7KTWh3cF6zDtoLJL2k8jBtqH65byohs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgENSxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgENSxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:53:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69F2220727;
        Thu, 14 May 2020 18:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482396;
        bh=ED73cyVGG3lGrKMi4I5pTPwgx72l7uyHVJq0WjKJR4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5skA6RgPxo9AEU7BpoiO7/1q1ZH5WU0TeYgTfGFGvCVAbPTq4wAHiHnyMhYzHJ3D
         cUvRhKOToQPhx8cCS3CB6apjt2hzRq3g11R6leDVS6r7jtrbIN5gFK1uLgzfQJz6SY
         3af20cbAquB6el4ussjfq8poyav/ltpTQayPe3MQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 03/49] Makefile: disallow data races on gcc-10 as well
Date:   Thu, 14 May 2020 14:52:24 -0400
Message-Id: <20200514185311.20294-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185311.20294-1-sashal@kernel.org>
References: <20200514185311.20294-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Trofimovich <slyfox@gentoo.org>

[ Upstream commit b1112139a103b4b1101d0d2d72931f2d33d8c978 ]

gcc-10 will rename --param=allow-store-data-races=0
to -fno-allow-store-data-races.

The flag change happened at https://gcc.gnu.org/PR92046.

Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 54dd58bc60712..388b7b49a52d0 100644
--- a/Makefile
+++ b/Makefile
@@ -713,6 +713,7 @@ endif
 
 # Tell gcc to never replace conditional load with a non-conditional one
 KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
+KBUILD_CFLAGS	+= $(call cc-option,-fno-allow-store-data-races)
 
 include scripts/Makefile.kcov
 include scripts/Makefile.gcc-plugins
-- 
2.20.1

