Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804A4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8D220691
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izHn04h0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgFKLyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgFKLyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:54:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BBAC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:54:32 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i3so2014081ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KpSE9IXIWaR1OHxswOLDwFAs52InKm2JRRYIDBwBJ0o=;
        b=izHn04h0oLXC99OMtomvNPL1dhIuwQcknv4PT6s5x2wKyGb9fj2LrqpeCT9W7Nnq07
         Gl18N+mi1LrRGSoKsUgL6ZRv6BjiNvTkaQC0CmMl/7NAcsxDCAfacgabGJj8JbwGt3aL
         55Wu9mn6PFMaGBOzzVHaUq2kZltVQMcTaKXi+du7c2kRNH17nqf3MD/CzxU4avgmXL3E
         44JVx822X8HKJxrnBUBJjQc3jjIuJ60IOEZGL7/dLqfaDxHMg7st2O+kpRgX50d7w3zv
         JrnBahhpVgXZmChSVBNCIqjYSs2y8SmjY93w7f+wQr11zWD1hoFN1jmaLzz26G9mf4Qw
         /AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KpSE9IXIWaR1OHxswOLDwFAs52InKm2JRRYIDBwBJ0o=;
        b=V1G+y2QMSs+Q4uT1WMNN8LBcA01XU0HMbY/ZDGZ3cAYuLFJWEN8bFgmEG0W6o8OWii
         HxNNch2kuOu0+7ltRAcS9fORF6vW+TVyRebC8ZRLIvsTJ7YyY8KiOWqciA17kmB2smPt
         CWl52Zx9x412KNZ2PJDqk2deteAmxkRTqjGaS/EXhC75MPATTXax0/a4buLuIL9bU0tQ
         2CddJPFO4MvrbnMk4Z1Sog3CR/CnbtrVF03SvRwfNk0jpWTHfygHJPinh8kXlbz8c+hO
         jmlCwO4k4wiwiP48MC5BRbiH+YyHpuC3g9y5/M4lSspnXO924fLWbxyip86kNiFLW27E
         +FcQ==
X-Gm-Message-State: AOAM5325XhpYv2c5EpZWStbcMH/en6afcvNoiAq5uivCi35xzx2iCSMC
        z4MCNVnqMcFLf1vUqjBRHIkXjlugmmrnfrUdXso=
X-Google-Smtp-Source: ABdhPJwfYJy3/BL+ialcKRAMG2OHMwoT6PII9OfaxqxRoXpWpyarknnakoU3bxEwBbVFXbJ5GXcB9jL3h9X4rKJLywc=
X-Received: by 2002:a05:651c:11c7:: with SMTP id z7mr4390510ljo.29.1591876470581;
 Thu, 11 Jun 2020 04:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200610125147.2782142-1-christian.brauner@ubuntu.com>
 <c8851256aa453461481233e8a7fea878f9580c5b.camel@perches.com>
 <CANiq72=BbGqXmiG8+1QuJnLXMTwNjUg9WuWR9eJcLMHZ=k5hQw@mail.gmail.com> <4c6f8d63817cbc51765fd0b3046f81dccbd17ec7.camel@perches.com>
In-Reply-To: <4c6f8d63817cbc51765fd0b3046f81dccbd17ec7.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 11 Jun 2020 13:54:19 +0200
Message-ID: <CANiq72nOaDo9LQ3JoZk6VH-ZYErHpvD1O=DyVngs3xno5e9W7Q@mail.gmail.com>
Subject: Re: [PATCH] .clang-format: update column limit
To:     Joe Perches <joe@perches.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 12:36 PM Joe Perches <joe@perches.com> wrote:
>
> Exactly.  So don't set a new hard limit of 100.
>
> This would _always_ wrap lines to 100 columns when
> 80 columns is still preferred.

Why is 80 "still preferred" to begin with? The patch you sent for
`coding-style.rst` was picked up by Linus, yes, but the wording seems
too strong still, considering it is for newcomers.

The point is that 80 *isn't* a limit, so I don't see why it is
mentioned, much less "preferred". Rather, I would have worded it like
[*]. What do you think?

> Imagine using a 100 column limit where a statement still
> fits on 2 lines.  Now imagine the same statement wrapped
> at 80 columns still fitting on 2 lines.
>
> Which would you prefer and why?

The former. While sometimes it may be more aesthetically pleasing to
have 2 lines of similar lengths rather than a long one and a short
one, having a deterministic approach allows us to use automatic
formatters. Which in turn makes code more regular since breaks are
always done the same way (modulo heuristic differences between
clang-format versions etc.).

In other words, I prefer automatic breaks vs. discussing every break :-)

Cheers,
Miguel

[*] (please excuse any word-wrap)

From 3b3cad415b56498534fadf732f2762f4dbe108eb Mon Sep 17 00:00:00 2001
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Jun 2020 13:16:46 +0200
Subject: [PATCH] coding-style: don't mention line length hard limits, add tips

Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 Documentation/process/coding-style.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/coding-style.rst
b/Documentation/process/coding-style.rst
index 17a8e584f15f..309d3ae17e6c 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -84,11 +84,13 @@ Get a decent editor and don't leave whitespace at
the end of lines.
 Coding style is all about readability and maintainability using commonly
 available tools.

-The preferred limit on the length of a single line is 80 columns.
+Avoid lines that are too long and use reasonable line lengths.  There is no
+hard limit: break lines where it makes the most sense, somewhere around
+the 80-120 columns.  Complex statements should be broken into sensible chunks;
+identifiers should not be unreasonably verbose.  Follow nearby conventions.

-Statements longer than 80 columns should be broken into sensible chunks,
-unless exceeding 80 columns significantly increases readability and does
-not hide information.
+A good test is using `clang-format`: if the formatter is unable to split
+the lines wisely, then the code likely needs rearrangement.

 Descendants are always substantially shorter than the parent and are
 are placed substantially to the right.  A very commonly used style
-- 
2.27.0
