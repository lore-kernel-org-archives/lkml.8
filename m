Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF7CC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339CE2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YamDIrDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgBLTxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:53:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39019 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgBLTxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:53:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id j15so1757267pgm.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1AWXJaZ+M/XEkvhiKGrLr+34R/ByznWv2S2mVXPNnjg=;
        b=YamDIrDwFddysAcDWua56hzXv7lDB4HKrdSODVsPwHBE4HHsAYGn+XDZXaLyGGJLuD
         4N6BTWo6LRFS5vXXP6KAh/l1wvA65OHmtw/S1qbPAdcyTCBTaxonp4pggsf0hy6oitMf
         nKfCWU9CgVkCLAkcf+IIObAX4N2fivvdfm3BKqhD7SygUsmFFS04afPpEQEn/CexEjIi
         Uoi9/c1Q4IzArRa+H3OBoOJPbEYqEFKDZcI5QfDUAP1xlIRyhb8ado0qBp7XXWgoaWkS
         jgAsn9GLQd68qpur8Cz34vSBaC/8FytAq/rnOnK9IxLsgg83nRXtIFX/rUaMDekw5LFg
         HThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1AWXJaZ+M/XEkvhiKGrLr+34R/ByznWv2S2mVXPNnjg=;
        b=ZASy7MF3x4VXrlJvlFL2bJkp+y927crmX0HwW/MgFMHT0VpzauUmITFq6yKEkYCOtJ
         IfVSNdvcKlwCqOUD9pSnGX5RDov30q+8MwJG1DceFwINxmKg4wmCCyajzZ8GZi8IqCfq
         0XEA4qKWDAJjTWwDxuAKgn+cbHTsLW+nSp1cVWMu4TzGDuSk89c1kOZHtLfmFnkTWT0v
         Tt2k6kPAe3MzJnsPxo417QYI3kp6bWhHVPXgBahZY7hNBm6bvvGLKNUWHYbMPtP0o7Of
         XdPz6k4fp0D1ShafUR3ZqN0D6U5+LV2GEdk+L/B6A6C9UeBo/ShQvt4V6WYDx3xRAIMN
         eSvg==
X-Gm-Message-State: APjAAAVwCs/3uao3bkYSVdVdlid9yqquzgZJLKdHU2LnlMw3Zsj8Tmx7
        718uzG3vDWZLYpDjim1hnIR0Ig==
X-Google-Smtp-Source: APXvYqwiBlO43Srtx0lyJj2MrAKlNqXYg1FIQ7p5Qm51cLDiEjDInDuC0790jSVHcD0Qe04DoyWBZg==
X-Received: by 2002:aa7:84c4:: with SMTP id x4mr10064136pfn.144.1581537199973;
        Wed, 12 Feb 2020 11:53:19 -0800 (PST)
Received: from google.com ([2620:15c:100:202:d78:d09d:ec00:5fa7])
        by smtp.gmail.com with ESMTPSA id x21sm49255pfn.164.2020.02.12.11.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 11:53:18 -0800 (PST)
Date:   Wed, 12 Feb 2020 11:53:14 -0800
From:   Oliver Upton <oupton@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Subject: Re: [GIT PULL] KVM changes for Linux 5.6-rc2
Message-ID: <20200212195314.GA27069@google.com>
References: <20200212164714.7733-1-pbonzini@redhat.com>
 <CAHk-=wh6KEgPz_7TFqSgg3T29SrCBU+h64t=BWyCKwJOrk3RLQ@mail.gmail.com>
 <b90a886e-b320-43d3-b2b6-7032aac57abe@redhat.com>
 <CAHk-=wh8eYt9b8SrP0+L=obHWKU0=vXj8BxBNZ3DYd=6wZTKqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh8eYt9b8SrP0+L=obHWKU0=vXj8BxBNZ3DYd=6wZTKqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 11:38:20AM -0800, Linus Torvalds wrote:
> On Wed, Feb 12, 2020 at 11:19 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > > So this clearly never even got a _whiff_ of build-testing.
> >
> > Oh come on.
> 
> Seriously - if you don't even _look_ at the warnings the build
> generates, then it hasn't been build-tested.
> 
> I don't want to hear "Oh come on". I'm 100% serious.
> 
> Build-testing is not just "building". It's the "testing" of the build
> too. You clearly never did _any_ testing of the build, since the build
> had huge warnings.
> 
> Without the checking of the result, "build-testing" is just
> "building", and completely irrelevant.
> 
> If you have problems seeing the warnings, add a "-Werror" to your scripts.
> 
> I do not want to see a _single_ warning in the kernel build. Yes, we
> have one in the samples code, and even that annoys the hell out of me.
> 
> And exactly because we don't have any warnings in the default build,
> it should be really really easy to check for new ones - it's not like
> you have to wade through pages of warnings to see if any of them are
> your new ones.
> 
> So no "Oh come on". You did *zero* testing of this crap, and you need
> to own that fact instead of making excuses about it.
> 
>                    Linus

I should've caught this before even a build test, let alone sending it
out. My apologies for such an obvious + crap mistake.

--
Oliver
