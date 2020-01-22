Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B21C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4464D20678
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699889;
	bh=3gY41t3PBbf9Bh54MQwzN0iQ5H5WEPl331nOFmFK0gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OQgSpuU4leOnyJf6yKxMoC0m6nVGSh3EiD4Fg6X5DnK3w9v9IMlZFxY2xashU2+yV
	 Ii9nQjMOxhHPblM/o1cF5+cw+vYJk5/JM2fMg5UyojewpuDqce3WINT/r1o3fcZohc
	 FHRB4ImXHokD4Rcj1X/v5WatwIwESiyqFwFh6WBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAVNTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgAVNTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:19:44 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 512AE2468A;
        Wed, 22 Jan 2020 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699183;
        bh=3gY41t3PBbf9Bh54MQwzN0iQ5H5WEPl331nOFmFK0gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1m+b2j1WYkCPfgGXQ4ApUXw60uFVkAwgTIRSvqd4c4Kya2VAX3dnnDxlS2OpbZRx
         OGM7Ne02G+Uj3r58knncanAuYj9ekVBOr/Xif8StS0O/2c7VTwUFG4zaHe2ucEBY5+
         ArEML+NxfdVug2lyvXwQ2lbtnW7RVLcjN6Tlp8nI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Like Xu <like.xu@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5.4 065/222] perf/x86/intel/uncore: Fix missing marker for snr_uncore_imc_freerunning_events
Date:   Wed, 22 Jan 2020 10:27:31 +0100
Message-Id: <20200122092838.375669008@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

commit fa694ae532836bd2f4cd659e9b4032abaf9fa9e5 upstream.

An Oops during the boot is found on some SNR machines.  It turns out
this is because the snr_uncore_imc_freerunning_events[] array was
missing an end-marker.

Fixes: ee49532b38dd ("perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge")
Reported-by: Like Xu <like.xu@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Like Xu <like.xu@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20200116200210.18937-1-kan.liang@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/uncore_snbep.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4536,6 +4536,7 @@ static struct uncore_event_desc snr_unco
 	INTEL_UNCORE_EVENT_DESC(write,		"event=0xff,umask=0x21"),
 	INTEL_UNCORE_EVENT_DESC(write.scale,	"3.814697266e-6"),
 	INTEL_UNCORE_EVENT_DESC(write.unit,	"MiB"),
+	{ /* end: all zeroes */ },
 };
 
 static struct intel_uncore_ops snr_uncore_imc_freerunning_ops = {


