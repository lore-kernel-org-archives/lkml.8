Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF2FC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254E02070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340629;
	bh=hICHC4Ra948PVX+UTtiFr7xOs8L6FcENYfoPJ5wbrSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZvEVe1Eeu78jEZbFbqRIqA+K8HtT4BLfHPYQbDzLWbVoEKVaHEntYc4mXm+Tv8ThB
	 Qd1dr4kg7fArJePvQO5AEgwkzVhoJKucD8wa3vu7QMsZNQX52PwSLAJWsbYMhuZ90g
	 q1Rw4JbA+gE8UY9JfZleThGj1g9oQMbZ3QilT1jU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgBJMiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:38:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbgBJMgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:41 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 834C02173E;
        Mon, 10 Feb 2020 12:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338200;
        bh=hICHC4Ra948PVX+UTtiFr7xOs8L6FcENYfoPJ5wbrSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2m1ow/crqe4QsRn+B98h5PD34QtLb8ECtUxrMHZSoyVWNeaRZ3iK1Wkzkf3jjMGK/
         F/o70OTZzNT4ulQT32nbXOllio0gG0cCRCZZnI+YPQD+3RBv64RERwKMzn+Okcsxb1
         5lvX63slWCMpEmaoT1TY/n+M4sBFl/JSdA5p04QI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 016/309] tcp: clear tp->data_segs{in|out} in tcp_disconnect()
Date:   Mon, 10 Feb 2020 04:29:32 -0800
Message-Id: <20200210122407.567967949@linuxfoundation.org>
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
@@ -2639,6 +2639,8 @@ int tcp_disconnect(struct sock *sk, int
 	tp->bytes_acked = 0;
 	tp->bytes_received = 0;
 	tp->bytes_retrans = 0;
+	tp->data_segs_in = 0;
+	tp->data_segs_out = 0;
 	tp->duplicate_sack[0].start_seq = 0;
 	tp->duplicate_sack[0].end_seq = 0;
 	tp->dsack_dups = 0;


