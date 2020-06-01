Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B39C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48ED207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vs7Yv/hX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbgFAShw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbgFAShn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:37:43 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D1FC008631
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:26:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o6so3887175pgh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vQsHm/Fb+3S9GG4hi4C54VWzmvQfSDfHYATb203csRU=;
        b=Vs7Yv/hX/ULE3o4BYT8jfnU2UW8Uy0ez3j2yQ8d6Stdt/38QVd16hvblONaRxgdbUK
         HfbmgcTRdgDtj0uTkJE/cNinFuhzfppdk2J2grs4bm465GiL6n76ZgakZKzTV8r6dxUM
         X7r7To/s/otOe8sf2hzW/wE30chaO+juxjXCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vQsHm/Fb+3S9GG4hi4C54VWzmvQfSDfHYATb203csRU=;
        b=oMv0ziCdwJbVmis/OPs1izQb2eI+D2Tb4OPM7oFPMxNtUxYXPIEA5sYXDjbGNmOh9O
         srndwuGcOOlnZGiiSK9nl6s8/qocE1T2rcujhIuHfdGGwHnimAxFrAQdiZNo0MSJSapi
         4Q5j+MJN9hbaSphnY4J5B37fgNVQUr1ZZD6quji5dlku/qcCF2Ja9dlxnb4/A4YlV/PK
         Sl/WWxcAuXBro8Jhy4d3nicVHQf3mhCdjuP2LU33r9qo7pnZrv886u3Vgbrxt/S8jUkg
         lmS25XVmubyTCYciWMkdmoQaIQ8XJ5GNuqsJmGv0ZnuMSnFomJZIPvT2Ssic/iT0XKl+
         uwrQ==
X-Gm-Message-State: AOAM5334kD1ZNA7OHt8spEtMcdNXXKDhayJ/a2LZD7me4a+TjuG5T1oU
        DMzqpwf9UafGB8HyXP3d23XDXw==
X-Google-Smtp-Source: ABdhPJy0Bj3McrkKbyUtGly01m03y4YOkwiHA40WeFmBiKfrbJdT7bHmuLQ//OCOxyp80PPGIZRcrw==
X-Received: by 2002:a63:7052:: with SMTP id a18mr20225520pgn.39.1591035993241;
        Mon, 01 Jun 2020 11:26:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3sm151966pjs.17.2020.06.01.11.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:26:32 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:26:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        christian.brauner@ubuntu.com, cyphar@cyphar.com, jannh@google.com,
        jeffv@google.com, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v3] seccomp: Add find_notification helper
Message-ID: <202006011126.3DB757FBF5@keescook>
References: <20200601112532.150158-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601112532.150158-1-sargun@sargun.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 04:25:32AM -0700, Sargun Dhillon wrote:
> This adds a helper which can iterate through a seccomp_filter to
> find a notification matching an ID. It removes several replicated
> chunks of code.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Reviewed-by: Tycho Andersen <tycho@tycho.ws>
> Cc: Matt Denton <mpdenton@google.com>
> Cc: Kees Cook <keescook@google.com>,
> Cc: Jann Horn <jannh@google.com>,
> Cc: Robert Sesek <rsesek@google.com>,
> Cc: Chris Palmer <palmer@google.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Tycho Andersen <tycho@tycho.ws>

Thanks! Applied to for-next/seccomp.

-- 
Kees Cook
