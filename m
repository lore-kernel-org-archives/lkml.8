Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4309CC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3E221473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941996;
	bh=fPRyYirZGI46harqaBoy4ZXpVIopBJ/BGCpq1G7F0TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YTEb2QHYyvgWIS5c+Jrxn2ly4+t3RtJ2E5ShTM5gdsiEgA6oGUEWo/2bpDNkVncx2
	 kZv/Xxp8+cAnlNMNpTh9YvXwg3Dv7w1jbG4NBW3Oj+Jaxj9IRDdaWCnSAdGTXDxGV5
	 bq5YthbqKA1aEnRs9/MO1UEXinjfZj8uuKaoLKEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgEHMqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbgEHMq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:46:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ED1921473;
        Fri,  8 May 2020 12:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941988;
        bh=fPRyYirZGI46harqaBoy4ZXpVIopBJ/BGCpq1G7F0TE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0lli1VBU7tmdR+tHTQ96ZLyzoYadGXstNwchGacR2LxnivqVVNsrL4j6gdGXUakZA
         3ncmuj7rLuyn20H/udUCQhKW1odzVYvYHD7ldvJJSFW21rq04o/oneoJ+F4eBTRNF8
         U64LTI+lIFYQlNq5qZXlXYi8argTV0Di2w0vyuZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 252/312] net: bcmgenet: device stats are unsigned long
Date:   Fri,  8 May 2020 14:34:03 +0200
Message-Id: <20200508123142.135187266@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

commit 6517eb59b03965689e6bb16bb2d480096b3ef95d upstream.

On 64bit kernels, device stats are 64bit wide, not 32bit.

Fixes: 1c1008c793fa4 ("net: bcmgenet: add main driver file")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -927,7 +927,11 @@ static void bcmgenet_get_ethtool_stats(s
 		else
 			p = (char *)priv;
 		p += s->stat_offset;
-		data[i] = *(u32 *)p;
+		if (sizeof(unsigned long) != sizeof(u32) &&
+		    s->stat_sizeof == sizeof(unsigned long))
+			data[i] = *(unsigned long *)p;
+		else
+			data[i] = *(u32 *)p;
 	}
 }
 


