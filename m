Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1E4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F268120738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457846;
	bh=2Rf00zb0NiJrc2Hsb0wQlosMgVlGXbTqxrdugp9D0xA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WZ+iYxQMINH8KIXm+nOaUN94u8+eG/WPP563G38Y0TZ4JGjuwSxkGrLM6n5n5MVVj
	 UUGeql1JTyClrPNOTbOCGFsfj7sonFn57Jjn6brnaj+MvpWNGx0eRB4tKkE+fpnzFy
	 LckaEBmHatQaD+xXZYJztF/kqUo5LcRVQpUaHRy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgHCMao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbgHCMam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:30:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 406DA22B42;
        Mon,  3 Aug 2020 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457840;
        bh=2Rf00zb0NiJrc2Hsb0wQlosMgVlGXbTqxrdugp9D0xA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WkkEsja//BnYKYrNqWnlCbUly4RqEzQugyx5RgTYsQZ1oev5vZlXX4/GdFMRPEsd7
         dJonG7iheAzxQe+h4na/TvQ9Hz/xBde6RIKwW89sAAGhl6R3Ktrg1st2T6n1tCGNdf
         uwcWnSapVzusBtBeeNK/xXlGQFmEsDODKobo2ZGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 62/90] arm64/alternatives: move length validation inside the subsection
Date:   Mon,  3 Aug 2020 14:19:24 +0200
Message-Id: <20200803121900.616234497@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit 966a0acce2fca776391823381dba95c40e03c339 ]

Commit f7b93d42945c ("arm64/alternatives: use subsections for replacement
sequences") breaks LLVM's integrated assembler, because due to its
one-pass design, it cannot compute instruction sequence lengths before the
layout for the subsection has been finalized. This change fixes the build
by moving the .org directives inside the subsection, so they are processed
after the subsection layout is known.

Fixes: f7b93d42945c ("arm64/alternatives: use subsections for replacement sequences")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1078
Link: https://lore.kernel.org/r/20200730153701.3892953-1-samitolvanen@google.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/alternative.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 12f0eb56a1cc3..619db9b4c9d5c 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -77,9 +77,9 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	"663:\n\t"							\
 	newinstr "\n"							\
 	"664:\n\t"							\
-	".previous\n\t"							\
 	".org	. - (664b-663b) + (662b-661b)\n\t"			\
-	".org	. - (662b-661b) + (664b-663b)\n"			\
+	".org	. - (662b-661b) + (664b-663b)\n\t"			\
+	".previous\n"							\
 	".endif\n"
 
 #define __ALTERNATIVE_CFG_CB(oldinstr, feature, cfg_enabled, cb)	\
-- 
2.25.1



