Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60E6C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D9C2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hTtWr/rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgBZWUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:20:16 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.31]:11729 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727709AbgBZWUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:20:16 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 1680744C75
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 16:19:50 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 751yjH6i4XVkQ751yjcJXT; Wed, 26 Feb 2020 16:19:50 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CYTLc8pzQUmhST1gNF70buho/8DcO3iBpI5E0Ps5vfs=; b=hTtWr/rdD8SusMKMAi5uEL8juy
        dZ47G5Sct45sZijelNMJKhUg18pT1s0/d9NzSEZjOcU4I/wb6kR72CiR7oFBeb3HIlCWq5IIv8bvm
        yYK8yDuO6cwb5MBZJGiL5j41lRRfDtT/0qesFj5EVohGUejlqcEj++uSyLGI0tV1UZPRyOEZ8j6YU
        nxOyyfP4bqYbe9Rx2GypCzmS37+Uwd47VNEUBVF65as/wZmB23uYScHruywbXdS9Vopp+K9A2gRWn
        E9OAPJHPcLHsO7rfunENjPgARy/xyFybE40Kb71ZfKTh9EX2SQP4idDZ+zD+nf/tRYN0q/MZcd5tw
        7mjcoH+Q==;
Received: from [201.166.157.20] (port=49854 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j751w-001Htv-8f; Wed, 26 Feb 2020 16:19:48 -0600
Date:   Wed, 26 Feb 2020 16:22:40 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dimitri Sivanich <sivanich@sgi.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] misc: Replace zero-length array with flexible-array member
Message-ID: <20200226222240.GA14474@embeddedor>
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
X-Source-IP: 201.166.157.20
X-Source-L: No
X-Exim-ID: 1j751w-001Htv-8f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.166.157.20]:49854
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
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
inadvertently introduced[3] to the codebase from now on.

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
 drivers/misc/mei/hw.h            | 2 +-
 drivers/misc/mei/mei_dev.h       | 2 +-
 drivers/misc/sgi-gru/grulib.h    | 2 +-
 drivers/misc/sgi-gru/grutables.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index 8231b6941adf..b1a8d5ec88b3 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -216,7 +216,7 @@ struct mei_msg_hdr {
 
 struct mei_bus_message {
 	u8 hbm_cmd;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 /**
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 76f8ff5ff974..3a29db07211d 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -533,7 +533,7 @@ struct mei_device {
 #endif /* CONFIG_DEBUG_FS */
 
 	const struct mei_hw_ops *ops;
-	char hw[0] __aligned(sizeof(void *));
+	char hw[] __aligned(sizeof(void *));
 };
 
 static inline unsigned long mei_secs_to_jiffies(unsigned long sec)
diff --git a/drivers/misc/sgi-gru/grulib.h b/drivers/misc/sgi-gru/grulib.h
index e77d1b1f9d05..85c103923632 100644
--- a/drivers/misc/sgi-gru/grulib.h
+++ b/drivers/misc/sgi-gru/grulib.h
@@ -136,7 +136,7 @@ struct gru_dump_context_header {
 	pid_t		pid;
 	unsigned long	vaddr;
 	int		cch_locked;
-	unsigned long	data[0];
+	unsigned long	data[];
 };
 
 /*
diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
index a7e44b2eb413..5ce8f3081e96 100644
--- a/drivers/misc/sgi-gru/grutables.h
+++ b/drivers/misc/sgi-gru/grutables.h
@@ -372,7 +372,7 @@ struct gru_thread_state {
 	int			ts_data_valid;	/* Indicates if ts_gdata has
 						   valid data */
 	struct gru_gseg_statistics ustats;	/* User statistics */
-	unsigned long		ts_gdata[0];	/* save area for GRU data (CB,
+	unsigned long		ts_gdata[];	/* save area for GRU data (CB,
 						   DS, CBE) */
 };
 
-- 
2.25.0

