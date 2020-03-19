Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C021C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6A82098B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623763;
	bh=l5cFa6Emn1btZwMRpEet7GN0OLXU861N0lQ98ZxATI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BSR6CU9jXOcH2tQfCXjGGgcG+YmgbH/mo/S3Mb3cYXGqMGXqycyGDxsoDNjt0jsnJ
	 WatvtFKZL1UqcThqFALvK1U9cYhZOmipyzVT5RCr1zWBExgaAFstPP6araGkngRdUA
	 pMm1zXAWNJt+lHV7HFaOi606SmijrBLHwnNttWZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgCSNQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729462AbgCSNP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:15:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F7420724;
        Thu, 19 Mar 2020 13:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623756;
        bh=l5cFa6Emn1btZwMRpEet7GN0OLXU861N0lQ98ZxATI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeTQwJ6Ar+wFSmHT7JQ2TdxuqNOylhej7IcizGYhvJkKsmx8qPuTflhL8StHhKdpr
         YQBFEfOvG/CZtsxYWdr38VzGY4ujon5/ffRLpcZK3p0GeVJbcoM6hL/i30ImFuzHr5
         CL5b1hBv6vY9yHM3e9y38WlAjOWUsAiez4eQVgPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 35/99] ipvlan: egress mcast packets are not exceptional
Date:   Thu, 19 Mar 2020 14:03:13 +0100
Message-Id: <20200319123952.429268161@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

commit cccc200fcaf04cff4342036a72e51d6adf6c98c1 upstream.

Currently, if IPv6 is enabled on top of an ipvlan device in l3
mode, the following warning message:

 Dropped {multi|broad}cast of type= [86dd]

is emitted every time that a RS is generated and dmseg is soon
filled with irrelevant messages. Replace pr_warn with pr_debug,
to preserve debuggability, without scaring the sysadmin.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ipvlan/ipvlan_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -451,8 +451,8 @@ static int ipvlan_process_outbound(struc
 
 	/* In this mode we dont care about multicast and broadcast traffic */
 	if (is_multicast_ether_addr(ethh->h_dest)) {
-		pr_warn_ratelimited("Dropped {multi|broad}cast of type= [%x]\n",
-				    ntohs(skb->protocol));
+		pr_debug_ratelimited("Dropped {multi|broad}cast of type=[%x]\n",
+				     ntohs(skb->protocol));
 		kfree_skb(skb);
 		goto out;
 	}


