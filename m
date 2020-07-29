Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3506C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FEC22076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BK9PBdDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgG2G1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgG2G1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:27:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3041C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 23:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9+S6v9RZBs6CIZboH5IsDpxdhW0gmtmen/1pdOwyxUE=; b=BK9PBdDIA3v360u6pRg1Kl43Tv
        +Lc+rFkNFBhap4fCOn9gf/4199Khtot3SAbsuTsZmzhqztz3mxJRR74C1P9uLMpHhzm07TmAOMr1t
        m23ELiO8U37CRDAKLoQGt8lyLLyquBRFIXqpxzE2cgoIbmEYbLcA+FdmS37k5ZTRdJj6LOqEqK/+F
        7AlrUqnaTHFo7BrB1rQds/m7JBZOvBr4GCWT3GZe+i5dMku0ODziuNcStl+RKxHYraFFgwQ+hN3pZ
        QejpUCYRGMvMhUm4zxM5uOJq728tCKGTavkG1mt3+llLX3cp/G//uMoF0ZupYU0BcWz8EbZ8YKVXg
        RguO117Q==;
Received: from 089144218008.atnat0027.highway.a1.net ([89.144.218.8] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0fYe-00041W-1q; Wed, 29 Jul 2020 06:27:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/7] modules: unexport __module_address
Date:   Wed, 29 Jul 2020 08:27:09 +0200
Message-Id: <20200729062711.13016-6-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729062711.13016-1-hch@lst.de>
References: <20200729062711.13016-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__module_address is only used by built-in code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/module.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index d241866f9d4a2b..54e853c7212f72 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4469,7 +4469,6 @@ struct module *__module_address(unsigned long addr)
 	}
 	return mod;
 }
-EXPORT_SYMBOL_GPL(__module_address);
 
 /*
  * is_module_text_address - is this address inside module code?
-- 
2.27.0

