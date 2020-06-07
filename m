Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F29C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 19:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FFB2074B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 19:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591559964;
	bh=vGEH5CjwcynpLKnaXh4RxdMgcDpygGI1sZY4cxDNUY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MxVBlGs3uiv8d2MyXguFXFjiGkHo4v2RWohqFpoIka9d48OJDCOiRQVtDasjAwBmB
	 vfOfWLN0LasVkZ4wrJMrBtWlhfMflC/SXNjoXsjSmMvg1fMDaxHpWpenBqMaxz3SMp
	 BBCOOf5j1GFIo/YaeC2IKwvdsQ2H/IkSVcAJw2Iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgFGT7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 15:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgFGT7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 15:59:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E4DC08C5C4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 12:59:21 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i27so6922681ljb.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 12:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfFkjoxj9fOIuKPRJb0FDkBxNdU4BLvuGT9ldDD2gzo=;
        b=Z/UxSQFSg3CDWwOVJuymkitl0NLXIOoRBih0s5v1TS0bvysDNE7rbLrJqwHBvcXhIc
         lHvnCJXF/bTw/cJJkyXraQFWjE5VkIE4f7yumSh8zxnuOzwkU+uZYNxoNLZrPUU7QZWm
         matRTgJ+GFJInbWVu4kDVi/ok+81m/ZgikWSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfFkjoxj9fOIuKPRJb0FDkBxNdU4BLvuGT9ldDD2gzo=;
        b=UBYv73Nk5iAqlIpTIakRuDD/AWXp4lQzNLHMasWGkM7ddblWRJ+AaYjN7EAOM0vQ1L
         89goNNu3vYgI6OUPtUGApq2zZzXx8YBWPQuWpgOwErtFAPzhdRFjI+it8ZsS1iiMUeQJ
         K2LIgFUWljq7NI5PiFUQWfA7Ta0rURDlOkygpRc6v/AueZ4IshrfZJYDHAKQXDUgIIIA
         EghfZ0xkOYbUbNi4uqNkXbecjuYHAQqE2K7CzsXfmmxyPzBEBobTvEhmHwq4SxG/5vFr
         XyiTwlD/fFxnZaTuYdXXdlfBXzkJMzyinnB9bcWe5+gsubutPM0OwB28t2v64rntcaMg
         +s2A==
X-Gm-Message-State: AOAM533n5vetpPObpToeGKVTYLZhP4AewVfK+XDJS9OWJVJ8MZTSHQTw
        5hUUAPKGV8rM+LjvTaT6pWy1GArYun8=
X-Google-Smtp-Source: ABdhPJxAaRdX+gme8gMp9e9pPb4CwUhXE/gjyyOzbbQzuH1NAPfmzLP/ZNHTdGtl7TO6j5MaBnAgMw==
X-Received: by 2002:a2e:4812:: with SMTP id v18mr9778822lja.353.1591559959612;
        Sun, 07 Jun 2020 12:59:19 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id a1sm3225873ljk.133.2020.06.07.12.59.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 12:59:18 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id a25so17877396ljp.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 12:59:18 -0700 (PDT)
X-Received: by 2002:a2e:8991:: with SMTP id c17mr8444228lji.421.1591559957881;
 Sun, 07 Jun 2020 12:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <1591376548.5816.14.camel@linux.ibm.com>
In-Reply-To: <1591376548.5816.14.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Jun 2020 12:59:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whV2B4fPSkHA1Z6qEbwRTcJF0gYWBfAuqSGG+p-05HtfQ@mail.gmail.com>
Message-ID: <CAHk-=whV2B4fPSkHA1Z6qEbwRTcJF0gYWBfAuqSGG+p-05HtfQ@mail.gmail.com>
Subject: Re: [GIT PULL] integrity subsystem updates for v5.8
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 10:03 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> The main changes are extending the TPM 2.0 PCR banks with bank
> specific file hashes, calculating the "boot_aggregate" based on other
> TPM PCR banks, using the default IMA hash algorithm, instead of SHA1,
> as the basis for the cache hash table key, and preventing the mprotect
> syscall to circumvent an IMA mmap appraise policy rule.

I'm not sure why I didn't notice this during my test builds, but this
results in a new warning:

  WARNING: modpost: vmlinux.o(.text+0x496264): Section mismatch in
reference from the function ima_calc_boot_aggregate() to the function
.init.text:ima_pcrread()
  The function ima_calc_boot_aggregate() references
  the function __init ima_pcrread().
  This is often because ima_calc_boot_aggregate lacks a __init
  annotation or the annotation of ima_pcrread is wrong.

and I think the warning is real - and the problem is real, not just a
missing annotation.

It looks like ima_calc_boot_aggregate() may be called not only at init
time (ima_eventdigest_init() is referenced from "struct
ima_template_field supported_fields[]", for example)

So calling an __init function would be very wrong, because it might be
gone by that time.

Hmm?

                Linus
