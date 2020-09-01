Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7B9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2602065F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977032;
	bh=LrFyfFDXc9/jLnZm3rg0fByB+NJEn1pQKELGSz4xFsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zT07btJiF+2Ut25nHJ9Vg4svbs6KIr5uaYX486Pnw4ClPN/8nq4ymsQt9td7DBUda
	 OycVxNmtumhbOZ4ZMJwefT5VaWRoON5dW47dz+a2v8aI7dj50pailx3N3eT66y4anJ
	 nOSe0IwS4N/fj+so6t9iblCV8ezCgqFVIP8n8WB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbgIAQRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbgIAPd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:33:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A09520E65;
        Tue,  1 Sep 2020 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974436;
        bh=LrFyfFDXc9/jLnZm3rg0fByB+NJEn1pQKELGSz4xFsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYvKVSN7E2iB4163ZTolk+BROOAHx1304cWfYqBqEeq3T0wmkR3165MnCDg1lfpbD
         jWZNu6Mui4n8J8+VJU5vOoRgD4xe62QxXbPHIKf+Aj+iYKbeOBK7p/UTw66HocCQkC
         fnJS8HCpE4+AiyGQRuauBWjOeNR1SRqAzhD8a2vQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 176/214] powerpc/perf: Fix crashes with generic_compat_pmu & BHRB
Date:   Tue,  1 Sep 2020 17:10:56 +0200
Message-Id: <20200901151001.413630837@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

commit b460b512417ae9c8b51a3bdcc09020cd6c60ff69 upstream.

The bhrb_filter_map ("The Branch History Rolling Buffer") callback is
only defined in raw CPUs' power_pmu structs. The "architected" CPUs
use generic_compat_pmu, which does not have this callback, and crashes
occur if a user tries to enable branch stack for an event.

This add a NULL pointer check for bhrb_filter_map() which behaves as
if the callback returned an error.

This does not add the same check for config_bhrb() as the only caller
checks for cpuhw->bhrb_users which remains zero if bhrb_filter_map==0.

Fixes: be80e758d0c2 ("powerpc/perf: Add generic compat mode pmu driver")
Cc: stable@vger.kernel.org # v5.2+
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200602025612.62707-1-aik@ozlabs.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/perf/core-book3s.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1522,9 +1522,16 @@ nocheck:
 	ret = 0;
  out:
 	if (has_branch_stack(event)) {
-		power_pmu_bhrb_enable(event);
-		cpuhw->bhrb_filter = ppmu->bhrb_filter_map(
-					event->attr.branch_sample_type);
+		u64 bhrb_filter = -1;
+
+		if (ppmu->bhrb_filter_map)
+			bhrb_filter = ppmu->bhrb_filter_map(
+				event->attr.branch_sample_type);
+
+		if (bhrb_filter != -1) {
+			cpuhw->bhrb_filter = bhrb_filter;
+			power_pmu_bhrb_enable(event);
+		}
 	}
 
 	perf_pmu_enable(event->pmu);
@@ -1846,7 +1853,6 @@ static int power_pmu_event_init(struct p
 	int n;
 	int err;
 	struct cpu_hw_events *cpuhw;
-	u64 bhrb_filter;
 
 	if (!ppmu)
 		return -ENOENT;
@@ -1952,7 +1958,10 @@ static int power_pmu_event_init(struct p
 	err = power_check_constraints(cpuhw, events, cflags, n + 1);
 
 	if (has_branch_stack(event)) {
-		bhrb_filter = ppmu->bhrb_filter_map(
+		u64 bhrb_filter = -1;
+
+		if (ppmu->bhrb_filter_map)
+			bhrb_filter = ppmu->bhrb_filter_map(
 					event->attr.branch_sample_type);
 
 		if (bhrb_filter == -1) {


