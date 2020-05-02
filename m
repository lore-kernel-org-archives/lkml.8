Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1E3C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 15:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424372072E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 15:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cq5xuwqr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="RjJoXBY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgEBPBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 11:01:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59457 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgEBPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 11:01:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4B9447964;
        Sat,  2 May 2020 11:01:09 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=Dpm
        qLVcbjVo4NvxFD6u3LJKoo48=; b=Cq5xuwqrammYphIcUO1hfFUKVOnjQd9gZyM
        xczKuf9AFsr2gdQTbq9vyObkxqRZThwztWKDCuVDS2Gjezo2OuwPUQ7ku1op456T
        MTlxIB7c46ZmpoojWFK0ug73ACr9w2hSBL/GJQFcJPWfcLEsLvuimxZ3m4iTdESD
        Fy+MYaZ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B657A47963;
        Sat,  2 May 2020 11:01:09 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2016-12.pbsmtp; bh=+FROliyTzXHsXbhtStynZPnZkrNdiApKyTgT3NSjMok=;
 b=RjJoXBY9z2fi7rRGkGWZs8KtpeAwixJbLEW0DPhImvCJ6uZxRuRnxhq+TgFdCuOLCzZLfOQQ+Q3m/bWooV+Ee0nYNXg8w8N1XvoftOENQ6Nzgv9nwFsiW/SkBlcSAQdvo3CU65vbOXxV1Ab/SItbFgNOcJhHzFpFb9th9qnqVEI=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0368047962;
        Sat,  2 May 2020 11:01:09 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 1CAAD2DA014A;
        Sat,  2 May 2020 11:01:08 -0400 (EDT)
Date:   Sat, 2 May 2020 11:01:07 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     gregkh@linuxfoundation.org
cc:     jslaby@suse.com, daniel.vetter@ffwll.ch, sam@ravnborg.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vt: fix unicode console freeing with a common interface
Message-ID: <nycvar.YSQ.7.76.2005021043110.2671@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: C154EFCE-8C85-11EA-92D4-C28CBED8090B-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By directly using kfree() in different places we risk missing one if
it is switched to using vfree(), especially if the corresponding
vmalloc() is hidden away within a common abstraction.

Oh wait, that's exactly what happened here.

So let's fix this by creating a common abstraction for the free case
as well.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
Reported-by: syzbot+0bfda3ade1ee9288a1be@syzkaller.appspotmail.com
Fixes: 9a98e7a80f95 ("vt: don't use kmalloc() for the unicode screen buffer")
Cc: <stable@vger.kernel.org>

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e5ffed795e..48a8199f78 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -365,9 +365,14 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
 	return uniscr;
 }
 
+static void vc_uniscr_free(struct uni_screen *uniscr)
+{
+	vfree(uniscr);
+}
+
 static void vc_uniscr_set(struct vc_data *vc, struct uni_screen *new_uniscr)
 {
-	vfree(vc->vc_uni_screen);
+	vc_uniscr_free(vc->vc_uni_screen);
 	vc->vc_uni_screen = new_uniscr;
 }
 
@@ -1230,7 +1235,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	err = resize_screen(vc, new_cols, new_rows, user);
 	if (err) {
 		kfree(newscreen);
-		kfree(new_uniscr);
+		vc_uniscr_free(new_uniscr);
 		return err;
 	}
 
