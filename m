Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E7EC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1716D21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hHn6LzED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBZVg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:36:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34785 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgBZVg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:36:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so450078pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 13:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MdGE6BkJQteoHqLFsX7TImGOPTqgSwWqtI5U+DIM000=;
        b=hHn6LzEDcoli9XE2imSXc/0SNncPv+Co6E5fSIu6UY6oc8VoHpUFi6WhCwjXPHyPdi
         KadNY2PDkICluix8nWf1LkfQBvP/9yPl2vOcR51NoVMqa8OzqwDCPTZBk1fisiTHLnTI
         GSASYEl9NUi1JFSDvceRGcrmheoQkE+0mBl70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MdGE6BkJQteoHqLFsX7TImGOPTqgSwWqtI5U+DIM000=;
        b=MVH2MahT9oD95lxR7YYk/oOojn1/QGWqj+efGUJeSNuWqBl8mbgoDQyvUf+zN5hidu
         tioj9t/fuL5t0lX6riNwXXeII6B1u0YWYX4F6qsPKMQhV2VeUNLWxmgZjMxIBFMQKkAS
         X+brHreHGPnNLOtnuGmgSLUjrL0SOKCKCKF5MEFBC6XAClwxnPiSrkFtsOj1n7n/llOg
         MbbV/AGXfniEd6uwJBy0vQ8iYPZuQ/+tNujfLV70S9+YGTWK8V+yqlbFR2QIrMlpNWr1
         ccoUXR/8WGDNtwQcanRkKwJEL0vZJ1fk/9P786k2zsueD5974sqebP39N7kg7zl3FmfS
         WLfg==
X-Gm-Message-State: APjAAAU2FiudbGF6polPb78ohJpL+shkt4XRju6LqI6WwgTEp938JhLT
        fGy7ONHXKnYPzPuZtzYoTJpqzw==
X-Google-Smtp-Source: APXvYqwUOyrjDh+tdrrmX9MirJDDqGewjTRiSj+3Ffb039L62oEzlFEnM/BTWWD9U6RUiHlgqQ71TQ==
X-Received: by 2002:a63:112:: with SMTP id 18mr809974pgb.116.1582753015247;
        Wed, 26 Feb 2020 13:36:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7sm4242978pfp.93.2020.02.26.13.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:36:54 -0800 (PST)
Date:   Wed, 26 Feb 2020 13:36:53 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, luto@amacapital.net, axboe@kernel.dk,
        torvalds@linux-foundation.org, jannh@google.com, will@kernel.org
Subject: Re: [PATCH v2] mm: Fix use_mm() vs TLB invalidate
Message-ID: <202002261336.7A72F3C@keescook>
References: <20200226132133.GM14946@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226132133.GM14946@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 02:21:33PM +0100, Peter Zijlstra wrote:
> v2 now with WARN_ON_ONCE
> [...]
> +	WARN_ON(!(tsk->flags & PF_KTHREAD));
> +	WARN_ON(tsk->mm != NULL);
> [...]
> +	WARN_ON(!(tsk->flags & PF_KTHREAD));

Version mismatch?

-- 
Kees Cook
