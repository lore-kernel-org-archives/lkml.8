Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7265C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8322424650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271091;
	bh=nKJjF866yjwJPSLo14ekLgStyMcGGRJrLmEcN+E0vcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KRLATVzAXfRtmaaMzFgq6z5fl8zVbvOajfLfawaXgFVm4/SzZyxuSdfDB7OQWZuqN
	 0ja2F5w19sMLmsNjBX9f5jhgZ6RFoIXl3JIvhmUjwTkzklWLpvzKCBazT4H/TAXmFx
	 AedijzRvt4pi/CFmqyykkBS9Mutu43vciH4L8VQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgBUHou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:44:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbgBUHor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:44:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272DC20801;
        Fri, 21 Feb 2020 07:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271086;
        bh=nKJjF866yjwJPSLo14ekLgStyMcGGRJrLmEcN+E0vcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOFnKkxDRfRgOhUTz5RBCq4QEHoTbMywwxQk1dUR1qQ9xvRYWmTkqg2afGIq4K5Fn
         tySLzoqL5A7F5sHEjEQJClR7J9JAwWqDAEJ5YzJ/TMdZ6Cmq6Ki8uTb1LEL9lQmGTt
         FlHumCfsQVUpbnrz/4kYLVby7upNyXW36iJuUm2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 006/399] net/sched: flower: add missing validation of TCA_FLOWER_FLAGS
Date:   Fri, 21 Feb 2020 08:35:31 +0100
Message-Id: <20200221072402.933005748@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit e2debf0852c4d66ba1a8bde12869b196094c70a7 ]

unlike other classifiers that can be offloaded (i.e. users can set flags
like 'skip_hw' and 'skip_sw'), 'cls_flower' doesn't validate the size of
netlink attribute 'TCA_FLOWER_FLAGS' provided by user: add a proper entry
to fl_policy.

Fixes: 5b33f48842fa ("net/flower: Introduce hardware offload support")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_flower.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -691,6 +691,7 @@ static const struct nla_policy fl_policy
 					    .len = 128 / BITS_PER_BYTE },
 	[TCA_FLOWER_KEY_CT_LABELS_MASK]	= { .type = NLA_BINARY,
 					    .len = 128 / BITS_PER_BYTE },
+	[TCA_FLOWER_FLAGS]		= { .type = NLA_U32 },
 };
 
 static const struct nla_policy


