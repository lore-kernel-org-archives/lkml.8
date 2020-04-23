Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C651C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4D520CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HS3L0RvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgDXAAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDXAAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 20:00:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3D3C09B043
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 17:00:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b2so8100489ljp.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 17:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AO2zDYw2OTrVTsEOf9qOCAlkKJ6vVvcI1aCDMu2ZHI=;
        b=HS3L0RvS4J2AHu7yfa/WS299UPIfdIbz/WFwgftGS6ioGesdU8JDJpiCx8KTLRhzpA
         Sfr0mHYtsT0QNWyBvlx8aWk4NH51uEI07Sr1zkBRpg2pGcz3a3lRSpCoqLAgwInRrt2P
         J2Jv3rZreCwePGwxg5ozt4xBt6eUBnW1Am+tGXtZBNVX8gRgNeIyGZE6gjHpmMmjMR7a
         OqPZfZcjampppdtDZ8OBwmW1hsnnK++hHZHP2GyH0qVPUsaBj5DiTrxhcwv6AWkYBiO8
         FSfcdCtwihfWI8gehyCoCkUNA6Y7H9x6+q9r5a3ae6cNP056qNWkhKgJrrrI2dzM2wch
         SRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AO2zDYw2OTrVTsEOf9qOCAlkKJ6vVvcI1aCDMu2ZHI=;
        b=A3ZyIaN/37Lpb+YXb0YH2i6o2VQTQMS6QeCk2vg04MptGnnpXsiU1fk0yt58KZGd78
         GjXBgDsVQ340m1uQMYjEA9BRehAUn3FOrAQ1l0zqMjuz6ziuUesVSRAWrQAf7XHy4lF0
         fqi5AXEQ17U8e4ztCG25Nvnvd/n9FKQza68cqOrOFT9HwCh5abFFLLRh2joDCww48Tsf
         BXtd3rxaoBTbiWWwpaSlVwNEbq1GKOUQBM3w3rfshPm9QZ1fRU4RPFDvULYaxSRb7M2m
         R4CA5xYYrz9PL2RWFmKsYbXrD6669ylXsEiBHrk2UXmm1MMF8NNr0oOF02S1LxjBWlaO
         yQNQ==
X-Gm-Message-State: AGi0Pua7udtSy3yzp7TWDdPdnevWAKGWDAz7qSzBYPaoy7GEaym8gsbT
        Q5cX6iZJRTqAf+Kl1gCR1Q1MNV8PvTz0f75b1+qnwiniSAA=
X-Google-Smtp-Source: APiQypK+4462/UiJw2zVslTXnFJSdEZhNkC9wnzz+Q8zSaEjmCsx8aWyreNA0I93TTjbrrEaBN7JVQiJAfn44Wb6CKA=
X-Received: by 2002:a2e:87d3:: with SMTP id v19mr3762634ljj.176.1587686413751;
 Thu, 23 Apr 2020 17:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <lsq.1587683027.831233700@decadent.org.uk>
In-Reply-To: <lsq.1587683027.831233700@decadent.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 24 Apr 2020 01:59:47 +0200
Message-ID: <CAG48ez0nyLsyAeLJXEnCnhkh26EnZGnam1cyd84a5LoFcEyMiw@mail.gmail.com>
Subject: Re: [PATCH 3.16 000/245] 3.16.83-rc1 review
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Denis Kirjanov <kda@linux-powerpc.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 1:03 AM Ben Hutchings <ben@decadent.org.uk> wrote:
> This is the start of the stable review cycle for the 3.16.83 release.
> There are 245 patches in this series, which will be posted as responses
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Apr 28 18:00:00 UTC 2020.
> Anything received after that time might be too late.

Can you please add backports of the following patches? I asked for
that in <https://lore.kernel.org/stable/CAG48ez29d-JJOw8XMp1Z=7sDj8Kvmt+9KXC9-ux-0OBhUP02Xg@mail.gmail.com/>,
but I guess that fell through the cracks somehow.

8019ad13ef7f64be44d4f892af9c840179009254 "futex: Fix inode life-time issue"
8d67743653dce5a0e7aa500fcccb237cde7ad88e "futex: Unbreak futex hashing"

Can those still go into 3.16.83, or is it too late for that now?
