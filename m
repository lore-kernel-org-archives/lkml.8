Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79675C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515CA206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595344475;
	bh=EC70+klebLS+syijFaXMg0/XUwOgroRzpIFSyx0/eAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WWhTOyMzjDJhp+mEKTM428VaPS9FKxJ7BsvfTdPC8MRS0YrXVBJx4hB1p/XOCbIE3
	 oo10oe8Da+NG7kKmoiHYBRDQUoGKbA90cv79K4lvOBXyYmqqZebjq5qlqjOnc2SySi
	 8TJoGyDt5kLYDGwPrfT9PE9kVof3PlinCHrQpBLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgGUPOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgGUPOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:14:33 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13634C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:14:33 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f5so24468156ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UJ2oiatPJQaDkSAS79bD6RyNLxzOHISiSh/NEV751ag=;
        b=NrTtagrMMk3FxqlaHdZNgbKdUc8Vh/avD14adDz7BB+LEJ2DXgeu7STJKNQgPO9iT+
         vSjLYZPFhle+9JLlHdTV3Skc3JPIoW16dsZg/nAYIi5sPJWRptJVp8QKGoW5L8byXqHe
         KmCEJht0AbHbpA8JTAsGOB5DlCkMZzJPxMHII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJ2oiatPJQaDkSAS79bD6RyNLxzOHISiSh/NEV751ag=;
        b=Icoe0daVYc5yXWkQ4AEQ5esST4CoQbA3ibbs2aeWD5Mif6yy/mmdzW1ZeQfcrHuaxp
         WFoblXuKZL08+SET188HhDGEBzn/a7spVbEetQQlK2KjW3/ZrZWmj3p9yLzJdqzqEKBd
         XxtwCF6rC6q7gCH/V1dIWr6R2sq9rRYpveJf3g+AIZ+WF6hYJCFUaP3WNhQIRvGe9NR6
         SyqNqhbr8f5Vku4sjkYNoOvasgvbDwdgMA/bQ6CGDpJn0YSXHzt6LM/D+Uc9uAeaCG+Q
         UsLYxGzyNZA++aFHsN/cnhheiklS3Ml8RfWuILr2n+IuYCLMV8EWSKYiMH9BGSZpim+W
         XheQ==
X-Gm-Message-State: AOAM531lNXg2vh8a8M0WudHeAaNL7prBbm4GBYH1j6hkqzdizJbJogyi
        k9c9XCJxX4twDIuSQ76FEeWEeWpLQAU=
X-Google-Smtp-Source: ABdhPJySzstn5hqME2i2Ih9Ly4JjtlYnLEIYLSuNw9Od3JGrJ32RLDawgChAB4U3TWdV3+MDve5ODg==
X-Received: by 2002:a2e:8216:: with SMTP id w22mr13436738ljg.2.1595344471264;
        Tue, 21 Jul 2020 08:14:31 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id b18sm2390120lfp.36.2020.07.21.08.14.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 08:14:30 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q6so3465395ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:14:30 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr12417087ljj.102.1595344469962;
 Tue, 21 Jul 2020 08:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUGO0__SEZ7YvuQzfSdaWfTnCHW=73-3W4X=Vz51wHd+w@mail.gmail.com>
 <CAHk-=wiR+uHUyp3=Nf1aiNjmg0ZekaQJupLRguFNZ=MreuGhfg@mail.gmail.com> <CA+icZUXRjrX+1NAZy4As_ficD4aHRAZWHRj5hrE+D6E5zEKXHw@mail.gmail.com>
In-Reply-To: <CA+icZUXRjrX+1NAZy4As_ficD4aHRAZWHRj5hrE+D6E5zEKXHw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Jul 2020 08:14:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaTO-TNHimPtsBYWk7VMdL3rqdn=Uzom3f=Bs1CKw3kw@mail.gmail.com>
Message-ID: <CAHk-=wgaTO-TNHimPtsBYWk7VMdL3rqdn=Uzom3f=Bs1CKw3kw@mail.gmail.com>
Subject: Re: Linux 5.8-rc6
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 1:17 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> You happen to know if I can configure in my ~/.gitconfig to pull
> linux-git stuff from two repositories - check first git.kernel.org
> then GitHub.

Just script it. IOW, do

   git pull ..kernel.org..
   git pull ...github..

and if you _want_ to, you can just create an alias for that in your
.gitconfig so that you can do it with one "git update" command or
whatever.

But normally, they are both updated at pretty much the same time.

             Linus
