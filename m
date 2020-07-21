Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1172DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29E92072E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RG0AVML5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbgGUVs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgGUVs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:48:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27848C0619DC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:48:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a14so101830pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DyUMSyCvKRYW4MD4ELntmNMKa8iS1Uqy8qtQ5GRD50Y=;
        b=RG0AVML5JPLKh1gC4Yp7oNCkx99dZ9fnFTUGOz8UovIZDJzKW32LdIVokMTsN0TvOy
         KbEUErep5CkAGc2tzZn3ShhRZXTvZsrPkKk+21w/wQKOCKCbuuEN7kcuWAq5HyOcgGPi
         itNKg5ZZrt8SDWM0tUVL5qj1/Yb7Cf/3K5j8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DyUMSyCvKRYW4MD4ELntmNMKa8iS1Uqy8qtQ5GRD50Y=;
        b=gILapAqYfhdxWnVvhgNC4KuG1pmOl1BMsy3doQF83X5MeOZm7fVq4brCeQh+nmI5lM
         p8tKAF1iqHVCoC7oz2nq5nsHo6Nl5ocWTsHo7N5kod43ndsjf1YVeq3yYpaHzHfj1UHz
         ieQ4AA46KQp81fmKUUu/SYMsErcO38DAH9SLhJPTxVuR6mouuHTK2GQmDx9moz7FbMDU
         Cm1kqxHVFjIEiOw5enaMy9lCLF3Tlw1AgoU7OsJj2el2xpPuP76ybNwGHgJqcZR4sUiT
         eKdCk0bpCiho5Nq5VKH1CDwMAzEWBY3Tt5/jG/+Feo7ZSVXDhSPi1H4jmeaZrV6xRS3r
         fJjw==
X-Gm-Message-State: AOAM533OpBUomw8Y9bf6GDDNFvGYYceFRrdagWWLE12JD0GPe3tgv4zJ
        9SXLc8f3i1QUNI+yAKsk1s7t8ciqN0Q=
X-Google-Smtp-Source: ABdhPJwevklT4e/5X1FPV+4eAjXjbwppCGlsYeJC9yecBh6vXjQodUdX5w6Z+6/rtIjc7fywF1XA8w==
X-Received: by 2002:a63:de4b:: with SMTP id y11mr24014742pgi.26.1595368135462;
        Tue, 21 Jul 2020 14:48:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 198sm21548925pfb.27.2020.07.21.14.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:48:54 -0700 (PDT)
Date:   Tue, 21 Jul 2020 14:48:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V4 14/15] x86/entry: Cleanup idtentry_enter/exit
Message-ID: <202007211448.9BB6C2E8B5@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110809.747620036@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721110809.747620036@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 12:57:20PM +0200, Thomas Gleixner wrote:
> Remove the temporary defines and fixup all references.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
