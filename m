Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15737C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BC12082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341226;
	bh=5v64RglUFJuc4nM31dOBXF0JdWrVYkV3eh4KqTNworA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=12xTbVhenRzyzkh1GhU5gw0pcgszzy8+RDYBpgECL5YGnTZ+QI5+E3Fpu2VR4JhC1
	 wFg8QkxQ/n0CUVQidSOzs6UtsAntj9LXc97rOR62hV/8cnJI2yJPRWQ0YzLH1f/kd+
	 csvJowpI7aHRhI2AvSl7XUSdDE0iTjwSUp72imis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbgBJN1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:27:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgBJMgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:40 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F61220838;
        Mon, 10 Feb 2020 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338199;
        bh=5v64RglUFJuc4nM31dOBXF0JdWrVYkV3eh4KqTNworA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcWq1jnWrtKxn+hH8G2NpKjdiOJZUablKbkIl64PVXmL7VfKI+/U/tCcKuTZYo7G7
         JWxG2YiMg+H8oNVwCygcAjKCcviE4bZfgH2Fv11zLEOomhG0wBC/LR4sml4VkVkdrY
         z1HJh5wCKNpDkdHbN2JUk4H7u0oyPihxMTkh8pto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        SeongJae Park <sjpark@amazon.de>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 014/309] tcp: clear tp->total_retrans in tcp_disconnect()
Date:   Mon, 10 Feb 2020 04:29:30 -0800
Message-Id: <20200210122407.370933714@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit c13c48c00a6bc1febc73902505bdec0967bd7095 ]

total_retrans needs to be cleared in tcp_disconnect().

tcp_disconnect() is rarely used, but it is worth fixing it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2622,6 +2622,7 @@ int tcp_disconnect(struct sock *sk, int
 	tcp_set_ca_state(sk, TCP_CA_Open);
 	tp->is_sack_reneg = 0;
 	tcp_clear_retrans(tp);
+	tp->total_retrans = 0;
 	inet_csk_delack_init(sk);
 	/* Initialize rcv_mss to TCP_MIN_MSS to avoid division by 0
 	 * issue in __tcp_select_window()


