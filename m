Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF55C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D0F24683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580219991;
	bh=6H6cu1G/WQUmZ2MDjL0b/bXedbzOPN3nbxogY/FZ+3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VcKuYYQcj6C1JOJBiS/mL0JfBSnIdD7ZxcUA39L0TWHX2///5cLrl+uohLLQZYCSX
	 tcIzAeTCzedL4BbEgfjsp5sI4IwHMuHRzXWZXs4wEM2fj8VWwAgtLBpTXW/M6WD6w3
	 fQ85NX+/RIxSFobaCnhnMF+iUF7DJcOicAHXQKaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgA1N7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:59:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgA1N7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:59:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D40A824688;
        Tue, 28 Jan 2020 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580219980;
        bh=6H6cu1G/WQUmZ2MDjL0b/bXedbzOPN3nbxogY/FZ+3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQyL+1gObYwaOwQbNPlEJKXPB72qGV2l2hiJi7lbynZJttocXp5vaxViCRfqbX6bx
         pFZIHpOxW6Rvh+bBGbUIY/HHXmi41/QEr8wcVctK/L5sV62CPqxrOqiKNhrBVPqUn4
         z+0WE27Pc2yM55zjmZhUhgA1hmCBBoSO3wlGggVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 4.14 38/46] coresight: etb10: Do not call smp_processor_id from preemptible
Date:   Tue, 28 Jan 2020 14:58:12 +0100
Message-Id: <20200128135754.798242502@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135749.822297911@linuxfoundation.org>
References: <20200128135749.822297911@linuxfoundation.org>
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
@@ -287,9 +287,7 @@ static void *etb_alloc_buffer(struct cor
 	int node;
 	struct cs_buffers *buf;
 
-	if (cpu == -1)
-		cpu = smp_processor_id();
-	node = cpu_to_node(cpu);
+	node = (cpu == -1) ? NUMA_NO_NODE : cpu_to_node(cpu);
 
 	buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
 	if (!buf)


