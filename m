Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5412BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A93B24686
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686165;
	bh=0W1V3W8CggVjNQyaN/zVeXev/bVrx1JcSlDjkkeRYbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KZoj5Yg+D2/d6gXYoBvkTTOY2EnXotNEqQINk9MXncntxrrzdb0SJACcSEZ7KPhC7
	 v1dbgTtvnQXFtNvxsnkFEGf3ZWuQ8jCbZAMBjRtfkd3vZ+iSATCEfTYtaDqCRklK5z
	 yqLosW8IKSxteIvz2/jZNVayNUzeHaB4HYT+Gpu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbgAVJmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:42:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387748AbgAVJmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:42:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 136BD24684;
        Wed, 22 Jan 2020 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686155;
        bh=0W1V3W8CggVjNQyaN/zVeXev/bVrx1JcSlDjkkeRYbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wXQnNJU7LBnMbSw1S5bAryuXl4DLs7f+3w1oxBTjGyspIMN4B6Mtge4r1VM9Ir/6q
         /8AYGHUqBZBZIhPBVCyuq3LjJkOG08fpsYZIa7sK7A2/2vHwc+X9avnUQJRmhZSabC
         k4hBwUClK2U+pTENKtxPC8nU/vV/sbG012iJ0yXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4c3cc6dbe7259dbf9054@syzkaller.appspotmail.com,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 059/103] netfilter: fix a use-after-free in mtype_destroy()
Date:   Wed, 22 Jan 2020 10:29:15 +0100
Message-Id: <20200122092812.841396727@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

commit c120959387efa51479056fd01dc90adfba7a590c upstream.

map->members is freed by ip_set_free() right before using it in
mtype_ext_cleanup() again. So we just have to move it down.

Reported-by: syzbot+4c3cc6dbe7259dbf9054@syzkaller.appspotmail.com
Fixes: 40cd63bf33b2 ("netfilter: ipset: Support extensions which need a per data destroy function")
Acked-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/ipset/ip_set_bitmap_gen.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/ipset/ip_set_bitmap_gen.h
+++ b/net/netfilter/ipset/ip_set_bitmap_gen.h
@@ -64,9 +64,9 @@ mtype_destroy(struct ip_set *set)
 	if (SET_WITH_TIMEOUT(set))
 		del_timer_sync(&map->gc);
 
-	ip_set_free(map->members);
 	if (set->dsize && set->extensions & IPSET_EXT_DESTROY)
 		mtype_ext_cleanup(set);
+	ip_set_free(map->members);
 	ip_set_free(map);
 
 	set->data = NULL;


