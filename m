Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D18BC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1927220873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340808;
	bh=G4kgGGeoj+dWTzgCjehelOgG4stCoMbF9iSLP4XKNDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WGudjwGnU0mrgT6kSGESiCNb3ZdqMUPuJLNMkMN26ShLSBRulTTbPQ8tYEfrPAu2J
	 in6QBYmLuDlrthwdaB5ih1pjezseRzi9g5sIzN4q6YlPC7I6UEj9KHvDGTrYxYk/yX
	 MOhSqy7KAvWe5cBkJy6SGjaDk9mnAPAZ3BwUxpok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgBJNUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728868AbgBJMhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:43 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF1D22085B;
        Mon, 10 Feb 2020 12:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338262;
        bh=G4kgGGeoj+dWTzgCjehelOgG4stCoMbF9iSLP4XKNDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djIxwElwaSvkYaHzxejqZcKFEaHAK05fe4gBY3uM5y4gsDXHfsUdsW31gqgZbPyAx
         B/7pNBxNvbXHrpI5vpDrK0GDlsKb2LjnVIIyJOyF/hG3Ynn/84/kYsEn296TBRUAbm
         Yf0pRGKO1ylOJapIgKzrm/oU+K911+otYMRYqIgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.4 130/309] dm crypt: fix GFP flags passed to skcipher_request_alloc()
Date:   Mon, 10 Feb 2020 04:31:26 -0800
Message-Id: <20200210122418.866965236@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 9402e959014a18b4ebf7558733076875808dd66c upstream.

GFP_KERNEL is not supposed to be or'd with GFP_NOFS (the result is
equivalent to GFP_KERNEL). Also, we use GFP_NOIO instead of GFP_NOFS
because we don't want any I/O being submitted in the direct reclaim
path.

Fixes: 39d13a1ac41d ("dm crypt: reuse eboiv skcipher for IV generation")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-crypt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -717,7 +717,7 @@ static int crypt_iv_eboiv_gen(struct cry
 	struct crypto_wait wait;
 	int err;
 
-	req = skcipher_request_alloc(any_tfm(cc), GFP_KERNEL | GFP_NOFS);
+	req = skcipher_request_alloc(any_tfm(cc), GFP_NOIO);
 	if (!req)
 		return -ENOMEM;
 


