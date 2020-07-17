Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DC5C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4374520759
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mk+1aVml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgGQXg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGQXgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:36:55 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE76C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xoMatlgLD3Z1wEYqrUZq/DerA7K/9lWT0DD9Rym4RfM=; b=mk+1aVml8cHNj+TIzfgTQl3IUq
        4Hcxjbmk6hXY+Yha3sQ61U+0o4UzGAcyDcaPo0l2zoTijkJObH1ENBmDGAXcN2RZ/ZZ7p9qQZnXiP
        JYYmp+4wSDNpnkzydnCQDUkYbnrh/0ZKBgevnStiJX4LJi1xCfhpqJP1Y8DV1xTmcY1TN9KiCBZyl
        o55kJEDKFAhFKExLGGx12N6UNxkYJe9ymWUTd5GTAIYa9Pos4ZHFinoTK5u9wQZTlB7ZiDAEd+Ofp
        lD2HLNC+E3Fw6o41NFfajGNyfnhRaI83CipNGioINAq5VXCmhxzyIjn/vIeZF/wkaEUSgFRgUdWyM
        92C1X7gA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwZuP-0006Xw-48; Fri, 17 Jul 2020 23:36:53 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] modules: linux/moduleparam.h: drop duplicated word in a
 comment
To:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>
Message-ID: <e6006b9e-48dd-5b79-b676-eab2fc71c718@infradead.org>
Date:   Fri, 17 Jul 2020 16:36:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jessica Yu <jeyu@kernel.org>
---
 include/linux/moduleparam.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/moduleparam.h
+++ linux-next-20200714/include/linux/moduleparam.h
@@ -108,7 +108,7 @@ struct kparam_array
  * ".") the kernel commandline parameter.  Note that - is changed to _, so
  * the user can use "foo-bar=1" even for variable "foo_bar".
  *
- * @perm is 0 if the the variable is not to appear in sysfs, or 0444
+ * @perm is 0 if the variable is not to appear in sysfs, or 0444
  * for world-readable, 0644 for root-writable, etc.  Note that if it
  * is writable, you may need to use kernel_param_lock() around
  * accesses (esp. charp, which can be kfreed when it changes).


