Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF03C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB556214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858461;
	bh=YZ4f4ks6O71W6NH+POUMPFFhchcU7/jfnUU11yW58IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uNmFb/5+RtYrYZF0jNv6613mhcQPYs8MVJ0kqsIW6fwIvLty7iubLQwYANCU8Kcps
	 J+gRIAj5qhQnCJFi4NRDNzhajMErAB2p2df7GldzykoFpL4WGLfkG0iFQo0yDLiTKI
	 1pA7TYarxETyZ/AW5IrIclok41MkJoZRtGvc9EL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbgAXJeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:34:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727520AbgAXJeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:34:18 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8058521556;
        Fri, 24 Jan 2020 09:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858458;
        bh=YZ4f4ks6O71W6NH+POUMPFFhchcU7/jfnUU11yW58IU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tY5vjMM85oR9j7ce1vYmJLxDN07rMuIwPSgrOFtv+VfWpChwGbpfzM+MX7CjA2BC7
         YpSCmeBr/Z2nHpG9KQJMLyDcbJT23qps37swwdjApmr2p0PYBZa4cgZguHXbJiIaZr
         H/y6oiFKUoIoyM4Uob+L4QEPmOPKZLY+jd8XY55w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        Hoang Le <hoang.h.le@dektech.com.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 023/102] tipc: reduce sensitive to retransmit failures
Date:   Fri, 24 Jan 2020 10:30:24 +0100
Message-Id: <20200124092809.645342452@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hoang Le <hoang.h.le@dektech.com.au>

commit 426071f1f3995d7e9603246bffdcbf344cd31719 upstream.

With huge cluster (e.g >200nodes), the amount of that flow:
gap -> retransmit packet -> acked will take time in case of STATE_MSG
dropped/delayed because a lot of traffic. This lead to 1.5 sec tolerance
value criteria made link easy failure around 2nd, 3rd of failed
retransmission attempts.

Instead of re-introduced criteria of 99 faled retransmissions to fix the
issue, we increase failure detection timer to ten times tolerance value.

Fixes: 77cf8edbc0e7 ("tipc: simplify stale link failure criteria")
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Hoang Le <hoang.h.le@dektech.com.au>
Acked-by: Jon
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/link.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1084,7 +1084,7 @@ static bool link_retransmit_failure(stru
 		return false;
 
 	if (!time_after(jiffies, TIPC_SKB_CB(skb)->retr_stamp +
-			msecs_to_jiffies(r->tolerance)))
+			msecs_to_jiffies(r->tolerance * 10)))
 		return false;
 
 	hdr = buf_msg(skb);


