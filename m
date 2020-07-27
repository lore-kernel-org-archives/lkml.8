Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83075C433FC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C6B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860193;
	bh=xpn+nNpgUhBKarM+fQiQTBmJ1lrn02PNKrtmx3CVs5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sy4UUOGnU9fQGiO2WXOzHJzZ2n2GDL24PtVa1Zy9Jdpr46TGqCm4OXieRxpP0JHXJ
	 c12oeqtaLNpPsPm4drfK3wAKl6vrrSG6+C4PlYmq9wtVU08ufMtZPhk0ggl5w6kjgB
	 Ta2EzeExWtjvpFBy1ufW/BP1/4qnlfUaYXGHPMnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbgG0O3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:29:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731969AbgG0OWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:22:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 438FC20FC3;
        Mon, 27 Jul 2020 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859770;
        bh=xpn+nNpgUhBKarM+fQiQTBmJ1lrn02PNKrtmx3CVs5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lQBFJOiWtX4mo/8bUZOTiA/WaFyvJdlaQL43DFHbYrasRxZlpYzGp8uDMdrA73rOV
         5KkuXGM34QV/C1wQ6HKMTiRrU8rEDBFIWNIyG05cJ4xEo3Y/hE/O99yqVw3zCPVaR0
         5fZ4KkTS0G9IKkO8J7b7LIDsuXtqEPP2/dWSeskI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 099/179] kbuild: fix single target builds for external modules
Date:   Mon, 27 Jul 2020 16:04:34 +0200
Message-Id: <20200727134937.476337129@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 20b1be59528295e5c2a8812059b8560753dd8e68 ]

Commit f566e1fbadb6 ("kbuild: make multiple directory targets work")
broke single target builds for external modules. Fix this.

Fixes: f566e1fbadb6 ("kbuild: make multiple directory targets work")
Reported-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Tested-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e622e084e7e26..74056e09f0a30 100644
--- a/Makefile
+++ b/Makefile
@@ -1730,7 +1730,7 @@ PHONY += descend $(build-dirs)
 descend: $(build-dirs)
 $(build-dirs): prepare
 	$(Q)$(MAKE) $(build)=$@ \
-	single-build=$(if $(filter-out $@/, $(filter $@/%, $(single-no-ko))),1) \
+	single-build=$(if $(filter-out $@/, $(filter $@/%, $(KBUILD_SINGLE_TARGETS))),1) \
 	need-builtin=1 need-modorder=1
 
 clean-dirs := $(addprefix _clean_, $(clean-dirs))
-- 
2.25.1



