Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32559C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027532072A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326055;
	bh=SrkKK2cHQEUZID7PZ8xTPnqkOQtsZ2PQBLGVpEUQFQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=toGtvex6SvQwhwb8PZUiN3111+uUN8sA8PrmLRsuXeZm7ASCV2Ro5BAThIvGe9hcu
	 FzG4m4cAw3Ce7eZWgNGf9sOJyWVMXthKoArnbKuM1Y303hUfD/H2Ih2uFiwSWbcYLG
	 viHGejyvSVzrOq6w5gFvPxlMMQAzmN6NTpBOSHJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgCPCeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729770AbgCPCeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:34:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BAC320724;
        Mon, 16 Mar 2020 02:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326048;
        bh=SrkKK2cHQEUZID7PZ8xTPnqkOQtsZ2PQBLGVpEUQFQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UgHir014DyBWELC3QV/zGRKxs0b5zVaj7iFLVE8ePxgHM0G+v5N9pebrpwQmaJMQC
         FUI8X82a/hB+K6pPpLjixs418PKj2sF2WAB3AG8ysfeW6Jv3AN2FOY/FWGGGYQv1rW
         viMFhZH+TGaCTwMPDyaYIGJimwVwC5l0cREX8XAc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 40/41] parse-maintainers: Mark as executable
Date:   Sun, 15 Mar 2020 22:33:18 -0400
Message-Id: <20200316023319.749-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023319.749-1-sashal@kernel.org>
References: <20200316023319.749-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

[ Upstream commit 611d61f9ac99dc9e1494473fb90117a960a89dfa ]

This makes the script more convenient to run.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/parse-maintainers.pl | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 scripts/parse-maintainers.pl

diff --git a/scripts/parse-maintainers.pl b/scripts/parse-maintainers.pl
old mode 100644
new mode 100755
-- 
2.20.1

