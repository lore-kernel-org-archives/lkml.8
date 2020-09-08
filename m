Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FF6C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9520E206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YC5Px98t";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gWQcRQfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbgIHQkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732065AbgIHQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:37:25 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8E8C06125F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:18:32 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Bm5Lk486wzQlQN;
        Tue,  8 Sep 2020 15:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-disposition:content-type:content-type:mime-version
        :message-id:subject:subject:from:from:date:date:received; s=
        mail20150812; t=1599571097; bh=ubvOJcIFKGPENL3Obyw3VCwL5f9wX0uXs
        ncDj/8C6DY=; b=YC5Px98tIOe3edNX/+M8QphLzqvgNrPgyt4UBsWIINeGWY2dj
        Z/qv+KLEhdv2oNWdFXDTNCEoqhp0Qa3RShwqAJwYFQT67B3apuB+bihcAQ/TrSJf
        OdlV8EV6kFEBPhYkD4Z0hN5mMddSPULv9Zk1KJib1urUB9s+W06ccr2o3Xs4eXvh
        +xzCVrdnw7CNvd32xdiDyI3k0WT5JynUBbVuY6bXRmSyzzeRDsqPC80a2vDeVZjV
        QHG8qR0jxMZRqWaIQtSSqla+2zjGIsMOx8jizpxtWMhwiX8O7pQXaferH0knboTR
        +APSLJzly9xJ3JOd673g5OgR7tQmPgMki/Ugg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1599571100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SKp5ZDHQ9MIbdi3QU3eOPS0Z+8Dc9dwteGuJYkPA53k=;
        b=gWQcRQfwZNxKlejbS0JekUOiTjLnHV5z7ZGv9HjIw3Xm8T+l45s9BPW+qLSLDstXqc5BLJ
        L+2hqPncY7po/zgNbXs5HNXGCMh/mAesFvE2pxUN8au50lKanTGTw+2+Y/rJ0sChsyMl7R
        Rg5Kd+8jjRqcZ0HZUMmmL0H0RkuQD4HZe7+5qIU7JWBBSh7VxOg4a2fdRwZsVuz3ReU1T1
        e1Og2mj68qXSlrAghH8dfJYNpadnPTZUYHKi1TGod99Q1R0BTl0SBPAkrD+up5PHJYsMbC
        kUoOtAVu3C6Im0AcmQ5L1DWtwh5KWfzTuMk3kD8+vlzubt1XVuVGgiAAJvxCHg==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id PDb37bZMjMCv; Tue,  8 Sep 2020 15:18:17 +0200 (CEST)
Date:   Tue, 8 Sep 2020 15:18:08 +0200
From:   Wilken Gottwalt <wilken.gottwalt@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH] documentation: arm: sunxi: Allwinner H2+/H3 update
Message-ID: <20200908131808.GA65247@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.85 / 15.00 / 15.00
X-Rspamd-Queue-Id: 2FCD3274
X-Rspamd-UID: 3fa5e3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated information about H2+ and H3 difference and added a link to a
slightly newer datasheet.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
---
 Documentation/arm/sunxi.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/arm/sunxi.rst b/Documentation/arm/sunxi.rst
index b037428aee98..50b9199d929d 100644
--- a/Documentation/arm/sunxi.rst
+++ b/Documentation/arm/sunxi.rst
@@ -103,12 +103,15 @@ SunXi family
 
         * No document available now, but is known to be working properly with
           H3 drivers and memory map.
+        * It is basically a H3 where the GMAC block was replaced by a 100 MBit only MAC block.
 
       - Allwinner H3 (sun8i)
 
         * Datasheet
 
           http://dl.linux-sunxi.org/H3/Allwinner_H3_Datasheet_V1.0.pdf
+          or a slightly more up to date version
+          https://linux-sunxi.org/images/4/4b/Allwinner_H3_Datasheet_V1.2.pdf
 
       - Allwinner R40 (sun8i)
 
-- 
2.28.0

