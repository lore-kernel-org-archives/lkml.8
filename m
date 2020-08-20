Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B2EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EFB2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927967;
	bh=0pkLbZ3ecE1PW8MfK1EZfq9ZmaccVL2nFYhP+U3ugMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bAjYawJZIiJ45yEXTKn9lz3m5GSGZbwzNp46/kWaie/8HqBO4ElGSRStFgParn3Cf
	 9HxzPXxxKM6INEf/mdVT/onFNFRVV3sPJgOBaR/xcEYD8ngchzPiFyCOv40gHshHdQ
	 ArEfe+YMrYQapgMKIZI7FKKiFxFV+0nCpRfR2YNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgHTMwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729258AbgHTJni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:43:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1572207DE;
        Thu, 20 Aug 2020 09:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916617;
        bh=0pkLbZ3ecE1PW8MfK1EZfq9ZmaccVL2nFYhP+U3ugMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=So3GdkBPDNuDbnX4Mf1/Oa1EOXBzybH05Zt9b8Barb2CDxUNSClmd6tesQ7hZrBbD
         Jeh4+tIsScvKVcmmwJJz+gBnkqshSvq+dUcDDzDEUceGTqE7Y3dhfKu8R1qCecJlM/
         iFZJ4zsHVozIq2+IrMbao+wRq+cV8EUP6Kq2aJnw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dilip Kota <eswara.kota@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 161/204] x86/tsr: Fix tsc frequency enumeration bug on Lightning Mountain SoC
Date:   Thu, 20 Aug 2020 11:20:58 +0200
Message-Id: <20200820091614.262581605@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dilip Kota <eswara.kota@linux.intel.com>

[ Upstream commit 7d98585860d845e36ee612832a5ff021f201dbaf ]

Frequency descriptor of Lightning Mountain SoC doesn't have all the
frequency entries so resulting in the below failure causing a kernel hang:

    Error MSR_FSB_FREQ index 15 is unknown
    tsc: Fast TSC calibration failed

So, add all the frequency entries in the Lightning Mountain SoC frequency
descriptor.

Fixes: 0cc5359d8fd45 ("x86/cpu: Update init data for new Airmont CPU model")
Fixes: 812c2d7506fd ("x86/tsc_msr: Use named struct initializers")
Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/211c643ae217604b46cbec43a2c0423946dc7d2d.1596440057.git.eswara.kota@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/tsc_msr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 4fec6f3a1858b..a654a9b4b77c0 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -133,10 +133,15 @@ static const struct freq_desc freq_desc_ann = {
 	.mask = 0x0f,
 };
 
-/* 24 MHz crystal? : 24 * 13 / 4 = 78 MHz */
+/*
+ * 24 MHz crystal? : 24 * 13 / 4 = 78 MHz
+ * Frequency step for Lightning Mountain SoC is fixed to 78 MHz,
+ * so all the frequency entries are 78000.
+ */
 static const struct freq_desc freq_desc_lgm = {
 	.use_msr_plat = true,
-	.freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 },
+	.freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000,
+		   78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 },
 	.mask = 0x0f,
 };
 
-- 
2.25.1



