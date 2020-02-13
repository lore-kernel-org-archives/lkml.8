Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4C2C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB1420656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581610060;
	bh=CQAKHV4BSCeYRbHKraTgN5W6h0RTdtGu3oa9fkRWODY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vp/yeYvx/KMAZRjkvl3OSgVndK/yMUUFkwlbGyMmiBm9GKbZLn2QRMHYlKtHntyHr
	 eYADxdjv0+jAOby33mxErhtKPUca24apyqQ8ULrIP7MT2vyxLa+VffNEO7rFq6QRrS
	 wYzc2fJvIickE+6LWkjyedHvF6RqQWwfvBoICfac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbgBMQHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:07:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbgBMPXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:19 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AA7C246AD;
        Thu, 13 Feb 2020 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607399;
        bh=CQAKHV4BSCeYRbHKraTgN5W6h0RTdtGu3oa9fkRWODY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YA7C0xZom4ucwVQm01Qq6XQD7l9v5S57dz1stv1nhdzdShmUTW0IZYq0+S8SzmVxn
         lj8Hutz1E1NsrRnaT8cjvwytqjdGnkx4Qc6gj+wo/D93iC7mJ3INoOEpN4GCnOUQIV
         esZzL90WiSydS/UdkGA7w0oHCsDHWlplpjguACoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.9 014/116] tcp: clear tp->segs_{in|out} in tcp_disconnect()
Date:   Thu, 13 Feb 2020 07:19:18 -0800
Message-Id: <20200213151848.383376921@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 784f8344de750a41344f4bbbebb8507a730fc99c ]

tp->segs_in and tp->segs_out need to be cleared in tcp_disconnect().

tcp_disconnect() is rarely used, but it is worth fixing it.

Fixes: 2efd055c53c0 ("tcp: add tcpi_segs_in and tcpi_segs_out to tcp_info")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Marcelo Ricardo Leitner <mleitner@redhat.com>
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
@@ -2314,6 +2314,8 @@ int tcp_disconnect(struct sock *sk, int
 	dst_release(sk->sk_rx_dst);
 	sk->sk_rx_dst = NULL;
 	tcp_saved_syn_free(tp);
+	tp->segs_in = 0;
+	tp->segs_out = 0;
 	tp->bytes_acked = 0;
 	tp->bytes_received = 0;
 	tp->data_segs_in = 0;


