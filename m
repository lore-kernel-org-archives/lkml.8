Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1B6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF4C204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691889;
	bh=JX9YD0fyNo6GydpHRaQDCiHNNZT4tpcruFeiYGycKgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H1JAPKMAekCWj8NKrHl1kUnZgHb2fiKR4cfi21/wurxyZyoNeDzy82JsGcu7+878x
	 4yaCr2XEw/hw99R5qwKNvAjFQ/hdgAsW2NKXaP34gjvxx8zR0Q966BwNHE3+lCB/1P
	 PAo3hTd4FVBRm5A2lK+IeZfv68eU++wSLGN0vszc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392267AbgHQTSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730574AbgHQPiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:38:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0611923357;
        Mon, 17 Aug 2020 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678686;
        bh=JX9YD0fyNo6GydpHRaQDCiHNNZT4tpcruFeiYGycKgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZIMBvyv9rjO3mdrqikjmaA3Y6YaSNndz859HOPEllZEtK+pGStkoEfh7k7V/Z/0L
         jh6McoErhQkPxIEiH7WHRLBCzd8YRDDiG4nI6+o28Vvgi0FOOdn1gnD0cN23+OEFTX
         cHv+szZMCC4ZzTH3kY5WfpDD/ZBLZLGxWzg558NU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.8 389/464] net/tls: Fix kmap usage
Date:   Mon, 17 Aug 2020 17:15:42 +0200
Message-Id: <20200817143852.412641434@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

[ Upstream commit b06c19d9f827f6743122795570bfc0c72db482b0 ]

When MSG_OOB is specified to tls_device_sendpage() the mapped page is
never unmapped.

Hold off mapping the page until after the flags are checked and the page
is actually needed.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_device.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -561,7 +561,7 @@ int tls_device_sendpage(struct sock *sk,
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct iov_iter	msg_iter;
-	char *kaddr = kmap(page);
+	char *kaddr;
 	struct kvec iov;
 	int rc;
 
@@ -576,6 +576,7 @@ int tls_device_sendpage(struct sock *sk,
 		goto out;
 	}
 
+	kaddr = kmap(page);
 	iov.iov_base = kaddr + offset;
 	iov.iov_len = size;
 	iov_iter_kvec(&msg_iter, WRITE, &iov, 1, size);


