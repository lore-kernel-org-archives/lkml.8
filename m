Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28474C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AA2206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="l7x6RPEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbgBKVFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:05:50 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.18]:49587 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729031AbgBKVFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:05:49 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id E8EB811A1AA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 15:05:48 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1cj6jHsAZvBMd1cj6jbTsw; Tue, 11 Feb 2020 15:05:48 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0/N7mjdKi9+R4kLcU/SMx8qgiSYzHOVxoh2RqMly75s=; b=l7x6RPEyjpONSlZYpjiakJQvc6
        Mi+OP2QYKKI7djRIwgHBGlZHzptDixPY2EEESwk2Bql58vPJQmXeC10SHraA0SrO0aju5i5sc2tC3
        LuLw3sVQMpqYTAIGftANtXkoJQfyN13VEbdbZ8KJYlPRth3Sb/l8wleorcQz2Bz01G+nmmWv+YyK6
        ppu2OlDpwvOMZsHQrLDHL8mZGPqACiIeVKcBGqtQBhGVNGp18vDg2USf5hj5b3Yw8oxtMGY6V8eZT
        XF2ha5sQy+Sv9gqc3zqhXko1ST+CklRpWehTtCTqrq4RYy1yHn/3k/y4e3SfAnWmNBVYk6uZj/TOt
        xaBLMHcg==;
Received: from [200.68.140.36] (port=31691 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1cj5-0028BD-CP; Tue, 11 Feb 2020 15:05:47 -0600
Date:   Tue, 11 Feb 2020 15:08:22 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mei: bus: replace zero-length array with flexible-array
 member
Message-ID: <20200211210822.GA31368@embeddedor>
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
X-Source-IP: 200.68.140.36
X-Source-L: No
X-Exim-ID: 1j1cj5-0028BD-CP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:31691
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
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

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/misc/mei/bus-fixup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 5fcac02233af..aa3648d59a8a 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -107,7 +107,7 @@ struct mkhi_rule_id {
 struct mkhi_fwcaps {
 	struct mkhi_rule_id id;
 	u8 len;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 struct mkhi_fw_ver_block {
@@ -135,7 +135,7 @@ struct mkhi_msg_hdr {
 
 struct mkhi_msg {
 	struct mkhi_msg_hdr hdr;
-	u8 data[0];
+	u8 data[];
 } __packed;
 
 #define MKHI_OSVER_BUF_LEN (sizeof(struct mkhi_msg_hdr) + \
-- 
2.25.0

