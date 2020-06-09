Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C9FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223B72081A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725334;
	bh=/G8p906UvT/4yhB83bWJPraTnQwHIrfXDNQJwOdqdxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xuKXM2R6Ai9j2XLg3CV8CkQ1qQHO3hT25ZzqEMfpa5nSvLTnTpKpMBCfZCArcsKkO
	 fFqtN50ZV0H+3hgrHlOKZGX4x7HruK+S06Dez73Q0xRcMYXRcqdVqnFBi1cAk09P3W
	 LrlTVNy/LZzpRBc1it3w0SzjI9X5tbjo51XOC/Dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733249AbgFIRza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733040AbgFIRxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:53:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B80020774;
        Tue,  9 Jun 2020 17:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725219;
        bh=/G8p906UvT/4yhB83bWJPraTnQwHIrfXDNQJwOdqdxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u48a+2gTKVPtO7qkdpbzSBR7ah85qlzRV/3eZ6ydF9YqajAfG7pE0AtRtt3BwPqV8
         EHXuct7ed7it+FR/1ZOahIklNuthiw7eIg/SlDStkkl6QPtyaBdpFg4zfaHBIakvTF
         BmfiEXQ0bFIyYCx0JUjCyRpoB2ONBdEX+SSQ8Id0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.6 17/41] net/mlx5e: replace EINVAL in mlx5e_flower_parse_meta()
Date:   Tue,  9 Jun 2020 19:45:19 +0200
Message-Id: <20200609174113.782291512@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174112.129412236@linuxfoundation.org>
References: <20200609174112.129412236@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit a683012a8e77675a1947cc8f11f97cdc1d5bb769 ]

The drivers reports EINVAL to userspace through netlink on invalid meta
match. This is confusing since EINVAL is usually reserved for malformed
netlink messages. Replace it by more meaningful codes.

Fixes: 6d65bc64e232 ("net/mlx5e: Add mlx5e_flower_parse_meta support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1824,7 +1824,7 @@ static int mlx5e_flower_parse_meta(struc
 	flow_rule_match_meta(rule, &match);
 	if (match.mask->ingress_ifindex != 0xFFFFFFFF) {
 		NL_SET_ERR_MSG_MOD(extack, "Unsupported ingress ifindex mask");
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	ingress_dev = __dev_get_by_index(dev_net(filter_dev),
@@ -1832,13 +1832,13 @@ static int mlx5e_flower_parse_meta(struc
 	if (!ingress_dev) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Can't find the ingress port to match on");
-		return -EINVAL;
+		return -ENOENT;
 	}
 
 	if (ingress_dev != filter_dev) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Can't match on the ingress filter port");
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;


