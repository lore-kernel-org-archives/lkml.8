Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09EEC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 22:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A387B2072B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 22:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a19cRORN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgDYWse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 18:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726232AbgDYWse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 18:48:34 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70DBC09B04F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 15:48:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z6so5278365plk.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=INjGMVxgX7lD+RGHEgxoq3gDShE5KD3g4HVfvBFmby0=;
        b=a19cRORNjk+/VdnJXmNiPknF3uo2PtEDXd+Wn4E4Yw2n5jXzONbHkfcL7Io7V4/h1A
         hqComD/2KShYjSZxHRAydagOWbxq3YizLF44RZb5NMD2WtxFknT5vLn3qoKXRKx43h5E
         obdJgZwA4bH5Uox8RuOWkBB9t/5HwOcUSuKEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=INjGMVxgX7lD+RGHEgxoq3gDShE5KD3g4HVfvBFmby0=;
        b=sccpy0/5ZeEOWYcRgHpu5Jhzm/CC0Mk4HWGQCAyT8ifyD0gJZekhn4JPOf+uGhSh5F
         S/7SrBRIzXCahf0lSDsF/4ILwFTLT0K5t/MlCAZ+fyq0bdmzqtD1t5SLONRFd0Y60Rrm
         NwD5B5GBBWpRTEFEE66cjliRdC2aVYbot9zEv00LUfaayaKXp6JKcEyzfKu0iC13GA6f
         +sOj5IwMzqTaITzRISLnInDD6fRbqeo+sg33uXfVhkXSejU6k+/nvRM85qZD+EZgvDeB
         r5MH2p7QQowRcfa+IeGVfvoQ5GgDaBL6Gb+c3T/W7rAKwOPIz/lmUm/DgIYlZ1zdTUfs
         a4zw==
X-Gm-Message-State: AGi0PuYO37muwYYTMpWtYIDcgr5+lggvsRlMgoMaet2RSBnbEHPaTrK0
        ejmnkokKpop9CJlgitilerXnoQ==
X-Google-Smtp-Source: APiQypLs6/BOi+uxr/spumGtn9iNGxndENmo4EqWuANXYqfmygIWEh2qromOmlkooNFsGiUVu4nPqA==
X-Received: by 2002:a17:902:598f:: with SMTP id p15mr15950225pli.264.1587854913322;
        Sat, 25 Apr 2020 15:48:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15sm8864879pfd.139.2020.04.25.15.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 15:48:32 -0700 (PDT)
Date:   Sat, 25 Apr 2020 15:48:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: do not place freelist pointer to middle of
 object if redzone is on
Message-ID: <202004251547.0F8E6856B@keescook>
References: <20200425091338.24283-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425091338.24283-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 05:13:38PM +0800, Changbin Du wrote:
> The recent kernel fails to boot when slub redzone is turned on. This is
> caused by commit 3202fa62fb ("slub: relocate freelist pointer to middle of
> object") which relocates freelist pointer to middle of object. In this
> case, get_track() gets a wrong address and then the redzone is overwritten.

Hi! A fix for this is already in -next:

https://www.ozlabs.org/~akpm/mmotm/broken-out/slub-avoid-redzone-when-choosing-freepointer-location.patch

the above doesn't disable the mitigation when using redzones, so I
prefer that to this suggested solution.

-- 
Kees Cook
