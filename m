Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591D4C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3305B207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595277231;
	bh=kj0ZGGx5hMwKSLrydmMNsRGslJV5volidUvrsWUF6tY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SGOyOvJ2aQSvOONfRBKk8dz+tYMFP0ROangfQSs+HI7+4wNhHPb2nil3HUbiooqhQ
	 dvIzmb/Pye4tk+WY9Wwkoi7H3UB5X3bvrwSnmaLxla+zowtf6pqSiBDMlqdUcXrUKZ
	 BLbWpwAf6XJ4SmB4nPN/9ZzMpdIA/FvjAj7W4DGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgGTUdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbgGTUdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:33:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532A8C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:33:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h22so21671241lji.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDmn1h2o2KlEqHHKhXBH9l8ZWcNt0/FAMYjurOyZeZg=;
        b=J4l0ZcnzbDcy4NJWIveg9d5dEt9neEhl18sUfvBpqY56FlAQL21UjlJxwmbxNx+nh5
         KR/TupZ9ygiCPROrZC35vFmtuQ5+WKGjNk9FwuChIo2oD1dzhTyBKJLyBBWSAge2LEwR
         ua9AsxJMZaL58Rq4qor3I5Vc+zo/LVQGM675Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDmn1h2o2KlEqHHKhXBH9l8ZWcNt0/FAMYjurOyZeZg=;
        b=GOh36G+n5iw5cPMo6WxKca+3GAnlxKy7FRKuOrfIUd3kXmdgOdZOXNjfe4enzJHSCr
         wK+1TLreLUDfsR6IcTvwIe9ujbuL0ta+hUY0rKqfHuaNH/ZQ3hFlKPNHRqJUXBkCVT5Z
         z/hVWjrPm/o69XKYVRdB9fFFuh/l8UIbwFTusC801M3A8fJ7gS4+5lrRKJAj5pv5J/Su
         AeMBIXGpu5/FeudJlvYIKZFpNfEYKldkyDDZDDTMTDHHsn07DwnAeHeBZSO4LAc8nieb
         3VAEdjJXRLh2kBHSgp4+9vqDuVUhbAJbigo8RytMHlMS2RMb4ZVuHzL55i1+mVhXBF6m
         oTMw==
X-Gm-Message-State: AOAM530GuHOXaEFSTg3Okneo7vgfGj+e2lCY2rUCi6wOuxbfo61U5M9C
        RsTFOdyy4f0L78A/nxQZ32/zVyEVUdQ=
X-Google-Smtp-Source: ABdhPJxUBx0tVE511n3lpKi7P6faAhEcVh1ngfRR5XtPj00rN6AFna14QOxyAP3No26QZ/G14mXU3A==
X-Received: by 2002:a2e:5806:: with SMTP id m6mr10103945ljb.23.1595277227292;
        Mon, 20 Jul 2020 13:33:47 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id g22sm4023741lfb.43.2020.07.20.13.33.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 13:33:46 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id j21so10454123lfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:33:46 -0700 (PDT)
X-Received: by 2002:ac2:522b:: with SMTP id i11mr276989lfl.30.1595277226113;
 Mon, 20 Jul 2020 13:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200720083427.50202e82@x1.home>
In-Reply-To: <20200720083427.50202e82@x1.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Jul 2020 13:33:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijGPPiUH8-kzu2ZyP9_SgBxbGib7afOMAwpusfx-2K+g@mail.gmail.com>
Message-ID: <CAHk-=wijGPPiUH8-kzu2ZyP9_SgBxbGib7afOMAwpusfx-2K+g@mail.gmail.com>
Subject: Re: [GIT PULL] VFIO fix for v5.8-rc7
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 7:34 AM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> VFIO fixes for v5.8-rc7
>
>  - Fix race with eventfd ctx cleared outside of mutex (Zeng Tao)

Why does this take and then re-take the lock immediately? That just
looks insane.

I realize that this isn't likely to be a performance-critical path,
but this is a basic source cleanliness issue. Doing silly things is
silly, and shouldn't be done, even if they don't matter.

              Linus
