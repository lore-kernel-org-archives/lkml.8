Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6B0C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26D220575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100320;
	bh=C4T+9qNnW8xUkfV4aUIrKOLkJ/rwfdF2rXxGPscAWbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EUzKnphrKov0iPCLVOPGGnEDjN/+SfEqw1mIjyLF87tD2xUl9JgHZToqDZ2MYIypC
	 QegZkB4x5N1QzkauQVJKT99EenvXEGIIvw8ADuyng9AUGE9YHa0XeLfmAUEikmAWJk
	 HQybl3eYfWwbsrOnjcnefe++LtL2/24B/kfuIYnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgD1S6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728768AbgD1S3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:29:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC1FB208E0;
        Tue, 28 Apr 2020 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098546;
        bh=C4T+9qNnW8xUkfV4aUIrKOLkJ/rwfdF2rXxGPscAWbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkM9LzlIttUCCytXvHUaFMzq73uxN8OqrWuKewza2eBVcykTkwQSVcQJihb7vHqQ1
         s6iPT5VuSRfSXmEyZOlsddAA0BC11Vh1Ni3sB/H7uNv3iPXro/NWbw1SlMjIWjwKcR
         qaL7GhDLDW2iTKP1TGogzH2Dzqv7JSbvj+rqRuas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 070/167] vxlan: use the correct nlattr array in NL_SET_ERR_MSG_ATTR
Date:   Tue, 28 Apr 2020 20:24:06 +0200
Message-Id: <20200428182233.814364231@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit cc8e7c69db4dcc565ed3020f97ddd6debab6cbe8 ]

IFLA_VXLAN_* attributes are in the data array, which is correctly
used when fetching the value, but not when setting the extended
ack. Because IFLA_VXLAN_MAX < IFLA_MAX, we avoid out of bounds
array accesses, but we don't provide a pointer to the invalid
attribute to userspace.

Fixes: 653ef6a3e4af ("vxlan: change vxlan_[config_]validate() to use netlink_ext_ack for error reporting")
Fixes: b4d3069783bc ("vxlan: Allow configuration of DF behaviour")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -3144,7 +3144,7 @@ static int vxlan_validate(struct nlattr
 		u32 id = nla_get_u32(data[IFLA_VXLAN_ID]);
 
 		if (id >= VXLAN_N_VID) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_ID],
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_ID],
 					    "VXLAN ID must be lower than 16777216");
 			return -ERANGE;
 		}
@@ -3155,7 +3155,7 @@ static int vxlan_validate(struct nlattr
 			= nla_data(data[IFLA_VXLAN_PORT_RANGE]);
 
 		if (ntohs(p->high) < ntohs(p->low)) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_PORT_RANGE],
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_PORT_RANGE],
 					    "Invalid source port range");
 			return -EINVAL;
 		}
@@ -3165,7 +3165,7 @@ static int vxlan_validate(struct nlattr
 		enum ifla_vxlan_df df = nla_get_u8(data[IFLA_VXLAN_DF]);
 
 		if (df < 0 || df > VXLAN_DF_MAX) {
-			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_DF],
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_VXLAN_DF],
 					    "Invalid DF attribute");
 			return -EINVAL;
 		}


