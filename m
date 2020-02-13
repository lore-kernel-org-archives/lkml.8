Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3582C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83F1222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609644;
	bh=m/bLRG+UoslbykTm7ozMjTlv5evEoNHvc/Ki2HNJmFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MGTWNOZ1snu/h5N6gXvU0Cs6sHzYAdBGDnfqvE4aoul4+IGrOHhb9MST58C/1uYKm
	 JqyOQX9562jl86rIfypi8Tw4w75NEuPoH0jPLNoaE6NPTzRGDO6adQPBOcfkfXkMCR
	 y2uG4hhvgSkDDzH1B9qe3b8GuKjocUx6kPrSHkZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgBMQAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:00:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbgBMPYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:45 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9A34246AD;
        Thu, 13 Feb 2020 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607484;
        bh=m/bLRG+UoslbykTm7ozMjTlv5evEoNHvc/Ki2HNJmFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fdu3nlar1yC9u/OKn5h2nZdwz0GMyA+cYLtepUnKwKyUBTa3Be4MXtL+rjoO7ap7G
         wEZ2lie39bGRhC0WZAMJ08jkqVebvZZUXTjrh7mxA8HIxbux/KuJAu/VSCWD+T7yTF
         iZjCf0OekcTfrqE14e0qAUZfmpqMTYMhdSa5RnB4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.14 014/173] tcp: clear tp->data_segs{in|out} in tcp_disconnect()
Date:   Thu, 13 Feb 2020 07:18:37 -0800
Message-Id: <20200213151936.391802729@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
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
@@ -2381,6 +2381,8 @@ int tcp_disconnect(struct sock *sk, int
 	tcp_saved_syn_free(tp);
 	tp->bytes_acked = 0;
 	tp->bytes_received = 0;
+	tp->data_segs_in = 0;
+	tp->data_segs_out = 0;
 
 	/* Clean up fastopen related fields */
 	tcp_free_fastopen_req(tp);


