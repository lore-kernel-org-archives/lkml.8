Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC41C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D98207ED
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BUjnOEL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgFDUTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgFDUTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:19:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D09C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 13:19:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q11so7507866wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pKwHJd8Guudh+4hbK4oPG+0YLHtu4hOoSvMusZ3RXcM=;
        b=BUjnOEL7TypCIuC+vuKzQGYrzTgaFT2P0mh8VApwjW0Jd2iLICrB8jOcPy0iXfTYrm
         t/2PGjF+m8jJHjLNFFdLTspFXCCqvED2nZKsKX8PZAiumNezAnlIPTMe7Kmzu5oAJIYl
         D2GZIgtsI3tffBmo4q7xM64ITLOdVBSyAwweDVZo/9dMRTm+B4P9Qr1Baeldf0pazybG
         YONzeEGt+wv8BjmNGG6cS4X4p0ZZLNTQyhqGGV3ecyrTDxgoQvhCH5HyiuyYPXnmvTb4
         KodaVRabQg+Y71Wke6E22WGQTF5ViLInaQgCJsU8oMCWzifVpmTboRUpbtIgC+vK7SS6
         Ci8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pKwHJd8Guudh+4hbK4oPG+0YLHtu4hOoSvMusZ3RXcM=;
        b=iIbot4QWyvg/7XdUWC/+Unt6dBoWV/6XYOtcE9cr1VGyC0OB8r1PdbCD9owk5/ApWh
         IdrOLXD5WhoKjtnCGfnOh//7dml/cAJ46QClqnXucwUWyPl3DPw+3qB5Sc6oicxdABY7
         hLw68zNhCjr4b1rwfcO3tna3BWlaO4pA3eslcNYi1kmJDEYdYpxIfZsRwdMh9NkJJdyX
         A9Lnud3i/hPJY+B3+JU/adCjk4eWBRRrpHRPLfKzJJM7Y0W3GEVYpJ4Ln8izE5KxVjzN
         OVDvRPMupw7N/QhrPJGt/fhd79CJsMzZxiD7d7OXFh/4vvrSPd4sAD64U0ilHd1FJVjX
         1Fbw==
X-Gm-Message-State: AOAM530w4Rbs+Rk3XwQcUFLgMn0BF7MZ6c519oKXVds5jzEwD/CE5t3q
        OZItt2EO/aYArP7qd/ZlZpVy7WngocHMHg==
X-Google-Smtp-Source: ABdhPJybTdyssgg8fzfF631+eGOA8fRx5P/v31GQlZ21fUG/UlcYtClukjNiE5mY7Cl8IlxyJ3AHlw==
X-Received: by 2002:a5d:54c7:: with SMTP id x7mr5877430wrv.162.1591301940275;
        Thu, 04 Jun 2020 13:19:00 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id b18sm8830388wrn.88.2020.06.04.13.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:18:59 -0700 (PDT)
Date:   Thu, 4 Jun 2020 21:18:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Backlight for v5.8
Message-ID: <20200604201858.GA3714@dell>
References: <20200603090429.GN3714@dell>
 <CAHk-=wgUg1v5hJ0D-tGnY4-YM2za+jtGQ2r2DG0Bq6OOxnMtHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgUg1v5hJ0D-tGnY4-YM2za+jtGQ2r2DG0Bq6OOxnMtHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jun 2020, Linus Torvalds wrote:

> On Wed, Jun 3, 2020 at 2:04 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> >    - Convert to GPIO descriptors; l4f00242t03
> 
> I'm impressed by that completely nonsensical device naming scheme.
> 
> I had to look it up because I thought that line might have been line noise.
> 
> I know some manufacturers and tech people have "issues" with naming,
> but I thought it was mainly just DRAM chip manufacturers that used the
> output from /dev/urandom to generate names.

What can I say, there is no accounting for taste.

To be fair, I've seen quite a few panels/LCDs with long, seemingly
meaningless model numbers.  Many times they have information encoded
within them.  Hopefully they mean something to someone anyway!

> Ass a few special characters, and it would make for an excellent password.

Yes, indeed. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
