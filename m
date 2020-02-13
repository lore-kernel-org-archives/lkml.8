Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B59C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287252168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSgExaGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgBMX11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:27:27 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40133 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBMX10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 18:27:26 -0500
Received: by mail-oi1-f195.google.com with SMTP id a142so7631360oii.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 15:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=phnCn7mKlZPWUI9KXkv1lYA4R+8w6RQ/h4tld1EHfzY=;
        b=tSgExaGoLaq8u6hZyZ70QjOD0b9Mo2pTA/GpwZyxT661oxJn9GDuJ43iuPoGCiWR6Q
         pTGcUIVDI4ZFXeCBb++m1pnArVPMf5e6I1U/+cnUHFgmsvXUwpL9CuB8ilC5wEhU8d7i
         5RQ7cDhGxWjNcavRCyXp03xB7bqyCULjB6OmO8NisychmtVgAK+4ibK0jYdr7deMXSow
         wquazQ+m7XdjmF0zauXHXG/fGjB1NAAENNjzYsiWJHoDvyb4IruZ/5UYiDgkQYuK5EeR
         73COvdUelbwqNooYGrBes6ZzhaMUj++cW7C4+olEZfDl9cZLJ32ZgWNPYSP24SB2SaZy
         a3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=phnCn7mKlZPWUI9KXkv1lYA4R+8w6RQ/h4tld1EHfzY=;
        b=X+onfO3CSi0ay/Of9UPr0f2sfsvRUYiXmlPOxGSgaeJ14EzTrXeE/Uu2vbrbcNEqrg
         iW+HwzOo+8mxYX0toJZSm7N/s1MQ67nbofMr90FYkw0cI0AJ1NQHBI1Vh8k2/faKOZE8
         J0fDmBhr8eTS5RHZKE05Vkrr2Gy9m94Vgn6rMMhZupmwjlYM1pIl/hgH1gsJ1iJuh4yq
         p+uQKAmfpRJSNVTCVVY5o3Ythone2yr/v6Hsfcqu+PcNR66RA8shQhG5GFekKZs4tuRZ
         G8WwseTAgAe9UrXqPtNGhMHsqUsJw3lqz2M5uq09bGoAjQWTfYLlJ1048zu4C+MRf0Bh
         oX4w==
X-Gm-Message-State: APjAAAXe6MvEaeqKbNk9myyr4+Ivf9qXXxHmcvqSUGSwug5/MXQI3VlW
        L7NwhQjb/bwdQ+T+Sl0b0VA=
X-Google-Smtp-Source: APXvYqzUb4skfimU29+d3GeNL8MzppZrPxpAt5aUIZc480u59SxuAnYW5JzENtYOmXrsHln3Fw/n9Q==
X-Received: by 2002:a54:488d:: with SMTP id r13mr5819oic.115.1581636445805;
        Thu, 13 Feb 2020 15:27:25 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c12sm1291127oic.27.2020.02.13.15.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 15:27:25 -0800 (PST)
Date:   Thu, 13 Feb 2020 16:27:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v2] drm/i915: Disable
 -Wtautological-constant-out-of-range-compare
Message-ID: <20200213232723.GA26697@ubuntu-m2-xlarge-x86>
References: <20200211050808.29463-1-natechancellor@gmail.com>
 <20200211061338.23666-1-natechancellor@gmail.com>
 <4c806435-f32d-1559-9563-ffe3fa69f0d1@daenzer.net>
 <20200211203935.GA16176@ubuntu-m2-xlarge-x86>
 <f3a6346b-2abf-0b6a-3d84-66e12f700b2b@daenzer.net>
 <20200212170734.GA16396@ubuntu-m2-xlarge-x86>
 <d81a2cfe-79b6-51d4-023e-0960c0593856@daenzer.net>
 <CAKwvOdm4eS19-D3pEkKsyZw7VjJP9Jeh5gMZaszwgjrJe63yUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdm4eS19-D3pEkKsyZw7VjJP9Jeh5gMZaszwgjrJe63yUg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:43:21PM -0800, Nick Desaulniers wrote:
> On Wed, Feb 12, 2020 at 9:17 AM Michel Dänzer <michel@daenzer.net> wrote:
> >
> > On 2020-02-12 6:07 p.m., Nathan Chancellor wrote:
> > > On Wed, Feb 12, 2020 at 09:52:52AM +0100, Michel Dänzer wrote:
> > >> On 2020-02-11 9:39 p.m., Nathan Chancellor wrote:
> > >>> On Tue, Feb 11, 2020 at 10:41:48AM +0100, Michel Dänzer wrote:
> > >>>> On 2020-02-11 7:13 a.m., Nathan Chancellor wrote:
> > >>>>> A recent commit in clang added -Wtautological-compare to -Wall, which is
> > >>>>> enabled for i915 so we see the following warning:
> > >>>>>
> > >>>>> ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
> > >>>>> result of comparison of constant 576460752303423487 with expression of
> > >>>>> type 'unsigned int' is always false
> > >>>>> [-Wtautological-constant-out-of-range-compare]
> > >>>>>         if (unlikely(remain > N_RELOC(ULONG_MAX)))
> > >>>>>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> > >>>>>
> > >>>>> This warning only happens on x86_64 but that check is relevant for
> > >>>>> 32-bit x86 so we cannot remove it.
> > >>>>
> > >>>> That's suprising. AFAICT N_RELOC(ULONG_MAX) works out to the same value
> > >>>> in both cases, and remain is a 32-bit value in both cases. How can it be
> > >>>> larger than N_RELOC(ULONG_MAX) on 32-bit (but not on 64-bit)?
> > >>>>
> > >>>
> > >>> Hi Michel,
> > >>>
> > >>> Can't this condition be true when UINT_MAX == ULONG_MAX?
> > >>
> > >> Oh, right, I think I was wrongly thinking long had 64 bits even on 32-bit.
> > >>
> > >>
> > >> Anyway, this suggests a possible better solution:
> > >>
> > >> #if UINT_MAX == ULONG_MAX
> > >>      if (unlikely(remain > N_RELOC(ULONG_MAX)))
> > >>              return -EINVAL;
> > >> #endif
> > >>
> > >>
> > >> Or if that can't be used for some reason, something like
> > >>
> > >>      if (unlikely((unsigned long)remain > N_RELOC(ULONG_MAX)))
> > >>              return -EINVAL;
> > >>
> > >> should silence the warning.
> > >
> > > I do like this one better than the former.
> >
> > FWIW, one downside of this one compared to all alternatives (presumably)
> > is that it might end up generating actual code even on 64-bit, which
> > always ends up skipping the return.
> 
> The warning is pointing out that the conditional is always false,
> which is correct on 64b.  The check is only active for 32b.
> https://godbolt.org/z/oQrgT_
> The cast silences the warning for 64b.  (Note that GCC and Clang also
> generate precisely the same instruction sequences in my example, just
> GCC doesn't warn on such tautologies).

Thanks for confirming! I'll send a patch to add the cast later tonight.

Cheers,
Nathan
