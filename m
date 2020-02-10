Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF66C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A8920708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339113;
	bh=w04zKDRhfpscS0qERuuz0M+TT8yN32ujVbARW/VIr00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mEMQb2Lnf1L9ywaxzxvnbTGG/fPPqslfZDENm+WbxccmxxGPWmbWwi9CHlFAZ3YEJ
	 pTMIsmXbp4ugNFK7HVXL11VXmNliuMWyjfl5fwN9S5oRWf1CPkqCbb+HC+TfUm7eg0
	 kIxTiykWDaE/QH5646N0d3xMb+Yz2AMLPmYmScNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgBJMnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729503AbgBJMjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:44 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A66D24683;
        Mon, 10 Feb 2020 12:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338383;
        bh=w04zKDRhfpscS0qERuuz0M+TT8yN32ujVbARW/VIr00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqMu7b9/QWW8SjnekWR/yG7kFH9EylQ2gF25oCRAenP8rPFsDDSpRxI4oegyLWSd1
         ur0TH5eXgBMj8Y0+sYAfkpRQy+flrfdW66NCFWR+5CajsDOcOgjbYEOnNYgbUxKlks
         s9rnU7VOU5ibzCyV8Y26q+62mXNe/3CLLo1xYK0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.5 064/367] lib/test_kasan.c: fix memory leak in kmalloc_oob_krealloc_more()
Date:   Mon, 10 Feb 2020 04:29:37 -0800
Message-Id: <20200210122430.002358593@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
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
@@ -158,6 +158,7 @@ static noinline void __init kmalloc_oob_
 	if (!ptr1 || !ptr2) {
 		pr_err("Allocation failed\n");
 		kfree(ptr1);
+		kfree(ptr2);
 		return;
 	}
 


