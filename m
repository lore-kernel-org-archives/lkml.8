Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9D7C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D982166E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580746909;
	bh=V95cMtoZomrzbOpNqb6B53ntBdklZCdetoQdW31/qlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dcsa+OQFLY6V1dDJ9+vk00hxsIT35IPZ37qsy2shzEBR6FFZB6wS+21upNee5W6O4
	 RWQKA3/0s7fJUsMmFKnjg2089ipZLr3E++97Anx1kEqd29BGsZM+dNIoKl5FSE117R
	 iWKHPY8KB+14xofHzGivSHIBAzTnc51y6WoAbess=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgBCQVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:21:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbgBCQVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:21:33 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A33F421582;
        Mon,  3 Feb 2020 16:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746893;
        bh=V95cMtoZomrzbOpNqb6B53ntBdklZCdetoQdW31/qlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXY+KvJscpLJhJMF9otbdt7GNH+g/c+hElq2hyPOPLPGsLriZcYhaB90PWMENsT7/
         n4yJp0cUwv7pkPOOzHl067MI3nCBi/524646dc2/tZL983K3VU1hL4MfV6RmsPWovV
         ewGldQZtWAsfqC/bGt23+m6oqvKiNDT7uH0gU7fI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 51/53] seq_tab_next() should increase position index
Date:   Mon,  3 Feb 2020 16:19:43 +0000
Message-Id: <20200203161911.812039112@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit 70a87287c821e9721b62463777f55ba588ac4623 ]

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
index 129d6095749a4..54d5e53e94af2 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
@@ -66,8 +66,7 @@ static void *seq_tab_start(struct seq_file *seq, loff_t *pos)
 static void *seq_tab_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	v = seq_tab_get_idx(seq->private, *pos + 1);
-	if (v)
-		++*pos;
+	++(*pos);
 	return v;
 }
 
-- 
2.20.1



