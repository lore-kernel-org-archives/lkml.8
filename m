Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D455C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECAB2070E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nAdHPfYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbgFWA41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732431AbgFWA4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:56:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2F0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:56:24 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z5so596922pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 17:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ddZISy/nnQaDTw5hRGQzjmZlz/IMEisCTFQ7iFu0Th0=;
        b=nAdHPfYXVzWTBCeDEMmkeKJ+hHfd7oErRWwLQb9dB7/Ol4YD/npR6fC0vwGRXy/c29
         GGQ0oMgXVfEfwUNLWB5Mq3C346cIetMwNMMUd76j9Ztr+rPIR33dCIUpM2i+4VJOQ8xU
         A1KmHa9YIl4kewOB9Lmi3GBsCMQ5u7F38OPjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ddZISy/nnQaDTw5hRGQzjmZlz/IMEisCTFQ7iFu0Th0=;
        b=XvCH3MPKb/aOX0sU/8ghNQUXwaZSrESJQ9l0jS9EVGIhAL+hKzJNgO/d0kn4VBZLd0
         LNPAjrv8Z9dgUclHuS0DgNKC8BtDTHoEvGr2J3/+w4yHTLb9YAuPNEIr8Yu7Od1lUhoC
         bH8Ek/JLgDLttbmwApQC1oBUwby8qBpiv1/RXN+T4C0iSOciDd28nXW9hSNVe7OvGaSp
         /aXtmXanVao/V5kM57e8GAz4gojmx3D9GPH4FmYJYyZXWE0YP51DUTh76ZS/bbff66LA
         zOBWZ5meS6w58WPiEhTSDiYQKHpJzSzML3ejNT09uezxfUHo6a7xYOgcgWvlzbNqdgwY
         A/dQ==
X-Gm-Message-State: AOAM532WFETasErYjoP6zl9jLfh2lLnjUGB8uI0kH8j9nNy1FTEDL3Z3
        9h4fQDLMELUBYN8mu7XmtsCBYA==
X-Google-Smtp-Source: ABdhPJzcouPDWEUYGfs6mnKQxNW21WTL2h/cvt4aWHu1LneMG7v+1KMi+E4KPxR8Q7oPaJp1wkS5WA==
X-Received: by 2002:a63:35cc:: with SMTP id c195mr14777269pga.180.1592873783576;
        Mon, 22 Jun 2020 17:56:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y187sm15258705pfb.46.2020.06.22.17.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 17:56:22 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:56:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] stack: Optionally randomize kernel stack offset
 each syscall
Message-ID: <202006221748.DA27A7FFC@keescook>
References: <20200622193146.2985288-1-keescook@chromium.org>
 <20200622193146.2985288-4-keescook@chromium.org>
 <20200622225615.GA3511702@rani.riverdale.lan>
 <202006221604.871B13DE3@keescook>
 <20200623000510.GA3542245@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623000510.GA3542245@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 08:05:10PM -0400, Arvind Sankar wrote:
> But I still don't see anything _stopping_ the compiler from optimizing
> this better in the future. The "=m" is not a barrier: it just informs
> the compiler that the asm produces an output value in *ptr (and no other
> outputs). If nothing can consume that output, it doesn't stop the
> compiler from freeing the allocation immediately after the asm instead
> of at the end of the function.

Ah, yeah, I get what you mean.

> I'm talking about something like
> 	asm volatile("" : : "r" (ptr) : "memory");
> which tells the compiler that the asm may change memory arbitrarily.

Yeah, I will adjust it.

> Here, we don't use it really as a barrier, but to tell the compiler that
> the asm may have stashed the value of ptr somewhere in memory, so it's
> not free to reuse the space that it pointed to until the function
> returns (unless it can prove that nothing accesses memory, not just that
> nothing accesses ptr).

-- 
Kees Cook
