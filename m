Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F45C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4D022B4D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597924961;
	bh=ILJ+X5dFj1WuZtMu5nk3WiTKNOR+oCEncXTbKxKz0t8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hzRBVgYHrOWY0IjyrvsFjPhsuuFjmgC6xOZeTgzZgkgmhRAR997Weh6OM/CPyjTTG
	 vvFFloy7/tniH32aX1a/DFgWBUmwcO98c5nV1BJMeR2m6qN0aM2Wg+u3QwcAbYPAJt
	 EJVQT3apLI9m9pCuQjTCI1uCj/4jyTkb2+VQmzLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgHTMCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730187AbgHTJ7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:59:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D040D207FB;
        Thu, 20 Aug 2020 09:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917591;
        bh=ILJ+X5dFj1WuZtMu5nk3WiTKNOR+oCEncXTbKxKz0t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RH4ONhXoo+758v7PKEphajBJIOHbfWhwGRjwtACrhqqM4E5WStSx7QHbQqELxK4Ea
         tj1y7sEWgR7ookREIRntRng4TtMQl9a6vAxIeiWtGV3Epje4NYDHMRtvNp2ZjgfomZ
         PAU2wFbxnhp2RIuJcUGfds7c24GlU1mZ1InG61KY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finn Thain <fthain@telegraphics.com.au>,
        Stan Johnson <userm57@yahoo.com>,
        Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 085/212] m68k: mac: Dont send IOP message until channel is idle
Date:   Thu, 20 Aug 2020 11:20:58 +0200
Message-Id: <20200820091606.650815922@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit aeb445bf2194d83e12e85bf5c65baaf1f093bd8f ]

In the following sequence of calls, iop_do_send() gets called when the
"send" channel is not in the IOP_MSG_IDLE state:

	iop_ism_irq()
		iop_handle_send()
			(msg->handler)()
				iop_send_message()
			iop_do_send()

Avoid this by testing the channel state before calling iop_do_send().

When sending, and iop_send_queue is empty, call iop_do_send() because
the channel is idle. If iop_send_queue is not empty, iop_do_send() will
get called later by iop_handle_send().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
Cc: Joshua Thompson <funaho@jurai.org>
Link: https://lore.kernel.org/r/6d667c39e53865661fa5a48f16829d18ed8abe54.1590880333.git.fthain@telegraphics.com.au
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/mac/iop.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index 7990b6f50105b..8209a74fbdebc 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -416,7 +416,8 @@ static void iop_handle_send(uint iop_num, uint chan)
 	iop_free_msg(msg2);
 
 	iop_send_queue[iop_num][chan] = msg;
-	if (msg) iop_do_send(msg);
+	if (msg && iop_readb(iop, IOP_ADDR_SEND_STATE + chan) == IOP_MSG_IDLE)
+		iop_do_send(msg);
 }
 
 /*
@@ -497,16 +498,12 @@ int iop_send_message(uint iop_num, uint chan, void *privdata,
 
 	if (!(q = iop_send_queue[iop_num][chan])) {
 		iop_send_queue[iop_num][chan] = msg;
+		iop_do_send(msg);
 	} else {
 		while (q->next) q = q->next;
 		q->next = msg;
 	}
 
-	if (iop_readb(iop_base[iop_num],
-	    IOP_ADDR_SEND_STATE + chan) == IOP_MSG_IDLE) {
-		iop_do_send(msg);
-	}
-
 	return 0;
 }
 
-- 
2.25.1



