Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCA1C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCDE20658
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6dnA0RT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgBLRHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:07:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41902 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLRHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:07:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so2702621oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 09:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q493gbsIG2nzkYQNNXMk8303hOGd7AofSKLTmVfJkrQ=;
        b=X6dnA0RTNXJDidnIaF7rpAQm9PvzOfyg3+2WZzhPcKSua0bjpxviNbu5jelqeJJX8d
         ThzB5qmZwKcDpAb+0WKbvBhC02OeLM+9OSwKuLKcilti+E/82Ld5GfQGWzu8MVW7aoYF
         BGghMfU3ghmMWNe8HA60guR6YC2DDj51kh8pBXxyUJvW91f8HY+7AMEyPlzoX19YxZeK
         KvRigiQNTGhKmTC/v4lPIUzPXc7v0GzPmLr2H07rGqdBaf5FD2+odeIoVZ0lyrGpfj+o
         ZaGJTlEX/ge92xgMybHE3N26Qyl7TZv1tnwirZ74cYWKTBenV6roDnTVYCrbPoqP0u9Y
         RgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q493gbsIG2nzkYQNNXMk8303hOGd7AofSKLTmVfJkrQ=;
        b=TYv9BcQSUH+Lk1XdecCYDMJkJ30SGdrZrd8v5ab8TIeOitHnk4FC1BUHrKPV55+Elf
         m0A2+W6V5DrCai7qa2GuLpyBLLExJvJ2Ycccn3LcSQ+Cs+GXW94Vjj/Yv0boYJP1Fjr2
         8Tz0gwknzEcpqmNkNcrsBAnJiSafsjF4hk3jqeD8meQWi9CDOAEHJsBAyob0iPz7pH6A
         sMglsuHzLenl0KS/SkAU0cg8saWRm8mKyMh5bBWG4eLDKPrmi2B164JbjvlgKcN+Lp71
         Dfl60m6ZYZSd5LG4RxJWlOwaydF5fb7RZhDqFFIfb+KCd836TpU6DE8lg0RjodWbq/Fw
         AiWg==
X-Gm-Message-State: APjAAAVl5kPYoJnGI1s+w47IZiD6F0GRTPtN5/CSsNHhP2p8K1rRZS/w
        Yf6DSzD1jlJgLm59vaD+5ic=
X-Google-Smtp-Source: APXvYqyviBldb4Xv5YdD9F9qx1MwM9JXddB2XpOhzhuPVHIEb7x8ahgRLbCAR8qoy6oNsTdEDQrDzA==
X-Received: by 2002:a05:6808:8ca:: with SMTP id k10mr36867oij.164.1581527256335;
        Wed, 12 Feb 2020 09:07:36 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id w20sm343637otj.21.2020.02.12.09.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 09:07:35 -0800 (PST)
Date:   Wed, 12 Feb 2020 10:07:34 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v2] drm/i915: Disable
 -Wtautological-constant-out-of-range-compare
Message-ID: <20200212170734.GA16396@ubuntu-m2-xlarge-x86>
References: <20200211050808.29463-1-natechancellor@gmail.com>
 <20200211061338.23666-1-natechancellor@gmail.com>
 <4c806435-f32d-1559-9563-ffe3fa69f0d1@daenzer.net>
 <20200211203935.GA16176@ubuntu-m2-xlarge-x86>
 <f3a6346b-2abf-0b6a-3d84-66e12f700b2b@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3a6346b-2abf-0b6a-3d84-66e12f700b2b@daenzer.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 09:52:52AM +0100, Michel Dänzer wrote:
> On 2020-02-11 9:39 p.m., Nathan Chancellor wrote:
> > On Tue, Feb 11, 2020 at 10:41:48AM +0100, Michel Dänzer wrote:
> >> On 2020-02-11 7:13 a.m., Nathan Chancellor wrote:
> >>> A recent commit in clang added -Wtautological-compare to -Wall, which is
> >>> enabled for i915 so we see the following warning:
> >>>
> >>> ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
> >>> result of comparison of constant 576460752303423487 with expression of
> >>> type 'unsigned int' is always false
> >>> [-Wtautological-constant-out-of-range-compare]
> >>>         if (unlikely(remain > N_RELOC(ULONG_MAX)))
> >>>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> >>>
> >>> This warning only happens on x86_64 but that check is relevant for
> >>> 32-bit x86 so we cannot remove it.
> >>
> >> That's suprising. AFAICT N_RELOC(ULONG_MAX) works out to the same value
> >> in both cases, and remain is a 32-bit value in both cases. How can it be
> >> larger than N_RELOC(ULONG_MAX) on 32-bit (but not on 64-bit)?
> >>
> > 
> > Hi Michel,
> > 
> > Can't this condition be true when UINT_MAX == ULONG_MAX?
> 
> Oh, right, I think I was wrongly thinking long had 64 bits even on 32-bit.
> 
> 
> Anyway, this suggests a possible better solution:
> 
> #if UINT_MAX == ULONG_MAX
> 	if (unlikely(remain > N_RELOC(ULONG_MAX)))
> 		return -EINVAL;
> #endif
> 
> 
> Or if that can't be used for some reason, something like
> 
> 	if (unlikely((unsigned long)remain > N_RELOC(ULONG_MAX)))
> 		return -EINVAL;
> 
> should silence the warning.

I do like this one better than the former.

> 
> 
> Either of these should be better than completely disabling the warning
> for the whole file.

Normally, I would agree but I am currently planning to leave
-Wtautological-constant-out-of-range-compare disabled when I turn on
-Wtautological-compare for the whole kernel because there are plenty of
locations in the kernel where these kind of checks depend on various
kernel configuration options and the general attitude of kernel
developers is that this particular warning is not really helpful
for that reason.

I'll see if there is a general consensus before moving further since I
know i915 turns on a bunch of extra warnings from the rest of the kernel
(hence why we are in this situation).

Cheers,
Nathan
