Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88E7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C17D2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RRs1XpvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388844AbgFISre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgFISrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:47:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B317DC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 11:47:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so1795257pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uJfu7VCoabwyy7XV4REVbfqvINHE8jJHSSQxXyuHXd8=;
        b=RRs1XpvKUrWcGC9rIH96xpb3pTK7Sz9Y478qOvPHNO4RLX043gSI9fVBKTbIjskAsD
         NYVbHiStuO9ZNyJZjm0N/3IRfTEgzEFthkAy/Nt63yzoJ0aFhLDWR5b0DOgY+O1mRVuG
         TpNIJcS9r6syyH23xPO0c25GxRl4Du26VqrsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uJfu7VCoabwyy7XV4REVbfqvINHE8jJHSSQxXyuHXd8=;
        b=anC1mWWX17UHE79cbW5gaROe7AJ3JBh+bqbnWRHGlUXL+NBVnkLdw4WxvMsknz7qaB
         dRg7CKeqh3VuO8XztwF4LlB+2Odpqmas3jM+h6spbkjs3HYUuvX8EZDIhgkA7yWbJB7P
         r03elpnACZn5q9K59cLp8fzVxOEu2f544Qrf47xY2vRwMolny6UVjS/6gEBffCsqlmRO
         BwunnNtGrD271XgZ00ZYVqrrHo4aQLcwiD3em1e0CR81reExpZoLSIHbkCXaQ7Ph9tl6
         /sY5N4yXu7Qt4QzSPEE3XJYyxt6HTjdHjnc6u3Jv8Cd2FrYcRspT+pgYAbjdU+qudyYt
         pZYg==
X-Gm-Message-State: AOAM533/tzZSE/MTZdDSm1P9/cUGDWWBxz5e96mFxf6r1aQjOhMs6YDQ
        2jDui3C4GaTjMBE/sFWvwwi7SA==
X-Google-Smtp-Source: ABdhPJx/4VVBlneDG36Q/SLWPtFp+CtxwJnOIUCT1u2jRalyMTmf8uve0S/G2MJuu/H/na/+h9PhSA==
X-Received: by 2002:a17:90a:30a5:: with SMTP id h34mr6603724pjb.36.1591728450330;
        Tue, 09 Jun 2020 11:47:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f3sm3388976pjw.57.2020.06.09.11.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 11:47:29 -0700 (PDT)
Date:   Tue, 9 Jun 2020 11:47:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        Mathias Krause <minipli@googlemail.com>,
        PaX Team <pageexec@freemail.hu>,
        Brad Spengler <spender@grsecurity.net>,
        Laura Abbott <labbott@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel-hardening@lists.openwall.com, linux-kbuild@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org, notify@kernel.org
Subject: Re: [PATCH 3/5] gcc-plugins/stackleak: Add 'verbose' plugin parameter
Message-ID: <202006091147.193047096C@keescook>
References: <20200604134957.505389-1-alex.popov@linux.com>
 <20200604134957.505389-4-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604134957.505389-4-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 04:49:55PM +0300, Alexander Popov wrote:
> Add 'verbose' plugin parameter for stackleak gcc plugin.
> It can be used for printing additional info about the kernel code
> instrumentation.
> 
> For using it add the following to scripts/Makefile.gcc-plugins:
>   gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK) \
>     += -fplugin-arg-stackleak_plugin-verbose
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
