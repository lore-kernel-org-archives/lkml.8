Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65F8C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA16A20674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQSVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:21:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55441 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgCQSVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:21:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEGpi-00060L-Tq; Tue, 17 Mar 2020 19:20:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6764F1C2293;
        Tue, 17 Mar 2020 19:20:54 +0100 (CET)
Date:   Tue, 17 Mar 2020 18:20:54 -0000
From:   "tip-bot2 for Baoquan He" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove the now redundant N_MEMORY check
Cc:     Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200311011823.27740-1-bhe@redhat.com>
References: <20200311011823.27740-1-bhe@redhat.com>
MIME-Version: 1.0
Message-ID: <158446925404.28353.8374899643384906431.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     aa61ee7b9ee3cb84c0d3a842b0d17937bf024c46
Gitweb:        https://git.kernel.org/tip/aa61ee7b9ee3cb84c0d3a842b0d17937bf024c46
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Wed, 11 Mar 2020 09:18:23 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Mar 2020 19:12:39 +01:00

x86/mm: Remove the now redundant N_MEMORY check

In commit

  f70029bbaacb ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE")

the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY.
Before, CONFIG_HIGHMEM && !CONFIG_MOVABLE_NODE could make (N_MEMORY ==
N_NORMAL_MEMORY) be true.

After that commit, N_MEMORY cannot be equal to N_NORMAL_MEMORY. So the
conditional check in paging_init() is not needed anymore, remove it.

 [ bp: Massage. ]

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Link: https://lkml.kernel.org/r/20200311011823.27740-1-bhe@redhat.com
---
 arch/x86/mm/init_64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index abbdecb..0a14711 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -818,8 +818,7 @@ void __init paging_init(void)
 	 *	 will not set it back.
 	 */
 	node_clear_state(0, N_MEMORY);
-	if (N_MEMORY != N_NORMAL_MEMORY)
-		node_clear_state(0, N_NORMAL_MEMORY);
+	node_clear_state(0, N_NORMAL_MEMORY);
 
 	zone_sizes_init();
 }
