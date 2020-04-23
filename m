Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1165C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C6420780
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587684192;
	bh=Tz5CMnRcgkpz8IB+Wui6WEZE0CTms+oTNEix0tZQyJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m8SAIG/sDptow32DEhVaBG1DGtW6qzIpiGp0Jjil9c40Y2BpS5SvY53kSubAoUuGz
	 p/qDvK8HDMVe7wMevdm44yMWRZvLhhqdc+IHG2B8YYyc+XuFXkc4+7N5kRwoC0Tbub
	 uBr0yjdLPP/mSzOtfa3hoDntdmcHGVDcnuUWasXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgDWXXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729046AbgDWXWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:22:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 875892173E;
        Thu, 23 Apr 2020 23:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587684142;
        bh=Tz5CMnRcgkpz8IB+Wui6WEZE0CTms+oTNEix0tZQyJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IPUWZAivfv9yKjnNJ2u73Rk396kd8ENGwXuoH6pEOonVOMb9CZrxwJtwBatPEz3Mf
         HpwdizD9NxT8fnGtxsZIJUMokTapcdH1A+R32swmRV/zRsaE+J71Xsw0bWuCUouwHF
         jNXEjV3OU0jYAAtrhlQPV94X5o55Na26aU23HxI0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v10 08/18] x86/entry/64: Document GSBASE handling in the paranoid path
Date:   Thu, 23 Apr 2020 19:21:57 -0400
Message-Id: <20200423232207.5797-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423232207.5797-1-sashal@kernel.org>
References: <20200423232207.5797-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

On FSGSBASE systems, the way to handle GS base in the paranoid path is
different from the existing SWAPGS-based entry/exit path handling. Document
the reason and what has to be done for FSGSBASE enabled systems.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/x86/entry_64.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/x86/entry_64.rst b/Documentation/x86/entry_64.rst
index a48b3f6ebbe87..0499a40723af3 100644
--- a/Documentation/x86/entry_64.rst
+++ b/Documentation/x86/entry_64.rst
@@ -108,3 +108,12 @@ We try to only use IST entries and the paranoid entry code for vectors
 that absolutely need the more expensive check for the GS base - and we
 generate all 'normal' entry points with the regular (faster) paranoid=0
 variant.
+
+On FSGSBASE systems, however, user space can set GS without kernel
+interaction. It means the value of GS base itself does not imply anything,
+whether a kernel value or a user space value. So, there is no longer a safe
+way to check whether the exception is entering from user mode or kernel
+mode in the paranoid entry code path. So the GS base value needs to be read
+out, saved and the kernel GS base value written. On exit, the saved GS base
+value needs to be restored unconditionally. The non-paranoid entry/exit
+code still uses SWAPGS unconditionally as the state is known.
-- 
2.20.1

