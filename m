Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C6AC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85627222E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752587;
	bh=7usj8G53T2PxhhBTZ/BHiSjt3kRtoBBMWsxNnyzeRD0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mhK43nr6KHzvFp9J2k1bnWy+cl48RDxzaJGZy5xtewZaVKwRvHOxaRuDjUcKXXu42
	 NmApCL9Hy8lf3ozEJbvR8CKXyYH3Q2ni7sxl0bYEWi4N5LHvziu41LYygPy0jPmhot
	 9tk0HeuhG4V4kUZGK7heD3LXpDkCjMStKzuZahlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgGNStq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgGNStl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:49:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6ADC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:49:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b25so24780005ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Alox4jKEMRaA950HZ1waP0+wedXfzVsNihjzfohVQYc=;
        b=VvlDJH5CSlxwkIB6dqeYM9fELFt2NoQrAo8WwW52hkqyP+QEgrAcfi37PxvMFQ3jXz
         exscy1cS5CvqO0N4kUSCglH47nIFT7m+TmAko7nxgzLwvs9rvLlklibVS3y9Lb+KsOEb
         7GJJwIeCsAlMivcZbPoiCqejNh8PNrAxOIO3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Alox4jKEMRaA950HZ1waP0+wedXfzVsNihjzfohVQYc=;
        b=X/LKeQIXm355+KLdnshrIPi60skknn7aWDtZdzcp5Ug2QBldBUmLoEiBa9OvBh/p53
         5WfRtszvMs61vbL+S/UTSY5qdYOFpL0qKfvI3cwZyCPSAC4ji8ULImcUpLqItMQre5KX
         g3NFLHhe3fVg1DvmNp91UBzQZ3P0VxwQPi/jI3eUYEdS6rOUA0eCG00D93pFsFGNgsef
         vgoXKogp5Q8r/Zz45bMRZAe1su31VtqiV9HBoYo1kez8Pie8s/JMVBWYhwk4ScFzPtls
         W40EiYDvWda4K387rrDI6eY5KbH7kw5BvQ+gcaogEXYzLw/6kmoIjnNzfTmEpSLshg9D
         N80g==
X-Gm-Message-State: AOAM533AcrMybX3Xi0tbGO8aho5Y0Mzu1PdBf66HwyRu8uimcvb3YSVF
        ZieK+QvWN+OzujHTzG1hmRds4papJuE=
X-Google-Smtp-Source: ABdhPJz/fv7+JpDgxX6su3ekiz/On1iOaJ0li8Qjf2H9zVwZxPuYkAmsLepF9JaOiWGsSK/V79MC8w==
X-Received: by 2002:a2e:7a16:: with SMTP id v22mr1794780ljc.42.1594752578974;
        Tue, 14 Jul 2020 11:49:38 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id k6sm5457184lfm.89.2020.07.14.11.49.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 11:49:37 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id f5so24801419ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:49:36 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr3097947ljj.312.1594752576542;
 Tue, 14 Jul 2020 11:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt+6OeibZMD0fP=O3nqFbcN3O4xcLkjq0mpQbZJ2uxB9w@mail.gmail.com>
 <CAHk-=wgRcFSnQt=T95S+1dPkyvCuVAVGQ37JDvRg41h8hRqO3Q@mail.gmail.com>
 <CA+G9fYuL=xJPLbQJVzDfXB8uNiCWdXpL=joDsnATEFCzyFh_1g@mail.gmail.com>
 <CAHk-=wgB6Ds6yqbZZmscKNuAiNR2J0Pf3a8UrbdfewYxHE7SbA@mail.gmail.com>
 <20200712215041.GA3644504@google.com> <CAHk-=whxP0Gj70pJN5R7Qec4qjrGr+G9Ex7FJi7=_fPcdQ2ocQ@mail.gmail.com>
 <20200714073306.kq4zikkphqje2yzb@box> <20200714160843.GA1685150@google.com>
 <CAHk-=wjffJ=EBrLjsz=KUFyPXVQUO03L=VJmHnLhVr4XvT3Mpw@mail.gmail.com> <CAEXW_YRTnCb-z6TeboA3OCYv8eoX8UiCNn7K1hGMX+41Zdz8Og@mail.gmail.com>
In-Reply-To: <CAEXW_YRTnCb-z6TeboA3OCYv8eoX8UiCNn7K1hGMX+41Zdz8Og@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 11:49:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRS_WpRdC9nyXzVZ7aWNQt0HKMbyFjhrgrNo49AFNWzg@mail.gmail.com>
Message-ID: <CAHk-=wgRS_WpRdC9nyXzVZ7aWNQt0HKMbyFjhrgrNo49AFNWzg@mail.gmail.com>
Subject: Re: WARNING: at mm/mremap.c:211 move_page_tables in i386
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
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
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:12 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> I think you misunderstood me. I was not advocating breaking the stack
> movement code or breaking stack randomization, I was going to try to
> see if I could keep that working while not having to do an overlapping
> move.

I'm not really seeing how you'd do that with a big stack that gets
close to the stack ulimit.

Except by avoiding randomization.

But the existing randomization may be so bad that it doesn't much
matter. And I do think we limit the execve stack to a reasonably small
fraction of the whole ulimit. So worth exploring, I guess.

The current code with "align_stack" doing randomization could also do
with a lot of clarifications. The code is odd.

            Linus
