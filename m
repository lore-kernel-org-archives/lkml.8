Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0268EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A8D218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580436;
	bh=GgNbKupob62BqUCj27AYN8DGZuT/nucfLviwTiGLsBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n1L0bPu3TIqM9xuE6b6gzZSCP25+W1kQ1jOXCu2Tgg4ZCcCbyeoz9K0cXSiiYzinm
	 gQAhBcNqtZEjQuZsB6Nyd+YoSxLUty0QYa2mYH0KoTUZgm+7egIKIMhYXdObOde133
	 2hRGeHU1UU036MAZLq6l9TImlKqC8aZn7i+Pf24I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404420AbgFSP1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393466AbgFSPZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:25:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93F7120734;
        Fri, 19 Jun 2020 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580349;
        bh=GgNbKupob62BqUCj27AYN8DGZuT/nucfLviwTiGLsBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7z0Y696SYCKfq8wEMuwozsPfDVO+d+3887WzF/YTpRfmwWtD1lEhwSbxO35FHOWG
         FwCWcrjc7XgwWMpCh2nJS0wxjb2L7TqRZbr8OMj0TXzLXsaBkKrUhVTnrdAqcLCJ/6
         ButQPIrHxXYCwg5aRJgNpIz9OTVpHPmAShzzvJFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 185/376] selftests/bpf: Install generated test progs
Date:   Fri, 19 Jun 2020 16:31:43 +0200
Message-Id: <20200619141719.108539085@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>

[ Upstream commit 309b81f0fdc4209d998bc63f0da52c2e96340d4e ]

Before commit 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
test_maps w/ general rule") selftests/bpf used generic install
target from selftests/lib.mk to install generated bpf test progs
by mentioning them in TEST_GEN_FILES variable.

Take that functionality back.

Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/ general rule")
Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20200513021722.7787-1-yauheni.kaliuta@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 01c95f8278c7..af139d0e2e0c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -264,6 +264,7 @@ TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS)
 TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,	\
 				 $$(filter-out $(SKEL_BLACKLIST),	\
 					       $$(TRUNNER_BPF_SRCS)))
+TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)
 
 # Evaluate rules now with extra TRUNNER_XXX variables above already defined
 $$(eval $$(call DEFINE_TEST_RUNNER_RULES,$1,$2))
-- 
2.25.1



