Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCE7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E81C2192A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588616170;
	bh=Z+tyRfl1Y/I0+t9KnKRbwn1BP0KDs/FUDpKOv23okvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gwz7ztcMd2+fXmWNq7i1MU70FpUgkHRqS+X1F2c84nXtBIlWCDlVdtFdJV7XYzHSa
	 Wx2KzCfYW3AZOmY1IRWSeOjzB0Tyjh8/SFGMOa2097ST+FLl7z/CyDO+se4FAWx5yD
	 Wx86572nxF/csa6eRBIbHaRCFq2JJaREVrWNjt/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgEDSQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730675AbgEDR7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:59:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6709E206D9;
        Mon,  4 May 2020 17:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615145;
        bh=Z+tyRfl1Y/I0+t9KnKRbwn1BP0KDs/FUDpKOv23okvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqKvdzZeFphi7raV6f84jn/uE10tBENYSwT/nAO8CjSzLY+kKK6MLHf2e4IDkoamn
         jmt3i2YdlOeELxXiKbcp/TtWlOzFj5N4KXqU6zbTdVSBA0mAFs9aOvViLSxmqgcCd2
         uF2p1rCh7GnGjDO2kNexGXQQtRVabS1PIxiUoRyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: [PATCH 4.4 14/18] [media] exynos4-is: fix a format string bug
Date:   Mon,  4 May 2020 19:57:12 +0200
Message-Id: <20200504165444.460789674@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165441.533160703@linuxfoundation.org>
References: <20200504165441.533160703@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit 76a563675485849f6f9ad5b30df220438b3628c1 upstream.

Ironically, 7d4020c3c400 ("[media] exynos4-is: fix some warnings when
compiling on arm64") fixed some format string bugs but introduced a
new one. buf_index is a simple int, so it should be printed with %d,
not %pad (which is correctly used for dma_addr_t).

Fixes: 7d4020c3c400 ("[media] exynos4-is: fix some warnings when compiling on arm64")

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/exynos4-is/fimc-isp-video.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/platform/exynos4-is/fimc-isp-video.c
+++ b/drivers/media/platform/exynos4-is/fimc-isp-video.c
@@ -221,8 +221,8 @@ static void isp_video_capture_buffer_que
 							ivb->dma_addr[i];
 
 			isp_dbg(2, &video->ve.vdev,
-				"dma_buf %pad (%d/%d/%d) addr: %pad\n",
-				&buf_index, ivb->index, i, vb->index,
+				"dma_buf %d (%d/%d/%d) addr: %pad\n",
+				buf_index, ivb->index, i, vb->index,
 				&ivb->dma_addr[i]);
 		}
 


