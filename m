Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D41C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BC321569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="SO0RE1gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgBLTbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:31:12 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.101]:34067 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727361AbgBLTbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:31:11 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id B4D0E607B87
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 13:31:10 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1xj4j0knLRP4z1xj4jSNtQ; Wed, 12 Feb 2020 13:31:10 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qVT3JEBGacGB2ITpJDbesv5hNV8nBdRWBrUKUxTwmPU=; b=SO0RE1grbeu4rE7C9/5vgBTS9v
        K+ivX9nq4nObO5gnVyWWT0j5krix2wwszSD9HtfY7xNU83Ao1JIqSDAcivueHllxK5q5NjlumO/9x
        lAkWMdQtrLxYO0DsEm2ozZ2D/WyOlP32QTmLnBGrNxsm51sc9eiIcBkCLbzAB9YxV2lslJvU/CBDK
        JBy1DJsGvdL4CdSrL13a6+iARyCiqeFtU6ZhV1jTHmbBX1u+VO8A+gG1QuEH5wC5WyfukIx26BZYM
        uOGnBXi930Jwk5WOrLliqaaVy4DpJ73ipH895mNAE+lTfv3eMlLKmUFgijJ0BD7C9/TeKFSumIaWP
        xKngX4VQ==;
Received: from [201.144.174.25] (port=10240 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1xj3-0017cN-2B; Wed, 12 Feb 2020 13:31:09 -0600
Date:   Wed, 12 Feb 2020 13:33:44 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/qxl: replace zero-length array with flexible-array member
Message-ID: <20200212193344.GA27929@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.144.174.25
X-Source-L: No
X-Exim-ID: 1j1xj3-0017cN-2B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.144.174.25]:10240
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 24
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertenly introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/qxl/qxl_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index ef09dc6bc635..d1086b2a6892 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -36,7 +36,7 @@ static int qxl_reap_surface_id(struct qxl_device *qdev, int max_to_reap);
 
 struct ring {
 	struct qxl_ring_header      header;
-	uint8_t                     elements[0];
+	uint8_t                     elements[];
 };
 
 struct qxl_ring {
-- 
2.25.0

