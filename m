Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C921BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CD0246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196086;
	bh=tO9+NvN2CHz+pMQCJlzm6srVxp0TIkGcSiB03L9otBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eUIZOaexx8Xmgk+FFRvHwBKsiXIE3LM2fUKYvdWtlNzMmqajgYKBevNvf+QCxRNkg
	 BMJrsWE4M5ug5MeEkdsTTCcGR2EibsLruaY+X8cLy83H85A9d1qPe8CeGg/DYrFIvB
	 AiL+Fpqws025poDkg7q+xPPFNIDVaH4O2AKacJU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393017AbgAPRep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:34:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392946AbgAPRaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:30:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56E7424714;
        Thu, 16 Jan 2020 17:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195804;
        bh=tO9+NvN2CHz+pMQCJlzm6srVxp0TIkGcSiB03L9otBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBnNZQ9cAKG0BNNHU6cItUbCcKa8wO0YS4gNDDH2hfF/lTxCrlp0G4cUdhpDA/NGG
         Om4efV2xfN5nDRuCI4ZTAugI48UC1eWn9jZTPHa+75C7nMf9aAb67Ph1ryNkg6X7eW
         lvBCIxJxKu052ePwfTT9PEFovjKw7gY/6OC2vBC0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 318/371] net: avoid possible false sharing in sk_leave_memory_pressure()
Date:   Thu, 16 Jan 2020 12:23:10 -0500
Message-Id: <20200116172403.18149-261-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 503978aca46124cd714703e180b9c8292ba50ba7 ]

As mentioned in https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE#it-may-improve-performance
a C compiler can legally transform :

if (memory_pressure && *memory_pressure)
        *memory_pressure = 0;

to :

if (memory_pressure)
        *memory_pressure = 0;

Fixes: 0604475119de ("tcp: add TCPMemoryPressuresChrono counter")
Fixes: 180d8cd942ce ("foundations of per-cgroup memory pressure controlling.")
Fixes: 3ab224be6d69 ("[NET] CORE: Introducing new memory accounting interface.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 90ccbbf9e6b0..03ca2f638eb4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2165,8 +2165,8 @@ static void sk_leave_memory_pressure(struct sock *sk)
 	} else {
 		unsigned long *memory_pressure = sk->sk_prot->memory_pressure;
 
-		if (memory_pressure && *memory_pressure)
-			*memory_pressure = 0;
+		if (memory_pressure && READ_ONCE(*memory_pressure))
+			WRITE_ONCE(*memory_pressure, 0);
 	}
 }
 
-- 
2.20.1

