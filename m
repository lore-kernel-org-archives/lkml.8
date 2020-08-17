Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EDAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB7D2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597687665;
	bh=VB67BcQRe1DuAd65X3jiZpXUTQ0j7BJtEfXDpKVmN48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JUBoMuDjYCRvb/WCMgD751hv7LkvMzbk3qRQKdvj05ilFZumuKj2erGII0AaaNepg
	 /1dztBkIKQkZXdEOqMDjw6Ic4Iy3DzIQFElfv2tiy3VXdehaLyS1ZgNzO9xGViugNj
	 hF/G1t4wmsi9Ebp91ayTCQlnAwJ3Triim2R/v3nQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbgHQSHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388477AbgHQQIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:08:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56E13207FB;
        Mon, 17 Aug 2020 16:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680530;
        bh=VB67BcQRe1DuAd65X3jiZpXUTQ0j7BJtEfXDpKVmN48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V3XHwei/NAVYOzRFid1iDfuZ0bHjUY48ODlmc1d9C6XYB9w+KyaB2Urfsnvv7dpJu
         SdeDruzihW8mbABMfdzPfmsR8j48YAKMMixs6aVPtYN2FGtdmU5gToSYyc/G3Q52Ny
         AD1qkpz4mFdxB3CnLA/PS0BDS+831zQxQe1eI9Rw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 222/270] net: Set fput_needed iff FDPUT_FPUT is set
Date:   Mon, 17 Aug 2020 17:17:03 +0200
Message-Id: <20200817143806.828898347@linuxfoundation.org>
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

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit ce787a5a074a86f76f5d3fd804fa78e01bfb9e89 ]

We should fput() file iff FDPUT_FPUT is set. So we should set fput_needed
accordingly.

Fixes: 00e188ef6a7e ("sockfd_lookup_light(): switch to fdget^W^Waway from fget_light")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/socket.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/socket.c
+++ b/net/socket.c
@@ -485,7 +485,7 @@ static struct socket *sockfd_lookup_ligh
 	if (f.file) {
 		sock = sock_from_file(f.file, err);
 		if (likely(sock)) {
-			*fput_needed = f.flags;
+			*fput_needed = f.flags & FDPUT_FPUT;
 			return sock;
 		}
 		fdput(f);


