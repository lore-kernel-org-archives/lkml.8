Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B97C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01BCD207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597925153;
	bh=Jcg2bOCFaxvQaQmqPtBJ/NnpJgFsRnFkdboU3XNsS4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1eZbnR6+ZOhgI2m+fVnwt/O78t6dyiX2U7ecIi0zWJm/SZ5SaJWWTe0zgL49rqmkc
	 ccqtAcLMLCfHCA7muJ5vcesfeLD89JdVGu2USqg2n3HAf2dDMj6MCDiCBxW4525fnB
	 yxLgcxxV3/D0QFxteR/NLj//lqFNKi5CYfPwK9Ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgHTMFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730344AbgHTJ64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:58:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78FA2207FB;
        Thu, 20 Aug 2020 09:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917536;
        bh=Jcg2bOCFaxvQaQmqPtBJ/NnpJgFsRnFkdboU3XNsS4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gp+IuFaofhtmEd6yDKCpbacDoVAtmfBLooeM1eA1KMeXZNNfARMJQt8teTqCIZBUB
         ZvDqOXyMwlqwe+8lAp9RNK3AkgmINaYI5gJSogT/Hu+7VFPUwtOZuHO3bA/h7NWrEb
         sYNHHH4+Q+wjq+2XvG1doV4W1xxt3E+HPSTF+4go=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 036/212] usb: hso: Fix debug compile warning on sparc32
Date:   Thu, 20 Aug 2020 11:20:09 +0200
Message-Id: <20200820091604.190926174@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert@linux-m68k.org>

[ Upstream commit e0484010ec05191a8edf980413fc92f28050c1cc ]

On sparc32, tcflag_t is "unsigned long", unlike on all other
architectures, where it is "unsigned int":

    drivers/net/usb/hso.c: In function ‘hso_serial_set_termios’:
    include/linux/kern_levels.h:5:18: warning: format ‘%d’ expects argument of type ‘unsigned int’, but argument 4 has type ‘tcflag_t {aka long unsigned int}’ [-Wformat=]
    drivers/net/usb/hso.c:1393:3: note: in expansion of macro ‘hso_dbg’
       hso_dbg(0x16, "Termios called with: cflags new[%d] - old[%d]\n",
       ^~~~~~~
    include/linux/kern_levels.h:5:18: warning: format ‘%d’ expects argument of type ‘unsigned int’, but argument 5 has type ‘tcflag_t {aka long unsigned int}’ [-Wformat=]
    drivers/net/usb/hso.c:1393:3: note: in expansion of macro ‘hso_dbg’
       hso_dbg(0x16, "Termios called with: cflags new[%d] - old[%d]\n",
       ^~~~~~~

As "unsigned long" is 32-bit on sparc32, fix this by casting all tcflag_t
parameters to "unsigned int".
While at it, use "%u" to format unsigned numbers.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/hso.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 27fc699d8be5b..2ae30db06bfa1 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -1404,8 +1404,9 @@ static void hso_serial_set_termios(struct tty_struct *tty, struct ktermios *old)
 	unsigned long flags;
 
 	if (old)
-		hso_dbg(0x16, "Termios called with: cflags new[%d] - old[%d]\n",
-			tty->termios.c_cflag, old->c_cflag);
+		hso_dbg(0x16, "Termios called with: cflags new[%u] - old[%u]\n",
+			(unsigned int)tty->termios.c_cflag,
+			(unsigned int)old->c_cflag);
 
 	/* the actual setup */
 	spin_lock_irqsave(&serial->serial_lock, flags);
-- 
2.25.1



