Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F595C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE3120656
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MQ63zU/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgG3GKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3GKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:10:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88171C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 23:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zwlQ9SaLTyUJF8fFTJ8gj1WKATelHcdnFE1SV3l7R/A=; b=MQ63zU/UqD1+VwWNT56FfY2zxk
        Kx3bVtBwyoh0ex6VAEfw8rkAQ71jPMSLtQ8O6Z+JvR0r6LS5P9aLLf9Ej3QL0k+x02i0tXQWLakyu
        hiyTkCCNn9RhOIhz7gFZjA1JOqjx0YLbbKPOFwfxeUvOGI32tWF5MTjpyw6oEM61hTxrfp/4yreek
        c1RS+eLAXU9qHiEpqkF9O8f6w0X8wITEeKS+nym/FJJ+aNQVUeMQfQq4N2eWkhwzlKp+UrycawuFr
        CbYBnqpVCqjgDDUlss/B8T01kqtrTP0MH2wFvamskLG5gd5d6duRrgoS1c9scfPVEEZktXomvM0ZP
        1F+gOmJQ==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k11m1-0007Ud-H2; Thu, 30 Jul 2020 06:10:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/8] modules: unexport __module_text_address
Date:   Thu, 30 Jul 2020 08:10:23 +0200
Message-Id: <20200730061027.29472-5-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730061027.29472-1-hch@lst.de>
References: <20200730061027.29472-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__module_text_address is only used by built-in code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/module.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index feeaa9629eb179..d241866f9d4a2b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4508,7 +4508,6 @@ struct module *__module_text_address(unsigned long addr)
 	}
 	return mod;
 }
-EXPORT_SYMBOL_GPL(__module_text_address);
 
 /* Don't grab lock, we're oopsing. */
 void print_modules(void)
-- 
2.27.0

