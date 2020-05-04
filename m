Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4241C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84CD220721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jgY22NFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgEDRWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729667AbgEDRWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:22:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389FBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Tl/t8Argnrjl74YSR8dZbdLmuYRfU0RXLsTShjlC7yQ=; b=jgY22NFKJJKITvIfqmlCVwVekQ
        2c1IYo4QSrFabRLHgMINiCXrtH4POPyi2jiFmOlnDBGzkohJXaovYhoWZiktM/h/hJiCrgOhwM03K
        xoJj9vI02LSGoJtYJsj+mCvuIpjk2gFMIXXEwKaJyeLuiDj6uwd0/agowPgTp6M2hlq/Iic+/j1pq
        lLvKedHdqmap/SnI4sgDOM7Fj58qHuWkaG6Hka2Ap0FBLhdErN0eRhErsY5Vlk4LemllOyNFiJqHD
        j7kej5XvIVYd0tl4IptOv6Gz5eP8ZGDG+iZK+JYcEffKjZKR1r8m/mCpCLUxa6fZKKJgQ9+K2qeHq
        dmivnyAA==;
Received: from 089144205116.atnat0014.highway.webapn.at ([89.144.205.116] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVenA-0008Ln-1h; Mon, 04 May 2020 17:22:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] x86/uv: Remove the uv_partition_coherence_id macro
Date:   Mon,  4 May 2020 19:15:18 +0200
Message-Id: <20200504171527.2845224-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504171527.2845224-1-hch@lst.de>
References: <20200504171527.2845224-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uv_partition_coherence_id is only used once.  Just open code it in the
only user.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/uv/bios.h  | 1 -
 arch/x86/platform/uv/uv_sysfs.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index fc85dafa5e496..2fcc3ac12e76c 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -140,7 +140,6 @@ extern long sn_partition_id;
 extern long sn_coherency_id;
 extern long sn_region_size;
 extern long system_serial_number;
-#define uv_partition_coherence_id()	(sn_coherency_id)
 
 extern struct kobject *sgi_uv_kobj;	/* /sys/firmware/sgi_uv */
 
diff --git a/arch/x86/platform/uv/uv_sysfs.c b/arch/x86/platform/uv/uv_sysfs.c
index 62214731fea5e..266773e2fb379 100644
--- a/arch/x86/platform/uv/uv_sysfs.c
+++ b/arch/x86/platform/uv/uv_sysfs.c
@@ -21,7 +21,7 @@ static ssize_t partition_id_show(struct kobject *kobj,
 static ssize_t coherence_id_show(struct kobject *kobj,
 			struct kobj_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%ld\n", uv_partition_coherence_id());
+	return snprintf(buf, PAGE_SIZE, "%ld\n", sn_coherency_id);
 }
 
 static struct kobj_attribute partition_id_attr =
-- 
2.26.2

