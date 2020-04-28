Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A9BC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A482420BED
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098511;
	bh=kVEuf2gaxCNZnPQLaEEHOFcGlNG9hxk+Tp1dBik2BeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ty/TlcSKHdndwb64jLMMxiDyk/IiUZCfBHn90u0I2rCaeFetHhAd+Dhue0OebUiSU
	 h17lTeU2S418QRhakkzs34jf/gZnvWX4BdMdhB6XJLZhMS/Y+wKmOZ7OezpA0udY/T
	 fMLCCqQcO71SPIBf4kt8EOvl9j41SLoYQtvgEAjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgD1S2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729153AbgD1S2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:28:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41A20208E0;
        Tue, 28 Apr 2020 18:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098492;
        bh=kVEuf2gaxCNZnPQLaEEHOFcGlNG9hxk+Tp1dBik2BeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jwkkf9r72Pv1C894XPAjeDRpMDdYfXIxeowen0QPc5m5NqJ0DAtUE++Q7TiEJX+1r
         JgzfX7fOMZzVdo1C9+SBSsYrc9oXjY5ZZBnI2V+640ldyV7Ty55xAAhVYp23jALZ+f
         C8HZs1I2N7A61nJ95S78ukjQ+P6ARRPnIdECT8Bw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 060/167] tcp: cache line align MAX_TCP_HEADER
Date:   Tue, 28 Apr 2020 20:23:56 +0200
Message-Id: <20200428182232.559466988@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9bacd256f1354883d3c1402655153367982bba49 ]

TCP stack is dumb in how it cooks its output packets.

Depending on MAX_HEADER value, we might chose a bad ending point
for the headers.

If we align the end of TCP headers to cache line boundary, we
make sure to always use the smallest number of cache lines,
which always help.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -51,7 +51,7 @@ extern struct inet_hashinfo tcp_hashinfo
 extern struct percpu_counter tcp_orphan_count;
 void tcp_time_wait(struct sock *sk, int state, int timeo);
 
-#define MAX_TCP_HEADER	(128 + MAX_HEADER)
+#define MAX_TCP_HEADER	L1_CACHE_ALIGN(128 + MAX_HEADER)
 #define MAX_TCP_OPTION_SPACE 40
 #define TCP_MIN_SND_MSS		48
 #define TCP_MIN_GSO_SIZE	(TCP_MIN_SND_MSS - MAX_TCP_OPTION_SPACE)


