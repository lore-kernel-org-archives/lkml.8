Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F41CC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79B220575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099719;
	bh=glYgs9FgqC4xgBUSZin2yYaQha2n/GDDZawSkrR6aHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=olk5VbDoVRbnCA+3g70mCumFcvUpyUEHL7iUI7KpG2SuNHRVFN2gp3EAGb7Pv8IKD
	 FXS5aV9TKImwaWYs6Gj3wRHVpCsQisPRjnT4kk48Q+XEhbrtF2xSc9AbwQC2nn1SzX
	 DK0teonG82pCbO9GdSLQhGv1F4UzqV9KrHONvUWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbgD1Ssh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730830AbgD1Skw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:40:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45E7F2085B;
        Tue, 28 Apr 2020 18:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099251;
        bh=glYgs9FgqC4xgBUSZin2yYaQha2n/GDDZawSkrR6aHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWqcaPW+Y+dxfmebIpKMsnlFdG4a2wndLc7AF0R54x/Kl8alS6UnNWPH7D8OjLrz3
         m3KCPXE2Hl8fpPS21TfunCFGelVNhVOEwlhlgFBTZt4aHlMFt4wS+PdWBoJDRDwd6L
         nEXUFyBfto4hx7g3mBks9LKh2liHma4C4bu7QlJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Jonas Karlsson <jonas.karlsson@actia.se>
Subject: [PATCH 4.19 122/131] cdc-acm: close race betrween suspend() and acm_softint
Date:   Tue, 28 Apr 2020 20:25:34 +0200
Message-Id: <20200428182240.549257748@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 0afccd7601514c4b83d8cc58c740089cc447051d upstream.

Suspend increments a counter, then kills the URBs,
then kills the scheduled work. The scheduled work, however,
may reschedule the URBs. Fix this by having the work
check the counter.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Tested-by: Jonas Karlsson <jonas.karlsson@actia.se>
Link: https://lore.kernel.org/r/20200415151358.32664-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -563,14 +563,14 @@ static void acm_softint(struct work_stru
 	struct acm *acm = container_of(work, struct acm, work);
 
 	if (test_bit(EVENT_RX_STALL, &acm->flags)) {
-		if (!(usb_autopm_get_interface(acm->data))) {
+		smp_mb(); /* against acm_suspend() */
+		if (!acm->susp_count) {
 			for (i = 0; i < acm->rx_buflimit; i++)
 				usb_kill_urb(acm->read_urbs[i]);
 			usb_clear_halt(acm->dev, acm->in);
 			acm_submit_read_urbs(acm, GFP_KERNEL);
-			usb_autopm_put_interface(acm->data);
+			clear_bit(EVENT_RX_STALL, &acm->flags);
 		}
-		clear_bit(EVENT_RX_STALL, &acm->flags);
 	}
 
 	if (test_and_clear_bit(EVENT_TTY_WAKEUP, &acm->flags))


