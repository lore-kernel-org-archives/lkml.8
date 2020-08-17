Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD6AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809FE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597682644;
	bh=kLRldtUwC7t3HFPXhNORNdUQOkvhyX8mWGlBQq4PcV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d4j4lCjFXJBuIMpsPWm0ExdywyDZzkCuPgNXA9jrXZfNydxWq702sF3zbtoFyhFT5
	 NQoHS1xlul5Vyd3vrlOej9nD91W+qz9eoKkfey3Wvy8Ynw/OTB7K//7Q5WT2lcJcRa
	 j1j/JUKpdHVL9rOjxKHwmFvSKdca3WnVOPlNzjpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbgHQQoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730964AbgHQP7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:59:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A821206FA;
        Mon, 17 Aug 2020 15:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679961;
        bh=kLRldtUwC7t3HFPXhNORNdUQOkvhyX8mWGlBQq4PcV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0qBjtwDaxOUQjqvvenH6FRGmF79VuxICOn3HLyGZnrps5mh2uBfIFZwDA+Wo48G4y
         KSJeb3IExNtG7oqzsjipfFopKxYmbA//XOAENqOVzTCvAW1KvgcfWXstc3G9WGjnph
         1HsW3T78JyE+stzrqaFw+B42x78m4mYF25Qe2u9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 5.7 386/393] s390/numa: set node distance to LOCAL_DISTANCE
Date:   Mon, 17 Aug 2020 17:17:16 +0200
Message-Id: <20200817143838.323520254@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

commit 535e4fc623fab2e09a0653fc3a3e17f382ad0251 upstream.

The node distance is hardcoded to 0, which causes a trouble
for some user-level applications. In particular, "libnuma"
expects the distance of a node to itself as LOCAL_DISTANCE.
This update removes the offending node distance override.

Cc: <stable@vger.kernel.org> # 4.4
Fixes: 3a368f742da1 ("s390/numa: add core infrastructure")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/include/asm/topology.h |    6 ------
 1 file changed, 6 deletions(-)

--- a/arch/s390/include/asm/topology.h
+++ b/arch/s390/include/asm/topology.h
@@ -86,12 +86,6 @@ static inline const struct cpumask *cpum
 
 #define pcibus_to_node(bus) __pcibus_to_node(bus)
 
-#define node_distance(a, b) __node_distance(a, b)
-static inline int __node_distance(int a, int b)
-{
-	return 0;
-}
-
 #else /* !CONFIG_NUMA */
 
 #define numa_node_id numa_node_id


