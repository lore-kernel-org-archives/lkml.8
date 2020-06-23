Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D27AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1662921927
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945080;
	bh=IKO8ZK/SkYdF/3dtBEcIEcacC+9R2DVwhJ5cfKla2TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n0GK0kx1NLdEmouEwTS/LOaau8JBKdnl17wG2tuWzH1TXBWfZ7EPXD+BPZCzMfM4k
	 UKNx806WnQmzgfZlp8LzJE44OyhjKyMn8SuwrX737zZYsC7fp4bl475Zf/qCfId826
	 xs1Vs7L8mha4JJhawUjLyf269dzE2BTNIqwUYr5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403998AbgFWUoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391849AbgFWUo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:44:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82AF521BE5;
        Tue, 23 Jun 2020 20:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945070;
        bh=IKO8ZK/SkYdF/3dtBEcIEcacC+9R2DVwhJ5cfKla2TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zFFwJCDzD0SqE3Qx62ygYxpoaARjouOwP/9tyXcZ9B5BgBYB1siIGH2A2PPcrJhUC
         WbiCQEpLkI1qGI3ScwICuqlWSSjPOhXDg4L9DQ5FEmkmKSXaTCCkfad31ARlQXeUi+
         P4e5YwrnhWCSfmIWSpRqVBD6c9Hae4GjI1PfqmCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 027/136] powerpc/perf/hv-24x7: Fix inconsistent output values incase multiple hv-24x7 events run
Date:   Tue, 23 Jun 2020 21:58:03 +0200
Message-Id: <20200623195305.011714831@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kajol Jain <kjain@linux.ibm.com>

[ Upstream commit b4ac18eead28611ff470d0f47a35c4e0ac080d9c ]

Commit 2b206ee6b0df ("powerpc/perf/hv-24x7: Display change in counter
values")' added to print _change_ in the counter value rather then raw
value for 24x7 counters. Incase of transactions, the event count
is set to 0 at the beginning of the transaction. It also sets
the event's prev_count to the raw value at the time of initialization.
Because of setting event count to 0, we are seeing some weird behaviour,
whenever we run multiple 24x7 events at a time.

For example:

command#: ./perf stat -e "{hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/,
			   hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/}"
	  		   -C 0 -I 1000 sleep 100

     1.000121704                120 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     1.000121704                  5 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     2.000357733                  8 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     2.000357733                 10 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     3.000495215 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     3.000495215 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     4.000641884                 56 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     4.000641884 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     5.000791887 18,446,744,073,709,551,616 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/

Getting these large values in case we do -I.

As we are setting event_count to 0, for interval case, overall event_count is not
coming in incremental order. As we may can get new delta lesser then previous count.
Because of which when we print intervals, we are getting negative value which create
these large values.

This patch removes part where we set event_count to 0 in function
'h_24x7_event_read'. There won't be much impact as we do set event->hw.prev_count
to the raw value at the time of initialization to print change value.

With this patch
In power9 platform

command#: ./perf stat -e "{hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/,
		           hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/}"
			   -C 0 -I 1000 sleep 100

     1.000117685                 93 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     1.000117685                  1 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     2.000349331                 98 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     2.000349331                  2 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     3.000495900                131 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     3.000495900                  4 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     4.000645920                204 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/
     4.000645920                 61 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=1/
     4.284169997                 22 hv_24x7/PM_MCS01_128B_RD_DISP_PORT01,chip=0/

Suggested-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Tested-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200525104308.9814-2-kjain@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/perf/hv-24x7.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 72238eedc360f..2bb798918483d 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1413,16 +1413,6 @@ static void h_24x7_event_read(struct perf_event *event)
 			h24x7hw = &get_cpu_var(hv_24x7_hw);
 			h24x7hw->events[i] = event;
 			put_cpu_var(h24x7hw);
-			/*
-			 * Clear the event count so we can compute the _change_
-			 * in the 24x7 raw counter value at the end of the txn.
-			 *
-			 * Note that we could alternatively read the 24x7 value
-			 * now and save its value in event->hw.prev_count. But
-			 * that would require issuing a hcall, which would then
-			 * defeat the purpose of using the txn interface.
-			 */
-			local64_set(&event->count, 0);
 		}
 
 		put_cpu_var(hv_24x7_reqb);
-- 
2.25.1



