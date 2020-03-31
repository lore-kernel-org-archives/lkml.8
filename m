Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB82AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C52220B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645740;
	bh=VXl/+8EHQkkOMjgvo6iRPG9Zs80istouIoRKhN0JfAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LPJf14remgmCO79GEbmGTMPbJDo9rcSernrXCoTwpaNU23W+sjWG+AGqIUjd+msnY
	 loDVcgKH7k/c3JipYEcZs0ioNPDrXip4sVX598vARoQHd2ahzhQ2qL1dwM6SnivlLz
	 vPWyHd8HF1cB7DSJFIdJd3sKJmZ5BizRYMv5NFgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbgCaJI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731401AbgCaJIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:08:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF8C120787;
        Tue, 31 Mar 2020 09:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645734;
        bh=VXl/+8EHQkkOMjgvo6iRPG9Zs80istouIoRKhN0JfAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=giVrSmA7HgNFenr/3pDPk+sPu+KTHO8ntcsuZ10gX7juBj/HyYOiyMyrn7hGwDxpl
         rtsCXdV5x1kt5B9UuVyvc2V7B/fQPS0U6uxwZYpv4J40aSyI8RTYlSnQoKD+zPTMCu
         jvTdvkoUEjsPGojWE/fhf1wlzFWLzc/OkMF6Oe5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 147/170] clocksource/drivers/hyper-v: Untangle stimers and timesync from clocksources
Date:   Tue, 31 Mar 2020 10:59:21 +0200
Message-Id: <20200331085438.915714636@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yubo Xie <yuboxie@microsoft.com>

[ Upstream commit 0af3e137c144377fbaf5025ba784ff5ba7ad40c9 ]

hyperv_timer.c exports hyperv_cs, which is used by stimers and the
timesync mechanism.  However, the clocksource dependency is not
needed: these mechanisms only depend on the partition reference
counter (which can be read via a MSR or via the TSC Reference Page).

Introduce the (function) pointer hv_read_reference_counter, as an
embodiment of the partition reference counter read, and export it
in place of the hyperv_cs pointer.  The latter can be removed.

This should clarify that there's no relationship between Hyper-V
stimers & timesync and the Linux clocksource abstractions.  No
functional or semantic change.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200109160650.16150-2-parri.andrea@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/hyperv_timer.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -327,7 +327,8 @@ static u64 notrace read_hv_clock_tsc(str
 
 static u64 read_hv_sched_clock_tsc(void)
 {
-	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
+	return (read_hv_clock_tsc(NULL) - hv_sched_clock_offset) *
+		(NSEC_PER_SEC / HV_CLOCK_HZ);
 }
 
 static struct clocksource hyperv_cs_tsc = {
@@ -352,7 +353,8 @@ static u64 notrace read_hv_clock_msr(str
 
 static u64 read_hv_sched_clock_msr(void)
 {
-	return read_hv_clock_msr(NULL) - hv_sched_clock_offset;
+	return (read_hv_clock_msr(NULL) - hv_sched_clock_offset) *
+		(NSEC_PER_SEC / HV_CLOCK_HZ);
 }
 
 static struct clocksource hyperv_cs_msr = {


