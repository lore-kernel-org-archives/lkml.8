Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E55C433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC36F22B2C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752592;
	bh=fSt4TwcoOm/uEpQtZN433CVrqFJwCh0iluC37WxKGoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oJDA5JAUglc2uX0hSFCb+v/p3rB1sUM9YGDwIleCys1+O0WuH81go/t3T90JWF5cw
	 BMCbragjCs+H7cMui9QczaC9ahZQX7peDCXCEEsJ99nrlOAd9T+ELwHV0Wdoa1Znqn
	 vgDNUMrXseFDvNqUNixXm21quJUmTMQPkjydjIiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgGNStv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbgGNStq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:49:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02C6E22AAA;
        Tue, 14 Jul 2020 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752586;
        bh=fSt4TwcoOm/uEpQtZN433CVrqFJwCh0iluC37WxKGoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BeshKuYNGTQQ0fP7cDcXXsTIe5fFqub3somyYeN2EYnD1NXMDf7vfELZzVxu5uetk
         eYvr4gkjWziltpGSiYTNC+KfUmEFq7Ue4qicYzvCCya/NHo9OER7dd3iDRhW9brDro
         JJoyk3BHjGdqjVEhIjsQ4ZzmpChqya93cm/KNC0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 033/109] x86/entry: Increase entry_stack size to a full page
Date:   Tue, 14 Jul 2020 20:43:36 +0200
Message-Id: <20200714184107.106217550@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit c7aadc09321d8f9a1d3bd1e6d8a47222ecddf6c5 ]

Marco crashed in bad_iret with a Clang11/KCSAN build due to
overflowing the stack. Now that we run C code on it, expand it to a
full page.

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Reported-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200618144801.819246178@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 54f5d54280f60..a07dfdf7759ec 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -334,7 +334,7 @@ struct x86_hw_tss {
 #define INVALID_IO_BITMAP_OFFSET	0x8000
 
 struct entry_stack {
-	unsigned long		words[64];
+	char	stack[PAGE_SIZE];
 };
 
 struct entry_stack_page {
-- 
2.25.1



