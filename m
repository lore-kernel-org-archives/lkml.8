Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F65C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E24E2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685500;
	bh=tLo/PZQiGCZ4iDPRBI4rrsteQuQ+bsj4OpwZeKsyMNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oiy7Q2dXlFvlXEKCAlF8BOJ7eJDoWQxXXJUVGB1W2TbbW7mM3jyAOe+qFLIESqL8J
	 kZg3jEKKMbhgoKATSl06sI9wZhRAao5gXXpShjvK1/UmwN1LEXSEAdVKC8QpiuOBpa
	 TYuJb/8+o08beWw2qQgUSFIXFgOAFVnxbFirqJuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgAVJbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:31:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:43786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbgAVJbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:31:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E998024673;
        Wed, 22 Jan 2020 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685493;
        bh=tLo/PZQiGCZ4iDPRBI4rrsteQuQ+bsj4OpwZeKsyMNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAdy0ychJ+fyhoyFkV+tL9az24e5Dm2xfd6yXvtzzZhZCD2pVt2Go0yV6iBX+laY2
         Lih8EO5ds0UBkhlPRXrzu1Q7VcNgO10ExOZhPN9RlaQw1uOlPO4Ngfmq2MAh6dx7iv
         PEP7rsmBqDDhGO2+WNh3DWwa4g81IGRZGpSG7UJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+219f00fb49874dcaea17@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 09/76] ALSA: line6: Fix write on zero-sized buffer
Date:   Wed, 22 Jan 2020 10:28:25 +0100
Message-Id: <20200122092752.509707971@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092751.587775548@linuxfoundation.org>
References: <20200122092751.587775548@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 3450121997ce872eb7f1248417225827ea249710 upstream.

LINE6 drivers allocate the buffers based on the value returned from
usb_maxpacket() calls.  The manipulated device may return zero for
this, and this results in the kmalloc() with zero size (and it may
succeed) while the other part of the driver code writes the packet
data with the fixed size -- which eventually overwrites.

This patch adds a simple sanity check for the invalid buffer size for
avoiding that problem.

Reported-by: syzbot+219f00fb49874dcaea17@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 4.4: Driver doesn't support asymmetrical packet
 sizes, so only check snd_line6_pcm::max_packet_size]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/line6/pcm.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -529,6 +529,11 @@ int line6_init_pcm(struct usb_line6 *lin
 				usb_rcvisocpipe(line6->usbdev, ep_read), 0),
 			usb_maxpacket(line6->usbdev,
 				usb_sndisocpipe(line6->usbdev, ep_write), 1));
+	if (!line6pcm->max_packet_size) {
+		dev_err(line6pcm->line6->ifcdev,
+			"cannot get proper max packet size\n");
+		return -EINVAL;
+	}
 
 	spin_lock_init(&line6pcm->out.lock);
 	spin_lock_init(&line6pcm->in.lock);


