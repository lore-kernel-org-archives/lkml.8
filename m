Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27634C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 076822073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034350;
	bh=HFNk47jELaw7uwMh7fkT5nlGQFTfz2GICQHMXpjGHI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lsIZDoEBLn743BvXyEcX0dByCdfGTTw4mu20hpF4OD1/LwDE7AXXTXclG2/Ip6rjT
	 oN6fgTfpo3tsnptMV9nndRPAFHzPoQGvaTiKW5GxkVifInrzV7f9cQKPrOVV+C2J4X
	 mbTSrbwlPmxya3KuWAlffQ0SvJNk0MxrlUPxk27Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgFAR7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:59:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbgFAR6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:58:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CFD2206E2;
        Mon,  1 Jun 2020 17:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034324;
        bh=HFNk47jELaw7uwMh7fkT5nlGQFTfz2GICQHMXpjGHI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZW1fGsYgaZO2kHJtV4b+PLrqXyhgfiAVLsMr/+f2kmnTJaxoABg8/dXHF1MnYPvp
         dyrHz0XL74nQ4bL1M8EXL8MGO6mvRS8gtK3PF2YyK+29lLe9e6ivnvzUMkXMCIaegd
         w0K5gRGQo+Tieu0km77Vj74cr/KaMU7UDmk20V0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 40/61] include/asm-generic/topology.h: guard cpumask_of_node() macro argument
Date:   Mon,  1 Jun 2020 19:53:47 +0200
Message-Id: <20200601174019.073804380@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174010.316778377@linuxfoundation.org>
References: <20200601174010.316778377@linuxfoundation.org>
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



