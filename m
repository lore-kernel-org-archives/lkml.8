Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D17FC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654F7206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjbihcz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgBMVsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:48:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45125 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbgBMVsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:48:15 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so7118714otp.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 13:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OA6xe4auWdZmJjRQ/wLiVug/7u1e1T2hWJ4r61PFbbI=;
        b=Yjbihcz/pjHpfRB3FK6+kvNDhYFYbKTb1fXNAhFDe7n59LWRE2MCoGk1PeaKJHPvF4
         RtNIcD/phGw2ZuoWRUZrK1q4zQOgagT8eH9UxHfJp8JS3HlkHgcoR5wj66yRZoz3lQG1
         0V2azohVyjf1jbPfBR6yNDkaJfpzXLfLX6hHZ30DyW4nRdCBdCiQ+qLLUqxQOE5Aw0RW
         w1TU55yhMAMuOHFWgjyf4knPaW8zX8nR0V70N6aBJz1weth7/T/9DOanwwibX1hGcLqb
         xDYSMNuXGUigliBYkNovwpJSc8hED9QlvnUIOCtqOWazNjan9pkfh6st8JLX1dn4BXGq
         FQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OA6xe4auWdZmJjRQ/wLiVug/7u1e1T2hWJ4r61PFbbI=;
        b=HP7wFVlJBjBbaQ1IueMY9HxMPdiPeGRc05EXx/OOhZD0cg/+BrvdU33fjMuiUHWhvI
         6U2x59LgucFNsPc4l0pvOCM/1hbpnV8ynYRhe3RQH9ITukugv6xBjfQ2n5v/32Ow8QlM
         mRa/u8DqpycHb1fzCyf8Np+9tAXQtcyY17OHLN/48+PYq8eQmVoXN5icIYbgDsxqxUqb
         xSw7UQ5EXeoQShLVvp2e+BfUSg+NnJNNvblw3Q3/i14FY/m5c1ZfXS+CKbyQTD6mwD3P
         lDcIRgr0lqrCssTVxWiNxoUf3HvF5zp+jGujRDiDdoX0mEs+0K7j8I2xMpW/nkwYFeoY
         /L4g==
X-Gm-Message-State: APjAAAX1unxStACPuV66+APxjtgK3rpdiopB3Se43LHI79l8Z5+5PeLq
        5KGA67Q+P3rBgCrq7oPuDg4=
X-Google-Smtp-Source: APXvYqz3P6jxWKRvESHwGthFWB57MpjdHTr6nTaZb86AI0CqwYT2Gh/3W9UwxiWywmhVURTmUZK27Q==
X-Received: by 2002:a9d:138:: with SMTP id 53mr8087394otu.334.1581630494627;
        Thu, 13 Feb 2020 13:48:14 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id q6sm1225527otn.73.2020.02.13.13.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 13:48:14 -0800 (PST)
Date:   Thu, 13 Feb 2020 14:48:12 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        clang-built-linux@googlegroups.com,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915: Disable
 -Wtautological-constant-out-of-range-compare
Message-ID: <20200213214812.GA7980@ubuntu-m2-xlarge-x86>
References: <20200211050808.29463-1-natechancellor@gmail.com>
 <20200211061338.23666-1-natechancellor@gmail.com>
 <4c806435-f32d-1559-9563-ffe3fa69f0d1@daenzer.net>
 <20200211203935.GA16176@ubuntu-m2-xlarge-x86>
 <f3a6346b-2abf-0b6a-3d84-66e12f700b2b@daenzer.net>
 <20200212170734.GA16396@ubuntu-m2-xlarge-x86>
 <d81a2cfe-79b6-51d4-023e-0960c0593856@daenzer.net>
 <877e0qy2n8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877e0qy2n8.fsf@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 04:37:15PM +0200, Jani Nikula wrote:
> On Wed, 12 Feb 2020, Michel Dänzer <michel@daenzer.net> wrote:
> > On 2020-02-12 6:07 p.m., Nathan Chancellor wrote:
> >> On Wed, Feb 12, 2020 at 09:52:52AM +0100, Michel Dänzer wrote:
> >>> On 2020-02-11 9:39 p.m., Nathan Chancellor wrote:
> >>>> On Tue, Feb 11, 2020 at 10:41:48AM +0100, Michel Dänzer wrote:
> >>>>> On 2020-02-11 7:13 a.m., Nathan Chancellor wrote:
> >>>>>> A recent commit in clang added -Wtautological-compare to -Wall, which is
> >>>>>> enabled for i915 so we see the following warning:
> >>>>>>
> >>>>>> ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
> >>>>>> result of comparison of constant 576460752303423487 with expression of
> >>>>>> type 'unsigned int' is always false
> >>>>>> [-Wtautological-constant-out-of-range-compare]
> >>>>>>         if (unlikely(remain > N_RELOC(ULONG_MAX)))
> >>>>>>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> >>>>>>
> >>>>>> This warning only happens on x86_64 but that check is relevant for
> >>>>>> 32-bit x86 so we cannot remove it.
> >>>>>
> >>>>> That's suprising. AFAICT N_RELOC(ULONG_MAX) works out to the same value
> >>>>> in both cases, and remain is a 32-bit value in both cases. How can it be
> >>>>> larger than N_RELOC(ULONG_MAX) on 32-bit (but not on 64-bit)?
> >>>>>
> >>>>
> >>>> Hi Michel,
> >>>>
> >>>> Can't this condition be true when UINT_MAX == ULONG_MAX?
> >>>
> >>> Oh, right, I think I was wrongly thinking long had 64 bits even on 32-bit.
> >>>
> >>>
> >>> Anyway, this suggests a possible better solution:
> >>>
> >>> #if UINT_MAX == ULONG_MAX
> >>> 	if (unlikely(remain > N_RELOC(ULONG_MAX)))
> >>> 		return -EINVAL;
> >>> #endif
> >>>
> >>>
> >>> Or if that can't be used for some reason, something like
> >>>
> >>> 	if (unlikely((unsigned long)remain > N_RELOC(ULONG_MAX)))
> >>> 		return -EINVAL;
> >>>
> >>> should silence the warning.
> >> 
> >> I do like this one better than the former.
> >
> > FWIW, one downside of this one compared to all alternatives (presumably)
> > is that it might end up generating actual code even on 64-bit, which
> > always ends up skipping the return.
> 
> I like this better than the UINT_MAX == ULONG_MAX comparison because
> that creates a dependency on the type of remain.
> 
> Then again, a sufficiently clever compiler could see through the cast,
> and flag the warning anyway...

Would you prefer a patch that adds that cast rather than silencing the
warning outright? It does appear to work for clang.

Cheers,
Nathan
