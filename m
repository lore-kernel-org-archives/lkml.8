Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597A6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274CF206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864967;
	bh=keRMlsFYzGpMPCm7+dNMTo6TNXo44yeRXT4UcS8m8+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JFk2bW2zcbsTd725mTZdsu3Gdusp06fQMnpbMMd4qdowYSYbFMNlGGPVXkiC2WzOE
	 L+fNWl6pcWjwu8GseJG+c+uwDCQpaT93ZJ/Mgo3N3N3RXfby511x3ohEkFcVHYjEs3
	 FHJv+XCLrm/PbmnqE6BBIK+iu7+/nlOK69lXFZ88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391246AbgAXLWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:22:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390883AbgAXLWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:22:39 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B675206D4;
        Fri, 24 Jan 2020 11:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864958;
        bh=keRMlsFYzGpMPCm7+dNMTo6TNXo44yeRXT4UcS8m8+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pWtJ5zuXtmHhwGs8TSRSe08Zf0J0f9Odjs/jsezbPeqyChvty8noQxxxSR+hMtEje
         D0KNXXcxEn7D676+EfZyEOyIBR3agpQzNdlE6rBfvQjm2y3R+qSLgrmj4IbVMEn/0L
         e5+hxVQXNcgcVA6fY8LBdwS4F9w0j2PCL2PtSmjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 400/639] inet: frags: call inet_frags_fini() after unregister_pernet_subsys()
Date:   Fri, 24 Jan 2020 10:29:30 +0100
Message-Id: <20200124093137.053859588@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit ae7352d384a552d8c799c242e74a934809990a71 ]

Both IPv6 and 6lowpan are calling inet_frags_fini() too soon.

inet_frags_fini() is dismantling a kmem_cache, that might be needed
later when unregister_pernet_subsys() eventually has to remove
frags queues from hash tables and free them.

This fixes potential use-after-free, and is a prereq for the following patch.

Fixes: d4ad4d22e7ac ("inet: frags: use kmem_cache for inet_frag_queue")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ieee802154/6lowpan/reassembly.c | 2 +-
 net/ipv6/reassembly.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index e7857a8ac86db..f3074249c6fc9 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -629,7 +629,7 @@ err_sysctl:
 
 void lowpan_net_frag_exit(void)
 {
-	inet_frags_fini(&lowpan_frags);
 	lowpan_frags_sysctl_unregister();
 	unregister_pernet_subsys(&lowpan_frags_ops);
+	inet_frags_fini(&lowpan_frags);
 }
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 095825f964e28..c6132e39ab16b 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -593,8 +593,8 @@ err_protocol:
 
 void ipv6_frag_exit(void)
 {
-	inet_frags_fini(&ip6_frags);
 	ip6_frags_sysctl_unregister();
 	unregister_pernet_subsys(&ip6_frags_ops);
 	inet6_del_protocol(&frag_protocol, IPPROTO_FRAGMENT);
+	inet_frags_fini(&ip6_frags);
 }
-- 
2.20.1



