Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27174C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 21:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9236720716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 21:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CCnptZX5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="VqzxExHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgC1V7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 17:59:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54392 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgC1V7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 17:59:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB7885DF0E;
        Sat, 28 Mar 2020 17:59:27 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=dgf
        WqgLTCrN+VlDEATqWy9fOblU=; b=CCnptZX5bYjc8MPRVVfYmeIBHcufNVEG54l
        2j2B87mGcjERdMfHjMegHwxqoSY5LQ00DOJx2/pNJ3QB+hEzR3W3lpqnLDCzVhPW
        DVaIX8aTh2dKLgU4y/A02CqOSGRJ2FSFB+jJ7F3H0kipbKqmINFBfSXQ7GWINIc1
        4ligjSDA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A21375DF0D;
        Sat, 28 Mar 2020 17:59:27 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2016-12.pbsmtp; bh=hboGcD0CSWpZTZid8EN5p6L2AKFvA36jUPmev5j9F8I=;
 b=VqzxExHh6a9ijv2T//5/Z1WbikPWsqrTuthGtrc+WdRnPPjjRc9QQL6cg0yJdlidsgUTzzgDz88GbQiOHVh6QNqdTlmea8TpyBQsrxnAOrTEnsJJIcJxQQofjqSkLhnWiWlR/s0GpDRyzCeWv1LRGVCFVazz4VRrwvSgOl50HiM=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 064715DF0C;
        Sat, 28 Mar 2020 17:59:27 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id EF1182DA0174;
        Sat, 28 Mar 2020 17:59:25 -0400 (EDT)
Date:   Sat, 28 Mar 2020 17:59:25 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     gregkh@linuxfoundation.org
cc:     Chen Wandun <chenwandun@huawei.com>,
        Adam Borowski <kilobyte@angband.pl>, jslaby@suse.com,
        daniel.vetter@ffwll.ch, sam@ravnborg.org, b.zolnierkie@samsung.com,
        lukas@wunner.de, ghalat@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] vt: don't use kmalloc() for the unicode screen buffer
Message-ID: <nycvar.YSQ.7.76.2003281745280.2671@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 6474F6CA-713F-11EA-84AA-D1361DBA3BAF-78420484!pb-smtp2.pobox.com
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

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 15d2769805..7c10edb648 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -350,7 +350,7 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
 	/* allocate everything in one go */
 	memsize = cols * rows * sizeof(char32_t);
 	memsize += rows * sizeof(char32_t *);
-	p = kmalloc(memsize, GFP_KERNEL);
+	p = vmalloc(memsize);
 	if (!p)
 		return NULL;
 
@@ -366,7 +366,7 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
 
 static void vc_uniscr_set(struct vc_data *vc, struct uni_screen *new_uniscr)
 {
-	kfree(vc->vc_uni_screen);
+	vfree(vc->vc_uni_screen);
 	vc->vc_uni_screen = new_uniscr;
 }
 
