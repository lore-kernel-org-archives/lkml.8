Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF66C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7F820809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096298;
	bh=L3Zw8ss3VmWopi7gORgZBBtYTkCV0QdjwK+a37qoRaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LwQJDWSATXtBdxMijiRgzEgNRL0p0Oyn2QRoCot4OOCWn7AYB2eCjASoZbBqKMPbN
	 8j3/gUGFtKHiBmtfvK7PBh1WrV+p4rAfnBLXp3qKOyGrYaEeN3Lmrbef4Folu5L5bV
	 R9wzURqvu8tOhKP7d5DgRS3GWfNSt2pGXR2YSufY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgG3IEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728758AbgG3IEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:04:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F47F2083B;
        Thu, 30 Jul 2020 08:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096289;
        bh=L3Zw8ss3VmWopi7gORgZBBtYTkCV0QdjwK+a37qoRaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OuXNpwNTUjpj1CiB5ObfPYIP2V1KfXMnsMusc5NW63X8PBR2XZl86DJL0JLpIzDWx
         wXxkDbsLVMTy/eWxXho2p3OziSs8ICBZUom5EePnZgmvMtrXR2FVV7iFhObyc0SXB3
         t1PDUPUwygl0LIggOOftOaijvKmmglorNVzcyExY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 13/20] AX.25: Prevent integer overflows in connect and sendmsg
Date:   Thu, 30 Jul 2020 10:04:03 +0200
Message-Id: <20200730074421.166778929@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.533211699@linuxfoundation.org>
References: <20200730074420.533211699@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 17ad73e941b71f3bec7523ea4e9cbc3752461c2d ]

We recently added some bounds checking in ax25_connect() and
ax25_sendmsg() and we so we removed the AX25_MAX_DIGIS checks because
they were no longer required.

Unfortunately, I believe they are required to prevent integer overflows
so I have added them back.

Fixes: 8885bb0621f0 ("AX.25: Prevent out-of-bounds read in ax25_sendmsg()")
Fixes: 2f2a7ffad5c6 ("AX.25: Fix out-of-bounds read in ax25_connect()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ax25/af_ax25.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1188,6 +1188,7 @@ static int __must_check ax25_connect(str
 	    fsa->fsa_ax25.sax25_ndigis != 0) {
 		/* Valid number of digipeaters ? */
 		if (fsa->fsa_ax25.sax25_ndigis < 1 ||
+		    fsa->fsa_ax25.sax25_ndigis > AX25_MAX_DIGIS ||
 		    addr_len < sizeof(struct sockaddr_ax25) +
 		    sizeof(ax25_address) * fsa->fsa_ax25.sax25_ndigis) {
 			err = -EINVAL;
@@ -1509,7 +1510,9 @@ static int ax25_sendmsg(struct socket *s
 			struct full_sockaddr_ax25 *fsa = (struct full_sockaddr_ax25 *)usax;
 
 			/* Valid number of digipeaters ? */
-			if (usax->sax25_ndigis < 1 || addr_len < sizeof(struct sockaddr_ax25) +
+			if (usax->sax25_ndigis < 1 ||
+			    usax->sax25_ndigis > AX25_MAX_DIGIS ||
+			    addr_len < sizeof(struct sockaddr_ax25) +
 			    sizeof(ax25_address) * usax->sax25_ndigis) {
 				err = -EINVAL;
 				goto out;


