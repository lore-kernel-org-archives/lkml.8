Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE0BC4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439A9206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QVngWJph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBZFtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:49:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40998 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgBZFtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:49:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so831930plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 21:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+o0Cxx8HmQdXWrejhdC3RH6moiQGlThNZB33TEB2/R0=;
        b=QVngWJphiEqTsggSbaGZG6KKVe/5xdUUs9fF1c8wpFIBC85uu6w0X4OjARiK7hiHsy
         YirmKlA8+5ufTIQVNnhu+cRiDjjkVNg+kDVeOmLSZcaJcnc/+CklCyb23K9XK4TexOyP
         w+JOHDZPBRFCgI7qgLAo6vpCvdZb8ga/AW3GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+o0Cxx8HmQdXWrejhdC3RH6moiQGlThNZB33TEB2/R0=;
        b=IAvmocFb645aZSFcPxnlehpHMZQIBkT4/k0L4k567t0SiPBzhIOCtZx51gDNXB/VLj
         IbLe+DhP2E4+lold4ahTCX2IN8ddW8QLq3ZjaIFT6vvDBM+8ZzUA6/GYpjaXob6P9M/U
         w9pnN2dcDd1v8p7mzA3xzY3ogfVEwMwvkW6i19BEondNzomhkA3HIUax5vWl2+iMaycv
         9ZZAH0lnaubOXaS71u/JcruYAQBU/egButoXpArbUIQi77H2JfpdYD0ZZmtJkfbzK00O
         mgSOczd+Q0Ekt/0n7S1aqZZnwqQUn+nYlrxWbIJTp0eYBW/wJyo2Y3DQoQNMayiIPEMB
         QDpA==
X-Gm-Message-State: APjAAAWtZAVTMEd6Ph27jw1N5VQ9od8rTwF8qHVFL5eBNkHf2NjdimpF
        i1SGi5ggUlHbraCoGDqG+6uwVaYCscI=
X-Google-Smtp-Source: APXvYqx8Hr/Cj5VybYqFNkztZ4OEH69rhUqXd7K5EOJh00EissLfKhJ2zFA3IUzdAa6QW4zPXy4nZg==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7mr2245702plt.314.1582696177733;
        Tue, 25 Feb 2020 21:49:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q6sm1057628pfh.127.2020.02.25.21.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 21:49:36 -0800 (PST)
Date:   Tue, 25 Feb 2020 21:49:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v6 01/11] ELF: UAPI and Kconfig additions for ELF program
 properties
Message-ID: <202002252147.7BFF9EE@keescook>
References: <20200212192906.53366-1-broonie@kernel.org>
 <20200212192906.53366-2-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212192906.53366-2-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 07:28:56PM +0000, Mark Brown wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> Pull the basic ELF definitions relating to the
> NT_GNU_PROPERTY_TYPE_0 note from Yu-Cheng Yu's earlier x86 shstk
> series.

Both BTI and SHSTK depend on this. If BTI doesn't land soon, can this
and patch 2 land separately? I don't like seeing the older version in
the SHSTK series -- I worry there will be confusion and the BTI version
(which is more up to date) will get missed.

What's left to land BTI support?

-- 
Kees Cook
