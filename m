Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A95BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59BFA21775
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JJAwQuBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGSAdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 20:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgGSAdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:33:24 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858C7C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ejhbUXRyUGcuxfHilbyRZHXTEvE6s41ebx55gOa3sr4=; b=JJAwQuBaSok0dLnO98Bcgkor9C
        vO8HkSOx6ZPvOn2dOFVTiS7E/yFQrdon8KXfn+O7hZPYPgtzRYOynx4TltF5G58lKDBX0BhhmDFo9
        16ZcOjrcvXVq6Bctnmah5JiGWDpOm2Fau3FS2JFaefCHUaJPIZEw8a2eaWmyH7RX/4svnfUt/u8ER
        RR5HjemBftX0T/6hfbHxIwW3imWhK3BX+xdbKoh7qUKaHo40cpKY41HebV/MjKGf2B5SIoDSFHPog
        NTo1eDaNsnNjtapMe96euBDZgE8QujB2v0rKE07Mx4X3DhhkipZ4ktiThra3yb7FmZgToVztSWbTa
        MLsiEENg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxGb-0003C7-Oe; Sun, 19 Jul 2020 00:33:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Subject: [PATCH] xen/gntdev: gntdev.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:33:17 -0700
Message-Id: <20200719003317.21454-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "of" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
---
 include/uapi/xen/gntdev.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/uapi/xen/gntdev.h
+++ linux-next-20200717/include/uapi/xen/gntdev.h
@@ -66,7 +66,7 @@ struct ioctl_gntdev_map_grant_ref {
 
 /*
  * Removes the grant references from the mapping table of an instance of
- * of gntdev. N.B. munmap() must be called on the relevant virtual address(es)
+ * gntdev. N.B. munmap() must be called on the relevant virtual address(es)
  * before this ioctl is called, or an error will result.
  */
 #define IOCTL_GNTDEV_UNMAP_GRANT_REF \
