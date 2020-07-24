Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A6BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBACB2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GhnZGzFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgGXRnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgGXRnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:43:52 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B5FC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:43:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so5697133pgf.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aaWhQPcSW3bE7rs+REjPzCquXYXIKucEYvw8vc6PND4=;
        b=GhnZGzFM9H5MZ1G8rKO9LRqg8IW3cO1w1wH/BXcQWPilam/lAlnkxGLmZrE9vV4u52
         K4DmyhZRZKHcPv0GEdH0K9KyLtYBYiIg8Y7BKPfji1nPew2uVmw2Cu0KJWgn0+QrhCy6
         J33pUtSnzj+iojGpXI+KpUUcr8S8iTr9Qn8UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aaWhQPcSW3bE7rs+REjPzCquXYXIKucEYvw8vc6PND4=;
        b=tozqq9mUKJ4uKxe4DiHwmbKXW1qPJDbKHQO59PmzNnWIIJDE2Deo1fs7nduimMN3Fv
         gTr1kysNt+0Eb3KfoNYX8MN1z7uj8e6cDrbRlyu361UOg0c55o6SJEdDHTDlMOgGuXXa
         sQM50hiKpnPQNjjHx0LQ+EjfjAFLGCb0ru3KDXwT54lXAB6WBtoGTJRZkS+72PQEeT6v
         +88FDHYTDP/TvLMKuMR7ge+k/gUIr1lo0DKmgTFG6zQ0ly9YoeTaeyLXp33nS9rqi36S
         O4T3h8BFiXh9v0kTFSV8qKwt8CRLV8k5PmdM/LpG6acg4NyAEEo2Hx3bQyG67nNZg+yW
         C5bw==
X-Gm-Message-State: AOAM531Aj+Q2Z62xqQv0ofebAdJ+k0x2TUEPgA5+p8FcTw1ALy/z5Eby
        hwYnuy6jsBXl0bfKlwHcxQnLLA==
X-Google-Smtp-Source: ABdhPJxm1pOTytr68wKlbjbawG7twhZ21XJYJ4ElyB1DPdJJWPc/wanYtwrYMS+M80MURBbJFVeEdw==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr10436021pff.132.1595612631874;
        Fri, 24 Jul 2020 10:43:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o136sm6832398pfg.24.2020.07.24.10.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 10:43:51 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:43:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 11/75] x86/boot/compressed/64: Disable red-zone usage
Message-ID: <202007241043.654ABB2@keescook>
References: <20200724160336.5435-1-joro@8bytes.org>
 <20200724160336.5435-12-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724160336.5435-12-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:02:32PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The x86-64 ABI defines a red-zone on the stack:
> 
>   The 128-byte area beyond the location pointed to by %rsp is considered
>   to be reserved and shall not be modified by signal or interrupt
>   handlers. Therefore, functions may use this area for temporary data
>   that is not needed across function calls. In particular, leaf
>   functions may use this area for their entire stack frame, rather than
>   adjusting the stack pointer in the prologue and epilogue. This area is
>   known as the red zone.
> 
> This is not compatible with exception handling, because the IRET frame
> written by the hardware at the stack pointer and the functions to handle
> the exception will overwrite the temporary variables of the interrupted
> function, causing undefined behavior. So disable red-zones for the
> pre-decompression boot code.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
