Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03D4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982A820709
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VPb/jaaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgHRU2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgHRU2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:28:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CA3C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3ePPQTqSgA3y882cmQuH4cZ0/NskoHX+u9okIl+XkXo=; b=VPb/jaaM5wPvJZro5z+2HSvqCX
        9gh6d9rdLjBMT+/Rzt0XAeYCE7X5QxqjNMyDF/PepxRR+45kH2aMWQW6dVxp3UafRWC0QDWIeZoZb
        yix/GbC5ffGQys759nAYh3aFm9pJ5bESz5QgrYJKbk5W4r38pYryySuHvuNi8zJADmB/s/Pn6Fyaf
        sf58HlXSYYUp3PS7jC+RUoMp9WFsqR96qQhP1O9Bg8vvOeeiezXn3369DCi1o8pqp+gIMLaz9097n
        f08h6R75VUaf6OVjySrLADNFJeWwmaemiKWHm8M6GQJfISHlfMGFB8PB+LKm0zwvOM191nSlodsRT
        3ReNkIrQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k88DO-0007Di-IE; Tue, 18 Aug 2020 20:28:15 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dave Airlie <airlied@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] drm: ast: fix double __iomem sparse warning
Message-ID: <a8185578-a69a-16b0-6fdf-f4e46bc4f61f@infradead.org>
Date:   Tue, 18 Aug 2020 13:28:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

sparse complains about having 2 "__iomem" attributes on the same line
where only one is needed since the first one applies to everything
up to the ending ';'.
However, to make it clear(er) that both of these pointers are
"__iomem", use separate lines for them.

../drivers/gpu/drm/ast/ast_cursor.c:256:26: CK: warning: duplicate [noderef]
../drivers/gpu/drm/ast/ast_cursor.c:256:26: CK: error: multiple address space given: __iomem & __iomem

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/ast/ast_cursor.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- lnx-59-rc1.orig/drivers/gpu/drm/ast/ast_cursor.c
+++ lnx-59-rc1/drivers/gpu/drm/ast/ast_cursor.c
@@ -253,7 +253,8 @@ void ast_cursor_show(struct ast_private
 		     unsigned int offset_x, unsigned int offset_y)
 {
 	u8 x_offset, y_offset;
-	u8 __iomem *dst, __iomem *sig;
+	u8 __iomem *dst;
+	u8 __iomem *sig;
 	u8 jreg;
 
 	dst = ast->cursor.vaddr[ast->cursor.next_index];

