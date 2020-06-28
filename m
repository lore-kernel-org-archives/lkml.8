Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D524CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B557C206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 18:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593369640;
	bh=sP6+YCYJ3vJWTnRzzpXrg2RGyvltOS9AxzZrcg9wbK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H4iKHu+/U6Yt+PnLRSfePLhsbb7wjkpM6nbS3sADzbossUo1gMne6eMLPam0ea+Bs
	 mU1BVcXxVq6THv+IiPfp1qEW8N9g+wcFtbW8LGArMNz/cjyMgPPr1vEOUr26SmnBNT
	 9WDqpjx7Vy5Suq5oDbQw/UBbORwSKOp+cAFfrnFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgF1Skg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 14:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgF1Skf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 14:40:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF18C03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:40:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f8so3408817ljc.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hCB3GF8caEOJFCpWHvqxldz66GMS9jafbuDojxYxgOo=;
        b=aJkCsFPfDrze8xst0GQoBdbCucE8dsyeRBsSQbhsmXwA1SxPl++40aFoA9VRJeJlKT
         wnO7c5E1wvdyCKwMfqlHCg4BKquBfqpwQIGjXH+dI1RiXT5SaZgPi5EOuFMsAA9HlGAc
         9ih+mw491LGp3FB0uLXziV4cpcAVbxI1o1a10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hCB3GF8caEOJFCpWHvqxldz66GMS9jafbuDojxYxgOo=;
        b=oVqk3J9qQNeYQ6RPTFVRbaVPhU3qn/xmbBlWkJQswYPseEbBzQelibLWK9jrq9x0xP
         4szemuEf5fnfzlcOBlTG4+tGKWPGn+YVtHn+Tx4GC6gpy0wQJAVrZkYjGj/19GnHoQmV
         shpxF0d4FEH/cU9bsyWZRLR0xYb1vr0gSYoto0Ok/oTScIm7dJcVOEYeCd000FLH/t15
         1zYB803Gi56dLfgkvZDQkimBlUbP7DJv357liXCcoQT/HQmKwSc1AwMJJ+0pyL+p8Ujo
         UVHDxdZ/DtbBHhnA4/q9vG4ulTsJ4cx+LB9XE6y5fAqKKophIF/KY8qAAWh+dQqqMmmW
         XoOA==
X-Gm-Message-State: AOAM533YdPWW61N/R9phMA6xgvDppDc7qLmk+LQ8eNDtuLrCgxDbtFUa
        IYuFTTOaM72H6NJYt0ES0PtvQ5tkwOI=
X-Google-Smtp-Source: ABdhPJziaG8AlzcZqFbl5eKJFhhA32quLhuVTwa1K7t9EuvlSbBbZRrRHmBx9DB8GZB66ADFh77wPw==
X-Received: by 2002:a2e:b0db:: with SMTP id g27mr6361271ljl.425.1593369633417;
        Sun, 28 Jun 2020 11:40:33 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q1sm6979902lji.71.2020.06.28.11.40.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2020 11:40:32 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 9so15659751ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 11:40:32 -0700 (PDT)
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr6585240ljj.312.1593369632297;
 Sun, 28 Jun 2020 11:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200628152342.GE18884@zn.tnic> <20200628181544.GB19572@gmail.com>
In-Reply-To: <20200628181544.GB19572@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Jun 2020 11:40:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqaq=otcxZfJrbRCJ31k_paP4RLOOkzLF6wwvW3aQd9A@mail.gmail.com>
Message-ID: <CAHk-=wjqaq=otcxZfJrbRCJ31k_paP4RLOOkzLF6wwvW3aQd9A@mail.gmail.com>
Subject: Re: [GIT PULL] sched/urgent for 5.8-rc3
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 11:15 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> I based sched/urgent on a tested-working merge commit, not on a random
> interim commit - in this sense your rebase of 68f7b5cc835d was
> somewhat unnecessary.
>
> I believe avoiding random merge commits is mostly relevant in the
> merge window phase, when reliability of interim merge stages is
> arguably low and same-day rebases were a disease a couple of years
> ago.

Yes. And in general I'd prefer to not see rebases.

I took the rebased pull from Borislav already, though, so it's there now.

                  Linus
