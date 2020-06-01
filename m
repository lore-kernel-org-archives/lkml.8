Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E31C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A6C2076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034206;
	bh=jJlvg5Icn2RSmfrA3Oj+7GiZzqZOSE+7heMsTdczNG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o6UxlQ81/xD05J+1a4B9X8Zsv6NudwPHluTSnLxYQQrtfhFm00WjxOUCNmPp/YxaP
	 mg5nMYBwJTILNI1V66v2IjAGsq+a4C88vWdN8Ab9UulWWUgtFBWDCQh24pvZQvJJAM
	 f38PPqIz+IE/7QJ7S+N3bVKCNG+DLl6lr8htdoLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgFAR4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728670AbgFAR4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:56:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDADB2074B;
        Mon,  1 Jun 2020 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034198;
        bh=jJlvg5Icn2RSmfrA3Oj+7GiZzqZOSE+7heMsTdczNG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLMjDxX5TzqeFSc8TQ2a0SVItUGfzKUKRUXz6nGDCGPu1KxM+yVaViO79tasAjp58
         Q3+6/D1FhdPqd/b4XN3iF9rWdC5xxVq9q3WyVmHG6UKqIefud1/ekPmgBABy4LqICM
         YiXlYLzwIXvZDsvqydQV8I3Ip6dLyYp3x8xizRq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 08/48] IB/cma: Fix reference count leak when no ipv4 addresses are set
Date:   Mon,  1 Jun 2020 19:53:18 +0200
Message-Id: <20200601173954.755172639@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601173952.175939894@linuxfoundation.org>
References: <20200601173952.175939894@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalderon, Michal <Michal.Kalderon@cavium.com>

commit 963916fdb3e5ad4af57ac959b5a03bf23f7568ca upstream.

Once in_dev_get is called to receive in_device pointer, the
in_device reference counter is increased, but if there are
no ipv4 addresses configured on the net-device the ifa_list
will be null, resulting in a flow that doesn't call in_dev_put
to decrease the ref_cnt.
This was exposed when running RoCE over ipv6 without any ipv4
addresses configured

Fixes: commit 8e3867310c90 ("IB/cma: Fix a race condition in iboe_addr_get_sgid()")

Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/rdma/ib_addr.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -200,11 +200,13 @@ static inline void iboe_addr_get_sgid(st
 	dev = dev_get_by_index(&init_net, dev_addr->bound_dev_if);
 	if (dev) {
 		ip4 = in_dev_get(dev);
-		if (ip4 && ip4->ifa_list && ip4->ifa_list->ifa_address) {
+		if (ip4 && ip4->ifa_list && ip4->ifa_list->ifa_address)
 			ipv6_addr_set_v4mapped(ip4->ifa_list->ifa_address,
 					       (struct in6_addr *)gid);
+
+		if (ip4)
 			in_dev_put(ip4);
-		}
+
 		dev_put(dev);
 	}
 }


