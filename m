Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F4DCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4E820753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363379;
	bh=FhvBPJNLASY6lwiZHMtDLrA+Rzd1BcGIVp+X4GlC4p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AmLGmyQuopW3v7ZgQ+st7pW4dwTnQZ2bZLm/94w8apmuMSWJ2fxLUFOEc6UTYCb5N
	 xgjDGmR9NqBeoZcz8ushcobRZjbLSpgK470/JvAXtaDlHjAHnNHk2v06XpCjPgb/cR
	 Fh9k78dPNierVoXxqY/VCYZNsiJO1Jof1dp4vlok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733276AbgEMJti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733257AbgEMJtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:49:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E99D2493D;
        Wed, 13 May 2020 09:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363373;
        bh=FhvBPJNLASY6lwiZHMtDLrA+Rzd1BcGIVp+X4GlC4p0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzLpNXU++sYv/c6nMThx5zsFZVGns2UId/JfwbJTINgJAQEVWqLykAwQHNNNg6FPt
         78rri4ATXW92XpQLNqaQWCNNurBMdL1NF5q+0wgosM5YFJ4oc68yXVWPir3rX5xDwP
         5g94uZt1KH+g53o0m3OzdBZqGKsUqRwITXmQLE8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Johan Hovold <johan@kernel.org>,
        syzbot+d29e9263e13ce0b9f4fd@syzkaller.appspotmail.com
Subject: [PATCH 5.4 48/90] USB: serial: garmin_gps: add sanity checking for data length
Date:   Wed, 13 May 2020 11:44:44 +0200
Message-Id: <20200513094413.913962011@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094408.810028856@linuxfoundation.org>
References: <20200513094408.810028856@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit e9b3c610a05c1cdf8e959a6d89c38807ff758ee6 upstream.

We must not process packets shorter than a packet ID

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reported-and-tested-by: syzbot+d29e9263e13ce0b9f4fd@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/garmin_gps.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -1138,8 +1138,8 @@ static void garmin_read_process(struct g
 		   send it directly to the tty port */
 		if (garmin_data_p->flags & FLAGS_QUEUING) {
 			pkt_add(garmin_data_p, data, data_length);
-		} else if (bulk_data ||
-			   getLayerId(data) == GARMIN_LAYERID_APPL) {
+		} else if (bulk_data || (data_length >= sizeof(u32) &&
+				getLayerId(data) == GARMIN_LAYERID_APPL)) {
 
 			spin_lock_irqsave(&garmin_data_p->lock, flags);
 			garmin_data_p->flags |= APP_RESP_SEEN;


