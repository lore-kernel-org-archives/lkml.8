Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2F2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3865820848
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591724787;
	bh=sAKqQsYspESBgdnN+eV9couIFzpg4RDXKq4PEh5Ww5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T1zZpl57Uhcd9EzZZgZGvlUEEVfZQ1pxd/KrjqIAN8OkOgZcQFUEcmoXcD3VhsgKr
	 ZuR7bzoEIFs+18jNUFAzIzt7P1xoJu76P5stY+3GIbzMmBda/gt9QE0Kw0J5o8W1O0
	 Iawvldvctpgi6hJ0Vy2txYSvZcoaM3bjjiGg3wLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbgFIRqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730555AbgFIRqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:46:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71B9620814;
        Tue,  9 Jun 2020 17:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724777;
        bh=sAKqQsYspESBgdnN+eV9couIFzpg4RDXKq4PEh5Ww5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VLkn7KRWaTNnkEYr8POhMF0jwueII5niHAG9eA7vwzE9A8klrVUQUlp9eNtc6yAg8
         SlWf9lbbbeoBeKlhh0aG/90WaIdBFrpQg+1O36t83rPq/8cAlz9o3R9CmRKuYegNfJ
         jzYCKYcw6HRy7oisGCSomS8FV/mC8cwy0f3HTN+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 04/36] esp6: fix memleak on error path in esp6_input
Date:   Tue,  9 Jun 2020 19:44:04 +0200
Message-Id: <20200609173933.542853475@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609173933.288044334@linuxfoundation.org>
References: <20200609173933.288044334@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

commit 7284fdf39a912322ce97de2d30def3c6068a418c upstream.

This ought to be an omission in e6194923237 ("esp: Fix memleaks on error
paths."). The memleak on error path in esp6_input is similar to esp_input
of esp4.

Fixes: e6194923237 ("esp: Fix memleaks on error paths.")
Fixes: 3f29770723f ("ipsec: check return value of skb_to_sgvec always")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/esp6.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -426,8 +426,10 @@ static int esp6_input(struct xfrm_state
 
 	sg_init_table(sg, nfrags);
 	ret = skb_to_sgvec(skb, sg, 0, skb->len);
-	if (unlikely(ret < 0))
+	if (unlikely(ret < 0)) {
+		kfree(tmp);
 		goto out;
+	}
 
 	aead_request_set_crypt(req, sg, sg, elen + ivlen, iv);
 	aead_request_set_ad(req, assoclen);


