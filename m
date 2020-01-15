Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF3FC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027482084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LQY5WOLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgAONMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:12:16 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50636 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgAONMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:12:15 -0500
Received: from zn.tnic (p200300EC2F0C7700ACD7CA379FB916C9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:acd7:ca37:9fb9:16c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4C1E1EC02D2;
        Wed, 15 Jan 2020 14:12:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579093934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=f+uFY3ywa7zVMTIIWGNJsEI8zxzucRmE9+gtjYc9q8M=;
        b=LQY5WOLfbsvB2Wb3gIJ0lAUmKJANeqpwVYNiwTmVFMzpyDlvqKg4qpX4Zd5yTwjztEqPHZ
        2bnE05F5rQCwAtqIXkvIs1xB34ct5QkbS0jLtJ2m/VzP1i0/k5ltrSYzOg6Yj+1plXUhGq
        KZfuFdf/FdxVX6NxlsdUne8OfWES7ho=
Date:   Wed, 15 Jan 2020 14:12:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Christopher Head <bugs@chead.ca>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sysfb: Fix check for bad VRAM size
Message-ID: <20200115131206.GF20975@zn.tnic>
References: <20200107230410.2291947-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107230410.2291947-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 06:04:10PM -0500, Arvind Sankar wrote:
> When checking whether the reported lfb_size makes sense, we PAGE_ALIGN
> height * stride before seeing whether it exceeds the reported size.
> 
> This doesn't work if height * stride is not an exact number of pages.
> For example, as reported in kernel bugzilla linked, an 800x600x32 EFI
> framebuffer gets skipped because of this.
> 
> Move the PAGE_ALIGN to after the check vs size.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206051
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/kernel/sysfb_simplefb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/sysfb_simplefb.c b/arch/x86/kernel/sysfb_simplefb.c
> index 01f0e2263b86..298fc1edd9c9 100644
> --- a/arch/x86/kernel/sysfb_simplefb.c
> +++ b/arch/x86/kernel/sysfb_simplefb.c
> @@ -90,11 +90,11 @@ __init int create_simplefb(const struct screen_info *si,
>  	if (si->orig_video_isVGA == VIDEO_TYPE_VLFB)
>  		size <<= 16;
>  	length = mode->height * mode->stride;
> -	length = PAGE_ALIGN(length);
>  	if (length > size) {
>  		printk(KERN_WARNING "sysfb: VRAM smaller than advertised\n");
>  		return -EINVAL;
>  	}
> +	length = PAGE_ALIGN(length);
>  
>  	/* setup IORESOURCE_MEM as framebuffer memory */
>  	memset(&res, 0, sizeof(res));
> -- 

Christopher,

can I add your Reported-by: and Tested-by: tags to the patch?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
