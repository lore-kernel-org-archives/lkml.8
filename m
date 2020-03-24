Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F30C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B83206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056318;
	bh=SrkKK2cHQEUZID7PZ8xTPnqkOQtsZ2PQBLGVpEUQFQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XmBcBR7OkyFe8btOOXRps2dfUi+IGtl1vfx31TuA177TsTrXDdtvIB6Ulf3BEp0Os
	 QatfFHv2N2jNWtbhuR6C2CUwv6M557HfXzWx/lRVhEHU0vuOfqChxhnABCCe6tFz/V
	 sknPdMc/wlb4au/mB5FZkdl7qag0Yo9swUyGtCrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgCXNZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729353AbgCXNZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:25:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAEFB208E0;
        Tue, 24 Mar 2020 13:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056311;
        bh=SrkKK2cHQEUZID7PZ8xTPnqkOQtsZ2PQBLGVpEUQFQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/uJ21tpmrsYQm13l5k4QsQ/CdhDocsb8kIAf4GmoxQJVEL4CXTpA7WhtcIp6FV55
         k3Jp/XZiyFdvbKCoupD/ayrsrBsypsdeDTIpPlTRqMuH78T1fGh1sxWH39SGIRh0SF
         iIdthXH4neN0Chc5zgy0Ry+ZWLs9rT/2REHynpak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 038/119] parse-maintainers: Mark as executable
Date:   Tue, 24 Mar 2020 14:10:23 +0100
Message-Id: <20200324130812.192747323@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



