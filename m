Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C540C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB302073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034501;
	bh=HFNk47jELaw7uwMh7fkT5nlGQFTfz2GICQHMXpjGHI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CxIPYZruPBB8R095eK53Mm2eRnuxe6zyzf0u8aUESUaoulKgsfA92nq8nkQ7ZvbkX
	 /bVotvI+OrVRuHuH6LfEB5J3qObZbHAgq6bevX8/D+UZ9bitBHLHaRHFSYfaFy4hlh
	 NEmsa9aNd4ITaOpsBXExd8lk2NulXmUKo6SS9TCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgFASBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbgFASBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:01:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9CC52065C;
        Mon,  1 Jun 2020 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034483;
        bh=HFNk47jELaw7uwMh7fkT5nlGQFTfz2GICQHMXpjGHI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p49JAdnEKIuUYphNS2Ru6FPP4rUBx/5KbOIOq48yWqgr+cG4fDdiNnG85uCiUbsh5
         loioLgqPO8/93xINegOBjr+pg4eX9ZlCdRXTNFFi2l7gSpeOEZ8Tx1pFAF5O8KhYgd
         2tZFJFWxPoHTlz0wGRzT1nJZut8mPGqzdE7H1y6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 50/77] include/asm-generic/topology.h: guard cpumask_of_node() macro argument
Date:   Mon,  1 Jun 2020 19:53:55 +0200
Message-Id: <20200601174025.236191511@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174016.396817032@linuxfoundation.org>
References: <20200601174016.396817032@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 4377748c7b5187c3342a60fa2ceb60c8a57a8488 ]

drivers/hwmon/amd_energy.c:195:15: error: invalid operands to binary expression ('void' and 'int')
                                        (channel - data->nr_cpus));
                                        ~~~~~~~~~^~~~~~~~~~~~~~~~~
include/asm-generic/topology.h:51:42: note: expanded from macro 'cpumask_of_node'
    #define cpumask_of_node(node)       ((void)node, cpu_online_mask)
                                               ^~~~
include/linux/cpumask.h:618:72: note: expanded from macro 'cpumask_first_and'
 #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
                                                                       ^~~~~

Fixes: f0b848ce6fe9 ("cpumask: Introduce cpumask_of_{node,pcibus} to replace {node,pcibus}_to_cpumask")
Fixes: 8abee9566b7e ("hwmon: Add amd_energy driver to report energy counters")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: http://lkml.kernel.org/r/20200527134623.930247-1-arnd@arndb.de
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/topology.h b/include/asm-generic/topology.h
index 5d2add1a6c96..864fcfa1df41 100644
--- a/include/asm-generic/topology.h
+++ b/include/asm-generic/topology.h
@@ -51,7 +51,7 @@
   #ifdef CONFIG_NEED_MULTIPLE_NODES
     #define cpumask_of_node(node)	((node) == 0 ? cpu_online_mask : cpu_none_mask)
   #else
-    #define cpumask_of_node(node)	((void)node, cpu_online_mask)
+    #define cpumask_of_node(node)	((void)(node), cpu_online_mask)
   #endif
 #endif
 #ifndef pcibus_to_node
-- 
2.25.1



