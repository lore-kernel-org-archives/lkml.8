Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FBEC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF97F20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274824;
	bh=Ni2uE3UrzUOKeHuUBp47BRf/YTw6+RTDvh2UjhiuMWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aWgKMaPbmgr+J4jrJUEpm9aIz4QPCfyGe4mircfP2nbD+6JFB+TxMdKw7ZVMv5MYe
	 eZpQopqmtCdk9v7w8ZHL5lEVhMs5kgZVIzVjIvScN3SP4YIipiKXNUwUpTLrqnRRef
	 KmYT0RHdZn4mzgkXVE8DN1Swrg17tNU20BO+LKEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgBUHtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:49:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729216AbgBUHtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:49:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E1D3207FD;
        Fri, 21 Feb 2020 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271349;
        bh=Ni2uE3UrzUOKeHuUBp47BRf/YTw6+RTDvh2UjhiuMWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vJAfNnHGhd1GfWZ1pvvzkEp75RfaRNDMwkArKaGS28OHAtvWdvl138nNDlIK6GPCL
         WJlspvrVKFWBr/if3cNod4GAof2chTX3I9SiqEKlICA4ckMjmqS+5iwkWgHsYhuxmG
         OC1V2iIEkQU4rHa5/sAI0xbJuYdKEpcqXhjKcvvg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 132/399] IMA: Check IMA policy flag
Date:   Fri, 21 Feb 2020 08:37:37 +0100
Message-Id: <20200221072415.299614924@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

[ Upstream commit c5563bad88e07017e08cce1142903e501598c80c ]

process_buffer_measurement() may be called prior to IMA being
initialized (for instance, when the IMA hook is called when
a key is added to the .builtin_trusted_keys keyring), which
would result in a kernel panic.

This patch adds the check in process_buffer_measurement()
to return immediately if IMA is not initialized yet.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d7e987baf1274..9b35db2fc777a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -655,6 +655,9 @@ void process_buffer_measurement(const void *buf, int size,
 	int action = 0;
 	u32 secid;
 
+	if (!ima_policy_flag)
+		return;
+
 	/*
 	 * Both LSM hooks and auxilary based buffer measurements are
 	 * based on policy.  To avoid code duplication, differentiate
-- 
2.20.1



