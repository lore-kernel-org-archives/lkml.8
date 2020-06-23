Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4A5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA1521473
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943556;
	bh=unXX75l7378VHfw0LAbGxggPIkORTvXTWA0IDMpMiBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZcoDPRUCbVwTSwaFFKZeSA+PsAPrp/C2+s7t/s9vOLa56WkncdDcXmaCn59iDhcm5
	 QrbWyw1V6c0WxEYGBedOo+Qe7DCeB1VqNRf3e7IWGTTmI/tpHbswE4lMNAwPyrV5BT
	 tk63w3TPrv4BZ0wI9IGQimbJVhsupWombjbnhLCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbgFWUTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:19:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388569AbgFWUTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:19:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1207F2064B;
        Tue, 23 Jun 2020 20:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943549;
        bh=unXX75l7378VHfw0LAbGxggPIkORTvXTWA0IDMpMiBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpRmE6k0T1SKy7riG2UVhkOhnvQVWa9k/Q22zknkdqSRa6vQLZuN3Z38eSoJe8rop
         cOV6SN4ZivZqND+ByRpQJQ65xnkg/rXodBNyoHIzUw6J1iOmDFGwQQRUHF+Rot5W4K
         5JQb6GLbufzJKlwPcdARWIUZN61UP8Gn+pY62eu8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 405/477] s390/numa: let NODES_SHIFT depend on NEED_MULTIPLE_NODES
Date:   Tue, 23 Jun 2020 21:56:42 +0200
Message-Id: <20200623195426.678210466@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[ Upstream commit 64438e1bc0cdbe6d30bcdcb976f935eb3c297adc ]

Qian Cai reported:
"""
When NUMA=n and nr_node_ids=2, in apply_wqattrs_prepare(), it has,

for_each_node(node) {
        if (wq_calc_node_cpumask(...

where it will trigger a booting warning,

WARNING: workqueue cpumask: online intersect > possible intersect

because it found 2 nodes and wq_numa_possible_cpumask[1] is an empty
cpumask.
"""

Let NODES_SHIFT depend on NEED_MULTIPLE_NODES like it is done
on other architectures in order to fix this.

Fixes: 701dc81e7412 ("s390/mm: remove fake numa support")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 2167bce993ff6..ae01be202204b 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -462,6 +462,7 @@ config NUMA
 
 config NODES_SHIFT
 	int
+	depends on NEED_MULTIPLE_NODES
 	default "1"
 
 config SCHED_SMT
-- 
2.25.1



