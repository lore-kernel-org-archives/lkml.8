Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEE2C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B1524673
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579046898;
	bh=1D17WKll4uo5KmAQ6zemir8nkMb0k1M+AUPjOoDka+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w0hoHzjTI2Zj83Zl4f/myRf+fYwckBFUqg92qbtlkQn66GJ6XhY0u1SScfitKFaFH
	 S6Qb4o1PZVYLx8FPWIVYgut0E8N5U61PJgTT9muSwkWQpHJT64UOfZ4AOzqywcaMwd
	 38zVVgJ6Pnb5ZttLBT7jSbDaWjG3oCgFkZ1MSXuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgAOAIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 19:08:17 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38731 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgAOAIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:08:17 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so6678951pje.3;
        Tue, 14 Jan 2020 16:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UVhvv7Uw/SgFERHeIFwqIjnjDKMcUs8QCM8cO0ODGvs=;
        b=QwXRtz6ZtM6G+tqUbhkJGknfdRRgPXfmleWgaFcV0+5kV4v//WTSvtYznEmOiejx65
         /6kQNHZO2Fva91D8XZQ09XwBzntwcH2pBJN4RPazq/bd24GFGZaqest9ow3rRo6L/1Kr
         cH8kjkm8v7ewVUDFHzy0qwfZmaU2RvxAM9Pdrz1diIElx45TRCUO1z/EVZ1oGZs9Oc2X
         oD5aoxp9xdElsGxYpU+XR868aHwVC8BwjPcqh1WB9j73LqfNbYwqvHVyxp5Al+1qK/2X
         nRBOgP0r25SrB5tVU7TkpGUbGBhmKc2phcyKAeRLGxMpYMx22YYT7pLEk4rMknb/nT2x
         WzJg==
X-Gm-Message-State: APjAAAXTZkrGuLPj6PyLv0okPRNYzusYdHaB67y4yv54uSZqorBdt9EZ
        GKl7gTVREbR8iRUz7/p+J2o=
X-Google-Smtp-Source: APXvYqxKDpCb5695gqAA8CnF5To4bJksFfluyEa5gZHP0dyuUd9Y8/GQ7bxiMoA3cYRSL85dQlfQiQ==
X-Received: by 2002:a17:90a:8986:: with SMTP id v6mr31645608pjn.90.1579046896533;
        Tue, 14 Jan 2020 16:08:16 -0800 (PST)
Received: from localhost (MIPS-TECHNO.ear1.SanJose1.Level3.net. [4.15.122.74])
        by smtp.gmail.com with ESMTPSA id c1sm19795475pfa.51.2020.01.14.16.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 16:08:15 -0800 (PST)
Date:   Tue, 14 Jan 2020 16:08:15 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Guoyun Sun <sunguoyun@loongson.cn>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Allison Randal <allison@lohutok.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  mips/vdso: Support mremap() for vDSO
Message-ID: <20200115000815.narpydp4unkkuboj@pburton-laptop>
References: <1578978808-18633-1-git-send-email-sunguoyun@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578978808-18633-1-git-send-email-sunguoyun@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guoyun,

On Tue, Jan 14, 2020 at 01:13:28PM +0800, Guoyun Sun wrote:
> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> index bc35f84..eac3982 100644
> --- a/arch/mips/kernel/vdso.c
> +++ b/arch/mips/kernel/vdso.c
> @@ -38,6 +38,28 @@ static struct vm_special_mapping vdso_vvar_mapping = {
>  	.pages = no_pages,
>  };
>  
> +int vdso_mremap(const struct vm_special_mapping *sm,
> +		       struct vm_area_struct *new_vma)
> +{
> +	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
> +
> +#ifdef CONFIG_MIPS32_O32
> +	if (vdso_image_o32.size != new_size)
> +		return -EINVAL;
> +#endif
> +
> +#ifdef CONFIG_MIPS32_N32
> +	if (vdso_image_n32.size != new_size)
> +		return -EINVAL;
> +#endif
> +
> +	if (vdso_image.size != new_size)
> +		return -EINVAL;
> +
> +	current->mm->context.vdso = (void __user *)(new_vma->vm_start);
> +	return 0;
> +}
> +

Thanks for the patch; this bit doesn't seem right though. It requires
that all the VDSOs be the same size, which seems questionable. I think
we probably need separate mremap callbacks for each VDSO, so that we can
check the appropriate VDSO size.

Thanks,
    Paul
