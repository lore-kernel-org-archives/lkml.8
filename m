Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8412EC10F29
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523F5206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326142;
	bh=SrkKK2cHQEUZID7PZ8xTPnqkOQtsZ2PQBLGVpEUQFQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p/6Y/pYWlfZzRqHLBom+hYCtqf5I+7bvzjUUdpRBaEcfynz29dcTiXFoOWvtR0cTU
	 ALkrXwJ3WZVq1cLj3hz0Lvua73GDytbh/5VKDeipw8IMPSD+XyrujnmHiaTwHa/w+X
	 bGtxozINgz7pQb5pZ994N0b1YvqXA7HHMDVPLWyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgCPCfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730214AbgCPCfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:35:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F33272073C;
        Mon, 16 Mar 2020 02:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326137;
        bh=SrkKK2cHQEUZID7PZ8xTPnqkOQtsZ2PQBLGVpEUQFQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oRArfrppGfipkHmlHooCa/erQ7utvKWVhlrTZpHjBMnQ0p/2qFPqx8I6rVjWFzeJU
         1t2+VPrOZIBQ9TJSI8QzS+LgOJAUbzeA17mOLUsOH6A6E9Fc4wXnkHT9kWLWySPu+v
         fM5f4yFL89gO+f09EVkwpQVLwmrKlIaAweIAR228=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 15/15] parse-maintainers: Mark as executable
Date:   Sun, 15 Mar 2020 22:35:19 -0400
Message-Id: <20200316023519.2050-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023519.2050-1-sashal@kernel.org>
References: <20200316023519.2050-1-sashal@kernel.org>
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

