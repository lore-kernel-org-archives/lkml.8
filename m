Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC03C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673E120708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339173;
	bh=cuMIpdQ6frh5EBS3YjnBx5mISarMj9jt+9ERkJVG/ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RQibt4W0bMkImCdN67NJutgvYCdzcfc4a9fBeJVq1G2msPVmw2gSqPXIwoeQLTJ90
	 J4TzTLlguIPDFApU/IFd5ZBX1+XOEv8SfllRsaJn6q/XQRJZUPKvlXnnAbxvMNVuTC
	 bkT6PUZ0vxPOawgIYb0zhGnrjUk/RYFRuiKaM7Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgBJMww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:52:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730211AbgBJMmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:42:18 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AE7F2085B;
        Mon, 10 Feb 2020 12:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338538;
        bh=cuMIpdQ6frh5EBS3YjnBx5mISarMj9jt+9ERkJVG/ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSPi+KH0aPDeqho7yykrHPjLWvjDEI4PeyBoRHZ2VLske8ryvt3X+8iLrCcS3Ocxi
         mducw//GTLJWxsKM4YPXcVP/CqDtXNdgf8rgGzJxTfxvoC8+VvX8HxYa+EpMI/b4Rc
         qS27+VI6JHjwjyk3dl3LVMb3q/I5hOI9bDjmdXrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 337/367] taprio: Add missing policy validation for flags
Date:   Mon, 10 Feb 2020 04:34:10 -0800
Message-Id: <20200210122453.826842476@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit 49c684d79cfdc3032344bf6f3deeea81c4efedbf ]

netlink policy validation for the 'flags' argument was missing.

Fixes: 4cfd5779bd6e ("taprio: Add support for txtime-assist mode")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_taprio.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -767,6 +767,7 @@ static const struct nla_policy taprio_po
 	[TCA_TAPRIO_ATTR_SCHED_CLOCKID]              = { .type = NLA_S32 },
 	[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME]           = { .type = NLA_S64 },
 	[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION] = { .type = NLA_S64 },
+	[TCA_TAPRIO_ATTR_FLAGS]                      = { .type = NLA_U32 },
 };
 
 static int fill_sched_entry(struct nlattr **tb, struct sched_entry *entry,


