Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93E0C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA00122BEF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752893;
	bh=RBIbnZzztTdxZ/SbCqbKeaEtPBUQ+wEz5vBOHX/Wrjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aAtMcVk0Bqv+ET/JxLG9T3eblyoR/ryBBMjnFhog9Ve8qP0psfeVQ9iu97v3/2C58
	 8YP3unlHSw67TeZO6vtiSdvHs/OHF+4fAAPyL3P49fF7AfbAQvP6tJCP568HYTXAg/
	 dnrmwhWzxkG6JDp6hcKagl5mzXfdcwvyhdXQeGvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgGNSyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729677AbgGNSyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:54:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79E6A22BEF;
        Tue, 14 Jul 2020 18:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752886;
        bh=RBIbnZzztTdxZ/SbCqbKeaEtPBUQ+wEz5vBOHX/Wrjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcf8IYg8ZQUA52/SWeFSIEydXtjwoW1lsuyLZFJen9hiWkQXvaQlV4GyGDw14mVEw
         /JjQsXHpAEqZzNfdfFYteuF2FbxrFs4etdi/LaXd6nkwg+vJuJFCtbjiCE5QIUmZcC
         N5JwB5EY1hhsL36a0xDvM+/Gsm2UEKDJWTGv5WaI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 038/166] arm64: kpti: Add KRYO{3, 4}XX silver CPU cores to kpti safelist
Date:   Tue, 14 Jul 2020 20:43:23 +0200
Message-Id: <20200714184117.703665553@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

[ Upstream commit f4617be35b4b547e82d30993f56d631dfc2d5f88 ]

QCOM KRYO{3,4}XX silver/LITTLE CPU cores are based on Cortex-A55
and are meltdown safe, hence add them to kpti_safe_list[].

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Link: https://lore.kernel.org/r/20200624123406.3472-1-saiprakash.ranjan@codeaurora.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9fac745aa7bb2..b0fb1d5bf2235 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1059,6 +1059,8 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 		MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
 		MIDR_ALL_VERSIONS(MIDR_NVIDIA_CARMEL),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_SILVER),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_SILVER),
 		{ /* sentinel */ }
 	};
 	char const *str = "kpti command line option";
-- 
2.25.1



