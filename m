Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47261C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8F621D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048007;
	bh=LoTfbwCSaBF2QyTddDg0v6TEKT+rRRwgXkOpkMtXQUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xxuWVtFMJB7yTKT3I4M/2SrCJuTuPu8WFN1O/ubdKqhVF5xGKDgMDQB5Ni5lYIZjg
	 JOHIXAIuZuvXEbKX3nFu/txKt23B83BSzHxrfLdN3exWflns76XkYH0NsNaZsbR+au
	 y/W5WgIhqCwwDpZfq/qrOeU8WbdJeQmh18RjBgY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406500AbgDPOBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898256AbgDPNlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:41:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D11520732;
        Thu, 16 Apr 2020 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044468;
        bh=LoTfbwCSaBF2QyTddDg0v6TEKT+rRRwgXkOpkMtXQUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BgIA0Ha14XaTy3LIEeW1Kn+urgMPBIppHaa0t9d0dE31ymG9LG2cZebu1DU06dspH
         IQpdOqmCCjP6hC4HB9PBKm0Wex8ckanhLd7ZbB/Tu6INqi/1ou3jEAqZEDhNL7eou6
         aWNx/PWSq4QJAIGoQlzgEfesiCiVykL+xmugxATU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver OHalloran <oohall@gmail.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.5 230/257] cpufreq: powernv: Fix use-after-free
Date:   Thu, 16 Apr 2020 15:24:41 +0200
Message-Id: <20200416131354.479566978@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver O'Halloran <oohall@gmail.com>

commit d0a72efac89d1c35ac55197895201b7b94c5e6ef upstream.

The cpufreq driver has a use-after-free that we can hit if:

a) There's an OCC message pending when the notifier is registered, and
b) The cpufreq driver fails to register with the core.

When a) occurs the notifier schedules a workqueue item to handle the
message. The backing work_struct is located on chips[].throttle and
when b) happens we clean up by freeing the array. Once we get to
the (now free) queued item and the kernel crashes.

Fixes: c5e29ea7ac14 ("cpufreq: powernv: Fix bugs in powernv_cpufreq_{init/exit}")
Cc: stable@vger.kernel.org # v4.6+
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200206062622.28235-1-oohall@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/powernv-cpufreq.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -1080,6 +1080,12 @@ free_and_return:
 
 static inline void clean_chip_info(void)
 {
+	int i;
+
+	/* flush any pending work items */
+	if (chips)
+		for (i = 0; i < nr_chips; i++)
+			cancel_work_sync(&chips[i].throttle);
 	kfree(chips);
 }
 


