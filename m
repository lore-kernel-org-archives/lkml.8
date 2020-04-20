Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A5FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A3720A8B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fynmVLdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgDTJbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725775AbgDTJbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:31:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC81C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 02:31:37 -0700 (PDT)
Received: from zn.tnic (p200300EC2F08140068F64889F873250A.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:1400:68f6:4889:f873:250a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5221D1EC0469;
        Mon, 20 Apr 2020 11:31:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587375096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CXhTfvXi11xyHHW7Yd77e/vXQQSj/cvzXDUeJIedA8g=;
        b=fynmVLdY6AUb68D6SdKAM4i7yRswJcGa/nZw0Ce5PtMXYuLkgWosT91CehApC5vMx+21lk
        Y+mGSvvLzToXwGFDVC6oYYlClGr866kd49Yqjn0u0XdohWOiLdU/+zAdxfhrUQWPAR9v+q
        BU2sMXvgX5YPZnaaHzu+8TASg8aaJZE=
Date:   Mon, 20 Apr 2020 11:31:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Evalds Iodzevics <evalds.iodzevics@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] x86/microcode/intel: replace sync_core() with
 native_cpuid_reg(eax)
Message-ID: <20200420093129.GA21839@zn.tnic>
References: <20200420120037.1537-1-evalds.iodzevics@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200420120037.1537-1-evalds.iodzevics@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 03:00:37PM +0300, Evalds Iodzevics wrote:
> sync_core() always jums past cpuid instruction on 32 bit machines
> because data structure boot_cpu_data are not populated so early in boot.

I'm guessing because boot_cpu_data.cpuid_level is not properly set and
very early code in head_32.S sets it to -1 temporarily until the highest
CPUID level has been detected (or not).

But the microcode loading happens *before* that.

I'd probably be interested how you trigger that but since the backport
got changed (see below) and yours is correcting it to the upstream
variant then perhaps maybe I don't care that much. :)

> It depends on commit 5dedade6dfa243c130b85d1e4daba6f027805033 for
> native_cpuid_reg(eax) definitions
> 
> This patch is for 4.4 but also should apply to 4.9
> 
> Signed-off-by: Evalds Iodzevics <evalds.iodzevics@gmail.com>
> ---
>  arch/x86/include/asm/microcode_intel.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
> index 90343ba50485..92ce9c8a508b 100644
> --- a/arch/x86/include/asm/microcode_intel.h
> +++ b/arch/x86/include/asm/microcode_intel.h
> @@ -60,7 +60,7 @@ static inline u32 intel_get_microcode_revision(void)
>  	native_wrmsrl(MSR_IA32_UCODE_REV, 0);
>  
>  	/* As documented in the SDM: Do a CPUID 1 here */
> -	sync_core();
> +	native_cpuid_eax(1);
>  
>  	/* get the current revision from MSR 0x8B */
>  	native_rdmsr(MSR_IA32_UCODE_REV, dummy, rev);
> -- 

Hrm, the original patch of mine did use native_cpuid_eax():

4167709bbf82 ("x86/microcode/intel: Add a helper which gives the microcode revision")

but the backport:

commit 98cc1464cfd6edf9dc7fa96aaaf596aae952029b
Author: Borislav Petkov <bp@suse.de>
Date:   Mon Jan 9 12:41:45 2017 +0100

    x86/microcode/intel: Add a helper which gives the microcode revision
    
    commit 4167709bbf826512a52ebd6aafda2be104adaec9 upstream.
    
    Since on Intel we're required to do CPUID(1) first, before reading
    the microcode revision MSR, let's add a special helper which does the
    required steps so that we don't forget to do them next time, when we
    want to read the microcode revision.
    
    Signed-off-by: Borislav Petkov <bp@suse.de>
    Link: http://lkml.kernel.org/r/20170109114147.5082-4-bp@alien8.de
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    [bwh: Backported to 4.4:
     - Don't touch prev_rev variable in apply_microcode()
     - Keep using sync_core(), which will alway includes the necessary CPUID
     	^^^^^^^^^^^^^^^^^^^

decided to use sync_core() for whatever reason. Perhaps because the
native_cpuid* things weren't there. Adding Ben to Cc.

I believe this is the background info Greg needed to figure out *why*
you're doing this.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
