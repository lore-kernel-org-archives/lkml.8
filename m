Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F88C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F845208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055550;
	bh=SrkKK2cHQEUZID7PZ8xTPnqkOQtsZ2PQBLGVpEUQFQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z2TKe7JcOwqMsSF+6DiXnzPg4Ra7IXZmkZiNFliC7wBZnt9sTMRo3DHIItCgOoeZx
	 oAxPcusdjKKo+l/3EwxjN4wVj4m2jMMGH4SCDdgckxu7BcKSBuMy/0evXTv34/Wzw4
	 A4HX1ycLI+J8SIWygS9KkD7HPtrqWRT8ob3ZYukI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgCXNM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbgCXNMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:12:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F249D20775;
        Tue, 24 Mar 2020 13:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055543;
        bh=SrkKK2cHQEUZID7PZ8xTPnqkOQtsZ2PQBLGVpEUQFQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVoDFJVnPZJCfbcMt3WYLHnb8Yw9XvNlzh3qCWaZdoTWerYUCFPpKyVIONYTL0Zr+
         +mzrodpawH3yJheLeLw8nI0qfVJdvEAhmMIU3xUsKRBd/reM5N0WxBIgDSeq3GmPTV
         vaD6XgqfL7o+dSI+lWcsLinRenIygouSj7ruDAlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 19/65] parse-maintainers: Mark as executable
Date:   Tue, 24 Mar 2020 14:10:40 +0100
Message-Id: <20200324130759.445503124@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
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



