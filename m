Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB29C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1B620728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="vX6fievF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbgAPV60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:58:26 -0500
Received: from gateway30.websitewelcome.com ([192.185.150.24]:30773 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729380AbgAPV6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:58:25 -0500
X-Greylist: delayed 1317 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2020 16:58:25 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 9DBBE2FD24F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 15:36:27 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sCoViv3QVqNtvsCoViWjog; Thu, 16 Jan 2020 15:36:27 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eAKpUW4Y8qknkzN4AAowy2Wed9URe9xaFrVdLf7t/EI=; b=vX6fievFaA18QZ1ClygheHbXNM
        QdTnvyNZ4p1+AAUymuJXsaetAMLpJB8ixy5m3U0VlDqut8iQMCzL8rPbI14J7rDedsJF487gyKOj4
        jDyiwHjZrCBdOxcPnTHVCjFDY4vyIlXO2roP85bEE1YXax1uR42+DJx6PiGUom0n52ZJNG4CEJnsd
        pPp/l7A4aiYhaJTzeSVwfqx93xWolfSwpGYZcZTpe7XhWRY/9EIZVkgHSGNMzNXEsklY8O8DniIkS
        g31CZl/IUyXR3TQI9/4s+pAPu0Ai0SMgYtHWX11Tkw81aViB9LcTi0RAihyoHqbLD2qskeLuZ/CUN
        lOLKjSnA==;
Received: from 187-162-252-62.static.axtel.net ([187.162.252.62]:43810 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1isCoT-000Pu6-Im; Thu, 16 Jan 2020 15:36:25 -0600
Date:   Thu, 16 Jan 2020 15:36:25 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] net: sched: cls_u32: Use flexible-array member
Message-ID: <20200116213625.GA9294@embeddedor.com>
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
X-Source-IP: 187.162.252.62
X-Source-L: No
X-Exim-ID: 1isCoT-000Pu6-Im
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-252-62.static.axtel.net (embeddedor) [187.162.252.62]:43810
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Old code in the kernel uses 1-byte and 0-byte arrays to indicate the
presence of a "variable length array":

struct something {
    int length;
    u8 data[1];
};

struct something *instance;

instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
instance->length = size;
memcpy(instance->data, source, size);

There is also 0-byte arrays. Both cases pose confusion for things like
sizeof(), CONFIG_FORTIFY_SOURCE, etc.[1] Instead, the preferred mechanism
to declare variable-length types such as the one above is a flexible array
member[2] which need to be the last member of a structure and empty-sized:

struct something {
        int stuff;
        u8 data[];
};

Also, by making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
unadvertenly introduced[3] to the codebase from now on.

[1] https://github.com/KSPP/linux/issues/21
[2] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/sched/cls_u32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index a0e6fac613de..5537b5b72ad5 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -79,7 +79,7 @@ struct tc_u_hnode {
 	/* The 'ht' field MUST be the last field in structure to allow for
 	 * more entries allocated at end of structure.
 	 */
-	struct tc_u_knode __rcu	*ht[1];
+	struct tc_u_knode __rcu	*ht[];
 };
 
 struct tc_u_common {
-- 
2.23.0

