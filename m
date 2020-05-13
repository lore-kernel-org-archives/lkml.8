Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B259C2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4D023128
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363644;
	bh=2//70JfgGrfyqpGrlGdGZMeHpKH1PrGxXfJ48VpBiDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AbNFlhZWil9r0460qI9FxhQoksbEs0AyCJ9doCzyK56exFfyDiRC5eRuGhzBKPkN8
	 q3WLqY0Q8frEasoqtctcjSRrCrEVt5+oM+Vm/S2PKg7C98YegIQjcJS5h1JwSLla9I
	 0BRDDVpOgvAu9jj+8Pbi0L+rEH4NbMj+VOqtN4gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbgEMJyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388034AbgEMJx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:53:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F1C320740;
        Wed, 13 May 2020 09:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363639;
        bh=2//70JfgGrfyqpGrlGdGZMeHpKH1PrGxXfJ48VpBiDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVha7ldfcWQuzWuLMJIQqieFkAeZDfnvrtGoqNNLe6LkkEKBUKy5D1sjC1RJTHJ6O
         ErFl7DZ/zUOpZ7Cv7lzQUwkSXhveVPiM3XW8Quvriy3CDsGMFzxVx/XdnuG4z6gLV+
         nLXg2VBWUXs8fjiEhS/aejsKX/KQiXO6QPtLU00E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 028/118] net_sched: sch_skbprio: add message validation to skbprio_change()
Date:   Wed, 13 May 2020 11:44:07 +0200
Message-Id: <20200513094420.067636995@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 2761121af87de45951989a0adada917837d8fa82 ]

Do not assume the attribute has the right size.

Fixes: aea5f654e6b7 ("net/sched: add skbprio scheduler")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_skbprio.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/sched/sch_skbprio.c
+++ b/net/sched/sch_skbprio.c
@@ -169,6 +169,9 @@ static int skbprio_change(struct Qdisc *
 {
 	struct tc_skbprio_qopt *ctl = nla_data(opt);
 
+	if (opt->nla_len != nla_attr_size(sizeof(*ctl)))
+		return -EINVAL;
+
 	sch->limit = ctl->limit;
 	return 0;
 }


