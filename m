Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3356C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79DC32071C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590359118;
	bh=dhIJrZ72teGdcL2LEy6HG5o/UAl2iTat+S7Tcw5Qu1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qM3XEN7wZvxDc3oNYQiYpqzMa2W/K0bjPsvNhPK7LfJgLu4s0FFX2PornwUk25lp7
	 MzG/7bat/Wr7JlKw7nQyvLtCVW5tyEZ+o+CibHemTSZ5AThius2hkSe3qMyf1FhJQE
	 Cq96kIBDsluwvXB/rNNG0fZ5pw5H2MyRjzjQ9q7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbgEXWZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 18:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387850AbgEXWZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:25:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEFFC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 15:25:16 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z13so9115333ljn.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 15:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LnH5vtANI20i7lJYnJcoMA8wwxltt92oOwvSOq9RUuE=;
        b=WcziryS69mkb45C7qhQ90LM1BVHcdYlgxKsBeHjdkQYthluvPkeCMT9yg3OHJMKOY+
         Mry/HeOIrqV93Cw5NEV+6nlhW95JiSaasEMOZpf8Gm0AkrIAxkJxeOX7btcFB+f295TH
         XEVaCLOx+zUvrjifO++8ASkSVoab16CUu78D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnH5vtANI20i7lJYnJcoMA8wwxltt92oOwvSOq9RUuE=;
        b=QivpsV/2amSoHxYqgtJEj7xECvNLI8sBcFXwHhqtYBnoYhvMM4URwTs3kt6Tag/n2X
         J4k6vVnYwrqBpVFcuSdcneziryVr5kM5lKFY45DpwcBye1tb6a80KErXh0yOsvvpSDsW
         8hxNldPClPGkynCwndWOLtKyfK8q9/+9W0parLJopFirBc1v6g8ETdu8GXOV0sSUS7RO
         3vFI3luKEvN4Y2kVJpswAng/mjdDUx5+tIcXFRPJCqHfFSJO8PtjAmLUhShb7M5pGpmp
         tKd7MorBTYAxKZ1qD+bPqSB8N5Vr+eWWK+7KdT+WToJ592IH2XtLmFMXHDxdXit9EU/F
         /iPA==
X-Gm-Message-State: AOAM533GmmHHJWqYNHJLUb9GaSdFeueoDOmkBNehYC0yf/P3h9NNAQut
        rzxd3E3vLyCOnu9IjSdwuioKL+th3fs=
X-Google-Smtp-Source: ABdhPJxNqxKRKPqzToQ491hHB2jO8qD9/nHpekwTssG8FucKs0WEVrnRPPZM73YPmBmPwYwvqXnLOg==
X-Received: by 2002:a2e:7007:: with SMTP id l7mr5957909ljc.74.1590359114657;
        Sun, 24 May 2020 15:25:14 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id c23sm3998396ljd.16.2020.05.24.15.25.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 15:25:13 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id m12so16386444ljc.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 15:25:12 -0700 (PDT)
X-Received: by 2002:a2e:9891:: with SMTP id b17mr10980257ljj.312.1590359112449;
 Sun, 24 May 2020 15:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200523131759.GA55886@kroah.com> <20200523152922.GA224858@kroah.com>
 <CAHk-=wih_B_8a48Au=6B+gwFcYnM7qF02dGX3R0QN_2bzVcjVA@mail.gmail.com>
 <20200524150018.GB11262@kroah.com> <CAHk-=wh4bZdCkhng3EsJCDhHLxHT6x4S66v5JQvusihVfYrc5Q@mail.gmail.com>
 <20200524194550.GV33628@sasha-vm>
In-Reply-To: <20200524194550.GV33628@sasha-vm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 May 2020 15:24:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+hNaq6B4zPFZZTLWKUYJEeQmZjHf6Yxz+B50o0CquAw@mail.gmail.com>
Message-ID: <CAHk-=wg+hNaq6B4zPFZZTLWKUYJEeQmZjHf6Yxz+B50o0CquAw@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7 - take 2
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 12:45 PM Sasha Levin <sashal@kernel.org> wrote:
>
> Interesting. My thinking around --follow was that it's like
> --full-history in the sense that it won't prune history, but it would
> also keep listing history beyond file renames.

No. It's only completely accidentally like full-history because it
sets the flag that basically says "give me the whole diff" - so that
if the file goes away, you see where it came from.

And because it wants the whole diff and doesn't limit it to just the
one file that is tracked, it ends up following both sides of the merge
because _other_ files changed in that merge.

> The --follow functionality is quite useful when looking at older
> branches and trying to understand where changes should go into on those
> older branches.

It is useful, but it is ambiguous. What happens if the file came to be
two different ways in two different branches? Or what happens if two
files were combined into one?

So "git log --follow" is not _wrong_, but the operation of trying to
follow a file identity is basically broken. In git, it's not a
fundamental operation (because git isn't broken), it's just an
emulation of that broken concept that often works in practice.

It's a "let's give people what they are used to", but it really isn't
very well-defined in the general case. You think it works, because for
the simple cases it gives the "obviously correct" answer.

> We also do have some notion of "file identity" in the kernel;

No, we really really don't.

The CVS/SVN kind of "file identity" is more like an "inode". Nothing
in the kernel sources cares about the inode number of a file. The
inode will be different depending on how something was created, and
when you rename what previously were two different files to one single
path (as a result of a merge), you have to pick one at random, and
lose the other.

So you end up with the crazy random "Attic" model of stale files in
CVS, exactly because the thing is based on a file identity that is
completely fundamentally broken.

Note how you've never seen anything like that in git. Because the
whole concept is garbage, and git isn't garbage.

Yes, I still hate CVS with a passion, almost two decades after I had
to use that horrid horrid thing. Some mental scars will  not go away.

>i t's prevalent with "quirk files". Look at these for example:
> [ deleted]
> We know that patches to those files are likely to contain quirks

No, those are not file identities AT ALL.

Those are just pathnames with some meaning. You can throw away the
file, and start a new one, and the meaning doesn't go away - because
it's attached to the path.

And yes, certain paths in the repository can be special, although
that's irrelevant to a SCM, of course. Git won't care. It's just
"contents with a name".

Which is exactly what git tracks, and is *not* what the SVN/CVS kind
of completely broken file identity is all about.

          Linus
