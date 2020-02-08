Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2A5C35254
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADB320661
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgBHSew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 13:34:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34164 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727873AbgBHS3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 13:29:44 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1j0UrK-0003fR-1Q; Sat, 08 Feb 2020 18:29:38 +0000
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1j0UrJ-000CSF-Pk; Sat, 08 Feb 2020 18:29:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Marcel Holtmann" <marcel@holtmann.org>
Date:   Sat, 08 Feb 2020 18:20:45 +0000
Message-ID: <lsq.1581185940.488106583@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 106/148] Bluetooth: delete a stray unlock
In-Reply-To: <lsq.1581185939.857586636@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.82-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit df66499a1fab340c167250a5743931dc50d5f0fa upstream.

We used to take a lock in amp_physical_cfm() but then we moved it to
the caller function.  Unfortunately the unlock on this error path was
overlooked so it leads to a double unlock.

Fixes: a514b17fab51 ("Bluetooth: Refactor locking in amp_physical_cfm")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/bluetooth/l2cap_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4902,10 +4902,8 @@ void __l2cap_physical_cfm(struct l2cap_c
 	BT_DBG("chan %p, result %d, local_amp_id %d, remote_amp_id %d",
 	       chan, result, local_amp_id, remote_amp_id);
 
-	if (chan->state == BT_DISCONN || chan->state == BT_CLOSED) {
-		l2cap_chan_unlock(chan);
+	if (chan->state == BT_DISCONN || chan->state == BT_CLOSED)
 		return;
-	}
 
 	if (chan->state != BT_CONNECTED) {
 		l2cap_do_create(chan, result, local_amp_id, remote_amp_id);

