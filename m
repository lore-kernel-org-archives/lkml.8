Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69A3C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A5C2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581569311;
	bh=6XgnjQAmLJi/ywxNwipKTQhR87xeEOBguUpFp+51AZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ph21gmmhOHJYvyzInS8i/nraGg6J5jKFacER60mR/OsL2AaCl2MUtQ4lzK01P5Tvf
	 U4gT6o406juCnzEjuyXMTVUUzMYCfGqBhXMgcFeYd5IKuu/Cj2P3AjTvkC5LhSEaZo
	 Yv4z12/pnmLqTf1Z3gtuhZ7LtklpKWoA9zDwaSP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgBMEsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:48:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbgBMEsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:48:30 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA5D206DB;
        Thu, 13 Feb 2020 04:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581569308;
        bh=6XgnjQAmLJi/ywxNwipKTQhR87xeEOBguUpFp+51AZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jh1EgfLfdu4815kbBoKihNSuOoGATxgqPZ4iw0rzQQ2ZqhT7JMSZ0mIJ45bEw4bi7
         saPkUFAAcU7OLbMBK2Qtr1gD6VnqpipJJgjch+psQ0Bq5IBwAnYKrohld7tKKVe5is
         yx2uJL66693LcBnPC2ulCOcnA949yPgj0xr47W5w=
Date:   Wed, 12 Feb 2020 20:48:27 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmpressure: don't need call kfree if kstrndup
 fails
Message-Id: <20200212204827.df1de9015a3c03c79a8d7155@linux-foundation.org>
In-Reply-To: <48d53caf-4b89-69c3-cf9b-47b8627db0bd@linux.alibaba.com>
References: <1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com>
        <b47f8f37-fbde-5487-5025-fcb0df7a7e30@redhat.com>
        <48d53caf-4b89-69c3-cf9b-47b8627db0bd@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 19:14:27 -0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> On 2/12/20 3:21 AM, David Hildenbrand wrote:
> > On 11.02.20 06:24, Yang Shi wrote:
> >> When kstrndup fails (returns NULL) there is no memory is allocated by
> >> kmalloc, so no need to call kfree().
> > "When kstrndup fails, no memory was allocated and we can exit directly."
> 
> Thanks for correcting the commit log.
> 
> Andrew, do you prefer I send an updated version or you would just update 
> the patch in -mm tree?

I have already done this.

From: Yang Shi <yang.shi@linux.alibaba.com>
Subject: mm: vmpressure: don't need call kfree if kstrndup fails

When kstrndup fails, no memory was allocated and we can exit directly.

[david@redhat.com: reword changelog]
Link: http://lkml.kernel.org/r/1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmpressure.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/mm/vmpressure.c~mm-vmpressure-dont-need-call-kfree-if-kstrndup-fails
+++ a/mm/vmpressure.c
@@ -371,10 +371,8 @@ int vmpressure_register_event(struct mem
 	int ret = 0;
 
 	spec_orig = spec = kstrndup(args, MAX_VMPRESSURE_ARGS_LEN, GFP_KERNEL);
-	if (!spec) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!spec)
+		return -ENOMEM;
 
 	/* Find required level */
 	token = strsep(&spec, ",");
_

