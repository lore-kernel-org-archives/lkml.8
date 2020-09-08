Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156E7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D39F221D43
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594029;
	bh=4u0pJ/Gs1vJAvB9/KtzVLob7u/TS+QyBVuy835xWRPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JEzuh3Ss8qhPMqDtqSZGIdRe8a8sJWEXZREEVXUv+PZ6qIfKlk9wbzIdrO8oC4Xeo
	 w8qofeSpyeDdwwFrAM7ySDtcijzOUxaiV13oNSX2XBKTOhcBlFiuw8prtu7X/9BWZX
	 e4M7PDOOsrmHUqsQHS7P6ZLtm6XlXAmdpJ2bhmag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbgIHTkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730797AbgIHPyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:54:44 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1378C23F5B;
        Tue,  8 Sep 2020 15:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579490;
        bh=4u0pJ/Gs1vJAvB9/KtzVLob7u/TS+QyBVuy835xWRPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmHyQgvzjeTTQul4+Z4lLj4KlD0g3EBDLAflQDu1bL3tem8a3PdAQQCI556H2F4AS
         YDfBovxBrLNI6vRcRQa89/daDbbedOpEVelJ2ZdLuXX3W/sO+J2ogLKy8rR0yAMGDC
         LengJKtiuKa20q3s1G8f+zgL54P7BXeL9nfPScLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Louis Peens <louis.peens@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 099/186] nfp: flower: fix ABI mismatch between driver and firmware
Date:   Tue,  8 Sep 2020 17:24:01 +0200
Message-Id: <20200908152246.433714284@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Louis Peens <louis.peens@netronome.com>

[ Upstream commit f614e536704d37326b0975da9cc33dd61d28c378 ]

Fix an issue where the driver wrongly detected ipv6 neighbour updates
from the NFP as corrupt. Add a reserved field on the kernel side so
it is similar to the ipv4 version of the struct and has space for the
extra bytes from the card.

Fixes: 9ea9bfa12240 ("nfp: flower: support ipv6 tunnel keep-alive messages from fw")
Signed-off-by: Louis Peens <louis.peens@netronome.com>
Signed-off-by: Simon Horman <simon.horman@netronome.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index 2df3deedf9fd8..7248d248f6041 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -61,6 +61,7 @@ struct nfp_tun_active_tuns {
  * @flags:		options part of the request
  * @tun_info.ipv6:		dest IPv6 address of active route
  * @tun_info.egress_port:	port the encapsulated packet egressed
+ * @tun_info.extra:		reserved for future use
  * @tun_info:		tunnels that have sent traffic in reported period
  */
 struct nfp_tun_active_tuns_v6 {
@@ -70,6 +71,7 @@ struct nfp_tun_active_tuns_v6 {
 	struct route_ip_info_v6 {
 		struct in6_addr ipv6;
 		__be32 egress_port;
+		__be32 extra[2];
 	} tun_info[];
 };
 
-- 
2.25.1



