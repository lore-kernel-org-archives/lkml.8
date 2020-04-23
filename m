Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A199DC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C9520780
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgDWXNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:13:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50064 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728501AbgDWXGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:06:51 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvY-0004mo-QQ; Fri, 24 Apr 2020 00:06:40 +0100
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvU-00E6vG-KR; Fri, 24 Apr 2020 00:06:36 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jiri Kosina" <jkosina@suse.cz>,
        "Fabian Henneke" <fabian.henneke@gmail.com>
Date:   Fri, 24 Apr 2020 00:06:36 +0100
Message-ID: <lsq.1587683028.201707401@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 169/245] hidraw: Return EPOLLOUT from hidraw_poll
In-Reply-To: <lsq.1587683027.831233700@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.83-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Fabian Henneke <fabian.henneke@gmail.com>

commit 378b80370aa1fe50f9c48a3ac8af3e416e73b89f upstream.

Always return EPOLLOUT from hidraw_poll when a device is connected.
This is safe since writes are always possible (but will always block).

hidraw does not support non-blocking writes and instead always calls
blocking backend functions on write requests. Hence, so far, a call to
poll never returned EPOLLOUT, which confuses tools like socat.

Signed-off-by: Fabian Henneke <fabian.henneke@gmail.com>
In-reply-to: <CA+hv5qkyis03CgYTWeWX9cr0my-d2Oe+aZo+mjmWRXgjrGqyrw@mail.gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
[bwh: Backported to 3.16: s/EPOLL/POLL/]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hid/hidraw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -265,7 +265,7 @@ static unsigned int hidraw_poll(struct f
 
 	poll_wait(file, &list->hidraw->wait, wait);
 	if (list->head != list->tail)
-		return POLLIN | POLLRDNORM;
+		return POLLIN | POLLRDNORM | POLLOUT;
 	if (!list->hidraw->exist)
 		return POLLERR | POLLHUP;
 	return 0;

