Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC412C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D09207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592260695;
	bh=NxEoxsPnKpVaUgBMolvqzprgY0L/U6ngzncz0qbEMbs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GAKWIcuUPpe2LSfFWCYVU85D4tkfdIJ6Gnm8Pa1tHOOZ5f83Q73Q59MJgQa/jOPbc
	 fWXoQWMyYMIRgBprhnTKvGz46mTA/XQYqezMQEMfQTck6LimfCZzPYPtscQLwYaOfw
	 kDYc61Z2s2c00n8jXpp0WMDnb2OFmfSd7OEOmZes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgFOWiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFOWiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:38:13 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCEFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:38:12 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i27so21130752ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hDkCcz9pJTljCHKlO0VjvIrQ/0YyW9zXpKFl2PZzA9U=;
        b=WJKgNcDeluq3Js9hmc9GLKlZTmxtuneMSLtXZEDSyZObiMxXS09cxnh8mLcBHQIA/m
         mRMDkRHN7y8aDfxnO8mxEh58PAPuojiTplNIr4Yfzac55vzGpJfQ7xUxHmhDZdjqsFwL
         1k+AJpguvcfOehk6AZXEWzgMGoD0mC/2oC8Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hDkCcz9pJTljCHKlO0VjvIrQ/0YyW9zXpKFl2PZzA9U=;
        b=ifbcU4H9PzEJJ1mCUU0MHHfBI8B7swvbmrsw100hsssDwna9fPmyNG0YagxDi/Xkci
         secSBIm5gNntCGr/IrsErf1cITRjmk9bUUL7G9mi/M6H66na1p42TH/uf4HckrcNcWdC
         GmWf57KB/CCkwfAod5Y8q1Ja0CtCD6U5Z/lz90Aq+5SO9FS+od5ZQmuvj95Ti8Q8DKlW
         ugeu5Z9nnKth5SulB25HuxuysngyQRWEYo4gRvQvsPTS22nsQeBSBUIa1dA/ToWbn+gb
         H2wUqhG+nyqXOTXc2GLrwe5DE5CR0w6jQRKNEnExwi2qScXX0CUob6aa81RWltglpeuf
         91Cw==
X-Gm-Message-State: AOAM531zEHLmsZ+X9QplIwgvZJ381Fs3XEVvrcnOprIbsU/tiri0N5IU
        KvnYSygHk+a1WQT2v9QC6S7PZ0NYglQ=
X-Google-Smtp-Source: ABdhPJyq+Yot0q5h/sO3UmHhhlzRV+XGk3194SIdDYQu7Z5jylNL+61acWKIqjXr4KW1Inf/C/slvA==
X-Received: by 2002:a2e:3808:: with SMTP id f8mr13687344lja.165.1592260690125;
        Mon, 15 Jun 2020 15:38:10 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id a23sm1115491lfb.10.2020.06.15.15.38.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 15:38:09 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id a26so6090947lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:38:08 -0700 (PDT)
X-Received: by 2002:ac2:521a:: with SMTP id a26mr95385lfl.192.1592260688575;
 Mon, 15 Jun 2020 15:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgB6xs-gfihkMSngyAcRHaQ0oE3jVawVMzzAh4Xm0VsSQ@mail.gmail.com>
 <20200615222427.60126-1-sashal@kernel.org>
In-Reply-To: <20200615222427.60126-1-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 15:37:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wid9pjXmafH_-F6TooC9j7nfqKweWbHKzENkk+YHTo=AQ@mail.gmail.com>
Message-ID: <CAHk-=wid9pjXmafH_-F6TooC9j7nfqKweWbHKzENkk+YHTo=AQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/decode_stacktrace: warn when modpath is needed
 but is unset
To:     Sasha Levin <sashal@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 3:24 PM Sasha Levin <sashal@kernel.org> wrote:
>
> When a user tries to parse a symbol located inside a module he must have
> modpath set. Otherwise, decode_stacktrace won't be able to parse the
> symbol correctly.
>
> Right now the failure is silent and easily missed by the user. What's
> worse is that by the time the user realizes what happened (or someone on
> LKML asks him to add the modpath and re-run), he might have already got
> rid of the vmlinux/modules.

Well, that looks straightforward.

Applied,

              Linus
