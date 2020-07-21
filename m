Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0828C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741E72064C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K2nZxYuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgGUTAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGUTAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:00:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA8BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:00:38 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j20so11169280pfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=z7r+tykWJeqyUt+0w32i8HpBG73ZF426jmYt8FWFXXg=;
        b=K2nZxYuSsZMrLPLzyUJFpDo78L0fWs1qa1pyFS0dED7D85EPDvugXZNiC6I4kYNyaj
         QVuNzYcQ9C1wAQ9KfL95/gpg1xghQUSwychQJx9ETTXmZ5CtgqSOEgLlvXQgzzQft6d5
         NXH7njx4hhVgj3kjD8v4NwD7xU/MdKbe/sm7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z7r+tykWJeqyUt+0w32i8HpBG73ZF426jmYt8FWFXXg=;
        b=OtY682vPdII64EC5uGoMIK7fXrPdR/JZfJcwucxeiMRXSuFC8vwUkCAWXx8Lf66eFW
         TfyGGhfKFwC4KrpC37C5KGbJAiamLrhvJ5V46TGwMfyVltbSWM94WEVPM0eAag/GQEtK
         Inwy8RrS9uPw8Gjaqgv1l2kwIcvrWxLd/33UlNI3GFxe10eIIoGQD/2eYLE2VbrwrquF
         QnX54pFrxAnm6Qi+CR+AYKW8MYLWMlcuAjFw0xMo14w/OsmpavkTECdjaJyFxNXgTU9L
         0g5YWEhkr0eJPpoHjZK/6zzqulpeBXsFralo40rD5Q9NttPjmor5lWZzB7hZjyGK9FvU
         e15A==
X-Gm-Message-State: AOAM531K45PYDkGaRAjKd2Dv6uK54NbQFSweEXi+jjzWbhhv6fP2tL5w
        iaf7OLI+oW2c8s9jPQLYh7nMTp1rTHo=
X-Google-Smtp-Source: ABdhPJzFRVwhgZiNvdtFdhMOJEbWQvREg/oK2BKjqDkHDbM1u9rD/uol5R217ObAI8/HuNJS1XXZqA==
X-Received: by 2002:a63:df03:: with SMTP id u3mr22870077pgg.84.1595358037787;
        Tue, 21 Jul 2020 12:00:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm18970158pgh.94.2020.07.21.12.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 12:00:36 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:00:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Duncan <1i5t5.duncan@cox.net>,
        Anthony Ruhier <anthony.ruhier@gmail.com>,
        Vinicius <mphantomx@yahoo.com.br>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [Regression] hangs caused by commit 3202fa62fb (slub: relocate
 freelist pointer to middle of object)
Message-ID: <202007211156.D8BEDEA247@keescook>
References: <15cbac6d-1f96-2ba9-cb54-08af6682f56d@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15cbac6d-1f96-2ba9-cb54-08af6682f56d@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 04:55:12PM +0200, Paul Menzel wrote:
> No idea, if you are aware of it yet, but three people verified that commit
> 3202fa62fb (slub: relocate freelist pointer to middle of object) causes a
> regression on AMD hardware [1].

Hi, thanks for emailing; I don't get bugzilla notifications, so I hadn't
seen this yet.

> It’d be great, if you took a look, and advised if this commit (and
> follow-ups) should be reverted, until the issue is analyzed.

There have been a number of fixes to that commit (which I see are
mentioned in a quick skim of the bug), but they've mostly been around
additional slab debugging features. If it's causing a problem outside
of that, my instinct would be there might be a use-after-free happening,
but I'll go read the bug more closely now, and comment there (or here,
if needed).

Thanks!

-- 
Kees Cook
