Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D644AC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB4C722482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfJBApBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbgGTRdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgGTRdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 13:33:17 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBC3C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 10:33:16 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id s9so1439444lfs.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 10:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GlE22XiDFB+02pU5gzklDIha+BcKyqLDHWBhHRmLvCg=;
        b=dfJBApBkPqCxrfZaO8xj/Jd/hhxetMuW26nEQCNgDBr6vF++y2LiHqPaOr1n+OKIZu
         /U4IY9i+lR09yAOqpMqYvzuGB9ZkLFmuvo2qMhWI5MSqV4t9/Nxt497aI37ATZoJd+a6
         S/L43y2Qe+I+2ZtGX2pcGaO0WBVoUdl/1eVmgkq7pmLyKMCLqMhNL8D//TjqyKbvftDg
         lR+S1reD0MPs2fPw8jgCcPJetsFjmnESHyo+DoDljyDpFRJfDvzxdY+VkAXQShrkOGNX
         920eCIyJyJmNm/LSDuRjDQ/LxF3Z2m6hKy63hranT86ULSBf1F/hsGgXAjY8G/Td+jwF
         a62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GlE22XiDFB+02pU5gzklDIha+BcKyqLDHWBhHRmLvCg=;
        b=R9PuIc3yxIw2/JvRhEP2QPoVCSlSranL4+evCTs7TGIcuhLvhvOmJfVFTM7BC7e48K
         R7jE/CcV0vgxuCx2fxI/xwg4MrO/v9G3RjjztnS3MXlgFCbvlrR5g6sQ++kRkvFt/HI2
         ul3RGTUxQTKJCakToUCb6QaaGa1XncNtF7dHybca1wFbWxa19uewhUUa6WKWExibJlkF
         hAFyWUmsyxB0vGKniRJcgvH+ZodrYeKGUpdpzhfAIVtAJY4St+DnLrcEUXDJMKgW5g4I
         llcL05JuR5vVPxiB2CNdyoLERCjHjg8JzNS7pUjReI8o+5aU3+2d04Iu6cJ63cRHtFiw
         r5tQ==
X-Gm-Message-State: AOAM532UdyK+s3OeRPll99BhJufCVOSCrAL7X8vxHUYRO8+EDIIgaFXV
        TUkIrjedkC6Wsb8t9z75S0c=
X-Google-Smtp-Source: ABdhPJxJJDO67I4deiu1pOuDSqU1htLlr6KC7I1YBKGhlRjQtjdi5ZcH8VtUL2xBeI+gAUF1R1mSqg==
X-Received: by 2002:a05:6512:31d5:: with SMTP id j21mr11355350lfe.83.1595266395106;
        Mon, 20 Jul 2020 10:33:15 -0700 (PDT)
Received: from grain.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id b9sm976048lfi.88.2020.07.20.10.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 10:33:13 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 5CE871A007A; Mon, 20 Jul 2020 20:33:13 +0300 (MSK)
Date:   Mon, 20 Jul 2020 20:33:13 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, hpa@zytor.com,
        eranian@google.com, ak@linux.intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH] x86/fpu/xstate: Fix an xstate size check warning
Message-ID: <20200720173313.GA4221@grain>
References: <1595253051-75374-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595253051-75374-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 06:50:51AM -0700, kan.liang@linux.intel.com wrote:
...
>  static unsigned int __init get_xsave_size(void)
>  {
>  	unsigned int eax, ebx, ecx, edx;
> @@ -710,7 +741,7 @@ static int __init init_xstate_size(void)
>  	xsave_size = get_xsave_size();
>  
>  	if (boot_cpu_has(X86_FEATURE_XSAVES))
> -		possible_xstate_size = get_xsaves_size();
> +		possible_xstate_size = get_xsaves_size_no_dynamic();
>  	else
>  		possible_xstate_size = xsave_size;

Hi! Maybe we could enhance get_xsaves_size instead ? The get_xsaves_size is
static and __init function (thus not a hot path) used once as far as I see.
Say

static unsigned int __init get_xsaves_size(void)
{
	u64 mask = xfeatures_mask_dynamic();
	unsigned int eax, ebx, ecx, edx;

	/*
	 * In case if dynamic features are present make
	 * sure they are not accounted in the result since
	 * the buffer should be allocated separately from
	 * task->fpu.
	 */
	if (mask)
		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());

	/*
	 * - CPUID function 0DH, sub-function 1:
	 *    EBX enumerates the size (in bytes) required by
	 *    the XSAVES instruction for an XSAVE area
	 *    containing all the state components
	 *    corresponding to bits currently set in
	 *    XCR0 | IA32_XSS.
	 */
	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);

	if (mask)
		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() | mask);

	return ebx;
}

but if you expect more use of get_xsaves_size_no_dynamic() and
get_xsaves_size() in future then sure, we need a separate function.

The benefit from such extension is that when you read get_xsaves_size
you'll notice the dependency on dynamic features immediaely.

Though I'm fine with current patch as well, up to you. Thanks for the patch!

Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
