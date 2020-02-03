Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C793EC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955912051A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747625;
	bh=V67d985jCKm5fPRVRf9nl7XWuWBHPQXZixIhQw/nxHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gZIRu6wcmiQhQMkhJ2cPfkMoRkm4DDEbojx1M/7OxJ42+88/Zsn03tIC+DxFryzbF
	 JKjQj3Y7b2wz7ht5KtvTq+KsH/JcxIgyNFjRyR3MlynQH8cJb90HDnVmKnX2tUTpiJ
	 EE0CQjxoVzDn5S8y+gpJ8zsthJ8Y/qEW1comLb4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbgBCQdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:33:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730161AbgBCQdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:33:38 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9CD72051A;
        Mon,  3 Feb 2020 16:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747618;
        bh=V67d985jCKm5fPRVRf9nl7XWuWBHPQXZixIhQw/nxHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YmfcO2UzJ+5DIqnp04YG4iZEHlAM7XUmK03uctZfj4vrWDi2hcBwTxVp4xYYXTaur
         QGdnaXdd0RJptkdmcid7KGlstYsO+L3wX1b1/ub2qt87bv54kZVlzUW6FSoeq2MHnz
         9SqHpW73vVjkxnhSjuCkcy/YNnIwibDIv8Azfpp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 69/70] l2t_seq_next should increase position index
Date:   Mon,  3 Feb 2020 16:20:21 +0000
Message-Id: <20200203161922.032186269@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit 66018a102f7756cf72db4d2704e1b93969d9d332 ]

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/l2t.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/l2t.c b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
index 301c4df8a5664..986277744611c 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/l2t.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
@@ -683,8 +683,7 @@ static void *l2t_seq_start(struct seq_file *seq, loff_t *pos)
 static void *l2t_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	v = l2t_get_idx(seq, *pos);
-	if (v)
-		++*pos;
+	++(*pos);
 	return v;
 }
 
-- 
2.20.1



