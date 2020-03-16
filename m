Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFA0C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E23820674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZSyiK0rT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbgCPSIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:08:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53454 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732242AbgCPSIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:08:25 -0400
Received: from zn.tnic (p200300EC2F06AB00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:ab00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E85871EC0C84;
        Mon, 16 Mar 2020 19:08:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584382103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BWcGdDqsDLKukOwUdjv1uByG4xJeZMLjRXLsayzjkaE=;
        b=ZSyiK0rTzOfdUWBy80UPgJ1F0kWy8AOIcOnfpO9jCLDjyguTmras8/gvB0ruNU4J4pCt01
        +71UQAiN0kbs6IOtbYrBWwZ++25bwdK+amIA6DKyPWMM7VF99h92dJDCPIXC3lbwmSHak+
        fNBIFlrCFGDhvqUpFyXoRWC0TTLU4Ns=
Date:   Mon, 16 Mar 2020 19:08:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Wei Huang <wei.huang2@amd.com>
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        yazen.ghannam@amd.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, linux-edac@vger.kernel.org, x86@kernel.org,
        smita.koralahallichannabasappa@amd.com
Subject: Re: [PATCH 1/1] x86/mce/amd: Add PPIN support for AMD MCE
Message-ID: <20200316180829.GP26126@zn.tnic>
References: <20200311044409.2717587-1-wei.huang2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311044409.2717587-1-wei.huang2@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:44:09PM -0500, Wei Huang wrote:
> Newer AMD CPUs support the feature of protected processor identification
> number (PPIN). This patch detects and enables PPIN support on AMD platforms

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> and includes PPIN info in MCE records if available. Because this feature is
> almost identical on both Intel and AMD, it re-uses X86_FEATURE_INTEL_PPIN
> feature bit and renames it to X86_FEATURE_PPIN.

Strictly speaking, you can't rename it anymore because it is visible in
/proc/cpuinfo and thus ABI.

Besides, we have already a cpufeatures.h leaf for exactly that word:

/* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */

which means you can call the AMD define

#define X86_FEATURE_AMD_PPIN               ( 13*32+23) /* AMD Protected Processor Inventory Number */

and /proc/cpuinfo will have "amd_ppin" and the code will use the
respective vendor flag to test.

> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Smita Koralahalli Channabasappa <smita.koralahallichannabasappa@amd.com>

What does this SOB mean? Grep Documentation/ for "Co-developed-by" in
case this is what you're trying to express.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
