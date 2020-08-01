Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8FEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 06:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 457CF20725
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 06:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qULcZ0lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHAGRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 02:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgHAGRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 02:17:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C0FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 23:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=s786NZ2wn+wvTzdNxwxwJAIYDebzF7T6hYGvMjGv3bI=; b=qULcZ0lrrjpAZ/xCPUuEU7Y3wl
        XnRWdSlB/sl0uGRwClUIu+fwXc54yzXTXfo73mxJXLPZC4WkXVM7kvrKpkii1/QIxbaMFcy6L8BhY
        96KbuRDkuKbMdi1xRukt02oeDskdJpvUpQ5iYj5N5q0rS0Tx+Sray2ZZXa1jZ0gVngGFRObVO+OGd
        9sPhJSxXp9jvB51DHCFYpm3GDW6QvaI/2+aGIPAr0GQ1WrH+gQ9e56rN/sWoeuXkVjcnvkEqi4YLC
        URO++DpdGu2N153Gw0WDEebs39dwsu9kwR9Hnql6LEAVsgUiFjvxaOayiSJ1JWwMj4Gn82ZYBbwks
        LZP/m2Fg==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1kpW-0002sP-QA; Sat, 01 Aug 2020 06:17:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vgaarb: mark vga_tryget static
Date:   Sat,  1 Aug 2020 08:17:13 +0200
Message-Id: <20200801061713.307434-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbols isn't used anywhere outside of vgaarb.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/vga/vgaarb.c | 3 +--
 include/linux/vgaarb.h   | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index f2f3ef8af2710f..5180c5687ee530 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -529,7 +529,7 @@ EXPORT_SYMBOL(vga_get);
  *
  * 0 on success, negative error code on failure.
  */
-int vga_tryget(struct pci_dev *pdev, unsigned int rsrc)
+static int vga_tryget(struct pci_dev *pdev, unsigned int rsrc)
 {
 	struct vga_device *vgadev;
 	unsigned long flags;
@@ -554,7 +554,6 @@ int vga_tryget(struct pci_dev *pdev, unsigned int rsrc)
 	spin_unlock_irqrestore(&vga_lock, flags);
 	return rc;
 }
-EXPORT_SYMBOL(vga_tryget);
 
 /**
  * vga_put - release lock on legacy VGA resources
diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
index 553b34c8b5f700..977caf96c8d2a3 100644
--- a/include/linux/vgaarb.h
+++ b/include/linux/vgaarb.h
@@ -109,12 +109,6 @@ static inline int vga_get_uninterruptible(struct pci_dev *pdev,
        return vga_get(pdev, rsrc, 0);
 }
 
-#if defined(CONFIG_VGA_ARB)
-extern int vga_tryget(struct pci_dev *pdev, unsigned int rsrc);
-#else
-static inline int vga_tryget(struct pci_dev *pdev, unsigned int rsrc) { return 0; }
-#endif
-
 #if defined(CONFIG_VGA_ARB)
 extern void vga_put(struct pci_dev *pdev, unsigned int rsrc);
 #else
-- 
2.27.0

