Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989C6C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8072063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759449;
	bh=XH7uTBcyzXV4kA3f7gcqFz4C7CleSNZ0spz90N7qeV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e24s9iCbqrQIxzAOFPU2i7nHdSsy1BjVZzLd++tfsHzEEyGOuZgPpenew4++fpvnU
	 GNdBmOrjTuTZZO7pkAiZs2QUQb6rvN29FmCxN6orXfv4KFqjI/7tOXGOBRnODDMGxS
	 PsQO2XISCluO3KAjzrB8wBcerz+wQ2nyLIO8hSjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388397AbgDAQoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389679AbgDAQoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:44:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B8DD20658;
        Wed,  1 Apr 2020 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759443;
        bh=XH7uTBcyzXV4kA3f7gcqFz4C7CleSNZ0spz90N7qeV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S40dy2WY6G/Tji1OjwC/P7bHUA90klR713hMP/U4l+5dhCPLSAp/3E2s1K1aEATE7
         n9bHZd/AVoy6SmzmRwaFpHIuaWjtPt2UNPcc/pHper5xIooLN8kftcNFpw5Q5n434E
         qpbRv0jgXA4WZ3x23iZ5C5db8LTPGHPTsIhUX+RI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anthony Mallet <anthony.mallet@laas.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 041/148] USB: cdc-acm: fix rounding error in TIOCSSERIAL
Date:   Wed,  1 Apr 2020 18:17:13 +0200
Message-Id: <20200401161556.761117969@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anthony Mallet <anthony.mallet@laas.fr>

[ Upstream commit b401f8c4f492cbf74f3f59c9141e5be3071071bb ]

By default, tty_port_init() initializes those parameters to a multiple
of HZ. For instance in line 69 of tty_port.c:
   port->close_delay = (50 * HZ) / 100;
https://github.com/torvalds/linux/blob/master/drivers/tty/tty_port.c#L69

With e.g. CONFIG_HZ = 250 (as this is the case for Ubuntu 18.04
linux-image-4.15.0-37-generic), the default setting for close_delay is
thus 125.

When ioctl(fd, TIOCGSERIAL, &s) is executed, the setting returned in
user space is '12' (125/10). When ioctl(fd, TIOCSSERIAL, &s) is then
executed with the same setting '12', the value is interpreted as '120'
which is different from the current setting and a EPERM error may be
raised by set_serial_info() if !CAP_SYS_ADMIN.
https://github.com/torvalds/linux/blob/master/drivers/usb/class/cdc-acm.c#L919

Fixes: ba2d8ce9db0a6 ("cdc-acm: implement TIOCSSERIAL to avoid blocking close(2)")
Signed-off-by: Anthony Mallet <anthony.mallet@laas.fr>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200312133101.7096-2-anthony.mallet@laas.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 74d0a91e84273..30a124b74d459 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -942,6 +942,7 @@ static int set_serial_info(struct acm *acm,
 {
 	struct serial_struct new_serial;
 	unsigned int closing_wait, close_delay;
+	unsigned int old_closing_wait, old_close_delay;
 	int retval = 0;
 
 	if (copy_from_user(&new_serial, newinfo, sizeof(new_serial)))
@@ -952,18 +953,24 @@ static int set_serial_info(struct acm *acm,
 			ASYNC_CLOSING_WAIT_NONE :
 			msecs_to_jiffies(new_serial.closing_wait * 10);
 
+	/* we must redo the rounding here, so that the values match */
+	old_close_delay	= jiffies_to_msecs(acm->port.close_delay) / 10;
+	old_closing_wait = acm->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
+				ASYNC_CLOSING_WAIT_NONE :
+				jiffies_to_msecs(acm->port.closing_wait) / 10;
+
 	mutex_lock(&acm->port.mutex);
 
-	if (!capable(CAP_SYS_ADMIN)) {
-		if ((close_delay != acm->port.close_delay) ||
-		    (closing_wait != acm->port.closing_wait))
+	if ((new_serial.close_delay != old_close_delay) ||
+            (new_serial.closing_wait != old_closing_wait)) {
+		if (!capable(CAP_SYS_ADMIN))
 			retval = -EPERM;
-		else
-			retval = -EOPNOTSUPP;
-	} else {
-		acm->port.close_delay  = close_delay;
-		acm->port.closing_wait = closing_wait;
-	}
+		else {
+			acm->port.close_delay  = close_delay;
+			acm->port.closing_wait = closing_wait;
+		}
+	} else
+		retval = -EOPNOTSUPP;
 
 	mutex_unlock(&acm->port.mutex);
 	return retval;
-- 
2.20.1



