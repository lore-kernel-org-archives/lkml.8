Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E768AC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08D020767
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587482154;
	bh=BIIOBl8+ZNrCzgiqbTaN4rmD/4q+lBLlpujtsbRQ36E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dW1Caf1nVQv9+ic2H4CFrEh1Yyq5JD1GVCwVMbHgzkygJ+BO2HUTX/rd9ObtduX9r
	 ld/ugljO/vy2gmJ8U9l+mAwxvur4Jd31SxqpaK2B/bSchgmnFPtL2ZThWxzk95qq8t
	 SlF/PztJBshwhGixDV+vaPaK/jHhnzfhQIxLx7T0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDUPPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgDUPPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:15:51 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F8FB2071C;
        Tue, 21 Apr 2020 15:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587482150;
        bh=BIIOBl8+ZNrCzgiqbTaN4rmD/4q+lBLlpujtsbRQ36E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXiIt2poxX2aWPr9iRmCyI66qYitvSa+FKnYfPEBq0lw0lL06NNXtKpjKkFxoFwtj
         DVikMO6TssIer88s1N8ZPNn4ouTaUIfxa8wzmHIf7gz2QYL3CWHtNmtxAlrzwPmNLb
         PUKYi4iv/G/ab+JDaFufUwIIE5Gyn8HALw6qrGJk=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v4 02/11] netfilter: Avoid assigning 'const' pointer to non-const pointer
Date:   Tue, 21 Apr 2020 16:15:28 +0100
Message-Id: <20200421151537.19241-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421151537.19241-1-will@kernel.org>
References: <20200421151537.19241-1-will@kernel.org>
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
2.26.1.301.g55bc3eb7cb9-goog

