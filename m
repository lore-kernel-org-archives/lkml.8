Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4BEC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E62520661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ONakVT6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBFLpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:45:03 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46941 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBFLpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:45:03 -0500
Received: by mail-oi1-f194.google.com with SMTP id a22so4230988oid.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 03:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jy0CnJlvOas43+pFTR7ABDjKL2TXvtkTC2vp+5n1KXg=;
        b=ONakVT6tfkQcyhj4YBW/4z8SAQxXM9Agcc1+RSXbaSD8K338Y7VQjuV7od7jMjE0z3
         q/gCnJ6Moy7DeX0SiuPEB3nqJSEdJNNgcbhguI4PN62WjhS/vycCHXSuAacXUEBH79FF
         tfaIg7sxMToGwKaC+8ZEsJPW1l7/qpl8ZvO6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jy0CnJlvOas43+pFTR7ABDjKL2TXvtkTC2vp+5n1KXg=;
        b=QlCiGU7wDPeoXzLERYL+vvQ19VxXqBnn1sE/a8xyk3G9vJSF7mN3XL/dW5dJPSt5Rl
         UL6sHmu+IysJM+aAJmIKjnVhRQr9fcgTI30DjR7pAKaBtlvqdgEUKvEnL+j8oMa0wpFP
         ylX230kGVFeK/sV+x3iR0JdPIZKY5ZT7Llco8Ypn8P1y/w4Q9gXQ1SBUk9NaWIfnT63N
         IUSd3OZIe/zjN24yN63IRsj6WVjRMePeIs4eNV+rDMM2wSlUjlphQAFmOalPGUv9b/aG
         2bG9fPLw3qY/UQnc0fazFowE+RMxeLU/5pArWIq5CYQ0MRl1zxkqDBt+syj2rDbsjo5Q
         E6VQ==
X-Gm-Message-State: APjAAAUI2zVeWlm67x01YZhq+f/UI/9rS5z0KarrGVMmlQoCqox4lUWv
        0uhgdkaq7ZtpGZUiL4soXglHCQ==
X-Google-Smtp-Source: APXvYqz8MSscmT3S/MN/+mSEamzW0i5iaMPDTSnPHg6J3kxWcNYfva9TGqhmyyfmxQtvaZlISzd1KA==
X-Received: by 2002:aca:4183:: with SMTP id o125mr6340760oia.125.1580989495806;
        Thu, 06 Feb 2020 03:44:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q5sm842562oia.21.2020.02.06.03.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 03:44:54 -0800 (PST)
Date:   Thu, 6 Feb 2020 03:44:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <202002060320.2B76A4E6@keescook>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200109150218.16544-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109150218.16544-2-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 10:02:18AM -0500, Arvind Sankar wrote:
> Discarding the sections that are unused in the compressed kernel saves
> about 10 KiB on 32-bit and 6 KiB on 64-bit, mostly from .eh_frame.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Looks good to me. I was worried this would paper over the problem, but
actually this solves it even more directly by removing the troublesome
sections. So, yes, let's do this too. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
