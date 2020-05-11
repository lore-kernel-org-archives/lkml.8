Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9438C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA7A020661
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589229765;
	bh=POJB7hnN0/xvBNfrkIDdkd6mL5J51lim3zkfStZEOBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K9PvLRT8fIMP6z0XOZlPNJFBCZtUVIv0GlcbelxWdPuD2TDLbEpJqSCjTG2TB5EPe
	 SOiFgHqKaxkphtkveJuU+wybbiMIcBxLynSBjImFA93ZXEY0MNZ+TYvEbhdXhyACSy
	 p2qu08REEkXC0hlVFujJqeD38y1PrJFNXOjZInA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbgEKUmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731777AbgEKUmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:42:43 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 319272075E;
        Mon, 11 May 2020 20:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589229762;
        bh=POJB7hnN0/xvBNfrkIDdkd6mL5J51lim3zkfStZEOBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlV7joy+2Ygogi5xWG0s9p5ILPVEYiZ0YDnLE4ECq657fIFvcj5weOmPVAnOl4AxD
         CiTjwQyaHAcObJCiv3cf/CgCyHs3umbN6yRWFJNP8oQma0Wi9iCFdP1awMchZcvnnx
         9AhtIP7aZVZHSE0QxmJSBGTOMREwv1IWzxVgxsJY=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org, will@kernel.org
Subject: [PATCH v5 06/18] netfilter: Avoid assigning 'const' pointer to non-const pointer
Date:   Mon, 11 May 2020 21:41:38 +0100
Message-Id: <20200511204150.27858-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511204150.27858-1-will@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nf_remove_net_hook() uses WRITE_ONCE() to assign a 'const' pointer to a
'non-const' pointer. Cleanups to the implementation of WRITE_ONCE() mean
that this will give rise to a compiler warning, just like a plain old
assignment would do:

  | In file included from ./include/linux/export.h:43,
  |                  from ./include/linux/linkage.h:7,
  |                  from ./include/linux/kernel.h:8,
  |                  from net/netfilter/core.c:9:
  | net/netfilter/core.c: In function ‘nf_remove_net_hook’:
  | ./include/linux/compiler.h:216:30: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  |   *(volatile typeof(x) *)&(x) = (val);  \
  |                               ^
  | net/netfilter/core.c:379:3: note: in expansion of macro ‘WRITE_ONCE’
  |    WRITE_ONCE(orig_ops[i], &dummy_ops);
  |    ^~~~~~~~~~

Follow the pattern used elsewhere in this file and add a cast to 'void *'
to squash the warning.

Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 net/netfilter/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 78f046ec506f..3ac7c8c1548d 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -376,7 +376,7 @@ static bool nf_remove_net_hook(struct nf_hook_entries *old,
 		if (orig_ops[i] != unreg)
 			continue;
 		WRITE_ONCE(old->hooks[i].hook, accept_all);
-		WRITE_ONCE(orig_ops[i], &dummy_ops);
+		WRITE_ONCE(orig_ops[i], (void *)&dummy_ops);
 		return true;
 	}
 
-- 
2.26.2.645.ge9eca65c58-goog

