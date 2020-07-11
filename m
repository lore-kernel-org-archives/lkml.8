Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A73C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B8320786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594491727;
	bh=AUBBbysgdMeR71Y6xbwcXY/YIVqMzNZkIcPQpyj09H4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P+WVZxFA/uj0am6vokqNqtRtL9XNEr4hLvn/AhYIYAcxw+Ej0jVaG//CJ8Dlm9cdD
	 zYubHr1AT60dzurBWHHARxHfwBD32vyfMXOjRGc4ElhODTXOJQDZNN+XSKSRIjAfFX
	 5PQUYb/S8nx3i+RUg2zYbno6KSFMfj+Lqs0SLjdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgGKSWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 14:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgGKSWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 14:22:05 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40169C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 11:22:04 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e8so10175740ljb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qptBZzYQmGUSrB1gYaro4KC86w7xRACt4nGpxA934Lg=;
        b=MS0M6Jpdfk5BRX9IT/yz435ln8+5sFvRJ5xcVUEVxD5BVgZX9q3pL4EfWbDc3q4Jkr
         e50VjG3ye4PDFlZy8RDkfbelBtcZP6hNhsexP/JMdK3XJmaM7/ypSusjb8G6D9Qy6xRk
         mWs+G1YR76GNa9sv/YeWuA+fcLo5auw5Y4kPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qptBZzYQmGUSrB1gYaro4KC86w7xRACt4nGpxA934Lg=;
        b=p5nRdnIzuuk8m6biT7cgacrTjmBquH1C8cO+0nkVlWf0AUSRJGdA4dUp9L81IB1M1T
         eOsvFVbPuhqa0C7nbgzF5E3Dwz6uHN6l5AGATDX1qLPE0ljUbAyCeYMBT8zo9JxV57C0
         bpQ75d96yBzcGF704rHymNnCVfdlh7z0fpPq8da+waBro09PhKUpBPC+aycJ9RsubVMN
         eyFegqPAjNmAsahwDgkx4ot/iX5PIkX3NenNMCU1FAsUkcWBx+/reO1c0HvD90LI6Ner
         nwXXxs0JFPyEiYrWzzb+JXPvlh/ENtgN7FSaCvZFxBkvX9kQc2oazPZaBueOjFLyhgVC
         d4uw==
X-Gm-Message-State: AOAM533NPLhvSqLa3d1lhtLCayUG970tFW6UpLqYGdmNV3raq9jp1zTW
        4GSf+uXMbc0EiLcBoyuW0LJ3ZYJo/5s=
X-Google-Smtp-Source: ABdhPJxHIQK4z3jC0csP+SyHazF+FgTjkiR41/ytzpWAiWJglEPlHF5st3UhDfweXAOq7ivdLHZpbQ==
X-Received: by 2002:a2e:5746:: with SMTP id r6mr45780400ljd.205.1594491722340;
        Sat, 11 Jul 2020 11:22:02 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id s4sm3304312lfc.71.2020.07.11.11.22.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2020 11:22:00 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id f5so10123131ljj.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 11:22:00 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr38521209ljn.421.1594491719786;
 Sat, 11 Jul 2020 11:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt+6OeibZMD0fP=O3nqFbcN3O4xcLkjq0mpQbZJ2uxB9w@mail.gmail.com>
 <CAHk-=wgRcFSnQt=T95S+1dPkyvCuVAVGQ37JDvRg41h8hRqO3Q@mail.gmail.com>
 <CA+G9fYuL=xJPLbQJVzDfXB8uNiCWdXpL=joDsnATEFCzyFh_1g@mail.gmail.com>
 <CAHk-=wgB6Ds6yqbZZmscKNuAiNR2J0Pf3a8UrbdfewYxHE7SbA@mail.gmail.com>
 <CA+G9fYudT63yZrkWG+mfKHTcn5mP+Ay6hraEQy3G_4jufztrrA@mail.gmail.com>
 <CAHk-=whPrCRZpXYKois-0t8MibxH9KVXn=+-O1YVvOA016fqhw@mail.gmail.com>
 <CA+G9fYusSSrc5G_pZV6Lc-LjjkzQcc3EsLMo+ejSzvyRcMgbqw@mail.gmail.com> <CAHk-=wj_Bqu5n3OJCnKiO_gs97fYEpdx6eSacEw2kv9YnnSv_w@mail.gmail.com>
In-Reply-To: <CAHk-=wj_Bqu5n3OJCnKiO_gs97fYEpdx6eSacEw2kv9YnnSv_w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Jul 2020 11:21:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6mHH-LwqMNBcrP2nO8_acb_T2CCsweH-p8BvUFeAWtg@mail.gmail.com>
Message-ID: <CAHk-=wg6mHH-LwqMNBcrP2nO8_acb_T2CCsweH-p8BvUFeAWtg@mail.gmail.com>
Subject: Re: WARNING: at mm/mremap.c:211 move_page_tables in i386
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        William Kucharski <william.kucharski@oracle.com>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>,
        Michel Lespinasse <walken@google.com>,
        Fan Yang <Fan_Yang@sjtu.edu.cn>,
        Brian Geffon <bgeffon@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, pugaowei@gmail.com,
        Jerome Glisse <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 11:12 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The fact that it seems to happen with
>
>     https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/thp/thp01.c
>
> makes me think it's somehow related to THP mappings, but I don't see
> why those would matter. All the same pmd freeing should still have
> happened, afaik.

No, I think the only reason it happens with that test-case is simply
because that test-case tests many different argument sizes, and as
part of that it ends up then hitting the "stack is exactly one pmd in
size" case when the stack alignment is right too.

So the THP part is almost certainly a red herring.

Maybe. Considering that I don't see what's wrong, anything is possible.

                Linus
