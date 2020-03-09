Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F6DC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802112253D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="DwYyDgp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgCIUmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:42:50 -0400
Received: from gateway36.websitewelcome.com ([192.185.186.5]:39670 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgCIUmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:42:50 -0400
X-Greylist: delayed 1352 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 16:42:49 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 0CCDB402A82EC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 14:35:47 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BOsqjTy5cRP4zBOsqjqRQt; Mon, 09 Mar 2020 15:20:16 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1SW9bbNj8GGkcXYRjTbvsqy4AZp4iaCXJFZ+BqFprAU=; b=DwYyDgp9YAfysRFRu7BvJjNXDQ
        FMrwv9zxJ+j2CJCkddaWuHV3fSNlKZ9oS3GRldKqIuCzA8M0nwkH/NKj9m7iBXuSKygrCCmc2VY1B
        +Kg0qlE3LRoB3XolYgpJycYRh3QGrS6GZF76QqCRby+InM7Ukdf1nphgPT0tWj7qu02+eHfw3RJRV
        NtPvIVTFNAiGq4Qljfof70tZCOjKAJx4K8Hm/CWKQikaozdDfho/3aOC25HOkI1W0DK0GYP6ChJsi
        0b4PBONi8CIp/KHr1eLtCR/wpPrvT6PTXrqkDaV4OmOVg5uTHqEtTMNjbDThUBHqaWhM1TFHbaNv0
        jR6T6cYw==;
Received: from [201.162.168.201] (port=29672 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jBOsp-000ygf-3i; Mon, 09 Mar 2020 15:20:15 -0500
Date:   Mon, 9 Mar 2020 15:23:27 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] pstore: ram_core: Replace zero-length array with
 flexible-array member
Message-ID: <20200309202327.GA8813@embeddedor>
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
X-Source-IP: 201.162.168.201
X-Source-L: No
X-Exim-ID: 1jBOsp-000ygf-3i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.168.201]:29672
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 23
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
 fs/pstore/ram_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 1f4d8c06f9be..c917c191e78c 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -34,7 +34,7 @@ struct persistent_ram_buffer {
 	uint32_t    sig;
 	atomic_t    start;
 	atomic_t    size;
-	uint8_t     data[0];
+	uint8_t     data[];
 };
 
 #define PERSISTENT_RAM_SIG (0x43474244) /* DBGC */
-- 
2.25.0

