Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DE0C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E72020715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340337;
	bh=a5qcjP+kDxAn/qvCFH3xMONL9V4BA5fly2WYTF6a/e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g8KSz+BEJtErOWnal2zQTOASM6wLCmhtGF1Vy39dWvnKtTJuC2h5Em3ImeAkJQnKx
	 aq4ogOZLK8xad6qYcuHkup0QL58OsQHbW4KVsQ4btioXb8oGXgpsDa4nCqb8rduBlp
	 mNz6K3xyFSEG3dM3lni0TpxCp/A9shuDy38hPHyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgBJNMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:12:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbgBJMiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:54 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B6B020733;
        Mon, 10 Feb 2020 12:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338334;
        bh=a5qcjP+kDxAn/qvCFH3xMONL9V4BA5fly2WYTF6a/e0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCHeedslUwg+KcyLjEceiS9M6wBpVhjtr7wmtsGGVKbLaiz5InHN74R4mwEbR1vIQ
         4agYSN6laASg1bOL0rrijoS0v5VCX7c3R+y0nisfQrhsbkd0nq9L4uQ9gB+s3+/UlY
         kn5zK8kGIxpUpezujy3zCtAu1QpNZyCf1+65dMhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 280/309] taprio: Use taprio_reset_tc() to reset Traffic Classes configuration
Date:   Mon, 10 Feb 2020 04:33:56 -0800
Message-Id: <20200210122433.548207342@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit 7c16680a08ee1e444a67d232c679ccf5b30fad16 ]

When destroying the current taprio instance, which can happen when the
creation of one fails, we should reset the traffic class configuration
back to the default state.

netdev_reset_tc() is a better way because in addition to setting the
number of traffic classes to zero, it also resets the priority to
traffic classes mapping to the default value.

Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_taprio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1588,7 +1588,7 @@ static void taprio_destroy(struct Qdisc
 	}
 	q->qdiscs = NULL;
 
-	netdev_set_num_tc(dev, 0);
+	netdev_reset_tc(dev);
 
 	if (q->oper_sched)
 		call_rcu(&q->oper_sched->rcu, taprio_free_sched_cb);


