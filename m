Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59411C4345A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F5152177B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892270;
	bh=S6znPVZ89jcmyvwj57Su9erZ8HNhREGGkPYBHmEPk6I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wyFsjdowHi1hdbY0LWGj8E8bivVrirvCoKPqEuU1QANs3YTjIcTgD3dlu0EHRALpa
	 DrST7NE5W2Q8dVMmuHHLEUVbDX6/enOzQjlRjWcYKVintlGsnEnU+/DFolVGn7GStU
	 TQlbGaBYpDXvfGiEUFq3q3Yt+Bb1+YPtWqWefofc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgG0XY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbgG0XYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:24:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2CB020FC3;
        Mon, 27 Jul 2020 23:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892262;
        bh=S6znPVZ89jcmyvwj57Su9erZ8HNhREGGkPYBHmEPk6I=;
        h=From:To:Cc:Subject:Date:From;
        b=z0tg7w7tbn6ZDdnvaexGKXyH5e98tDyJJFPJPRJ1U+jtzSReStIbgcMl2mqjbqVJI
         BoLaIEghaIydf/U0DWhU6gxhXxwxahNesEjXhLhneC0YDsPjna/1GRm1tQD000WyjY
         049sl8PiE6hYoDmbS+qwi7a2LET+Wf/5+Blbu2rE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 01/17] usb: hso: Fix debug compile warning on sparc32
Date:   Mon, 27 Jul 2020 19:24:04 -0400
Message-Id: <20200727232420.717684-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
index 74849da031fab..66a8b835aa94c 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -1389,8 +1389,9 @@ static void hso_serial_set_termios(struct tty_struct *tty, struct ktermios *old)
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

