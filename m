Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7857AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56711204EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="af45aeWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390296AbgEYLp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390095AbgEYLp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:45:27 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B360AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:45:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m18so20421965ljo.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NtZVEMzdq38fu53lZDWzc8NBLCjAY5aGK/W4AvmImNs=;
        b=af45aeWHxzz993GasxJ2DfBZasYWxwmTraiJoDa1HtjC3H6cGOoc5djQcGZWp9j4hA
         a/iuVLiJp66aBK3hh8y4MxJNezOdhe01gGy/45Z2i6q7few2H3GBY3tnmcLrWfnUsyAj
         Hcl4cHaKt0ENhoc1YgRIw5gRA6qs5UtxluRbnaegqVPQ5IuEAQOZmahjqWKar9NkL4p5
         Z5Ux+5Sxd1ABeVqvEtzAhK+BS874PGhMOGm3ERC444bvO7ahff/poQUda55cWsFB48SZ
         cePiHFj6PcHe70HeknCWC5xjEt3puYRpHJWplNCXR9sXYSyH1eDODeekPFYRJLCZHOyn
         6YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtZVEMzdq38fu53lZDWzc8NBLCjAY5aGK/W4AvmImNs=;
        b=qOdPqifu+5KVWbecZQxgB1zGTKmZuU04Ytz2DtxfAlTyt2DP3VkwCf7YhJBjOdOBVA
         FakXRjF7JnBPGHsgDqTGOeuJQKRokIYAnsqBLa5gXjW0hATWDOlcT1NP86wgdo9TVlKt
         CRGzuHOw8NAUQVfdF+N4G6CxCP9Ikll8nnBZoQ0ZHjIx4EN+TvvjucxDJ50rmoRA0a3K
         8HjccuipxVgOdab/9h0cZ/GSWtPpmU9TW/0KCmWghvOFLJU5w63S68WvrpNnNwR3rDf/
         eJFjDzaT+cDIkhoNYphd7DiJSHIGq+MFHNfiCmabyAhEhH/VZCJlNB1CMIjhppdFYaOt
         6WzA==
X-Gm-Message-State: AOAM531OoHaGhLRzKKZVjsvQRyPP48wn/SGIonlhesmGtALdgZEjmS/t
        j6aYY4IORl0bqezPSclxTjNX5bPXH+AOQR1MQpbA4g==
X-Google-Smtp-Source: ABdhPJxhvU1HCj31oOWfftM9cD+lFUmkL14Hjg1dfXYGtguHDYzH8w3FOiQ8yj1s+WPLO2gWt/U+JdwJVsZw7ohD1BM=
X-Received: by 2002:a2e:3818:: with SMTP id f24mr10564628lja.338.1590407124209;
 Mon, 25 May 2020 04:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200523170859.50003-1-sudeep.holla@arm.com> <20200523170859.50003-3-sudeep.holla@arm.com>
In-Reply-To: <20200523170859.50003-3-sudeep.holla@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 13:45:13 +0200
Message-ID: <CACRpkdbye2akEc+bm_Ox92N_bJbH5uh3rnGEpD0UZHu23kLB8w@mail.gmail.com>
Subject: Re: [PATCH 2/8] soc: realview: Use custom soc attribute group instead
 of device_create_file
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 7:09 PM Sudeep Holla <sudeep.holla@arm.com> wrote:

> Commit c31e73121f4c ("base: soc: Handle custom soc information sysfs
> entries") introduced custom soc attribute group in soc_device_attribute
> structure but there are no users treewide. While trying to understand
> the motivation and tried to use it, it was found lot of existing custom
> attributes can moved to use it instead of device_create_file.
>
> Though most of these never remove/cleanup the custom attribute as they
> never call soc_device_unregister, using these custom attribute group
> eliminate the need for any cleanup as the driver infrastructure will
> take care of that.
>
> Let us remove device_create_file and start using the custom attribute
> group in soc_device_attribute.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
