Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8384C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2FE2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597684849;
	bh=adhBHVJy2xHltP0rEAb5LWwcSj9nXk0sTpa4G7JeJGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AGVbmGb9m4zG+yxfROuGMa1bOL5XWLJ8phKGHyRYi4yCr5zYVUY1C0rfg7OzZMH1y
	 B9ierc5xKp3Yti0GRdxCPtQwIUQnJ1D0hEDEuAYH0qhUsQhk/ImGmU3fdxXfYwEdog
	 LGPYS+yjMKrvcUZ0BE57W+3M7pj2TGDm9sVyEgoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbgHQRUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731054AbgHQQSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:18:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72F0D22DA9;
        Mon, 17 Aug 2020 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597681084;
        bh=adhBHVJy2xHltP0rEAb5LWwcSj9nXk0sTpa4G7JeJGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pc5pWbEE838ilkzBBRMA8Xy5vVfCqnnrsp4ZB8AmMkLJ/qqpJZfZY84EfgHdB9JTU
         3Yp0jynKACfG4mAHEUEw2zxkncCBzbFQPoVBXqdxXV+9aDCLatUSe+5NbJCI6yEVZr
         wL86MHj1cWK2ZqFGUxaj1dB0DmOrSNfiQdHo+/ac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.19 168/168] xen/gntdev: Fix dmabuf import with non-zero sgt offset
Date:   Mon, 17 Aug 2020 17:18:19 +0200
Message-Id: <20200817143742.058067666@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

commit 5fa4e6f1c2d8c9a4e47e1931b42893172d388f2b upstream.

It is possible that the scatter-gather table during dmabuf import has
non-zero offset of the data, but user-space doesn't expect that.
Fix this by failing the import, so user-space doesn't access wrong data.

Fixes: bf8dc55b1358 ("xen/gntdev: Implement dma-buf import functionality")

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Juergen Gross <jgross@suse.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200813062113.11030-2-andr2000@gmail.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/gntdev-dmabuf.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -641,6 +641,14 @@ dmabuf_imp_to_refs(struct gntdev_dmabuf_
 		goto fail_detach;
 	}
 
+	/* Check that we have zero offset. */
+	if (sgt->sgl->offset) {
+		ret = ERR_PTR(-EINVAL);
+		pr_debug("DMA buffer has %d bytes offset, user-space expects 0\n",
+			 sgt->sgl->offset);
+		goto fail_unmap;
+	}
+
 	/* Check number of pages that imported buffer has. */
 	if (attach->dmabuf->size != gntdev_dmabuf->nr_pages << PAGE_SHIFT) {
 		ret = ERR_PTR(-EINVAL);


