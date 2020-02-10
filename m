Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66760C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F542070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341849;
	bh=F4AfoG+UT0oFK6SmvLrrn1HbOnp8qiEbFk9g7UvFoLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tYvrAk3ryvX3hr/hNZqr+TBm26majqWpxmSTLjvcb9BtrWBR5D6ihV/oJW/hZ60uk
	 f9fFQmb188dDbD3xR8NEdNWFszoDCwYOmMpNiFIVQ4n+7p1YBOblRQLpWysbM6aXEZ
	 d08UxApMynCmuLsFlyed9KzEtUi7DdL3LhU+mAOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbgBJNh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:37:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbgBJMfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:02 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 800D8208C4;
        Mon, 10 Feb 2020 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338102;
        bh=F4AfoG+UT0oFK6SmvLrrn1HbOnp8qiEbFk9g7UvFoLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jr5rRbz/4SBK0R9yLCfPbs9dXMJ5BnnC8BTpvitsxBRaAs5rmFNlU6neL12Ck5Yq7
         rvM5OIZ0x2FP8GtKQ5aBrTi8qmcQXEt7nr7gZ5fbi3pd8epejfp1SzMouxsUv1L7cB
         FUmQb/hn54KL4JZP3xDQmQoSThc2PNisOlCsb95E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19 020/195] tcp: clear tp->data_segs{in|out} in tcp_disconnect()
Date:   Mon, 10 Feb 2020 04:31:18 -0800
Message-Id: <20200210122307.843883179@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit db7ffee6f3eb3683cdcaeddecc0a630a14546fe3 ]

tp->data_segs_in and tp->data_segs_out need to be cleared
in tcp_disconnect().

tcp_disconnect() is rarely used, but it is worth fixing it.

Fixes: a44d6eacdaf5 ("tcp: Add RFC4898 tcpEStatsPerfDataSegsOut/In")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2609,6 +2609,8 @@ int tcp_disconnect(struct sock *sk, int
 	tp->bytes_acked = 0;
 	tp->bytes_received = 0;
 	tp->bytes_retrans = 0;
+	tp->data_segs_in = 0;
+	tp->data_segs_out = 0;
 	tp->dsack_dups = 0;
 	tp->reord_seen = 0;
 


