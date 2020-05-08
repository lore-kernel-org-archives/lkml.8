Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF0EC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1351F20870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943679;
	bh=oUncj4ZTgEbLMvRgVhyKKWVu5NsBh1svonvVs+5ViS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ycHAIqtgsuoin+uaX0xa8q3eWADPcAAyrK60ZywtJxuOGd5cJarFp/4NWwJuAZJRT
	 3P1/N1zricghDhzA7tpZydXpoJQLV2KE6P39hYhCSg0pTEQqnOgjvPULYaA9QpzdGt
	 6qungNFLtJONA6lILTbCRigafvEfQs1ANZQ13d68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbgEHNOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:14:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbgEHMq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:46:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16DF62145D;
        Fri,  8 May 2020 12:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942016;
        bh=oUncj4ZTgEbLMvRgVhyKKWVu5NsBh1svonvVs+5ViS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zCsZ0eTeTwrSyShLL4yoG1oq9FB5PGQ6mmon65LRZVXRkoGVlaRfzu0IB0ZLzU6+D
         736NB9/TkD3O/Vb/JhkWMziddnlCB1n7uvo7woycXBWDxmvshNiKNyYGxXExDaetDF
         bV6223GgWdKB10xkXGoh0ii4eSLZdkzzx3ZfnVdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Vlad Yasevich <vyasevic@redhat.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 262/312] macvtap: segmented packet is consumed
Date:   Fri,  8 May 2020 14:34:13 +0200
Message-Id: <20200508123142.851600982@linuxfoundation.org>
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

commit be0bd3160165e42783d8215f426e41c07179c08a upstream.

If GSO packet is segmented and its segments are properly queued,
we call consume_skb() instead of kfree_skb() to be drop monitor
friendly.

Fixes: 3e4f8b7873709 ("macvtap: Perform GSO on forwarding path.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vlad Yasevich <vyasevic@redhat.com>
Reviewed-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/macvtap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -373,7 +373,7 @@ static rx_handler_result_t macvtap_handl
 			goto wake_up;
 		}
 
-		kfree_skb(skb);
+		consume_skb(skb);
 		while (segs) {
 			struct sk_buff *nskb = segs->next;
 


