Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF762C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FAF3206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663048;
	bh=KgvnQajSgdueccwLmfJH3OzZtPwkXUgHAcvOeIma8FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GxOCbOHkTl5IiQYhhHS8Vf0wzq6zTa8BXQnwfYDnRau38vG7HRHhaqlPq71xBiuiK
	 tpy5oDLwbSEP4u4VqofUwZIhQpztu7afRrsS7NMSDE0Ua1bFVDk+gzSiNzBzYpz/sG
	 bwmd2p7kj0xPG3PwkM1qoOqI0b17/3VD2wPIH5SY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbgFIAhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbgFHXNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:13:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F1E621508;
        Mon,  8 Jun 2020 23:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658027;
        bh=KgvnQajSgdueccwLmfJH3OzZtPwkXUgHAcvOeIma8FI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yPLB5QCTWG7RIVoWM9RyVITuriXEiuSbGafXPYntjL4NKjM3EExCOc4mUeIWMmudB
         l4lkUeXEYP9jk+ta7HJ03IJQ5IB1bVOVzm3fcy1se4FKw8G9kI4AWMBIDIDmFqSpg5
         wvnBsogw4beIeFWR4Do72NBkiSq9kMpaelihwh0w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 079/606] Linux 5.6.14
Date:   Mon,  8 Jun 2020 19:03:24 -0400
Message-Id: <20200608231211.3363633-79-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7afb6942d3f7..713f93cceffe 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 6
-SUBLEVEL = 13
+SUBLEVEL = 14
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
-- 
2.25.1

