Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE67C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 02:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F646206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 02:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GlgXIdd5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="19+QgvAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgC2CZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 22:25:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62499 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgC2CZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 22:25:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AEF20C368B;
        Sat, 28 Mar 2020 22:25:16 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=485fjb41sdCpYdGKN+gsj9JL99A=; b=GlgXId
        d5Keu3nBE6AsHOSEQjkXiJxHQyU8XI6YhO5yDvlPR0X4nTuxbks5hvIl0AAYnIL+
        YECaR+/FCFv7JIIOk03upmxr4LOyDtJ7/XymBw59Fv/WlbPzzKpulAc73icRqcPH
        JZTi0B+0AAfai/64A/zNrMsTXIMHWVfjLmVfo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A5220C368A;
        Sat, 28 Mar 2020 22:25:16 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=zjHpEBHranZMY7AxPpaXoMY2MwJSJYWzjiVSpEtjaKs=; b=19+QgvArpH5Nfm6+L5Gg40HcDBTwpCYQ4d8TA7G8JApY/u3WWhXrfeIq0a+Nz8vhGS46ubZUHV47A72DxSYKFahFYZgYqGu3tG6X+2bFKsQ/ZRLLo8wevjTlgF1vl3QewA50Vv4HC0NIp1OHNg3DKlgdxxcITvOOOIJJ1sTJjQM=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A0FA7C3688;
        Sat, 28 Mar 2020 22:25:13 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id C33842DA0174;
        Sat, 28 Mar 2020 22:25:11 -0400 (EDT)
Date:   Sat, 28 Mar 2020 22:25:11 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     gregkh@linuxfoundation.org
cc:     Chen Wandun <chenwandun@huawei.com>,
        Adam Borowski <kilobyte@angband.pl>, jslaby@suse.com,
        daniel.vetter@ffwll.ch, sam@ravnborg.org, b.zolnierkie@samsung.com,
        lukas@wunner.de, ghalat@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] vt: don't use kmalloc() for the unicode screen buffer
In-Reply-To: <nycvar.YSQ.7.76.2003281745280.2671@knanqh.ubzr>
Message-ID: <nycvar.YSQ.7.76.2003282214210.2671@knanqh.ubzr>
References: <nycvar.YSQ.7.76.2003281745280.2671@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 8563157C-7164-11EA-B568-B0405B776F7B-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if the actual screen size is bounded in vc_do_resize(), the unicode 
buffer is still a little more than twice the size of the glyph buffer
and may exceed MAX_ORDER down the kmalloc() path. This can be triggered
from user space.

Since there is no point having a physically contiguous buffer here, 
let's avoid the above issue as well as reducing pressure on high order
allocations by using vmalloc() instead.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
Cc: <stable@vger.kernel.org>

---

Changes since v1:

- Added missing include, found by kbuild test robot.
  Strange that my own build doesn't complain.

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 15d2769805..d9eb5661e9 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -81,6 +81,7 @@
 #include <linux/errno.h>
 #include <linux/kd.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/major.h>
 #include <linux/mm.h>
 #include <linux/console.h>
@@ -350,7 +351,7 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
 	/* allocate everything in one go */
 	memsize = cols * rows * sizeof(char32_t);
 	memsize += rows * sizeof(char32_t *);
-	p = kmalloc(memsize, GFP_KERNEL);
+	p = vmalloc(memsize);
 	if (!p)
 		return NULL;
 
@@ -366,7 +367,7 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
 
 static void vc_uniscr_set(struct vc_data *vc, struct uni_screen *new_uniscr)
 {
-	kfree(vc->vc_uni_screen);
+	vfree(vc->vc_uni_screen);
 	vc->vc_uni_screen = new_uniscr;
 }
 
