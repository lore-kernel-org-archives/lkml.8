Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01618C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4868206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591290990;
	bh=08nZgXvPl19HDIg7XZbBxcvU4tdcjivgkaK6s6iQ7Zk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MisOE+D6tyirrwmrbLB1vJ4xDjaiCIkk3DoqlQx8FoVM5t7FX4vTo3wYUU8nTRJP+
	 trNbtm0L+EYenijntrHNCwQ4Rm7ibclh0keCJddhs81OYF5xnJoOTikYYN3xASG1EQ
	 YSRaqZyr/FwFPM6v2ZsETsl9ozEzgOvHdTZBl4I0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgFDRQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730051AbgFDRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:16:29 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14AAC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 10:16:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z18so8228439lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8kZFr8TiFC27H3w+X6ZCuLeuTOqZ7+EkG9BgkcWmiE=;
        b=C7WSNRoJag77E7M3JA5+YgLnjPBrdf00/5milKzOk0Mh/stV1wcQhNQM4qki+qew6e
         qTIrXsmck8Bd578raZvZGYMwEnRTiJv8DVaKRWk4F96h/ntvJqbdECJtT+SYCc2UAQYn
         6031MrSwuK2KLCneeH6uAJNVSwh5GMCXyqoqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8kZFr8TiFC27H3w+X6ZCuLeuTOqZ7+EkG9BgkcWmiE=;
        b=gulrlx2ZeYRoOX9YxkbyW+4u3zAgBkkodnJ7k6E2gOzur4kqq1heZk4KQCZ38/0JtY
         USqWHhp9O910kpvsHr7WPQE4u5ueyKT036PUIZA8qRGaMBE1gBiWDxDPUdbLp2CzM9Vi
         cjEsv9WpXF0o+F3aNS3tlML01h6g0EzrHIH1QYlmxPOuu1O7m69UlwsWJk4xjmULUB/c
         YvhJXr8KjR74giVjFtqhNbCxvOIgxo2nChd6OYXKB6fHANzZlvo+/u3I3g4ThvuE85l8
         L6tQUCjN+8zJJm3r9W+OtH+92J2IjMsO4wS4NdQEF6McbdwYz+QMVguhrzx44ojZMVPR
         kZSg==
X-Gm-Message-State: AOAM533iMh7dPF0aOWZZV0wdrDPmLRId5+nfyT1aL+j1cyJV1Oh4UARa
        SHjUvOUHqovzHYT9UI7+SQF9Aag8NFg=
X-Google-Smtp-Source: ABdhPJwp5tQ6+5Z63GZzHFM2S5m+ap4/Ghs8XiLha5Ecx8eHrDiwD2hdKSxGBmz4+Y9Cuy09KTNdAA==
X-Received: by 2002:a2e:b612:: with SMTP id r18mr2521993ljn.195.1591290986304;
        Thu, 04 Jun 2020 10:16:26 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id c8sm55581lfc.46.2020.06.04.10.16.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 10:16:25 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id a9so4726950ljn.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:16:24 -0700 (PDT)
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr2563945ljo.371.1591290984015;
 Thu, 04 Jun 2020 10:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200603232311.GA205619@roeck-us.net> <20200604083512.GN6857@suse.de>
In-Reply-To: <20200604083512.GN6857@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Jun 2020 10:16:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com>
Message-ID: <CAHk-=wj2_YdxPaRFqBUUDZvtZKKG5To2KJhciJmDbchW2NFLnw@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: track which page-table levels were modified
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 1:35 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> I posted the fix for this already:
>
>         https://lore.kernel.org/lkml/20200604074446.23944-1-joro@8bytes.org/

Ugh.

I was going to apply this directly, but as I looked at the patch I
just found it fairly illegible.

Is there some reason why the 5level-fixup.h versions use that
very-hard-to-follow macro, rather than the inline functions that the
main mm.h file uses?

I'm _assuming_ it's because it gets included in some place where not
everything is defined yet, so making it a macro means that it works
(later on) when everything has come together..

But the solution to that would seem to make all the p.._alloc_track()
macros just be in a different header file, and make them be all
together. We already have that

   #if !__ARCH_HAS_5LEVEL_HACK

in linux/mm.h, so it's not like we really have isolated that issue
into just 5level-fixup.h anyway, and creating a new
<linux/pagetable-alloc.h> header that has all the variations in one
place, and that is only included by the two (!) users of these things
would seem to be a good idea regardless.

Because <linux/mm.h> is included by pretty much everything. Why do we
have those alloc_track functions defined in such a common header when
they are _so_ special?

Please? I'd obviously like this to be fixed on ppc asap, but I'd also
like the fix to improve on the current somewhat confusing situation..

For extra point, the p??_alloc_track() functions could even be
generated from a macro pattern, because the pattern is pretty much set
in stone.

I think the only thing that really differs is the types and the
PGTBL_xyz_MODIFIED mask, and which entry is tested for "none" (which
is also the only thing that makes the 5level fixup case different -
no?

                       Linus
