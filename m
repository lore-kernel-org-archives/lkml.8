Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75038C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CAD02087D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XZh+cG3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgHUJHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHUJHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:07:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EED6C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:07:18 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0eda003935e3317bb76801.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:da00:3935:e331:7bb7:6801])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F34BB1EC03A0;
        Fri, 21 Aug 2020 11:07:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598000836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tFBtdIgFkDAtv391DKNWHLqjYSEZHMmZOnl+IsK8uiY=;
        b=XZh+cG3LjuGCagyceQeWByAKv9iiIp9PqyomV5vaG8vWVeRxuiUcTTPT6AArLB+PEbEK7c
        njnUtIsBZ6rRz57Eiz04IJ5ZSLZjHyF4jsv0ZRTOXu158ATSafn86rsG8TR+uulgVrEEQi
        AGyAly8tnCAYvXI4kNLy8fengE+Ux0M=
Date:   Fri, 21 Aug 2020 11:07:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -v2] x86/entry/64: Correct the comment over
 SAVE_AND_SET_GSBASE
Message-ID: <20200821090710.GE12181@zn.tnic>
References: <20200820091544.26564-1-bp@alien8.de>
 <6236F23E-B26A-4141-AD2E-9403CFF726D3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6236F23E-B26A-4141-AD2E-9403CFF726D3@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 06:04:50PM +0000, Bae, Chang Seok wrote:
> I think somehow the “MSR write” made confusion. Our conclusion was the 
> same as Thomas' that no FENCE is needed here.

Ok, here's v2 with a corrected comment:

---
From: Borislav Petkov <bp@suse.de>

Add the proper explanation why an LFENCE is not needed in the FSGSBASE
case.

Fixes: c82965f9e530 ("x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit")
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/entry/entry_64.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 26fc9b42fadc..5c5d234d968d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -840,8 +840,9 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 * retrieve and set the current CPUs kernel GSBASE. The stored value
 	 * has to be restored in paranoid_exit unconditionally.
 	 *
-	 * The MSR write ensures that no subsequent load is based on a
-	 * mispredicted GSBASE. No extra FENCE required.
+	 * The unconditional write to GS base below ensures that no subsequent
+	 * loads based on a mispredicted GS base can happen, therefore no LFENCE
+	 * is needed here.
 	 */
 	SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
 	ret
-- 
2.21.0

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
