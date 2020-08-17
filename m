Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAADBC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4BF204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689823;
	bh=xdUZ6JmuAWxPCP7ksF1xp3Pn0z3uNevBMXyZq8yKP4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mezvCYZUhmUsXdAt1/QFbpYfcbgYkADrK7IMqsfuX6gJrxR8NjUftSx+Yx2aAqYqb
	 b+mMQIdbCCLbzA5mnTwogy9HyZBYf1TdnABVxSwtYqBk94/OuOGi4doqdNrZ8Eq//R
	 8eaRkxo3TvK9rzaKSYVLIjszkIsk5Z0KXKuvBYDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391496AbgHQSnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388086AbgHQP4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:56:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 809BF2053B;
        Mon, 17 Aug 2020 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679806;
        bh=xdUZ6JmuAWxPCP7ksF1xp3Pn0z3uNevBMXyZq8yKP4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZ5M4gIIwRCKCldptEtqgEJosW3r3rVuxJfxpwFjq5at9bCb/me/jjguXVW0TgMka
         o0pJLY58kC1X9Z6ItdDLpdybUgB9DP0caSf93CgoTt0SZG+jH+8/CKDcsbquL8QS3m
         Ujvw5T9zfuW2Yo9hREk7bKnxA5RXxMUbGj0O0RYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.7 340/393] pstore: Fix linking when crypto API disabled
Date:   Mon, 17 Aug 2020 17:16:30 +0200
Message-Id: <20200817143836.089435992@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@linux.microsoft.com>

commit fd49e03280e596e54edb93a91bc96170f8e97e4a upstream.

When building a kernel with CONFIG_PSTORE=y and CONFIG_CRYPTO not set,
a build error happens:

    ld: fs/pstore/platform.o: in function `pstore_dump':
    platform.c:(.text+0x3f9): undefined reference to `crypto_comp_compress'
    ld: fs/pstore/platform.o: in function `pstore_get_backend_records':
    platform.c:(.text+0x784): undefined reference to `crypto_comp_decompress'

This because some pstore code uses crypto_comp_(de)compress regardless
of the CONFIG_CRYPTO status. Fix it by wrapping the (de)compress usage
by IS_ENABLED(CONFIG_PSTORE_COMPRESS)

Signed-off-by: Matteo Croce <mcroce@linux.microsoft.com>
Link: https://lore.kernel.org/lkml/20200706234045.9516-1-mcroce@linux.microsoft.com
Fixes: cb3bee0369bc ("pstore: Use crypto compress API")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/pstore/platform.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -275,6 +275,9 @@ static int pstore_compress(const void *i
 {
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESSION))
+		return -EINVAL;
+
 	ret = crypto_comp_compress(tfm, in, inlen, out, &outlen);
 	if (ret) {
 		pr_err("crypto_comp_compress failed, ret = %d!\n", ret);
@@ -661,7 +664,7 @@ static void decompress_record(struct pst
 	int unzipped_len;
 	char *unzipped, *workspace;
 
-	if (!record->compressed)
+	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESSION) || !record->compressed)
 		return;
 
 	/* Only PSTORE_TYPE_DMESG support compression. */


