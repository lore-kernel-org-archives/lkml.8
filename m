Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D93FC33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDF02084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738610;
	bh=YNKS4Tm3ked/WoWgQbe7SvOeinH9G+RC3XdjwiMRG3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vay1IaL3MGkqJz9OtxbbExDbCQmU4neduAnquIKcWkMGUWnc/0do9n8OczlVU8k3T
	 RDQSuM7Sx3fjuThS+1NRhh6qUGULjlVOUqmihHBrkqWiOKAYalLcca9XugVTEQcfmB
	 riARtvt3ni9r/QpgW++v704Kzt35ktMHZ7skP3G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbgAKKaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbgAKKaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:30:08 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BFFD20842;
        Sat, 11 Jan 2020 10:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738608;
        bh=YNKS4Tm3ked/WoWgQbe7SvOeinH9G+RC3XdjwiMRG3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iLrfdQOqMeo4/qAA4UVjaymkuud8EvLHyCSlhqb3mvT9lUiy550omOG9P0UzY0VwB
         NW12P2T2nAMbhnj5vEeIkXUAVSqo+NrxqLHRA6J1WNWh1yeOTBjRjDx1akgPNW3+ZI
         GVwBIaX0uG8pX3ZNm4owcqf+RGhjQBRFmD951zrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Li <liwei391@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 124/165] arm64: cpu_errata: Add Hisilicon TSV110 to spectre-v2 safe list
Date:   Sat, 11 Jan 2020 10:50:43 +0100
Message-Id: <20200111094934.506469863@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Li <liwei391@huawei.com>

[ Upstream commit aa638cfe3e7358122a15cb1d295b622aae69e006 ]

HiSilicon Taishan v110 CPUs didn't implement CSV2 field of the
ID_AA64PFR0_EL1, but spectre-v2 is mitigated by hardware, so
whitelist the MIDR in the safe list.

Signed-off-by: Wei Li <liwei391@huawei.com>
[hanjun: re-write the commit log]
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpu_errata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 93f34b4eca25..96f576e9ea46 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -575,6 +575,7 @@ static const struct midr_range spectre_v2_safe_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
 	MIDR_ALL_VERSIONS(MIDR_BRAHMA_B53),
+	MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
 	{ /* sentinel */ }
 };
 
-- 
2.20.1



