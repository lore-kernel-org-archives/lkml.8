Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B392CC2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9E620675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646279;
	bh=DxBXlCIzZHzAj+ZppowjceNLqo4ZsjCEnpsNfurN90o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aaBTbL/1+1F+fB4zrYyG9Jkho/10SqjbTn/2+XULRz+AzLui5k7h208Qcfp0QLVsy
	 XgbKaYbUci8AfXlERw3SHlZz9F1TF09tuSSZZLU3uIKxVRMXeqdG5Vj9dVv7shqQiz
	 xOkkmud9R/4y3kYmUgnmYBedlL7Xu9Tdn+FXSSsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbgCaJR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731899AbgCaJR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:17:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECD7F20675;
        Tue, 31 Mar 2020 09:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646276;
        bh=DxBXlCIzZHzAj+ZppowjceNLqo4ZsjCEnpsNfurN90o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t+H4QtWEfYXAU+JaDsXbHlBxySOvL3oNwCRgw7L0eBxpT0iTBK3hDHVyux7yZDyf+
         qwaXuqJg4O24Su32UHtLHLuKs7Q9IoCgf/c6fxpLUalcl1bgmk2p9//EeiKSZ1V2mV
         WMyNdALEiFjAbNR+uG0EFB+6g3hJhKS1NjtknrpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 135/155] clocksource/drivers/hyper-v: Untangle stimers and timesync from clocksources
Date:   Tue, 31 Mar 2020 10:59:35 +0200
Message-Id: <20200331085433.357680618@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
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
@@ -233,7 +233,8 @@ static u64 notrace read_hv_clock_tsc(str
 
 static u64 read_hv_sched_clock_tsc(void)
 {
-	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
+	return (read_hv_clock_tsc(NULL) - hv_sched_clock_offset) *
+		(NSEC_PER_SEC / HV_CLOCK_HZ);
 }
 
 static struct clocksource hyperv_cs_tsc = {
@@ -258,7 +259,8 @@ static u64 notrace read_hv_clock_msr(str
 
 static u64 read_hv_sched_clock_msr(void)
 {
-	return read_hv_clock_msr(NULL) - hv_sched_clock_offset;
+	return (read_hv_clock_msr(NULL) - hv_sched_clock_offset) *
+		(NSEC_PER_SEC / HV_CLOCK_HZ);
 }
 
 static struct clocksource hyperv_cs_msr = {


