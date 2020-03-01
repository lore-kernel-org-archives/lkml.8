Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71F1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 22:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1EA24699
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 22:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583102069;
	bh=Suh/emsHYdz5OjAWxH4h7mdHfnel+jzq2wtMoBo1/bs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GBCx15dlPoNuoMngYHV7e+Tur1RztMSUCHXZ5ludBgMeNHDssEyQ20AOHNoo5wqGl
	 WQMzXYzXR45k8wy48it/GXi841sRIIe/T2twKSapiBi2gVel3i1gdKgu9SS/hDh+SA
	 jWgC3LKZTGCswJd3WLCNDd68PbymweN9MqAnhFsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgCAWe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 17:34:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40779 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgCAWe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 17:34:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id 143so9627899ljj.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 14:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocqRb7d75cCd4WWUoRkxgNPbXtSjwtIPTt/0KThKpgE=;
        b=TKFtxdV2BajveGBQ5nXkbQS8BtNEg2/h92w4Eq13y9E182WzlTMQcFcfdVicOJWci4
         QGe9f8rSd1qRr3rMv0YVVAbPfSTGon99nPST9N9YvnSTFZJNIj4k5J/S6Kb05Tjkr8/E
         eI+gkv5J0ueKbE9DmjV5+GcuW9KrX9639Ibck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocqRb7d75cCd4WWUoRkxgNPbXtSjwtIPTt/0KThKpgE=;
        b=LtH8qYN6I9IO7etvRuSaze4AEN+lvk4pfKcL5l27SzHIj4A2MPCVr3kJXOAbbS+Wmj
         VsvaDYl0OxrkJ4J/F5XAefVzCynnJEZAz+IIGwWOqTzqSd9voRmT02zUnHdNEWbp1SyW
         d5z8+k+N7V0I9hiSNcwlfxmn+y087AOuEQWP9oi3rGQcJfO95nqcGkVHkjugfM6hxTNj
         izB9gnP6GKGfHWBMLEqA+RnLI1ph14riSyod5YjSHQLRhRg2lzdjToFuha563H/K0DgO
         IfEpY7+F03HDL6cLhZV0TEhrlvM2WBcRas+suTOLjjW9Cz07RsQP6GYzJcRGLnomdg2M
         GzLg==
X-Gm-Message-State: ANhLgQ2GqcuJtHPIVQiYxdsDW6oB4fqNjeZeqHVSvt4dx5WXWb8oN0ws
        nUThjRd14LHeXOcbp7dTGIv2HFwTInfnnQ==
X-Google-Smtp-Source: ADFU+vt34NaK6KnH+9T6BijSXB5vceVYe+x2+hvtHLDFOMq33kqba/mfKU0eMm/f5zwNyh0sT1LPSQ==
X-Received: by 2002:a2e:884d:: with SMTP id z13mr9491955ljj.116.1583102063878;
        Sun, 01 Mar 2020 14:34:23 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id r25sm10408060lfn.36.2020.03.01.14.34.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 14:34:23 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id a10so1459665ljp.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 14:34:22 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr9960735ljj.265.1583102062599;
 Sun, 01 Mar 2020 14:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200301215125.GA873525@ZenIV.linux.org.uk>
In-Reply-To: <20200301215125.GA873525@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Mar 2020 16:34:06 -0600
X-Gmail-Original-Message-ID: <CAHk-=wh1Q=H-YstHZRKfEw2McUBX2_TfTc=+5N-iH8DSGz44Qg@mail.gmail.com>
Message-ID: <CAHk-=wh1Q=H-YstHZRKfEw2McUBX2_TfTc=+5N-iH8DSGz44Qg@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v3)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 1, 2020 at 3:51 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Extended since the last repost.  The branch is in #work.dotdot;
> #work.do_last is its beginning (about 2/3 of the total), slightly
> reworked since the last time.

I'm traveling, so only a quick read-through.

One request: can you add the total diffstat to the cover letter (along
with what you used as a base)? I did apply it to a branch just to look
at it more closely, so I can see the final diffstat that way:

 Documentation/filesystems/path-lookup.rst |    7 +-
 fs/autofs/dev-ioctl.c                     |    6 +-
 fs/internal.h                             |    1 -
 fs/namei.c                                | 1333 +++++++++------------
 fs/namespace.c                            |   96 +-
 fs/open.c                                 |    4 +-
 include/linux/namei.h                     |    4 +-
 7 files changed, 642 insertions(+), 809 deletions(-)

but it would have been nice to see in your explanation too.

Anyway, from a quick read-through, I don't see anything that raises my
hackles - you've fixed the goto label naming, and I didn't notice
anything else odd.

Maybe that was because I wasn't careful enough. But the final line
count certainly speaks for the series..

             Linus
