Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC20C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1702070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262079;
	bh=JPe1lrDpA9xuwFElMoTI7X4eMCC3D4qGTTzu5bmtCbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gDnvOT4KAImpXn1FwMHRpSBUG7ofW485b+Apwqmj9n0glZx7pWFwFZk5TqibqcOf3
	 qg2J8dXPz7+2/mHuvTxC8AsSx2aIMXDOqTKtHATQ1Emy/ZM0B9YxYj4zRZ/Q8jzusq
	 1zBqw7lSi8WSiIgVpWoEu/B8yNcufFJgWH9FdmiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbgGTQVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387404AbgGTQIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:08:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAECA206E9;
        Mon, 20 Jul 2020 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261312;
        bh=JPe1lrDpA9xuwFElMoTI7X4eMCC3D4qGTTzu5bmtCbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkrcc3rPYa/Yyy/hYybYNgPwfShShAOsGgsD6VkHOzUnL2IEB+tZo/XH95CCWMEly
         LRLe09G4dhLCcSY7O26N4NoAxirU0YFGyBBzc73glAqV52Vk6524p0VxlGnPkb1Bu2
         tl7viYOgfXf+SG/wf5wjlYkLYvwJvG/MLqKA/Iuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 069/244] arm64: Add missing sentinel to erratum_1463225
Date:   Mon, 20 Jul 2020 17:35:40 +0200
Message-Id: <20200720152829.133440198@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 09c717c92b52df54918e12cbfe6a4658233fda69 ]

When the erratum_1463225 array was introduced a sentinel at the end was
missing thus causing a KASAN: global-out-of-bounds in
is_affected_midr_range_list on arm64 error.

Fixes: a9e821b89daa ("arm64: Add KRYO4XX gold CPU cores to erratum list 1463225 and 1418040")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Link: https://lore.kernel.org/linux-arm-kernel/CA+G9fYs3EavpU89-rTQfqQ9GgxAMgMAk7jiiVrfP0yxj5s+Q6g@mail.gmail.com/
Link: https://lore.kernel.org/r/20200709051345.14544-1-f.fainelli@gmail.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpu_errata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index dbf266212808e..f9387c1252325 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -778,6 +778,7 @@ static const struct midr_range erratum_1463225[] = {
 	MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 3, 1),
 	/* Kryo4xx Gold (rcpe to rfpf) => (r0p0 to r3p1) */
 	MIDR_RANGE(MIDR_QCOM_KRYO_4XX_GOLD, 0xc, 0xe, 0xf, 0xf),
+	{},
 };
 #endif
 
-- 
2.25.1



