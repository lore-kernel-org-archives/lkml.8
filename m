Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EB1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9918F22D3E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678271;
	bh=BJjDYJYE346Ldmp46iR+ZohEp0FtQWmXQUaNUBXvTms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pKdcD8Prvb4W3EQCdCoN1Np/hBv/36a0x+d65v8iXj39y+vLxe0b3BmEs88457WgC
	 jvJiqB1ooBoLsv3wpgSnIB0oZb4ruRB6W98RKLMRrqasQtndcUdtSn95iZjRvoqpu2
	 Q2e60upKcpUgT7RC/f+Utwy1WLdzhaOwFGbUdrV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgHQPbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbgHQP2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:28:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC46623CD5;
        Mon, 17 Aug 2020 15:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678127;
        bh=BJjDYJYE346Ldmp46iR+ZohEp0FtQWmXQUaNUBXvTms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Itc5Y83DmZ0sNyvYzKjhjnGXzl2J1QW76iHZlQgSxvfX4rVofxjo58jQwtMAIT8cC
         zpVhEKAkMIUJtdN/iuPUx/Snd7hluSGRs0LM73ebyJK40aa50uT0Zc6j4Nm7qcp4w/
         7wBk3hxuez3zjOgKPn+n2gcU6o8RJoKievuirC0c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 228/464] bpfilter: Initialize pos variable
Date:   Mon, 17 Aug 2020 17:13:01 +0200
Message-Id: <20200817143844.721217491@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit a4fa458950b40d3849946daa32466392811a3716 ]

Make sure 'pos' is initialized to zero before calling kernel_write().

Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bpfilter/bpfilter_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 4494ea6056cdb..42b88a92afe95 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -50,6 +50,7 @@ static int __bpfilter_process_sockopt(struct sock *sk, int optname,
 	req.len = optlen;
 	if (!bpfilter_ops.info.pid)
 		goto out;
+	pos = 0;
 	n = kernel_write(bpfilter_ops.info.pipe_to_umh, &req, sizeof(req),
 			   &pos);
 	if (n != sizeof(req)) {
-- 
2.25.1



