Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2009DC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0D3207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202314;
	bh=bmRdvpHD39WBfm6lyhHhVIBGEfuGksgspOgTMV/qZjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TrW16ijT88Oa+l3aUhO/QqtxTVSteBNNE0oXeS53d9LZXgxxUni0GKZM2wYbq8DMI
	 6gZ3ABnDVVc82Ul3pRfQExOkOzDmgIqRKxkMQmQdRBVErtFNG2oRbkjix/tIPftNVi
	 h5cRIZ4Hm9QMef3aOUDBC0R0gWMHsewgq8kf0g1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbgAPQyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:54:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731727AbgAPQyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:54:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B4C9205F4;
        Thu, 16 Jan 2020 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193660;
        bh=bmRdvpHD39WBfm6lyhHhVIBGEfuGksgspOgTMV/qZjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/oXsbNinds7DSo4J5C7vSQMg8GB/TGVYrtbnw6yjuyNZO21BnSfgnGc7xgaZKBE0
         LcTvxoluul+X5BeaKI5K61RBHHq/1+qW63EtrHxQWbXif3q4QOpeEH1zRlXms5gaO9
         OBKS1YiRm8+qh7AON7mOCF26Sp7WyWeWfnQGJd/0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Victorien Molle <victorien.molle@wifirst.fr>,
        Florent Fourcot <florent.fourcot@wifirst.fr>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, cake@lists.bufferbloat.net,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 188/205] sch_cake: Add missing NLA policy entry TCA_CAKE_SPLIT_GSO
Date:   Thu, 16 Jan 2020 11:42:43 -0500
Message-Id: <20200116164300.6705-188-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victorien Molle <victorien.molle@wifirst.fr>

[ Upstream commit b3c424eb6a1a3c485de64619418a471dee6ce849 ]

This field has never been checked since introduction in mainline kernel

Signed-off-by: Victorien Molle <victorien.molle@wifirst.fr>
Signed-off-by: Florent Fourcot <florent.fourcot@wifirst.fr>
Fixes: 2db6dc2662ba "sch_cake: Make gso-splitting configurable from userspace"
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_cake.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dd0e8680b030..2277369feae5 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2184,6 +2184,7 @@ static const struct nla_policy cake_policy[TCA_CAKE_MAX + 1] = {
 	[TCA_CAKE_MPU]		 = { .type = NLA_U32 },
 	[TCA_CAKE_INGRESS]	 = { .type = NLA_U32 },
 	[TCA_CAKE_ACK_FILTER]	 = { .type = NLA_U32 },
+	[TCA_CAKE_SPLIT_GSO]	 = { .type = NLA_U32 },
 	[TCA_CAKE_FWMARK]	 = { .type = NLA_U32 },
 };
 
-- 
2.20.1

