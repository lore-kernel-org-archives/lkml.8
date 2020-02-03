Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4F8C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E1A21582
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747990;
	bh=ATu7mnQ7kjwkEutz/nZqrsLZmfziIVGeD0WmcPB723g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vO0R/xZTKMzikNBqjPVnHU1R9/wJu+lHe5tgDs4sptkWRJ4R7XCz2Y8yHOuhaBhFe
	 N749q9LO5bp3+Q4oJ9djx/eJNl2V2K6Sa3tWZlaNB9AxQjMI4IW19VhLZ3ljH7wdnX
	 1smA/NkkHxqIF5WgxaKk9QmTz0rQ1CCw3Ts6NRCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbgBCQhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:37:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731292AbgBCQhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:37:10 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C78CB20721;
        Mon,  3 Feb 2020 16:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747830;
        bh=ATu7mnQ7kjwkEutz/nZqrsLZmfziIVGeD0WmcPB723g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/wajTEcE36aVR9kGe2cTvIo1RLNgR9pTx5heyADEHBKZP3bDTpWftSEpLQP5w6e3
         JRDYIKLEfXP95gx+E40WoohP8RQIDNaLU1wHGPRt+iO3rE/V2nocKZHi2FVZKisZPE
         71/pnqzPPAVpRA7RJqiYqPJH0ZeOEvFvBHkLLkvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 87/90] l2t_seq_next should increase position index
Date:   Mon,  3 Feb 2020 16:20:30 +0000
Message-Id: <20200203161927.644506604@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
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
index 1a407d3c1d67c..e6fe2870137b0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/l2t.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
@@ -682,8 +682,7 @@ static void *l2t_seq_start(struct seq_file *seq, loff_t *pos)
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



