Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA491C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF07120738
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596586263;
	bh=GirLEaU2UtwQcwdoezaA/I2WCWcjM942s/RMh81s37k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bb8GI6KiXtvy+EYIqExAA+CL9hyGGDznQNAOe/+gCNhE0v7OvYD9LocZMVACWny3j
	 sbTC1fDnSI6lmLcHG5Mz1M+QPRaQoGDgg8jY0+SO8LBR2woAheYnzcek4kToT6oQjs
	 S2QCZB522W85fxw3t3Ih+84KaS8lluqMArK90Keg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgHEALC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgHEAK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA4282177B;
        Wed,  5 Aug 2020 00:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586258;
        bh=GirLEaU2UtwQcwdoezaA/I2WCWcjM942s/RMh81s37k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPx5MgcPn0FED75vz79HrWKWwRKJ2bfVLAqaSuAnJwoRgR0p3SDQ0ky5oDzgZg7mr
         vNtkUlTlYtbZ/9NXwUmIF+LvjT6yCmV+I58OjXni4Dw7LxGnwF1swAI3RPpA/tPBqy
         K+CybKY2rVwsLnmm1flv3PiiABzOatZM6VBLsIhw=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 14/14] tools/kernel.h: hide task_struct.hardirq_chain_key
Date:   Tue,  4 Aug 2020 20:10:43 -0400
Message-Id: <20200805001043.3331907-15-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a result of c86e9b987cea ("lockdep: Prepare for noinstr sections") we need
to hide hardirq_chain_key from userspace to avoid a build error.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/lockdep.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/linux/lockdep.h b/tools/include/linux/lockdep.h
index 4e5f31f28ca3e..b6c9e81eb45e5 100644
--- a/tools/include/linux/lockdep.h
+++ b/tools/include/linux/lockdep.h
@@ -40,6 +40,7 @@ struct task_struct {
 	unsigned long hardirq_disable_ip, hardirq_enable_ip;
 	unsigned int hardirq_disable_event, hardirq_enable_event;
 	int softirq_context, hardirq_context;
+	unsigned long hardirq_chain_key;
 	char comm[17];
 };
 
-- 
2.25.1

