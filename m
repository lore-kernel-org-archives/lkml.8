Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC37C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4540224688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221759;
	bh=P6KcGisHSvjR+BrFl5v/tzfT28IsTpmGIDmXzlfafzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ugpzzenpFomVtNUmV/HZnDZBZx21qqBlCUoo/PnJcCRxrKegbraE8jQbJUzLkt8mv
	 7/UUCE3/3jDpbncc5YYZmTeZw8n8f3ve/ND2XExJR/Acmz1+adCpXNvJFonyhYBI8P
	 jjNB+x0EFvhyb6dQnsiES7Dp58z+tZKtywD3z+VI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbgA1O3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:29:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387632AbgA1O3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:29:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F233124699;
        Tue, 28 Jan 2020 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221755;
        bh=P6KcGisHSvjR+BrFl5v/tzfT28IsTpmGIDmXzlfafzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHE1mMcPsBeGNy2k0oLYSHozUtiI6l98h9g9pLq4IXub65RTH234Ci14JZce8vEnE
         GcvZkMPB5Gp0EOafpScNcGoQXxtBLzAsxXfXjOq/1D3JDgIrkhru0pkVJVW/4lFzu3
         Ys7hUjWOSDdLpbEbIIxDX90SVrVHtI1CPf+MeD00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 4.19 61/92] coresight: etb10: Do not call smp_processor_id from preemptible
Date:   Tue, 28 Jan 2020 15:08:29 +0100
Message-Id: <20200128135817.078806667@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135809.344954797@linuxfoundation.org>
References: <20200128135809.344954797@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit 730766bae3280a25d40ea76a53dc6342e84e6513 upstream.

During a perf session we try to allocate buffers on the "node" associated
with the CPU the event is bound to. If it is not bound to a CPU, we
use the current CPU node, using smp_processor_id(). However this is unsafe
in a pre-emptible context and could generate the splats as below :

 BUG: using smp_processor_id() in preemptible [00000000] code: perf/2544

Use NUMA_NO_NODE hint instead of using the current node for events
not bound to CPUs.

Fixes: 2997aa4063d97fdb39 ("coresight: etb10: implementing AUX API")
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: stable <stable@vger.kernel.org> # 4.6+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Link: https://lore.kernel.org/r/20190620221237.3536-5-mathieu.poirier@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/hwtracing/coresight/coresight-etb10.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -275,9 +275,7 @@ static void *etb_alloc_buffer(struct cor
 	int node;
 	struct cs_buffers *buf;
 
-	if (cpu == -1)
-		cpu = smp_processor_id();
-	node = cpu_to_node(cpu);
+	node = (cpu == -1) ? NUMA_NO_NODE : cpu_to_node(cpu);
 
 	buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
 	if (!buf)


