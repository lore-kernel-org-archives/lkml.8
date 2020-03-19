Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CF3C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38FA20787
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584625105;
	bh=CEmXS+Uh92PctpDbQE3BuX1dcUwZkaWTfiyUoV7XZBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OPJ8ATidcskF8jM4VZVB5Gczlk7qDqW+8dBmLSLBne1D7Iw2IDl76J9wUntWnVraw
	 F5YR5E5nz5AMMCYH2S0l6pACYdzJ66pYQBoZv6ZrERE61PQZKcc523kDOqvr/mykq/
	 IxZplQgHRsw7EYWroPJg+psYygXpZJUHlqQK+NqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgCSNiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbgCSNGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:06:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A850C20752;
        Thu, 19 Mar 2020 13:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623190;
        bh=CEmXS+Uh92PctpDbQE3BuX1dcUwZkaWTfiyUoV7XZBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zSvNtDAUjW/RMKmN4WZ/uiXKZaHhVX3O78p3OSIz+7aw68mXimqJO9hHvp9xvjq3/
         3NJ+Du97IXMxy3hHP0sZuVcQMd1Z+kM72lnq8F4MBqqr9u1NC6EqOJPH7TJcIxsMAp
         /YlN75iiHIJv35iJNNcmIhOz2d033QDJTuQYlQFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 21/93] net: fq: add missing attribute validation for orphan mask
Date:   Thu, 19 Mar 2020 13:59:25 +0100
Message-Id: <20200319123931.818982356@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 7e6dc03eeb023e18427a373522f1d247b916a641 ]

Add missing attribute validation for TCA_FQ_ORPHAN_MASK
to the netlink policy.

Fixes: 06eb395fa985 ("pkt_sched: fq: better control of DDOS traffic")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_fq.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -668,6 +668,7 @@ static const struct nla_policy fq_policy
 	[TCA_FQ_FLOW_MAX_RATE]		= { .type = NLA_U32 },
 	[TCA_FQ_BUCKETS_LOG]		= { .type = NLA_U32 },
 	[TCA_FQ_FLOW_REFILL_DELAY]	= { .type = NLA_U32 },
+	[TCA_FQ_ORPHAN_MASK]		= { .type = NLA_U32 },
 };
 
 static int fq_change(struct Qdisc *sch, struct nlattr *opt)


