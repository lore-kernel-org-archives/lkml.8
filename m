Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A61C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D245F2073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609661;
	bh=+BpZ3TDIChsJ4SUx/k15uWJiv6Ek36N7bx9aI6TNxAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t4IGlu2d7dlDaYHxY3AJ0mJJ6/kKUGxE3R02ChK+O63RCVB+z0o9JzBf9hxubB/iu
	 oIQzniCRl+jJv21Zhp/Tn6BXQv+dsngDBQZOLNzbAj9DI4YAe8FW9zQrzU33KMjbgH
	 ev/JE+mgsH4Pl0wBk8aZ3Fk21nEOec7Hgq1ma210=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgBMQBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:01:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728359AbgBMPYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:43 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5902B246C7;
        Thu, 13 Feb 2020 15:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607483;
        bh=+BpZ3TDIChsJ4SUx/k15uWJiv6Ek36N7bx9aI6TNxAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hoT0f2ky5AXrvprPbaOX8QoLqPUSTEf2+Czn0M5hgGnWceYfzbSR87SunKWidHzty
         dMw5vh3ugC1Jx+xBog65BNlw4ANPzxtOgrDtM6vlZ7PeVHR8J3cp8JD8NwLiwbCV2g
         V0CHjF7GLIt5kS+xkd+4bnWMQzXfGIcMwwv6oBn0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 028/173] lib/test_kasan.c: fix memory leak in kmalloc_oob_krealloc_more()
Date:   Thu, 13 Feb 2020 07:18:51 -0800
Message-Id: <20200213151940.587492472@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 3e21d9a501bf99aee2e5835d7f34d8c823f115b5 upstream.

In case memory resources for _ptr2_ were allocated, release them before
return.

Notice that in case _ptr1_ happens to be NULL, krealloc() behaves
exactly like kmalloc().

Addresses-Coverity-ID: 1490594 ("Resource leak")
Link: http://lkml.kernel.org/r/20200123160115.GA4202@embeddedor
Fixes: 3f15801cdc23 ("lib: add kasan test module")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/test_kasan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -126,6 +126,7 @@ static noinline void __init kmalloc_oob_
 	if (!ptr1 || !ptr2) {
 		pr_err("Allocation failed\n");
 		kfree(ptr1);
+		kfree(ptr2);
 		return;
 	}
 


