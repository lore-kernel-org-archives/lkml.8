Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5B3C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5EC206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQu4E3ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDUWw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgDUWw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:52:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90850C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:52:26 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so225293ljb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ErbRDIGeS5CB2D5zGfhVd1ehmArxxN7POtVIibUWBY=;
        b=AQu4E3llLgvg9AVRRxjqVDZiNEWre3Q5km3E650HVXWYmLPQ6N1g2RVDbboKVjvLM2
         Sya+k61fRZWoFA5xauOn3By8xwsB9ZOtr2XMB2MIzwj2Jq8CzW9nLqJNuYtcUh8R+Gep
         4vuKOcnkpJHXCgec3w/e1AXGQrRz/I2iPuN1krVn9AjUxzTBeDMwqVxC46ekmWw/SQJ5
         S0yBhML8Ki8Dp+UJ7JhVfXjU10Uv2FHorbtWBAFuxTNbpDGKlmFE07Ma+G0FDiZrn4IH
         MCCtt2q+zEJpjuLEgSIq18S55F7ad0phLF0sduMPQFFpwOxLD0tm5VszE+AO61dqg4P5
         UzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ErbRDIGeS5CB2D5zGfhVd1ehmArxxN7POtVIibUWBY=;
        b=ALFVC4dc9ucVkDokzgJT5LYfyIG7cNMP7Eu8kiOBnbRc6a1Yg1uJ3Ht4W8t0r/kEfV
         6BfMZL0Oa0hwfjitPKdotqsq5m0xxc2TbkspkcGBqtBDFNFW9uk6A/HXA6PGFE+9X0zk
         YYWNeGQkuwaEWGBlj0scHIDjw9MAdX/zmKGS9pa0/ixB2rMLSlk/8kcEizcfbbv7GNMx
         5WsuCVAxbhoyeEugt0qJeueQtiWqm77XyOyRFOMjN0sG+5UCANGPY3USp4SFvjmhSlwR
         3dHGp8WuAn1fyYEBspWZitfH08eoF2/p7OZKhtrPtpu8XnJ9u1Srb5JXlRCI2JPaPeff
         XzQA==
X-Gm-Message-State: AGi0PuaG2tzlw8ZeV9JQuIZn0VaLx6XDBUE+Los4rzRn55zL4odcZx0j
        48QBXLtBiQscUQMoYRQUtf0hpBxv14OE0dZPbYo=
X-Google-Smtp-Source: APiQypJcevQKuk0O5RwrZ7Du7bpHmrkzwNjU10N5+2QqeIHR7bolSWenFYn/yd268zKZUbePxjHT0uTACZeQdBw55YU=
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr14946594ljk.134.1587509545051;
 Tue, 21 Apr 2020 15:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200420190916.GA11695@gmail.com> <CAHk-=wiejBvKnrDysDva=DNFgyX02TZred_JMjzUnjFgVOUtOg@mail.gmail.com>
 <CAP-5=fVhWREzzjnXH4j+dcnP-GbSMnT_07qVrZM8huAhx6wtVw@mail.gmail.com> <CAHk-=wifecOQcL6vbL0uOY68jH4i3nBCksmc+As9hrUm_hjw1Q@mail.gmail.com>
In-Reply-To: <CAHk-=wifecOQcL6vbL0uOY68jH4i3nBCksmc+As9hrUm_hjw1Q@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 22 Apr 2020 00:52:14 +0200
Message-ID: <CANiq72n2T0UCdjb923LThts-3js8LiDTqFHB-PK3SqeG3xwY=w@mail.gmail.com>
Subject: Re: [GIT PULL] clang-format for v5.7-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:17 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, not really. I _did_ check the commit message. It says nothing
> very useful at all, in that the kernel doesn't use C++ (aside from a
> couple of clang tests)

Apart from what Ian said, one of those is tools/perf/util/c++/clang.{h,cpp}
which use `namespace perf` (with non-indented contents), which is why
I mentioned in the PR email that the change aligns clang-format to the
current usage.

But yeah, perhaps I should have edited the commit message rather than
say it in the email in passing.

Cheers,
Miguel
