Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D994EC52D2C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4EF2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811832;
	bh=pXbwtN89kYs1KMrU1Tv0AS/tssTUWXAUQ6qzW3DQbXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=syn8vfeJTyzO5iGOM1E/suHNVOh6lGI/+pzFFGEkVObavmgHOVRk+XSY0rdq5JHEb
	 +HDvUA4luNyx7Uc4m6owp4hfD2ikdtIzJxSoKUyA7vk20Bnau52AlFPxbOFpV9kug7
	 Q+x/TOgob88Xwbss+daHgvs2CDb7BKto7cxyZnmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgB0N5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:57:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731515AbgB0N5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:57:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A9D20801;
        Thu, 27 Feb 2020 13:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811819;
        bh=pXbwtN89kYs1KMrU1Tv0AS/tssTUWXAUQ6qzW3DQbXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SN3fxBPpojGaDofaRfEMym6B59oAopjM8qhe8Emxpeaj7yDmnxLCpze4CVDCHmD59
         F3HCTUrpwR1YZvlmv36SHTce0QvADuPersqWMxHoy2KBlf5eNMtzH1I79ik0dsePt0
         xS7gagJ0S9cMRXe30OU2ic8hR7svvfRMPXfMtGvg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 111/237] tty: synclinkmp: Adjust indentation in several functions
Date:   Thu, 27 Feb 2020 14:35:25 +0100
Message-Id: <20200227132305.054909944@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 1feedf61e7265128244f6993f23421f33dd93dbc ]

Clang warns:

../drivers/tty/synclinkmp.c:1456:3: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
        if (C_CRTSCTS(tty)) {
        ^
../drivers/tty/synclinkmp.c:1453:2: note: previous statement is here
        if (I_IXOFF(tty))
        ^
../drivers/tty/synclinkmp.c:2473:8: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
                                                info->port.tty->hw_stopped = 0;
                                                ^
../drivers/tty/synclinkmp.c:2471:7: note: previous statement is here
                                                if ( debug_level >= DEBUG_LEVEL_ISR )
                                                ^
../drivers/tty/synclinkmp.c:2482:8: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
                                                info->port.tty->hw_stopped = 1;
                                                ^
../drivers/tty/synclinkmp.c:2480:7: note: previous statement is here
                                                if ( debug_level >= DEBUG_LEVEL_ISR )
                                                ^
../drivers/tty/synclinkmp.c:2809:3: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
        if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
        ^
../drivers/tty/synclinkmp.c:2807:2: note: previous statement is here
        if (I_INPCK(info->port.tty))
        ^
../drivers/tty/synclinkmp.c:3246:3: warning: misleading indentation;
statement is not part of the previous 'else' [-Wmisleading-indentation]
        set_signals(info);
        ^
../drivers/tty/synclinkmp.c:3244:2: note: previous statement is here
        else
        ^
5 warnings generated.

The indentation on these lines is not at all consistent, tabs and spaces
are mixed together. Convert to just using tabs to be consistent with the
Linux kernel coding style and eliminate these warnings from clang.

Link: https://github.com/ClangBuiltLinux/linux/issues/823
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://lore.kernel.org/r/20191218024720.3528-1-natechancellor@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/synclinkmp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 4fed9e7b281f0..3c9e314406b4e 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -1467,10 +1467,10 @@ static void throttle(struct tty_struct * tty)
 	if (I_IXOFF(tty))
 		send_xchar(tty, STOP_CHAR(tty));
 
- 	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(tty)) {
 		spin_lock_irqsave(&info->lock,flags);
 		info->serial_signals &= ~SerialSignal_RTS;
-	 	set_signals(info);
+		set_signals(info);
 		spin_unlock_irqrestore(&info->lock,flags);
 	}
 }
@@ -1496,10 +1496,10 @@ static void unthrottle(struct tty_struct * tty)
 			send_xchar(tty, START_CHAR(tty));
 	}
 
- 	if (C_CRTSCTS(tty)) {
+	if (C_CRTSCTS(tty)) {
 		spin_lock_irqsave(&info->lock,flags);
 		info->serial_signals |= SerialSignal_RTS;
-	 	set_signals(info);
+		set_signals(info);
 		spin_unlock_irqrestore(&info->lock,flags);
 	}
 }
@@ -2484,7 +2484,7 @@ static void isr_io_pin( SLMP_INFO *info, u16 status )
 					if (status & SerialSignal_CTS) {
 						if ( debug_level >= DEBUG_LEVEL_ISR )
 							printk("CTS tx start...");
-			 			info->port.tty->hw_stopped = 0;
+						info->port.tty->hw_stopped = 0;
 						tx_start(info);
 						info->pending_bh |= BH_TRANSMIT;
 						return;
@@ -2493,7 +2493,7 @@ static void isr_io_pin( SLMP_INFO *info, u16 status )
 					if (!(status & SerialSignal_CTS)) {
 						if ( debug_level >= DEBUG_LEVEL_ISR )
 							printk("CTS tx stop...");
-			 			info->port.tty->hw_stopped = 1;
+						info->port.tty->hw_stopped = 1;
 						tx_stop(info);
 					}
 				}
@@ -2820,8 +2820,8 @@ static void change_params(SLMP_INFO *info)
 	info->read_status_mask2 = OVRN;
 	if (I_INPCK(info->port.tty))
 		info->read_status_mask2 |= PE | FRME;
- 	if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
- 		info->read_status_mask1 |= BRKD;
+	if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
+		info->read_status_mask1 |= BRKD;
 	if (I_IGNPAR(info->port.tty))
 		info->ignore_status_mask2 |= PE | FRME;
 	if (I_IGNBRK(info->port.tty)) {
@@ -3191,7 +3191,7 @@ static int tiocmget(struct tty_struct *tty)
  	unsigned long flags;
 
 	spin_lock_irqsave(&info->lock,flags);
- 	get_signals(info);
+	get_signals(info);
 	spin_unlock_irqrestore(&info->lock,flags);
 
 	result = ((info->serial_signals & SerialSignal_RTS) ? TIOCM_RTS : 0) |
@@ -3229,7 +3229,7 @@ static int tiocmset(struct tty_struct *tty,
 		info->serial_signals &= ~SerialSignal_DTR;
 
 	spin_lock_irqsave(&info->lock,flags);
- 	set_signals(info);
+	set_signals(info);
 	spin_unlock_irqrestore(&info->lock,flags);
 
 	return 0;
@@ -3241,7 +3241,7 @@ static int carrier_raised(struct tty_port *port)
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->lock,flags);
- 	get_signals(info);
+	get_signals(info);
 	spin_unlock_irqrestore(&info->lock,flags);
 
 	return (info->serial_signals & SerialSignal_DCD) ? 1 : 0;
@@ -3257,7 +3257,7 @@ static void dtr_rts(struct tty_port *port, int on)
 		info->serial_signals |= SerialSignal_RTS | SerialSignal_DTR;
 	else
 		info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
- 	set_signals(info);
+	set_signals(info);
 	spin_unlock_irqrestore(&info->lock,flags);
 }
 
-- 
2.20.1



