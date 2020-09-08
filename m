Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBC1C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 907C4206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599587981;
	bh=6XiXYf1OQACfz6Pl7MUVTDtIWF63t2t/6FVZNrXz7CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=02U+RZo851U81ItDH98/6dJnanjFV/rTmskHsd/zQRdukSp/fhfr0GCU/lnqpvTZV
	 CymBYIQtmJIdk+RTwteAqwJLcf/d2qwoT1Tlz6n+gRfJUjk5Yd3xWWu1VMeVK6MCzq
	 ouPAdqSEP8s9fRctQhQPPGqjPEA0ImV7GcuO9pMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgIHR7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731570AbgIHQMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:12:47 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF0C2489B;
        Tue,  8 Sep 2020 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580343;
        bh=6XiXYf1OQACfz6Pl7MUVTDtIWF63t2t/6FVZNrXz7CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDyLVmHBEUxFT9M8PdPiJACkxe161QJERkPFWwXWrRlNcc4eltXI4YfCc2SQ8ERvN
         6hEZfO4vSnIGOoM/POZBNwYH1NlNrkgJxZ+pkbp7MH+3tYU+uR/V/ztv/m9O5/fnjQ
         u/uZKJbrc+iiYGb8rrVOKLLjxQGhbYhMSEbAEnRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 37/65] include/linux/log2.h: add missing () around n in roundup_pow_of_two()
Date:   Tue,  8 Sep 2020 17:26:22 +0200
Message-Id: <20200908152218.947153234@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152217.022816723@linuxfoundation.org>
References: <20200908152217.022816723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit 428fc0aff4e59399ec719ffcc1f7a5d29a4ee476 ]

Otherwise gcc generates warnings if the expression is complicated.

Fixes: 312a0c170945 ("[PATCH] LOG2: Alter roundup_pow_of_two() so that it can use a ilog2() on a constant")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Link: https://lkml.kernel.org/r/0-v1-8a2697e3c003+41165-log_brackets_jgg@nvidia.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/log2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index c373295f359fa..cca606609e1bc 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -159,7 +159,7 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 #define roundup_pow_of_two(n)			\
 (						\
 	__builtin_constant_p(n) ? (		\
-		(n == 1) ? 1 :			\
+		((n) == 1) ? 1 :		\
 		(1UL << (ilog2((n) - 1) + 1))	\
 				   ) :		\
 	__roundup_pow_of_two(n)			\
-- 
2.25.1



