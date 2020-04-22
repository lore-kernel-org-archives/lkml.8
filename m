Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFB4C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE09920656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551971;
	bh=NAnVbASWnjgs7XmskmVMUUmV+KLJ3N68NxMBDVxbZLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=snsPKtZK+7ox3LPnqtgPYPIZa7aayJDmJjfsCCLFN6xBFg3Yl+CLjg94MOIDzYpM/
	 HV8mtmxd6HZ/kq7du8WWBRknwTwaAa3geBOyM967JhwpF7azoysMeTZ8alx0cB/BF0
	 8riS9rToiv66/1LnNIvFwAXJGNyCk/LTBtL8rYoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbgDVKja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgDVKVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:21:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ADA72076E;
        Wed, 22 Apr 2020 10:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550884;
        bh=NAnVbASWnjgs7XmskmVMUUmV+KLJ3N68NxMBDVxbZLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EiULXAxMJVgzhuY/jxFZnJ17466E2GuVO4Wt+z9TO+vMb2AQSCBVzUdYi14VEch65
         XGkFucNxzwB5lDljqiSDuGeZstQRyCMeMLfnlhAjARxjbsu48ldZz2KxOdaGQdz9ZF
         kI2ZMm2ft3zcqfArGd1G1DYCs+0RonZnOGbTSI+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.6 014/166] netfilter: nf_tables: report EOPNOTSUPP on unsupported flags/object type
Date:   Wed, 22 Apr 2020 11:55:41 +0200
Message-Id: <20200422095049.851270478@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit d9583cdf2f38d0f526d9a8c8564dd2e35e649bc7 upstream.

EINVAL should be used for malformed netlink messages. New userspace
utility and old kernels might easily result in EINVAL when exercising
new set features, which is misleading.

Fixes: 8aeff920dcc9 ("netfilter: nf_tables: add stateful object reference to set elements")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_tables_api.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3950,7 +3950,7 @@ static int nf_tables_newset(struct net *
 			      NFT_SET_INTERVAL | NFT_SET_TIMEOUT |
 			      NFT_SET_MAP | NFT_SET_EVAL |
 			      NFT_SET_OBJECT))
-			return -EINVAL;
+			return -EOPNOTSUPP;
 		/* Only one of these operations is supported */
 		if ((flags & (NFT_SET_MAP | NFT_SET_OBJECT)) ==
 			     (NFT_SET_MAP | NFT_SET_OBJECT))
@@ -3988,7 +3988,7 @@ static int nf_tables_newset(struct net *
 		objtype = ntohl(nla_get_be32(nla[NFTA_SET_OBJ_TYPE]));
 		if (objtype == NFT_OBJECT_UNSPEC ||
 		    objtype > NFT_OBJECT_MAX)
-			return -EINVAL;
+			return -EOPNOTSUPP;
 	} else if (flags & NFT_SET_OBJECT)
 		return -EINVAL;
 	else


