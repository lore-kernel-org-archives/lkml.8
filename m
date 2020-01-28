Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F70C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0D824685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220170;
	bh=UYePmV8CUdNFim5tIHubVgaS5KfCFYt1aT7JaIs8DwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fy4U9GilXDNDGDZbRp0QjyvOK4W1lm2rcgjh+qRIr88EePewWMmijbZfH5eclodRN
	 OSylWFo+iJmw2Ib1PxQSbH5YUOTJweIZ+agT3Z7gVlGY3cCAx2TaSoSeTTk/wwOR6K
	 W1T3wr37DLkG6VcE/3zdXfGzes9DFflu2u0bbDzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgA1OCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:02:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbgA1OCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:02:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE18F2468D;
        Tue, 28 Jan 2020 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220164;
        bh=UYePmV8CUdNFim5tIHubVgaS5KfCFYt1aT7JaIs8DwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJBlfvo0tlv+raspp27FnaRoZErjwJrrZPT52Ler72pPh+5IIkCDvSibD3J5555K5
         dFMULclQquJl+ZHtXsHpOonhqFLCS3k5ty7k54ZC5vTAx8U2EWBzWqtTKHAdpEQbDT
         n0MxN8ct3tW9vQqUdYUGpaPnZmnUvjAow8ontWP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+2f07903a5b05e7f36410@syzkaller.appspotmail.com,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+5af9a90dad568aa9f611@syzkaller.appspotmail.com
Subject: [PATCH 5.4 011/104] net_sched: fix datalen for ematch
Date:   Tue, 28 Jan 2020 14:59:32 +0100
Message-Id: <20200128135818.800068165@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 61678d28d4a45ef376f5d02a839cc37509ae9281 ]

syzbot reported an out-of-bound access in em_nbyte. As initially
analyzed by Eric, this is because em_nbyte sets its own em->datalen
in em_nbyte_change() other than the one specified by user, but this
value gets overwritten later by its caller tcf_em_validate().
We should leave em->datalen untouched to respect their choices.

I audit all the in-tree ematch users, all of those implement
->change() set em->datalen, so we can just avoid setting it twice
in this case.

Reported-and-tested-by: syzbot+5af9a90dad568aa9f611@syzkaller.appspotmail.com
Reported-by: syzbot+2f07903a5b05e7f36410@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/ematch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/ematch.c
+++ b/net/sched/ematch.c
@@ -263,12 +263,12 @@ static int tcf_em_validate(struct tcf_pr
 				}
 				em->data = (unsigned long) v;
 			}
+			em->datalen = data_len;
 		}
 	}
 
 	em->matchid = em_hdr->matchid;
 	em->flags = em_hdr->flags;
-	em->datalen = data_len;
 	em->net = net;
 
 	err = 0;


