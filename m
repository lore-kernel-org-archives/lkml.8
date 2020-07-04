Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DD9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6909C20870
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 23:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVToQFB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgGDXfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 19:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgGDXfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 19:35:10 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D467DC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 16:35:09 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f12so12374532eja.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 16:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNDVeItDy/XBJ+8/VApySLuTKnyDwRPMoyZTnmzqQFg=;
        b=mVToQFB0MteQPg60+j4sV1I3VbaU39JUkaonE1q9EGVvB6176pUyGu2KyH1VE3ixbD
         gfY/YIX3tKWUhzizlEgvK3g67Cxjbd5C0OGaHirmfieJtN0mkJjDLGmb9RPVVsoACtoA
         kVTWv+2kauUJf6W3C+FAz39m5bE8c2DzB+2Q2NcjNsKmJYsZj7IJaRNrK3O17oSxudQS
         v5vJdLD1mDnqkFiiIO3mU8BuhWY8SFlcXhv9MmfDq/AgPpdRTtO35/qsCQuNYEhqlOng
         80cf5/tzQnCwskMaplSXXY4aW318c/rn0ZxOwhIXF8I9xsM0c8HWtH0BWhod0ZbR8AF9
         CK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNDVeItDy/XBJ+8/VApySLuTKnyDwRPMoyZTnmzqQFg=;
        b=ogvtV6g8xPRrzWphwx2op3kFebi8SlhW6xLySontbGdn5AQbuIg0L7S/GF4RAdJH21
         /AKabq05k7wTYrpSWGCdNKFsO60YGrZHstI7NoIe0iJbNmYrcgnuwwegSCN+F/zLQ0Dy
         CpvDyqaW5JtXYCcFjugO/TbHMly5bxt7yYD74Mu5dBFfhjoF6Bhqw6pGLcW+2SQt5Mb1
         MiDhSfLEtGSpTX21C+MbyL8dmdb5s/kXDTDz3LQe1FAzpTd+jBceG/AtcwhBsNK2vE+X
         b95BMBkUVOj1wQPt3Tc9hRXZpDuMKUXIzvC9P4nVLVwO2qQUvOeMRtAJz5tJeBZo11JH
         qgtg==
X-Gm-Message-State: AOAM532+JucD7ffUNRKJdPo5+FY7rMQweH+YjBXGdZtXcTKrabOtupoY
        aIi0kM8QNOB2TlAoFjW44/P4eJnonbaQBsNyNAw=
X-Google-Smtp-Source: ABdhPJzLHDeLKWceSh0oqqwXr+kjyv7oF+hVEXofB6wPk1V5t3rlZKh6KqR8EFtrC8rgBH5h4Ut4Mck8IR9S9Tp4ZJA=
X-Received: by 2002:a17:906:4086:: with SMTP id u6mr40502780ejj.9.1593905708462;
 Sat, 04 Jul 2020 16:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200705064348.71d4d51f@canb.auug.org.au>
In-Reply-To: <20200705064348.71d4d51f@canb.auug.org.au>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sun, 5 Jul 2020 09:34:57 +1000
Message-ID: <CAPM=9txOgRYc7RM3fzohB4=Ejcp_xMGLBX_OOCOD=r+W6D678A@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jul 2020 at 06:45, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dan,
>
> On Sat, 04 Jul 2020 13:02:51 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > +Linux kernel inclusive terminology
> > +==================================
> > +
> > +The Linux kernel is a global software project, and in 2020 there was a
> > +global reckoning on race relations that caused many organizations to
> > +re-evaluate their policies and practices relative to the inclusion of
> > +people of African descent. This document describes why the 'Naming'
>
> I feel a need to point out that racial issues are wider than just
> people of African descent ...  Also, others have pointed out that
> slavery is not just restricted to those of African descent.

The racial issues are wider than that, and even wider again I'm sure,
but in 2020 this is as good a place to start as any, and the trigger
as that sentence says was in 2020, there was a reckoning about it
mainly due to people of African descent. That trigger has had flow on
effects in other countries, but I'm not sure that sentence in any way
diminishes that, it's merely an introduction to why this change is
happening now.

As for the non-black slavery, others have never pointed this out
before in 30 years of master/slave terminology? surely if white
slavery was as big a problem, they be as supportive of this, even more
so. It speaks volumes that I've never heard white slavery as a problem
once in 30 years, but now I'm hearing about it a few times, and
somehow as an excuse not to support this.

Dave.
