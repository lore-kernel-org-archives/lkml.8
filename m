Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BEEC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 21:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEE720714
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 21:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E3o+qHGz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="yH8DcDUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgC1Vcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 17:32:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63114 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1Vcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 17:32:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 365FDC1CA3;
        Sat, 28 Mar 2020 17:32:48 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=tuv
        2YoU2aL/2c/u/7jXp1zqbclA=; b=E3o+qHGz8/UGzrLdSBc4UdXQWZAInqosNDD
        nOSJ66aD+4VeWLOLC03WXeVZFZ0gOwCjNMKx+GJuo6hlt4jXeurcRJl93g8zJHl7
        CAZkYvIzrjOUmiJ7x/EOJhYcb+0tepAw8Jx3WouQN8UxSNKLrTBg9NCrOCo2AShH
        QhtJAttM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C468C1CA2;
        Sat, 28 Mar 2020 17:32:48 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2016-12.pbsmtp; bh=t4YwzAUHQeJQ27J5HRnM1y/AWnEpgYbN1AeSv1YdeuA=;
 b=yH8DcDUoYmDzjtD1P2XAigNE7y7BVD5VE4e1C+C9ii2z1uknM88c/7P2UftIoJLKvps8hYGn7TvHW5sa3NuudidCp7YmKzO5n3lTnsHMHiaXa08z2ZvuzVc15h+9lQqZltWNQI+Yk95r1K/WDYeOkQ2CM7Jj9mGksmTk8FOtuHs=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0B6A4C1CA1;
        Sat, 28 Mar 2020 17:32:45 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 161A82DA0174;
        Sat, 28 Mar 2020 17:32:43 -0400 (EDT)
Date:   Sat, 28 Mar 2020 17:32:42 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     gregkh@linuxfoundation.org
cc:     Adam Borowski <kilobyte@angband.pl>,
        Chen Wandun <chenwandun@huawei.com>, jslaby@suse.com,
        daniel.vetter@ffwll.ch, sam@ravnborg.org, b.zolnierkie@samsung.com,
        lukas@wunner.de, ghalat@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] vt: don't hardcode the mem allocation upper bound
Message-ID: <nycvar.YSQ.7.76.2003281702410.2671@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: A99919B0-713B-11EA-9914-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in vc_do_resize() bounds the memory allocation size to avoid
exceeding MAX_ORDER down the kzalloc() call chain and generating a 
runtime warning triggerable from user space. However, not only is it
unwise to use a literal value here, but MAX_ORDER may also be
configurable based on CONFIG_FORCE_MAX_ZONEORDER.
Let's use KMALLOC_MAX_SIZE instead.

Note that prior commit bb1107f7c605 ("mm, slab: make sure that 
KMALLOC_MAX_SIZE will fit into MAX_ORDER") the KMALLOC_MAX_SIZE value
could not be relied upon.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
Cc: <stable@vger.kernel.org> # v4.10+


diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 15d2769805..37c5f21490 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1193,7 +1193,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
 		return 0;
 
-	if (new_screen_size > (4 << 20))
+	if (new_screen_size > KMALLOC_MAX_SIZE)
 		return -EINVAL;
 	newscreen = kzalloc(new_screen_size, GFP_USER);
 	if (!newscreen)
