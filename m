Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E042C47247
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799132184D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589045836;
	bh=lCmbhHyFSvR8ipmtonVqDpN7IU+xGXfjR90A+02sw4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F6q8mNNWEdKdXkIZSYN3okdB2tKkpgVLE22L6KUVAvVmXKYqBJLWiSgMb7Zgfu6qs
	 sBcKtWkakwv8jwgroeRM08n/76vTdiEUNESQRnB2r75DQerexWBELK2XYgLvrHhzin
	 6DXYbWP+ASr6aC5eMaYiGOZ8C0rBTeml1uLFl1gU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgEIRhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 13:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbgEIRhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 13:37:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CC4F24954;
        Sat,  9 May 2020 17:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589045831;
        bh=lCmbhHyFSvR8ipmtonVqDpN7IU+xGXfjR90A+02sw4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1cx+zlgzqCAoS2+B/jPtyuBasegbXTU8iLEoAPOsLYZN5Qjcc77QQrslzV1HvQpo
         S3BW2EIWVIgJ6L/GLbaEAIVipfzEJUPcKHO0Uego798438br7Y3A01BCRAr+8gX3Ys
         /MvEYxyp7qaFMn0/DrBpzDaGVk7yDR18CXdXf5v0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v11 08/18] x86/entry/64: Document GSBASE handling in the paranoid path
Date:   Sat,  9 May 2020 13:36:45 -0400
Message-Id: <20200509173655.13977-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509173655.13977-1-sashal@kernel.org>
References: <20200509173655.13977-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
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

