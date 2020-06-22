Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D8FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26ACD2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J00hIsrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgFVV0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbgFVV03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:26:29 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D72C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:26:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so356114pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+fGVHQGbJSfeZpDFh+8/BeMq0iFulsSXIRYour5Vm0w=;
        b=J00hIsrXU7lUbB9T6uH+6OCvgVWQVpgD3QI0ZPH4Hk8LTAUfUiRewvjxyBQzGiD1ve
         iFnCJBgzFqit6FhHqe5BM8n1JJmg8rHtVkq3RtopnM4OgUUVSs4z5vEKGujmdV8eaHzg
         QPi3H0BTKGLlJqCPNPE+nQs3/vQLHDYWXLkWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+fGVHQGbJSfeZpDFh+8/BeMq0iFulsSXIRYour5Vm0w=;
        b=nQAumhEMXdqVuKpXvUcsQXogMWh0NtShzUH4fp4IADK6M9ICLEA69gBGpHGq0kRg8t
         Kt4vOJyTy49Wb6dVJReJMnqwvso1gukQGHDU4cALnBMX90We9RNYTKBGE6RuaxfAGM1i
         8uhTK7p15LaV9fUBt3Qc2Aptafvs3r6MerRQJbSHnGnzEHoCzYf++IGvMPxvkV24rzpr
         TKWGzaL2gf3heEyq5q+to3bY1Y6mjeRFekg65hS6NF8qMZhNOM+oFrcIRmH/G4V4yw3Y
         TOes799Lcldb5pA00rqIFOSNTN5d72D9FCHG5/8+GZ2BQgbCJLYdTGzS+QGM84hOo0gH
         sYyA==
X-Gm-Message-State: AOAM531TeE814vuw5x5OBEYH0oikY9fNq5k5BD1WmiX+f+tIUqBX7Uaq
        ZzY2SrErPxuJDTwNHm1Z6zOiJQ==
X-Google-Smtp-Source: ABdhPJz9FSwoUGnk0FK8dRtqojR7DRsccJU6Ok7KN9Xp0A18XOCuQ0Au72MfAI1gfeRNqQL2b31VvQ==
X-Received: by 2002:aa7:8a4c:: with SMTP id n12mr22059315pfa.326.1592861187688;
        Mon, 22 Jun 2020 14:26:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u35sm11783923pgm.48.2020.06.22.14.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:26:26 -0700 (PDT)
Date:   Mon, 22 Jun 2020 14:26:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
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
Message-ID: <202006221425.805E17B67@keescook>
References: <20200622193146.2985288-1-keescook@chromium.org>
 <20200622193146.2985288-4-keescook@chromium.org>
 <87a7b943-ed15-8521-773e-c182a37ee61e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7b943-ed15-8521-773e-c182a37ee61e@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:40:49PM -0700, Randy Dunlap wrote:
> On 6/22/20 12:31 PM, Kees Cook wrote:
> > This provides the ability for architectures to enable kernel stack base
> > address offset randomization. This feature is controlled by the boot
> > param "randomize_kstack_offset=on/off", with its default value set by
> > CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT.
> > 
> > Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > Link: https://lore.kernel.org/r/20190415060918.3766-1-elena.reshetova@intel.com
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  Makefile                         |  4 ++++
> >  arch/Kconfig                     | 23 ++++++++++++++++++
> >  include/linux/randomize_kstack.h | 40 ++++++++++++++++++++++++++++++++
> >  init/main.c                      | 23 ++++++++++++++++++
> >  4 files changed, 90 insertions(+)
> >  create mode 100644 include/linux/randomize_kstack.h
> 
> Please add documentation for the new kernel boot parameter to
> Documentation/admin-guide/kernel-parameters.txt.

Oops, yes. Thanks for the reminder!

(I wonder if checkpatch can notice "+early_param" and suggest the Doc
update hmmm)

-- 
Kees Cook
