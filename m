Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A68C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616AA2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748177;
	bh=im9tKlJjWpmjonHKie/VgDdH2xKFXdRSI5C2ILY+XUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lTPpwFkgwHPywUwMiWFT3KbDbRhKnEFP0BSSFBPzMfXO834KC0u1uy9tx1JbJGOhz
	 KQ6GloyGMPbS27SM5XBhKJGsgGccs/1eBTLPh8nDBJxWnk25q4vWT40g/ZDqKtb5m4
	 kl9p2iUp4fvaWjniH4kkV5bRFkjDhkqK9dWudqEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgBCQdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730609AbgBCQde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:33:34 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F06C9217BA;
        Mon,  3 Feb 2020 16:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747613;
        bh=im9tKlJjWpmjonHKie/VgDdH2xKFXdRSI5C2ILY+XUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4LTxwbWnqFDs1RKgiD3YYESN5Og3BBPs0QNUdEs9hzhm8+ydMEu1plgBpfcTdDZD
         UfOfat09jt9qrn/NPZnpZOiJ9Ky+XbTnofWgLWv9Hh62dH5dthzathikahA+G5qqDK
         gKmkWr8RyhY9EFGLgsJW9gYxtpmuEmleNSpZlpCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 68/70] seq_tab_next() should increase position index
Date:   Mon,  3 Feb 2020 16:20:20 +0000
Message-Id: <20200203161921.921245897@linuxfoundation.org>
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
index d320e9afab880..4af6e6ffc5df2 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
@@ -70,8 +70,7 @@ static void *seq_tab_start(struct seq_file *seq, loff_t *pos)
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



