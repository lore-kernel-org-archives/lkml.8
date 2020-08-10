Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63052C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26EC421775
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073154;
	bh=yDP87lINzHFiLkOkm6RlyKNPAAeN6uTzlS7Nkl4gNvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gp7zPMICB3xZx6gpQmAqoof8w6oAwRgppO2xtKQiREfj0AzO03M701I0Ql7YM6HKy
	 D1WiV49G93FqE7AwDiWoXr+7ORD0Jei3iij8kHgIjOd5Q+QFdHAGb6PQmN82S0iGqJ
	 H+Axd31WPnjl5lhG063MQGSGVU807wM/uOaMLkOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgHJPZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbgHJPZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:25:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1A920658;
        Mon, 10 Aug 2020 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073149;
        bh=yDP87lINzHFiLkOkm6RlyKNPAAeN6uTzlS7Nkl4gNvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=arUcv6Yc5KerwrtgaezAI6/ebW/fvugb6I9bVcrmMq3V13iC5RKt8tBE9sTwbHFKl
         hqOPKr4c0zHaaNrmRyvzhL31PtVhAbuZjbQp/XV/znPpM1EjWK9VjxYRisDZ4bLfKl
         i38XAwfS0viLZVvWbiQ0kbXgw5NcrMvKgiSYG4VI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 74/79] selftests/net: relax cpu affinity requirement in msg_zerocopy test
Date:   Mon, 10 Aug 2020 17:21:33 +0200
Message-Id: <20200810151815.872093726@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151812.114485777@linuxfoundation.org>
References: <20200810151812.114485777@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 16f6458f2478b55e2b628797bc81a4455045c74e ]

The msg_zerocopy test pins the sender and receiver threads to separate
cores to reduce variance between runs.

But it hardcodes the cores and skips core 0, so it fails on machines
with the selected cores offline, or simply fewer cores.

The test mainly gives code coverage in automated runs. The throughput
of zerocopy ('-z') and non-zerocopy runs is logged for manual
inspection.

Continue even when sched_setaffinity fails. Just log to warn anyone
interpreting the data.

Fixes: 07b65c5b31ce ("test: add msg_zerocopy test")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/msg_zerocopy.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -125,9 +125,8 @@ static int do_setcpu(int cpu)
 	CPU_ZERO(&mask);
 	CPU_SET(cpu, &mask);
 	if (sched_setaffinity(0, sizeof(mask), &mask))
-		error(1, 0, "setaffinity %d", cpu);
-
-	if (cfg_verbose)
+		fprintf(stderr, "cpu: unable to pin, may increase variance.\n");
+	else if (cfg_verbose)
 		fprintf(stderr, "cpu: %u\n", cpu);
 
 	return 0;


