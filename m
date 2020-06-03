Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBD3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD622074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 05:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BbzGrzFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgFCFwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 01:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFCFwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 01:52:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C138DC05BD43;
        Tue,  2 Jun 2020 22:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=actIeAq1J+DzXI5nECQdqeNdyNGdoq0WIhUeUKynMMM=; b=BbzGrzFz1zB1O0YdRhY/VKblus
        Wo5vAq0xmlzY/0eOBRXNGnvg+WRrbJvW3Zb6HcmnL9rcXtoydefCVfXNZ4QACGCFLvZpWCrMVLiuf
        tbcpTKQqrLljldddXykgp+VkUmAuSdTZSeSIEMgQ0PG7QC/zZT6s8NRKWKKDO0e8kZSv5iNYofLKI
        bkA2mkzjdT+Vrz8Uvk4aIiwTgT2Auuow7v8BeXNS18B0B8+rWXkMM8f+Cf/lpF2gDjNlLEyzhlr0Z
        C4yfiuLBX7m+a6LrSCBwVP4fi8aSs5x1kbUx/sUB68ReDRCMAzppo9yAI35+Ku88tApIOW1qGHMUi
        l09hH2yA==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgMKT-0003oS-85; Wed, 03 Jun 2020 05:52:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        build test robot <lkp@intel.com>
Subject: [PATCH 2/4] net/sysctl: remove leftover __user annotations on neigh_proc_dointvec*
Date:   Wed,  3 Jun 2020 07:52:35 +0200
Message-Id: <20200603055237.677416-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603055237.677416-1-hch@lst.de>
References: <20200603055237.677416-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the leftover __user annotation on the prototypes for
neigh_proc_dointvec*.  The implementations already got this right, but
the headers kept the __user tags around.

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Reported-by: build test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/net/neighbour.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index e1476775769c9..81ee17594c329 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -392,13 +392,12 @@ void *neigh_seq_next(struct seq_file *, void *, loff_t *);
 void neigh_seq_stop(struct seq_file *, void *);
 
 int neigh_proc_dointvec(struct ctl_table *ctl, int write,
-			void __user *buffer, size_t *lenp, loff_t *ppos);
+			void *buffer, size_t *lenp, loff_t *ppos);
 int neigh_proc_dointvec_jiffies(struct ctl_table *ctl, int write,
-				void __user *buffer,
+				void *buffer,
 				size_t *lenp, loff_t *ppos);
 int neigh_proc_dointvec_ms_jiffies(struct ctl_table *ctl, int write,
-				   void __user *buffer,
-				   size_t *lenp, loff_t *ppos);
+				   void *buffer, size_t *lenp, loff_t *ppos);
 
 int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 			  proc_handler *proc_handler);
-- 
2.26.2

