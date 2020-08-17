Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5640C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBFA2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597687581;
	bh=sEXgLNETWRnYr2UqSnDJpMZ7mhrKfcrWV3ANRgsVbAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aTiLYpneRpuaQyE7MLu9GCrYD/9APUwtu/GvAmDSAQVc6VMbia9zz3tpwDsyoe3g2
	 7Wujh4/FSb2ScsdsHGd5Ud2zFlGYhxLEjHXw0BtVqBdvTlvGiyBhLcBscrmsKpSE6+
	 0fDvG3hJzu9PZSefU+2O6ldsvkM1p83671xFvTag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390285AbgHQSGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388283AbgHQQIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:08:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A81AD20888;
        Mon, 17 Aug 2020 16:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680533;
        bh=sEXgLNETWRnYr2UqSnDJpMZ7mhrKfcrWV3ANRgsVbAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ff6Hzxl4TzF5Fpa1MrFayNWC9l2asMi1Y4cSIKFI1LmCHq15GVfFcu4MqvknKysmv
         tFJdUYToSAGP2YCsWqX49hIkPI2VXiJztgYgtSJD6OMJKN2bEl76YnLBoKBshOkwjy
         uID4XqtA+1xnEYttIX/5BemyhonIAvUS0rumhfQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 223/270] net/tls: Fix kmap usage
Date:   Mon, 17 Aug 2020 17:17:04 +0200
Message-Id: <20200817143806.877325542@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
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
@@ -549,7 +549,7 @@ int tls_device_sendpage(struct sock *sk,
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct iov_iter	msg_iter;
-	char *kaddr = kmap(page);
+	char *kaddr;
 	struct kvec iov;
 	int rc;
 
@@ -564,6 +564,7 @@ int tls_device_sendpage(struct sock *sk,
 		goto out;
 	}
 
+	kaddr = kmap(page);
 	iov.iov_base = kaddr + offset;
 	iov.iov_len = size;
 	iov_iter_kvec(&msg_iter, WRITE, &iov, 1, size);


