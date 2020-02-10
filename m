Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EE9C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9193E20708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339814;
	bh=G4kgGGeoj+dWTzgCjehelOgG4stCoMbF9iSLP4XKNDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ewqXplISHb4XQKzPHboL1YVRCt5K6i12UrMtV0h7/kAYQgDgIP3UmiywOUgpLR4LU
	 nPCUnwH+Bn6wfe3x0ys06RU8F28KrNJV2BOuV6HD1J5YHhdJ67oN4RT3yt4p1+Nxxi
	 Q1iWmTOJn2SdglZo9diCNodYdxTjSB8itynOmoEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgBJNDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:03:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729715AbgBJMkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:40:23 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD8352465D;
        Mon, 10 Feb 2020 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338423;
        bh=G4kgGGeoj+dWTzgCjehelOgG4stCoMbF9iSLP4XKNDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gi4dpEuWKnj6G0WIPXs4GzszuAaslv5GkIIzaVecuCWeMIKh+HrFQ7WRjHDMpox5w
         F3YrBzdjP5Muy/2avR3mO1gKrST10nEyWKocWYWA1yVzexYNTW2DpPzx2iEjh6sh+j
         edZxEDrHZ1ypKvIUsapKM9otB2buIq/K5ziDR9xQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.5 143/367] dm crypt: fix GFP flags passed to skcipher_request_alloc()
Date:   Mon, 10 Feb 2020 04:30:56 -0800
Message-Id: <20200210122438.047237719@linuxfoundation.org>
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
 


