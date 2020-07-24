Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71ACE206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="esEqwYwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGXRmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgGXRmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:42:53 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40012C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:42:53 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s26so5595368pfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U50zr+VshRe9mYuWVqDq7CNgzIqrkIfFylK6XexbWKE=;
        b=esEqwYwiF2m2i9Gp06Apxexvboy5U9ul9g68MueBSxJcjBjMQGdvHGFDnJJQap3xxR
         XhM4nWcCt/BWatQmNXYxfbnHeLB+cwvvzLxCD3ArVYYAeiHf4g3zESPK5T2qMVj5A4ft
         EhlkS/H1Gn677G/SsxoYiePReMo8rMYLkY4yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U50zr+VshRe9mYuWVqDq7CNgzIqrkIfFylK6XexbWKE=;
        b=oz8S6Nk3Y0Le4/4aodoF7BvdPaFiql4kT8U2nngllHKSeZPOh/1EaCaYwuGhSHKE48
         8UzEpzNrumtNb3zlr4wfmDjqeMEykYfb387rdMQMuhtkw4m8F1gu3vx754s/EPOPaNQA
         X6szfZQdoAGkd9cmZbOjvla7/OWMmJg95+WkMHhIWfkRKbtuHQ4bece4j5aGR9IXjO/0
         XQFoW2SuEB+KiAxJ94u4vF9Y0F7UCJt6Y21onLgTuzbO+WN1qjjHf1TUtGC93cgFqTHC
         GZ6aYDiIpxUZ9YI1tzt4JGmWIMEakKgowsrqDRevuI+WTDZYJrL85mw++QNYLHb+mBGG
         0avw==
X-Gm-Message-State: AOAM531hkCfcyDV3x/yPe5tS14Ara39Jwzx13ay+7YrcJ2aU4yBmLd98
        r7mPe69VZgtlfXUUfYNVIYBGcg==
X-Google-Smtp-Source: ABdhPJxtKpo45I9LuQoJECycYCtMUIABAY1HmaYIM7v7qjODgmc1ompAK4OP3e0iHW9NrkeIeAJbeA==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr9318212pgh.255.1595612572909;
        Fri, 24 Jul 2020 10:42:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g28sm6772558pfr.70.2020.07.24.10.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 10:42:51 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:42:51 -0700
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
Subject: Re: [PATCH v5 32/75] x86/head/64: Load segment registers earlier
Message-ID: <202007241042.D3E8FC382@keescook>
References: <20200724160336.5435-1-joro@8bytes.org>
 <20200724160336.5435-33-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724160336.5435-33-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:02:53PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Make sure segments are properly set up before setting up an IDT and
> doing anything that might cause a #VC exception. This is later needed
> for early exception handling.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
