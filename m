Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D66C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BF920715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340756;
	bh=Rb4+5OZy8/cgfkqgiWf+evdbzazPvvSkiaJPEhlwwHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2IDq9Js0xREXpmGxkKcTFeF0fuQSIrc0NqowwcES7ExZqaKdbl74nlk4utPT1utl/
	 j0BDU3ZuTUwvbAFUrBfYvIoohouqsWldJS0hsqBCygZALT0N0c+dfRr7tKuqQ6UbZc
	 dplsLuQZdJZ4QfC6lwLmlsDlRVKa6VKITSaeppqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbgBJNTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:19:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbgBJMhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:48 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0668824686;
        Mon, 10 Feb 2020 12:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338267;
        bh=Rb4+5OZy8/cgfkqgiWf+evdbzazPvvSkiaJPEhlwwHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tjl4jSQppIE7pUXx+nNbeHPlWa4VkgVKuciUty+WL07G3aEXw3nkdKQ5aOoUW70Hx
         zXwyd78VTJ8WKxctR1jCQEguY1xiUB1veQ8lvT49mJFdgq2Sx3wNEUS4WWq7eTCuQC
         2UyCHIMke2NODYogPx4o4foXaef35TD3QvgK0R5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amol Grover <frextrite@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH 5.4 146/309] bpf, devmap: Pass lockdep expression to RCU lists
Date:   Mon, 10 Feb 2020 04:31:42 -0800
Message-Id: <20200210122420.363422717@linuxfoundation.org>
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

From: Amol Grover <frextrite@gmail.com>

commit 485ec2ea9cf556e9c120e07961b7b459d776a115 upstream.

head is traversed using hlist_for_each_entry_rcu outside an RCU
read-side critical section but under the protection of dtab->index_lock.

Hence, add corresponding lockdep expression to silence false-positive
lockdep warnings, and harden RCU lists.

Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devices by hashed index")
Signed-off-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://lore.kernel.org/bpf/20200123120437.26506-1-frextrite@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/devmap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -293,7 +293,8 @@ struct bpf_dtab_netdev *__dev_map_hash_l
 	struct hlist_head *head = dev_map_index_hash(dtab, key);
 	struct bpf_dtab_netdev *dev;
 
-	hlist_for_each_entry_rcu(dev, head, index_hlist)
+	hlist_for_each_entry_rcu(dev, head, index_hlist,
+				 lockdep_is_held(&dtab->index_lock))
 		if (dev->idx == key)
 			return dev;
 


